//
//  DataManager.h
//  WEBIMAGE
//
//  Created by 王通 on 2017/11/20.
//  Copyright © 2017年 王通. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ImageStatusAll,
    ImageStatusNormal,
    ImageStatusRubbish,
} ImageStatus;

@interface DataManager : NSObject

+ (id)shareDataManager;

- (void)insertImage:(UIImage *)image imageURL:(NSString *)url;

- (void)queryImageWithID:(NSString *)ID finish:(void (^)(UIImage *image, BOOL success))finish;

- (void)queryImageCompressWithID:(NSString *)ID finish:(void (^)(UIImage *image, BOOL success))finish;

//物理删除
- (void)deleteImagePhysicsWithImageIDs:(NSArray *)imageIDs;

//逻辑删除
- (void)deleteImageLogicWithImageIDs:(NSArray *)imageIDs;

- (void)queryImageWithStatus:(ImageStatus)status finish:(void (^)(NSMutableArray *images, BOOL success))finish;

@end
