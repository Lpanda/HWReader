//
//  DocParser.m
//  HWReader
//
//  Created by LPanda on 14-7-3.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "DocParser.h"

@implementation DocParser

-(NSMutableArray *)getAllFilesByType:(NSString *)type{
    NSMutableArray *hhcPaths = [[NSMutableArray alloc]init];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *unZipPath = [DocManager getFolderPathFromDocmentPathByFileState:UNZIP];
    
    NSArray *unZipFileFolder = [fileManager contentsOfDirectoryAtPath:unZipPath error:nil];
    
    NSString *unZipFile = nil;
    
    for (NSString *fileName in unZipFileFolder) {
        
        NSString *unZipFilePath = [NSString stringWithFormat:@"%@/%@",unZipPath,fileName];
        
        NSDirectoryEnumerator *unZipFileDirEnum = [fileManager enumeratorAtPath:unZipFilePath];
        
        while (unZipFile = [unZipFileDirEnum nextObject]) {
            
            if ([[unZipFile pathExtension] isEqualToString:type]) {
                
                [hhcPaths addObject:[NSString stringWithFormat:@"%@/%@",unZipFilePath,unZipFile]];
                
                break;
            }
        }
    }
    
    return hhcPaths;
}

-(NSMutableDictionary *)parseFile{
    return nil;
}

@end
