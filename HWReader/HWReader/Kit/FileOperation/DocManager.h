//
//  DocManager.h
//  HWReader
//
//  Created by LPanda on 14-7-2.
//  Copyright (c) 2014年 huawei. All rights reserved.
//
//  文档管理类，处理文档解压，获取文档路径等工作

#import <Foundation/Foundation.h>

typedef enum {
    ZIP,
    UNZIP
}FileZipState;

typedef enum {
    Resource,
    Document
}FilePathState;

@interface DocManager : NSObject

//  获取document路径
+ (NSString*)getDocumentPath;

//  在document目录下创建存放解压和未解压文件的文件夹
+ (void)createFolderInDocument;

//  在document路径下创建文件存放文件夹
+ (NSString *)getFolderPathFromDocmentPathByFileState:(FileZipState)fileState;

//  获取Resource要解压的文件名数组
+ (NSMutableArray*)getZipFileNamesByPlistName:(NSString *)plistName;

//  从工程指定目录中获取文件路径
+ (NSString *)getFilePathByName:(NSString *)fileName AndPathState:(FilePathState)pathState;
+ (NSString *)getFilePathByName:(NSString *)fileName Type:(NSString *)type
                       AndPathState:(FilePathState)pathState;


//  获取所有需要解压的文件名数组
+ (NSMutableArray *)getAllZipFiles;

//  解压文件
+ (void)unZipFiles;


+(void)unzipFile:(NSString *)zipFilePath
        toDestinationPath: (NSString*) destinationPath;

+(NSString*)unzipFileToDefaulfFloder:(NSString*) zipFilePath;

+(NSString*)getHHCPathIn:(NSString*) folderPath;

+(NSString*)getHHPPathIn:(NSString*) folderPath;

+(NSMutableArray*)getLocalBooks;
+(void)writeToLocalBooks:(NSMutableArray *) books;

+(NSString*) findFileInFloder:(NSString*) folderPath withExtention: (NSString*) fileExt;
@end
