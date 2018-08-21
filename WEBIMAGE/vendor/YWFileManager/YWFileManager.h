//
//  YWFileManager.h
//
//  Created by Fabio Caccamo on 28/01/14.
//  Copyright (c) 2014 Fabio Caccamo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^SuccessBlock)(id result);
typedef void(^FaildBlock)(NSError *error);

@interface YWFileManager : NSObject

/*!
 *  获取文件的某个属性
 *
 *  @param path 文件路径
 *  @param key  属性名
 *
 *  @return 属性对应的值
 */
+(id)attributeOfItemAtPath:(NSString *)path forKey:(NSString *)key;
/*!
 *  获取文件的某个属性
 *
 *  @param path 文件路径
 *  @param key  属性名
 *  @param error  记录错误信息的对象
 *
 *  @return 属性对应的值
 */
+(id)attributeOfItemAtPath:(NSString *)path forKey:(NSString *)key error:(NSError **)error;
/*!
 *  获取文件的某个属性
 *
 *  @param path 文件路径
 *  @param key  属性名
 *  @param success  成功后执行的block
 *  @param faild  失败时执行的block
 *
 */
+(void)attributeOfItemAtPath:(NSString *)path forKey:(NSString *)key success:(void(^)(id result))success faild:(void(^)(NSError *error))faild;

/*!
 *  获取文件的属性列表
 *
 *  @param path 文件路径
 *
 *  @return 属性字典
 */
+(NSDictionary *)attributesOfItemAtPath:(NSString *)path;
/*!
 *  获取文件的属性列表
 *
 *  @param path 文件路径
 *  @param error 记录错误信息的对象
 *
 *  @return 属性字典
 */
+(NSDictionary *)attributesOfItemAtPath:(NSString *)path error:(NSError **)error;
/*!
 *  获取文件的属性列表
 *
 *  @param path 文件路径
 *  @param success  成功后执行的block
 *  @param faild  失败时执行的block
 *
 */
+(void)attributesOfItemAtPath:(NSString *)path success:(void(^)(NSDictionary *result))success faild:(void(^)(NSError *error))faild;

/*!
 *  拷贝文件到指定路径
 *
 *  @param path    原文件路径
 *  @param topath  目标路径
 *
 *  @return 拷贝是否成功
 */
+(BOOL)copyItemAtPath:(NSString *)path toPath:(NSString *)topath;
/*!
 *  拷贝文件到指定路径
 *
 *  @param path    原文件路径
 *  @param topath  目标路径
 *  @param error 记录错误信息的对象
 *
 *  @return 拷贝是否成功
 */
+(BOOL)copyItemAtPath:(NSString *)path toPath:(NSString *)topath error:(NSError **)error;
/*!
 *  拷贝文件到指定路径
 *
 *  @param path    原文件路径
 *  @param toPath  目标路径
 *  @param success  成功后执行的block
 *  @param faild  失败时执行的block
 *
 */
+(void)copyItemAtPath:(NSString *)path toPath:(NSString *)toPath success:(void(^)())success faild:(void(^)(NSError *error))faild;

/*!
 *  创建文件所依赖的目录
 *
 *  @param path 目录路径
 *
 *  @return 是否创建成功
 */
+(BOOL)createDirectoriesForFileAtPath:(NSString *)path;
/*!
 *  创建文件所依赖的目录
 *
 *  @param path 目录路径
 *  @param error 记录错误信息的对象
 *
 *  @return 是否创建成功
 */
+(BOOL)createDirectoriesForFileAtPath:(NSString *)path error:(NSError **)error;

/*!
 *  创建目录
 *
 *  @param path 目录路径
 *
 *  @return 是否创建成功
 */
+(BOOL)createDirectoriesForPath:(NSString *)path;
/*!
 *  创建目录
 *
 *  @param path 目录路径
 *  @param error 记录错误信息的对象
 *
 *  @return 是否创建成功
 */
+(BOOL)createDirectoriesForPath:(NSString *)path error:(NSError **)error;

/*!
 *  创建文件
 *
 *  @param path 文件路径
 *
 *  @return 是否创建成功
 */
+(BOOL)createFileAtPath:(NSString *)path;
/*!
 *  创建文件
 *
 *  @param path 文件路径
 *  @param error 记录错误信息的对象
 *
 *  @return 是否创建成功
 */
+(BOOL)createFileAtPath:(NSString *)path error:(NSError **)error;

/*!
 *  创建文件
 *
 *  @param path 文件路径
 *  @param content 文件内容
 *
 *  @return 是否创建成功
 */
