//
//  HtmlTextGetter.m
//  HWReader
//
//  Created by zhaochao on 14-12-30.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "HtmlTextGetter.h"

#import <libxml/HTMLparser.h>

@implementation HtmlTextGetter

+ (void)getTextInNode:(xmlNode *)n toString:(NSMutableString *)outString {
    if (!n) {
        return;
    }
    
    for (xmlNode *curNode = n; curNode; curNode = curNode->next) {
        if (curNode->type == XML_TEXT_NODE) {
            NSString *text = [[NSString stringWithUTF8String:(char *)curNode->content] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if (text != nil) {
                [outString appendString:text];
            }
        }
        [self getTextInNode:curNode->children toString:outString];
    }
}

+ (NSString *)getTextByHtml:(NSString  *)html{
    CFStringEncoding cfenc = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
    CFStringRef cfencstr = CFStringConvertEncodingToIANACharSetName(cfenc);
    const char *enc = CFStringGetCStringPtr(cfencstr, 0);
    htmlDocPtr doc = htmlReadDoc((xmlChar *)[html UTF8String],
                                           "",
                                           enc,
                                           XML_PARSE_NOERROR | XML_PARSE_NOWARNING);
    NSMutableString *outString = [[NSMutableString alloc] init];
    [[self class] getTextInNode:xmlDocGetRootElement(doc) toString:outString];
    return outString;
}

@end
