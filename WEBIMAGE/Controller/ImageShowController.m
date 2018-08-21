//
//  ImageShowController.m
//  WEBIMAGE
//
//  Created by WT on 2018/8/13.
//  Copyright © 2018年 王通. All rights reserved.
//

#import "ImageShowController.h"
#import "ImageScalView.h"

@interface ImageShowController () {
    ImageScalView *_imageScalView;
}

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ImageShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
    tap.numberOfTapsRequired = 3;
    [self.view addGestureRecognizer:tap];
}

- (void)close:(UIGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)setDisplayImage:(UIImage *)displayImage {
    _displayImage = displayImage;
    [self showImage];
}

- (void)showImage {
    if (_imageView) {
        [_imageView removeFromSuperview];
    }
    _imageScalView = [[ImageScalView alloc] initWithFrame:self.view.frame];
    _imageScalView.displayImage = _displayImage;
    [self.view insertSubview:_imageScalView atIndex:0];
}

#pragma mark- UIViewControllerDelegate

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self showImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