+(BOOL)createFileAtPath:(NSString *)path withContent:(NSObject *)content;
/*!
 *  创建文件
 *
 *  @param path 文件路径
 *  @param content 文件内容
 *  @param error 记录错误信息的对象
 *
 *  @return 是否创建成功
 */
+(BOOL)createFileAtPath:(NSString *)path withContent:(NSObject *)content error:(NSError **)error;

/*!
 *  获取文件创建的的时间
 *
 *  @param path 文件路径
 *
 *  @return 创建的时间
 */
+(NSDate *)creationDateOfItemAtPath:(NSString *)path;
/*!
 *  获取文件创建的的时间
 *
 *  @param path 文件路径
 *  @param error 记录错误信息的对象
 *
 *  @return 创建的时间
 */
+(NSDate *)creationDateOfItemAtPath:(NSString *)path error:(NSError **)error;

/*!
 *  清空 caches 目录
 *
 *  @return 清空操作是否成功
 */
+(BOOL)emptyCachesDirectory;
/*!
 *  清空 temporary 目录
 *
 *  @return 清空操作是否成功
 */
+(BOOL)emptyTemporaryDirectory;

/*!
 *  判断目标路径是否存在
 *
 *  @param path 目录路径
 *
 *  @return 是否存在
 */
+(BOOL)existsItemAtPath:(NSString *)path;

/*!
 *  判断目标路径是否为目录
 *
 *  @param path 目标路径
 *
 *  @return 是否为目录
 */
+(BOOL)isDirectoryItemAtPath:(NSString *)path;
/*!
 *  判断目标路径是否为目录
 *
 *  @param path 目标路径
 *  @param error 记录错误信息的对象
 *
 *  @return 是否为目录
 */
+(BOOL)isDirectoryItemAtPath:(NSString *)path error:(NSError **)error;
/*!
 *  判断目标路径是否为空
 *
 *  @param path 目标路径
 *
 *  @return 是否为空
 */
+(BOOL)isEmptyItemAtPath:(NSString *)path;
/*!
 *  判断目标路径是否为空
 *
 *  @param path 目标路径
 *  @param error 记录错误信息的对象
 *
 *  @return 是否为空
 */
+(BOOL)isEmptyItemAtPath:(NSString *)path error:(NSError **)error;
/*!
 *  判断目标路径是否为文件
 *
 *  @param path 目标路径
 *
 *  @return 是否为文件
 */
+(BOOL)isFileItemAtPath:(NSString *)path;
/*!
 *  判断目标路径是否为文件
 *
 *  @param path 目标路径
 *  @param error 记录错误信息的对象
 *
 *  @return 是否为文件
 */
+(BOOL)isFileItemAtPath:(NSString *)path error:(NSError **)error;

/*!
 *  是否是可执行文件
 *
 *  @param path 文件路径
 *
 *  @return 是否是可执行文件
 */
+(BOOL)isExecutableItemAtPath:(NSString *)path;
/*!
 *  是否文件可读
 *
 *  @param path 文件路径
 *
 *  @return 是否文件可读
 */
+(BOOL)isReadableItemAtPath:(NSString *)path;
/*!
 *  是否文件可写
 *
 *  @param path 文件路径
 *
 *  @return 是否文件可写
 */
+(BOOL)isWritableItemAtPath:(NSString *)path;

/*!
 *  获取目录下的文件
 *
 *  @param path 目录路径
 *
 *  @return 文件数组
 */
+(NSArray *)listFilesInDirectoryAtPath:(NSString *)path;
/*!
 *  获取目录下指定类型的文件
 *
 *  @param path 目录路径
 *  @param extension 文件扩展名
 *
 *  @return 获取目录下指定类型的文件
 */
+(NSArray *)listFilesInDirectoryAtPath:(NSString *)path withExtension:(NSString *)extension;
/*!
 *  获取目录下指定文件名前缀的文件
 *
 *  @param path 目录路径
 *  @param prefix 前缀
 *
 *  @return 获取目录下指定文件名前缀的文件
 */
+(NSArray *)listFilesInDirectoryAtPath:(NSString *)path withPrefix:(NSString *)prefix;
/*!
 *  获取目录下指定文件名后缀的文件
 *
 *  @param path 目录路径
 *  @param suffix 后缀
 *
 *  @return 获取目录下指定文件名后缀的文件
 */
+(NSArray *)listFilesInDirectoryAtPath:(NSString *)path withSuffix:(NSString *)suffix;
/*!
 *  获取目录下的文件
 *
 *  @param path 目录路径
 *  @param deep 是否查找子目录
 *
 *  @return 获取目录下的文件
 */
