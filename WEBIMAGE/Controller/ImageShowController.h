//
//  ImageShowController.h
//  WEBIMAGE
//
//  Created by WT on 2018/8/13.
//  Copyright © 2018年 王通. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageShowController;

@protocol ImageShowDelegate <NSObject>
@optional
@end

@protocol ImageShowDataSource <NSObject>
@required

- (UIImage *)imageShow:(ImageShowController *)imageShowController getImageAtIndex:(NSInteger)index;

@end

@interface ImageShowController : UIViewController

@property (nonatomic, strong) UIImage *displayImage;

@end
