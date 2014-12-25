//
//  HHCParser.m
//  HWReader
//
//  Created by zhaochao on 14-12-25.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "HHCParser.h"

@implementation HHCParser

static const xmlChar* kLI = BAD_CAST "LI";
static const xmlChar* kOBJECT = BAD_CAST "OBJECT";
static const xmlChar* kPARAM = BAD_CAST "PARAM";
static const xmlChar* kNAME = BAD_CAST "NAME";
static const xmlChar* kLOCAL = BAD_CAST "LOCAL";
static const xmlChar* kVALUE = BAD_CAST "value";  //取值的时候要小写
-(void)dealloc
{
	if (_xmlDoc)
	{
		xmlFreeDoc(_xmlDoc);
	}
    
}

-(void)getPreOderNodes:(HHCNode*) node toArr: (NSMutableArray *) arr
{
    [arr addObject:node];
    HHCNode *child = [node.children firstObject];
    while (child) {
        [self getPreOderNodes:child toArr:arr];
        child =  child->nextSibling;
    }
}

-(NSMutableArray*)getPreOrderTreeNodes
{
    NSMutableArray *nodes = [[NSMutableArray alloc] init];
    [self getPreOderNodes:_hhcRoot toArr:nodes];
    return nodes;
}


//递归创建hhc树
-(void) buildHHCTree : (xmlNode*) node withRoot: (HHCNode *) hhcNode withDepth:(int) dep;
{
 
    HHCNode *preparent = hhcNode;
    if ([self noCaseStringEqual:node->name withStr:kLI])
    {
        HHCNode * childHHCNode = [self buildHHCNode:node];
        childHHCNode.depth = ++dep;
        childHHCNode->parent = preparent;
        HHCNode *preSib = [preparent.children lastObject];
        childHHCNode->preSibling = preSib;
        if (preSib) {
            preSib->nextSibling = childHHCNode;
        }
        [preparent.children addObject:childHHCNode];
        preparent = childHHCNode;
    }
    xmlNode *child = node->children;
    while (child) {
        [self buildHHCTree:child withRoot:preparent withDepth:dep];
        child = child->next;
    }
}


-(BOOL) noCaseStringEqual:(const xmlChar*) str1 withStr :(const xmlChar*) str2
{
    if (0 == xmlStrncasecmp(str1, str2, xmlStrlen(str1) ) )
    {
        return YES;
    }
    return NO;
}

-(NSMutableArray*)getLiNodeNameLocal:(xmlNode*) liNode
{
    //取到object
    NSMutableArray *nameAndLocal = [[NSMutableArray alloc] initWithCapacity:2];
    xmlNode *objNode = liNode->children;
    NSAssert(0 == xmlStrcmp(objNode->name, BAD_CAST"object"), @"no object");
    if ([self noCaseStringEqual:objNode->name withStr:kOBJECT])
    {
        //取到param
        xmlNode *param = objNode->children;
        while (param) {
            if ([self noCaseStringEqual:param->name withStr:kPARAM]) {
                xmlAttr *attr = param->properties;
                while (attr) {
                    //todo : 仍然有问题
                    //取属性 找到  name= "Name"  取value ="名字"
                    xmlChar * attrValue = xmlGetProp(param, attr->name);

                    if (0 == xmlStrcmp(attr->name, BAD_CAST"name") &&
                        [self noCaseStringEqual:attrValue withStr:kNAME]) {
                        xmlChar * nameValue = xmlGetProp(param, kVALUE);
                        [nameAndLocal addObject: [NSString stringWithCString:(void *)nameValue encoding:NSUTF8StringEncoding]];
                    }
                    //   name = "Local"  取value = "href"
                    if (0 == xmlStrcmp(attr->name, BAD_CAST"name") &&
                        [self noCaseStringEqual:attrValue withStr:kLOCAL]) {
                        xmlChar * localValue = xmlGetProp(param, kVALUE);
                        [nameAndLocal addObject: [NSString stringWithCString:(void *)localValue encoding:NSUTF8StringEncoding]];
                    }
                    attr = attr->next;
                }
            }
            param = param->next;
        }
    }
    return  nameAndLocal;
}


-(void)printTree: (HHCNode *)node
{
    NSLog(@"%@ : %@", node.name, node.localHref);
    if ([node.children count]) {
        for (HHCNode* child in node.children) {
            [self printTree:child];
        }
    }
}
-(HHCNode* ) buildHHCNode: (xmlNode *) linode
{
    HHCNode *hhcNode = [[HHCNode alloc]initWithXmlNode:linode];
    NSMutableArray *nameAndLocal = [self getLiNodeNameLocal:linode];
    if (1 == [nameAndLocal count]) { //只是目录  没有链接
           hhcNode.name = nameAndLocal[0];
    }
    if (2 == [nameAndLocal count]) {  //正常节点
        hhcNode.name = nameAndLocal[0];
        hhcNode.localHref = nameAndLocal[1];
    }
    return hhcNode;
}


-(id)initWithString:(NSString*)string error:(NSError**)error
{
	if (self = [super init])
	{
		_xmlDoc = NULL;
		
		if ([string length] > 0)
		{
			CFStringEncoding cfenc = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
			CFStringRef cfencstr = CFStringConvertEncodingToIANACharSetName(cfenc);
			const char *enc = CFStringGetCStringPtr(cfencstr, 0);
			
			int optionsHtml = HTML_PARSE_RECOVER;
			optionsHtml = optionsHtml | HTML_PARSE_NOERROR; //Uncomment this to see HTML errors
			optionsHtml = optionsHtml | HTML_PARSE_NOWARNING;
			_xmlDoc = htmlReadDoc ((xmlChar*)[string UTF8String], NULL, enc, optionsHtml);
            xmlNode* xmlNodeRoot = xmlDocGetRootElement(_xmlDoc);
            if (xmlNodeRoot) {
                _hhcRoot = [[HHCNode alloc] initWithXmlNode:xmlNodeRoot];
                _hhcRoot.name = @"Root";
                _hhcRoot.localHref = @"";
                [self buildHHCTree:xmlNodeRoot withRoot:_hhcRoot withDepth:0];
            }
		}
		else
		{
			if (error) {
				*error = [NSError errorWithDomain:@"HTMLParserdomain" code:1 userInfo:nil];
			}
		}
	}
	
	return self;
}


@end