+(NSArray *)listItemsInDirectoryAtPath:(NSString *)path deep:(BOOL)deep;

/*!
 *  移动文件到指定目录
 *
 *  @param path   文件路径
 *  @param toPath 目标路径
 *
 *  @return 移动是否成功
 */
+(BOOL)moveItemAtPath:(NSString *)path toPath:(NSString *)toPath;
/*!
 *  移动文件到指定目录
 *
 *  @param path   文件路径
 *  @param toPath 目标路径
 *  @param error 记录错误信息的对象
 *
 *  @return 移动是否成功
 */
+(BOOL)moveItemAtPath:(NSString *)path toPath:(NSString *)toPath error:(NSError **)error;
/*!
 *  移动文件到指定目录
 *
 *  @param path   文件路径
 *  @param toPath 目标路径
 *  @param success  成功后执行的block
 *  @param faild  失败时执行的block
 *
 */
+(void)moveItemAtPath:(NSString *)path toPath:(NSString *)toPath success:(void(^)())success faild:(void(^)(NSError *error))faild;

/*!
 *  获取application support路径
 *
 *  @return 获取application support路径
 */
+(NSString *)pathForApplicationSupportDirectory;
/*!
 *  获取application support目录下文件的路径
 *  @param path   相对路径
 *
 *  @return 获取application support目录下文件的路径
 */
+(NSString *)pathForApplicationSupportDirectoryWithPath:(NSString *)path;

/*!
 *  获取 caches 路径
 *
 *  @return 获取 caches 路径
 */
+(NSString *)pathForCachesDirectory;
/*!
 *  获取caches目录下文件的路径
 *  @param path   相对路径
 *
 *  @return 获取caches目录下文件的路径
 */
+(NSString *)pathForCachesDirectoryWithPath:(NSString *)path;

/*!
 *  获取 Documents 目录路径
 *
 *  @return 获取 Documents 目录路径
 */
+(NSString *)pathForDocumentsDirectory;
/*!
 *  获取Documents目录下文件的路径
 *  @param path   相对路径
 *
 *  @return 获取Documents目录下文件的路径
 */
+(NSString *)pathForDocumentsDirectoryWithPath:(NSString *)path;

/*!
 *  获取 Library 目录路径
 *
 *  @return 获取 Library 目录路径
 */
+(NSString *)pathForLibraryDirectory;
/*!
 *  获取Library目录下文件的路径
 *  @param path   相对路径
 *
 *  @return 获取Library目录下文件的路径
 */
+(NSString *)pathForLibraryDirectoryWithPath:(NSString *)path;

/*!
 *  获取 main bundle 目录路径
 *
 *  @return 获取 main bundle 目录路径
 */
+(NSString *)pathForMainBundleDirectory;
/*!
 *  获取 main bundle 目录下文件的路径
 *  @param path   相对路径
 *
 *  @return 获取 main bundle 目录下文件的路径
 */
+(NSString *)pathForMainBundleDirectoryWithPath:(NSString *)path;

/*!
 *  查找 main bundle 目录下某plist文件的路径
 *
 *  @param name plist文件名
 *
 *  @return 文件路径
 */
+(NSString *)pathForPlistNamed:(NSString *)name;

/*!
 *  获取 temp 目录路径
 *
 *  @return 获取 temp 目录路径
 */
+(NSString *)pathForTemporaryDirectory;
/*!
 *  获取 temp 目录下文件的路径
 *  @param path   相对路径
 *
 *  @return 获取 temp 目录下文件的路径
 */
+(NSString *)pathForTemporaryDirectoryWithPath:(NSString *)path;

/*!
 *  读取文本文件内容
 *
 *  @param path 文件路径
 *
 *  @return 文件内容
 */
+(NSString *)readFileAtPath:(NSString *)path;
/*!
 *  读取文本文件内容
 *
 *  @param path 文件路径
 *  @param error 记录错误信息的对象
 *
 *  @return 文本内容
 */
+(NSString *)readFileAtPath:(NSString *)path error:(NSError **)error;

/*!
 *  读取数组文件内容
 *
 *  @param path 文件路径
 *
 *  @return 数组
 */
+(NSArray *)readFileAtPathAsArray:(NSString *)path;

/*!
 *  读取序列化文件
 *
 *  @param path 文件路径
 *
 *  @return 反序列化对象
 */
+(NSObject *)readFileAtPathAsCustomModel:(NSString *)path;

