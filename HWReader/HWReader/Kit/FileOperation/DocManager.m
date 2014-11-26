//
//  DocManager.m
//  HWReader
//
//  Created by LPanda on 14-7-2.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "DocManager.h"
#import "LocalizeManager.h"
#import "ZipArchive.h"

#define FILELISTPATH   @"/FileList.xml"

static  NSString *localPlistName = @"LocalBook";
static NSFileManager *fileManager;

@implementation DocManager

# pragma mark 获取document路径
+ (NSString*)getDocumentPath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docPath = [paths objectAtIndex:0];
    
    return docPath;
    
}

# pragma mark 在document目录下创建存放解压后和未解压文件的文件夹
+ (void)createFolderInDocument{
    
    NSString *zipFolderPath = [NSString stringWithFormat:@"%@/%@",
                               [self getDocumentPath],DOCUMENT_ZIPFILEFOLDERPATH];
    
    if (![fileManager fileExistsAtPath:zipFolderPath]) {
        [fileManager createDirectoryAtPath:zipFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *unZipFolderPath = [NSString stringWithFormat:@"%@/%@",
                               [self getDocumentPath],DOCUMENT_UNZIPFILEFOLDERPATH];
    
    if (![fileManager fileExistsAtPath:unZipFolderPath]) {
        [fileManager createDirectoryAtPath:unZipFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
}

# pragma mark 通过文件状态枚举获取对应的文件夹路径
+ (NSString *)getFolderPathFromDocmentPathByFileState:(FileZipState)fileState{
    
    NSString *folderName = nil;
    
    if (fileState == ZIP) {
        folderName = DOCUMENT_ZIPFILEFOLDERPATH;
    }else{
        folderName = DOCUMENT_UNZIPFILEFOLDERPATH;
    }
    
    NSString *folderPath = [NSString stringWithFormat:@"%@/%@",[self getDocumentPath],folderName];
    
    if (![fileManager fileExistsAtPath:folderPath]) {
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return folderPath;
    
}

# pragma mark 通过plist文件获取其中保存的文件名
+ (NSMutableArray*)getZipFileNamesByPlistName:(NSString *)plistName{
    
    NSDictionary *zipFiles = [NSDictionary dictionaryWithContentsOfFile:
                              [[NSBundle mainBundle] pathForResource: plistName ofType: @"plist"]];
    
    NSMutableArray *fileNames;
    
    //NSString *currentLanguage = [LocalizeManager getCurrentSysLanguage];
    
    fileNames = [zipFiles objectForKey: @"zh-Hans"];
    
    return fileNames;
}

# pragma mark 通过文件名，获取指定目录下的文件路径
+ (NSString *)getFilePathByName:(NSString *)fileName AndPathState:(FilePathState)pathState{
    return [[self class] getFilePathByName:fileName Type:@"zip" AndPathState:pathState];
}

+ (NSString *)getFilePathByName:(NSString *)fileName Type:(NSString *)type
                   AndPathState:(FilePathState)pathState
{
    if ([fileName isEmptyOrNull]) {
        return nil;
    }
    
    NSString *filePath = nil;
    
    if (pathState == Resource) {
        filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:type];
    }else{
        filePath = [NSString stringWithFormat:@"%@/%@",
                    [self getFolderPathFromDocmentPathByFileState:UNZIP],fileName];
    }
    
    return filePath;
}

# pragma mark 获取所有压缩文件路径
+ (NSMutableArray *)getAllZipFiles{
    //  获取到resource目录先要解压的文件名
    NSMutableArray *zipFiles = [[NSMutableArray alloc]init];
    
    NSArray *plistFileNames = [self getZipFileNamesByPlistName:localPlistName];
    
    for (NSString *plistFileName in plistFileNames) {
        NSString *plistFilePath = [self getFilePathByName:plistFileName AndPathState:Resource];
        [zipFiles addObject:plistFilePath];
    }
    
    //  获取document目录下要解压的文件名
    NSString *zipFolderPath = [self getFolderPathFromDocmentPathByFileState:ZIP];
    
    NSArray *docZipFiles = [fileManager contentsOfDirectoryAtPath:zipFolderPath error:nil];
    
    for (NSString *docFileName in docZipFiles) {
        NSString *docFilePath = [self getFilePathByName:docFileName AndPathState:Document];
        [zipFiles addObject:docFilePath];
    }
    
    return zipFiles;
    
}

# pragma mark 文件解压
+ (void)unZipFiles{
    
    fileManager = [NSFileManager defaultManager];
    
    //  获得所有压缩文件路径
    NSMutableArray *zipFiles = [self getAllZipFiles];
    
    NSString *unZipFolderPath = [self getFolderPathFromDocmentPathByFileState:UNZIP];
    
    ZipArchive *zipArchive = [[ZipArchive alloc]init];
    
    for (int i = 0; i != [zipFiles count]; ++ i) {
        
        NSString *zipFilePath = [zipFiles objectAtIndex:i];
        
        NSString *zipFileName = [[zipFilePath componentsSeparatedByString:@"/"] lastObject];
        
        zipFileName = [[zipFileName componentsSeparatedByString:@"."] firstObject];
        
        NSString *unZipPath = [NSString stringWithFormat:@"%@/%@",unZipFolderPath,zipFileName];
        
        if (![fileManager fileExistsAtPath:unZipPath]) {
            [fileManager createDirectoryAtPath:unZipPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        if (![fileManager fileExistsAtPath:unZipPath]) {
            if ([zipArchive UnzipOpenFile:zipFilePath]) {
                BOOL ret = [zipArchive UnzipFileTo:unZipPath overWrite:YES];
                if (ret) {
                    NSLog(@"unZip File to unZipPath Successed!!");
                }else{
                    NSLog(@"unZip File to unZipPath Failed!!");
                }
            }
        }else{
            NSLog(@"unZip File Already Exist!!");
        }
    }
    
    [zipArchive UnzipCloseFile];
    
}

@end
