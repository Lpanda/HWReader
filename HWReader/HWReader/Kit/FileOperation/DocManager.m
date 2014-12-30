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

static  NSString *kLocalBook = @"LocalBook.plist";
static NSFileManager *fileManager;
@interface DocManager ()<ZipArchiveDelegate>

@end
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

+(NSString*) getLocalBookPath
{
    NSString *docPath = [DocManager getDocumentPath];
    NSString *localBookPath = [docPath stringByAppendingPathComponent:kLocalBook];
    return  localBookPath;
}

+(void)writeToLocalBooks:(NSMutableArray *) books
{
    NSLog(@"ready to write to local book ,para: %@", books);
    [books writeToFile:[DocManager getLocalBookPath] atomically:YES];
}

+(NSMutableArray*)getLocalBooks
{
    NSString *localBookPath = [DocManager getLocalBookPath];
    NSMutableArray* books = [NSMutableArray arrayWithContentsOfFile:localBookPath];
    if(books == nil)
    {
        NSLog(@"create local book plist");
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:localBookPath contents:nil attributes:nil];
        books = [[NSMutableArray alloc] init];
    }
    NSLog(@"%@", books);
    return books;
}

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
    
    NSArray *plistFileNames = [self getZipFileNamesByPlistName:kLocalBook];
    
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

+(void)unzipFile:(NSString *)zipFilePath toDestinationPath: (NSString*) destinationPath
{

}

+(NSString*) unzipFileToDefaulfFloder:(NSString*) zipFilePath
{
    ZipArchive *zipArchive = [[ZipArchive alloc]init];
    
    ZipArchiveProgressUpdateBlock progressBlock = ^(int percentage, int filesProcessed, unsigned long numFiles)
    {
        NSLog(@"total %d, filesProcessed %d of %lu", percentage, filesProcessed, numFiles);
    };
    
    zipArchive.progressBlock = progressBlock;
    
    NSString *unZipFolderPath = [self getFolderPathFromDocmentPathByFileState:UNZIP];
    
    NSString *zipFileName = [[zipFilePath componentsSeparatedByString:@"/"] lastObject];
    
    zipFileName = [[zipFileName componentsSeparatedByString:@"."] firstObject];
    
    NSString *unZipPath = [NSString stringWithFormat:@"%@/%@",unZipFolderPath,zipFileName];
    
    [zipArchive UnzipOpenFile:zipFilePath];
    
    //unzip file to
    BOOL ret = [zipArchive UnzipFileTo:unZipPath overWrite:YES];
    if (ret) {
        NSLog(@"unZip File to unZipPath Successed!!");
    }else{
        NSLog(@"unZip File to unZipPath Failed!!");
    }
    [zipArchive UnzipCloseFile];
    return unZipPath;
}

+(NSString*) findFileInFloder:(NSString*) folderPath withExtention: (NSString*) fileExt
{
    NSFileManager*manager =[NSFileManager defaultManager];
    
    NSDirectoryEnumerator *direnum;
    
    direnum =[manager enumeratorAtPath: folderPath];
    
    NSString *filename;
    
    //定义一个空的NSString对象，如果遍历出来的对象为nil则代表到结尾了，可以跳转循环
    
    while (filename = [direnum nextObject]) {
        
        if ([[filename pathExtension] isEqualToString: fileExt]) {
            return filename;
        }
    }
    return nil;
}

+(NSString*)getHHCPathIn:(NSString*) folderPath
{
    NSLog(@"%@", folderPath);
    NSString *hhcPath = nil;
    
    NSFileManager*manager =[NSFileManager defaultManager];
    
    NSDirectoryEnumerator *direnum;
    
    direnum =[manager enumeratorAtPath: folderPath];
    
    NSString *filename;
    
    //定义一个空的NSString对象，如果遍历出来的对象为nil则代表到结尾了，可以跳转循环
    
    while (filename = [direnum nextObject]) {

        if ([[filename pathExtension] isEqualToString: @"jpg"]) {
            hhcPath = filename;
            break;
        }
    }
    return hhcPath;
}

+(NSString*)getHHPPathIn:(NSString*) folderPath
{
    NSString *hhpPath = nil;
    return hhpPath;
}
@end