/*!
 *  读取 data 类型文件
 *
 *  @param path 文件路径
 *
 *  @return data对象
 */
+(NSData *)readFileAtPathAsData:(NSString *)path;
/*!
 *  读取 data 类型文件
 *
 *  @param path 文件路径
 *  @param error 记录错误信息的对象
 *
 *  @return data对象
 */
+(NSData *)readFileAtPathAsData:(NSString *)path error:(NSError **)error;

/*!
 *  读取 dictionary 类型文件
 *
 *  @param path 文件路径
 *
 *  @return 字典对象
 */
+(NSDictionary *)readFileAtPathAsDictionary:(NSString *)path;

/*!
 *  读取图片文件
 *
 *  @param path 文件路径
 *
 *  @return 图片对象
 */
+(UIImage *)readFileAtPathAsImage:(NSString *)path;
/*!
 *  读取图片文件
 *
 *  @param path 文件路径
 *  @param error 记录错误信息的对象
 *
 *  @return 图片对象
 */
+(UIImage *)readFileAtPathAsImage:(NSString *)path error:(NSError **)error;

/*!
 *  读取图片文件返回构造好的 UIImageView
 *
 *  @param path 图片路径
 *
 *  @return UIImageView对象
 */
+(UIImageView *)readFileAtPathAsImageView:(NSString *)path;
/*!
 *  读取图片文件返回构造好的 UIImageView
 *
 *  @param path 图片路径
 *  @param error 记录错误信息的对象
 *
 *  @return UIImageView对象
 */
+(UIImageView *)readFileAtPathAsImageView:(NSString *)path error:(NSError **)error;

/*!
 *  读取json文件数据，并转换成 NSDictionary
 *
 *  @param path json路径
 *
 *  @return NSDictionary字典
 */
+(NSDictionary *)readFileAtPathAsJSON:(NSString *)path;
/*!
 *  读取json文件数据，并转换成 NSDictionary
 *
 *  @param path json路径
 *  @param error 记录错误信息
 *
 *  @return NSDictionary字典
 */
+(NSDictionary *)readFileAtPathAsJSON:(NSString *)path error:(NSError **)error;

/*!
 *  读取 array 类型文件数据，并转换成 NSMutableArray 对象
 *
 *  @param path 文件路径
 *
 *  @return NSMutableArray字典
 */
+(NSMutableArray *)readFileAtPathAsMutableArray:(NSString *)path;

/*!
 *  读取 Data 类型文件数据，返回构造好的 NSMutableData 对象
 *
 *  @param path 文件路径
 *
 *  @return NSMutableData 对象
 */
+(NSMutableData *)readFileAtPathAsMutableData:(NSString *)path;
/*!
 *  读取 Data 类型文件数据，返回构造好的 NSMutableData 对象
 *
 *  @param path 文件路径
 *  @param error 记录错误信息
 *
 *  @return NSMutableData 对象
 */
+(NSMutableData *)readFileAtPathAsMutableData:(NSString *)path error:(NSError **)error;

/*!
 *  读取 Dictionary 类型文件数据，返回构造好的 NSMutableDictionary 对象
 *
 *  @param path 文件路径
 *
 *  @return NSMutableDictionary 对象
 */
+(NSMutableDictionary *)readFileAtPathAsMutableDictionary:(NSString *)path;

/*!
 *  读取 String 类型文件，返回 NSString 对象
 *
 *  @param path 文件路径
 *
 *  @return NSString 对象
 */
+(NSString *)readFileAtPathAsString:(NSString *)path;
/*!
 *  读取 String 类型文件，返回 NSString 对象
 *
 *  @param path 文件路径
 *  @param error 记录错误信息
 *
 *  @return NSString 对象
 */
+(NSString *)readFileAtPathAsString:(NSString *)path error:(NSError **)error;

/*!
 *  删除文件
 *
 *  @param path 文件路径
 *
 *  @return 是否删除成功
 */
+(BOOL)removeFilesInDirectoryAtPath:(NSString *)path;
/*!
 *  删除文件
 *
 *  @param path 文件路径
 *  @param error 记录错误信息
 *
 *  @return 是否删除成功
 */
+(BOOL)removeFilesInDirectoryAtPath:(NSString *)path error:(NSError **)error;
/*!
 *  删除指定扩展名文件
 *
 *  @param path 文件路径
 *  @param extension 扩展名
 *
 *  @return 是否删除成功
 */
+(BOOL)removeFilesInDirectoryAtPath:(NSString *)path withExtension:(NSString *)extension;
/*!
 *  删除指定扩展名文件
 *
 *  @param path 文件路径
 *  @param extension 扩展名
 *  @param error 记录错误信息
 *
 *  @return 是否删除成功
 */
