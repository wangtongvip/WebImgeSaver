//
//  DataManager.m
//  WEBIMAGE
//
//  Created by 王通 on 2017/11/20.
//  Copyright © 2017年 王通. All rights reserved.
//

#import "DataManager.h"

#define IMAGE_CACHE_TABLE_NAME @"IMAGE_CACHE_TABLE" //表名
#define IMAGE_ID @"ID"                              //图片编号
#define IMAGE_DATA @"DATA"                          //图片数据
#define IMAGE_COMPRESS_DATA @"COMPRESSDATA"         //图片缩略图
#define IMAGE_H @"IMAGEHEIGHT"                      //图片高度
#define IMAGE_W @"IMAGEWIGHT"                       //图片宽度
#define IMAGE_RATIO @"RATIO"                        //宽高比
#define IMAGE_URL @"URL"                            //原图片的访问路径
#define IMAGE_IS_DELETE @"ISDELETE"                 //是否已删除
#define IMAGE_UPDATE_TIME @"UPDATETIME"             //图片更新时间

@interface DataManager () {
}

@property (nonatomic, strong) FMDatabase *dataBase;
@property (nonatomic, strong) FMDatabaseQueue *FMDatabaseQueue;

@end

@implementation DataManager

+ (id)shareDataManager
{
    static DataManager *__DataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __DataManager = [[DataManager alloc] init];
        
        NSString *dataPath = [YWFileManager pathForDocumentsDirectoryWithPath:@"/Data/Data.db"];
        if (![YWFileManager existsItemAtPath:dataPath]) {
            [YWFileManager createDirectoriesForPath:[YWFileManager pathForDocumentsDirectoryWithPath:@"/Data/"]];
            __DataManager.dataBase = [FMDatabase databaseWithPath:dataPath];
            CreatTable(__DataManager.dataBase);
            __DataManager.FMDatabaseQueue = [FMDatabaseQueue databaseQueueWithPath:dataPath];
            
        } else {
            __DataManager.dataBase = [FMDatabase databaseWithPath:dataPath];
            __DataManager.FMDatabaseQueue = [FMDatabaseQueue databaseQueueWithPath:dataPath];
        }
    });
    return __DataManager;
}

void CreatTable(FMDatabase *dataBase) {
    if ([dataBase open]) {
        //创建表
        NSString *tableCulom = [NSString stringWithFormat:@"CREATE TABLE '%@' ('%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text)",
                                IMAGE_CACHE_TABLE_NAME,
                                IMAGE_ID,
                                IMAGE_DATA,
                                IMAGE_COMPRESS_DATA,
                                IMAGE_H,
                                IMAGE_W,
                                IMAGE_RATIO,
                                IMAGE_URL,
                                IMAGE_IS_DELETE,
                                IMAGE_UPDATE_TIME];
        [dataBase executeUpdate:tableCulom];
        [dataBase close];
    }
}

