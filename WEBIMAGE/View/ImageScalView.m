//
//  imageScalView.m
//  WEBIMAGE
//
//  Created by WT on 2018/8/13.
//  Copyright © 2018年 王通. All rights reserved.
//

#import "ImageScalView.h"

@implementation ImageScalView {
    UIImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configSelf];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configSelf];
    }
    return self;
}

- (void)configSelf {
    self.backgroundColor = [UIColor blackColor];
    self.contentSize = CGSizeMake(CGRectGetWidth(self.frame),CGRectGetHeight(self.frame));
    self.minimumZoomScale = 0.5;
    self.maximumZoomScale = 3;
    self.delegate = nil;
    self.delegate = self;
    self.bouncesZoom = YES;
    self.bounces = YES;
    self.scrollEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    tapGesture.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tapGesture];
}

- (void)setDisplayImage:(UIImage *)displayImage {
    [_imageView removeFromSuperview];
    if (displayImage == nil) {
        return;
    }
    _imageView = [[UIImageView alloc] initWithImage:displayImage];
    [_imageView setBackgroundColor:[UIColor clearColor]];
    if (displayImage.size.width > CGRectGetWidth(self.frame) || displayImage.size.height > CGRectGetHeight(self.frame)) {
        CGFloat xScal = displayImage.size.width / CGRectGetWidth(self.frame);
        CGFloat yScal = displayImage.size.height / CGRectGetHeight(self.frame);
        if (xScal > yScal) {
            [_imageView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), displayImage.size.height / xScal)];
        } else {
            [_imageView setFrame:CGRectMake(0, 0, displayImage.size.width / yScal, CGRectGetHeight(self.frame))];
        }
        
        self.minimumZoomScale = 0.5;
        self.maximumZoomScale = 3;
    } else if (displayImage.size.width <= CGRectGetWidth(self.frame) && displayImage.size.height <= CGRectGetHeight(self.frame)) {
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 3;
    } else {
        self.minimumZoomScale = 0.5;
        self.maximumZoomScale = 3;
    }
    [_imageView setCenter:CGPointMake(CGRectGetWidth(self.frame) / 2.0,CGRectGetHeight(self.frame) / 2.0)];
    [self addSubview:_imageView];
}

- (void)doubleTap:(UIGestureRecognizer *)sender {
    if (self.zoomScale == 1.0) {
        [self setZoomScale:2 animated:YES];
    } else {
        [self setZoomScale:1 animated:YES];
    }
}

#pragma mark- UIScrollViewDelegate

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat xCenter = scrollView.center.x;
    CGFloat yCenter = scrollView.center.y;
    //目前contentsize的width是否大于原scrollview的contentsize，如果大于，设置imageview中心x点为contentsize的一半，以固定imageview在该contentsize中心。如果不大于说明图像的宽还没有超出屏幕范围，可继续让中心x点为屏幕中点，此种情况确保图像在屏幕中心。
    xCenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width / 2 : xCenter;
    yCenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height / 2 : yCenter;
    [_imageView setCenter:CGPointMake(xCenter, yCenter)];
}

@end