+(BOOL)removeFilesInDirectoryAtPath:(NSString *)path withExtension:(NSString *)extension error:(NSError **)error;
/*!
 *  删除指定文件名前缀的文件
 *
 *  @param path 文件路径
 *  @param prefix 文件名前缀
 *
 *  @return 是否删除成功
 */
+(BOOL)removeFilesInDirectoryAtPath:(NSString *)path withPrefix:(NSString *)prefix;
/*!
 *  删除指定文件名前缀的文件
 *
 *  @param path 文件路径
 *  @param prefix 文件名前缀
 *  @param error 记录错误信息
 *
 *  @return 是否删除成功
 */
+(BOOL)removeFilesInDirectoryAtPath:(NSString *)path withPrefix:(NSString *)prefix error:(NSError **)error;
/*!
 *  删除指定文件名后缀的文件
 *
 *  @param path 文件路径
 *  @param prefix 文件名后缀
 *
 *  @return 是否删除成功
 */
+(BOOL)removeFilesInDirectoryAtPath:(NSString *)path withSuffix:(NSString *)suffix;
/*!
 *  删除指定文件名后缀的文件
 *
 *  @param path 文件路径
 *  @param prefix 文件名后缀
 *  @param error 记录错误信息
 *
 *  @return 是否删除成功
 */
+(BOOL)removeFilesInDirectoryAtPath:(NSString *)path withSuffix:(NSString *)suffix error:(NSError **)error;

/*!
 *  删除目录
 *
 *  @param path 目录路径
 *
 *  @return 是否删除成功
 */
+(BOOL)removeItemsInDirectoryAtPath:(NSString *)path;
/*!
 *  删除目录
 *
 *  @param path 目录路径
 *  @param error 记录错误信息
 *
 *  @return 是否删除成功
 */
+(BOOL)removeItemsInDirectoryAtPath:(NSString *)path error:(NSError **)error;

/*!
 *  删除文件
 *
 *  @param path 文件路径
 *
 *  @return 是否删除成功
 */
+(BOOL)removeItemAtPath:(NSString *)path;
/*!
 *  删除文件
 *
 *  @param path 文件路径
 *  @param error 记录错误信息
 *
 *  @return 是否删除成功
 */
+(BOOL)removeItemAtPath:(NSString *)path error:(NSError **)error;

/*!
 *  删除指定目录下的文件
 *
 *  @param path 目录路径
 *  @param name 文件名
 *
 *  @return 是否删除成功
 */
+(BOOL)renameItemAtPath:(NSString *)path withName:(NSString *)name;
/*!
 *  删除指定目录下的文件
 *
 *  @param path 目录路径
 *  @param name 文件名
 *  @param error 记录错误信息
 *
 *  @return 是否删除成功
 */
+(BOOL)renameItemAtPath:(NSString *)path withName:(NSString *)name error:(NSError **)error;

/*!
 *  获取文件的大小
 *
 *  @param path 文件路径
 *
 *  @return 文件大小
 */
+(NSNumber *)sizeOfItemAtPath:(NSString *)path;
/*!
 *  获取文件的大小
 *
 *  @param path 文件路径
 *  @param error 记录错误信息
 *
 *  @return 文件大小
 */
+(NSNumber *)sizeOfItemAtPath:(NSString *)path error:(NSError **)error;

/*!
 *  获取指定路径构造的 NSURL 对象
 *
 *  @param path 文件路径
 *
 *  @return NSURL对象
 */
+(NSURL *)urlForItemAtPath:(NSString *)path;

/*!
 *  将内容写入文件
 *
 *  @param path    文件路径
 *  @param content 文件内容
 *
 *  @return 是否写入成功
 */
+(BOOL)writeFileAtPath:(NSString *)path content:(NSObject *)content;
/*!
 *  将内容写入文件
 *
 *  @param path    文件路径
 *  @param content 文件内容
 *  @param error 记录错误信息
 *
 *  @return 是否写入成功
 */
+(BOOL)writeFileAtPath:(NSString *)path content:(NSObject *)content error:(NSError **)error;

/*!
 *  修复应用应用程序沙盒中的文件路径
 *  由于应用程序重新安装（升级）导致ApplicationID变化，造成原沙盒中的文件路径变化
 *
 *  @param path    文件路径
 *
 *  @return 是否写入成功
 */
+(NSString *)fixApplicationFilePath:(NSString *)path;

@end