- (void)insertImage:(UIImage *)image imageURL:(NSString *)url {
    if (!image || !MBIsStringWithAnyText(url)) {
        WIWarning(@"图片数据异常", @"了解");
        return;
    }
    
    const char *identifier = [@"insertImageData" cStringUsingEncoding:NSASCIIStringEncoding];
    dispatch_queue_t q1 = dispatch_queue_create(identifier, NULL);
    dispatch_async(q1, ^{
        [[[DataManager shareDataManager] FMDatabaseQueue] inDatabase:^(FMDatabase *fmdb) {
            /*
            NSString *sql = [NSString stringWithFormat:@"delete from '%@' where %@ = \"%@\"",IMAGE_CACHE_TABLE_NAME, IMAGE_URL, MBNonEmptyString(url)];
            
            BOOL deleteRES = [fmdb executeUpdate:sql];
            if (!deleteRES) {
            } else {
            }
             */
            
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
            NSData *imageCompressData = UIImageJPEGRepresentation(image, 0.1f);
            NSString *imageH = [NSString stringWithFormat:@"%.0zu",CGImageGetHeight(image.CGImage)];
            NSString *imageW = [NSString stringWithFormat:@"%.0zu",CGImageGetWidth(image.CGImage)];
            NSString *ratio = [NSString stringWithFormat:@"%.4f",(float)CGImageGetWidth(image.CGImage) / (float)CGImageGetHeight(image.CGImage)];
            NSString *ID = [[NSDate date] dateTimeStringWithFormat:@"yyyyMMddHHmmss"];
            NSString *updateTime = [[NSDate date] dateTimeStringWithFormat:@"yyyyMMddHHmmss"];
            
            NSString *insertSql = [NSString stringWithFormat:
                                   @"INSERT INTO '%@' ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                                   IMAGE_CACHE_TABLE_NAME,
                                   IMAGE_ID,
                                   IMAGE_DATA,
                                   IMAGE_COMPRESS_DATA,
                                   IMAGE_H,
                                   IMAGE_W,
                                   IMAGE_RATIO,
                                   IMAGE_URL,
                                   IMAGE_IS_DELETE,
                                   IMAGE_UPDATE_TIME];
            BOOL insertRES = [fmdb executeUpdate:insertSql,
                              ID,
                              imageData,
                              imageCompressData,
                              imageH,
                              imageW,
                              ratio,
                              MBNonEmptyString(url),
                              @"0",
                              updateTime];
            if (!insertRES) {
                NSLog(@"插入数据失败...");
                WIWarning(@"保存图片失败", @"了解");
            } else {
                NSLog(@"插入数据成功...");
                WIWarning(@"保存图片成功", @"了解");
            }
        }];
    });
}

- (void)queryImageWithID:(NSString *)ID finish:(void (^)(UIImage *image, BOOL success))finish {
    const char *identifier = [@"queryImageData" cStringUsingEncoding:NSASCIIStringEncoding];
    dispatch_queue_t q1 = dispatch_queue_create(identifier, NULL);
    dispatch_async(q1, ^{
        [[[DataManager shareDataManager] FMDatabaseQueue] inDatabase:^(FMDatabase *fmdb) {
            FMResultSet *searchRS = [fmdb executeQuery:[NSString stringWithFormat:@"SELECT * FROM '%@' where %@ = \"%@\"",IMAGE_CACHE_TABLE_NAME, IMAGE_ID, ID]];
            NSData *imageData = nil;
            while ([searchRS next]) {
                imageData = [searchRS dataForColumn:IMAGE_DATA];
                break;
            }
            UIImage *returnImage = [UIImage imageWithData:(NSData *)imageData];
            [searchRS close];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finish) {
                    finish(returnImage, YES);
                }
            });
        }];
    });
}

- (void)queryImageCompressWithID:(NSString *)ID finish:(void (^)(UIImage *image, BOOL success))finish {
    const char *identifier = [@"queryImageCompressData" cStringUsingEncoding:NSASCIIStringEncoding];
    dispatch_queue_t q1 = dispatch_queue_create(identifier, NULL);
    dispatch_async(q1, ^{
        [[[DataManager shareDataManager] FMDatabaseQueue] inDatabase:^(FMDatabase *fmdb) {
            FMResultSet *searchRS = [fmdb executeQuery:[NSString stringWithFormat:@"SELECT * FROM '%@' where %@ = \"%@\"",IMAGE_CACHE_TABLE_NAME, IMAGE_ID, ID]];
            NSData *imageData = nil;
            while ([searchRS next]) {
                imageData = [searchRS dataForColumn:IMAGE_COMPRESS_DATA];
                break;
            }
            UIImage *returnImage = [UIImage imageWithData:imageData];
            [searchRS close];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finish) {
                    finish(returnImage, YES);
                }
            });
        }];
    });
}

//物理删除
- (void)deleteImagePhysicsWithImageIDs:(NSArray *)imageIDs {
    const char *identifier = [@"deletePhysicsImageData" cStringUsingEncoding:NSASCIIStringEncoding];
    dispatch_queue_t q1 = dispatch_queue_create(identifier, NULL);
    dispatch_async(q1, ^{
        [[[DataManager shareDataManager] FMDatabaseQueue] inDatabase:^(FMDatabase *fmdb) {
            //物理清除图片
            for (int i = 0; i < [imageIDs count]; i++) {
                NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = \"%@\"", IMAGE_CACHE_TABLE_NAME, IMAGE_ID, MBNonEmptyString(imageIDs[i])];
                [fmdb executeUpdate:sqlstr];
            }
        }];
    });
}

//逻辑删除
- (void)deleteImageLogicWithImageIDs:(NSArray *)imageIDs {
    const char *identifier = [@"deleteLogicImageData" cStringUsingEncoding:NSASCIIStringEncoding];
    dispatch_queue_t q1 = dispatch_queue_create(identifier, NULL);
    dispatch_async(q1, ^{
        [[[DataManager shareDataManager] FMDatabaseQueue] inDatabase:^(FMDatabase *fmdb) {
            NSString *updateTime = [[NSDate date] dateTimeStringWithFormat:@"yyyyMMddHHmmss"];
            //逻辑清除图片
            for (int i = 0; i < [imageIDs count]; i++) {
                NSString *updateSql = [NSString stringWithFormat: @"UPDATE %@ SET %@ = \"%@\", %@ = \"%@\" WHERE %@ = \"%@\"", IMAGE_CACHE_TABLE_NAME, IMAGE_IS_DELETE, @"1", IMAGE_UPDATE_TIME, updateTime, IMAGE_ID, MBNonEmptyString(imageIDs[i])];
                [fmdb executeUpdate:updateSql];
            }
        }];
    });
}

- (void)queryImageWithStatus:(ImageStatus)status finish:(void (^)(NSMutableArray *images, BOOL success))finish {
    const char *identifier = [@"queryAllImageData" cStringUsingEncoding:NSASCIIStringEncoding];
    dispatch_queue_t q1 = dispatch_queue_create(identifier, NULL);
    dispatch_async(q1, ^{
        [[[DataManager shareDataManager] FMDatabaseQueue] inDatabase:^(FMDatabase *fmdb) {
            FMResultSet *searchRS = nil;
            switch (status) {
                case ImageStatusAll:
                    searchRS = [fmdb executeQuery:[NSString stringWithFormat:@"SELECT * FROM '%@' ORDER BY %@ DESC",IMAGE_CACHE_TABLE_NAME, IMAGE_UPDATE_TIME]];
                    break;
                case ImageStatusNormal:
                    searchRS = [fmdb executeQuery:[NSString stringWithFormat:@"SELECT * FROM '%@' WHERE %@ = \"%@\" ORDER BY %@ DESC",IMAGE_CACHE_TABLE_NAME, IMAGE_IS_DELETE, @"0", IMAGE_UPDATE_TIME]];
                    break;
                case ImageStatusRubbish:
                    searchRS = [fmdb executeQuery:[NSString stringWithFormat:@"SELECT * FROM '%@' WHERE %@ = \"%@\" ORDER BY %@ DESC",IMAGE_CACHE_TABLE_NAME, IMAGE_IS_DELETE, @"1", IMAGE_UPDATE_TIME]];
                    break;
                    
                default:
                    break;
            }
            NSMutableArray *images = [NSMutableArray array];
            while ([searchRS next]) {
                ImageModel *model = [[ImageModel alloc] init];
                model.imageID = [searchRS stringForColumn:IMAGE_ID];
                model.aspectRatio = [searchRS stringForColumn:IMAGE_RATIO];
                [images addObject:model];
            }
            [searchRS close];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finish) {
                    finish(images, YES);
                }
            });
        }];
    });
}

@end
