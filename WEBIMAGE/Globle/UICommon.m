//
//  UICommon.m
//  WEBIMAGE
//
//  Created by 王通 on 2017/11/20.
//  Copyright © 2017年 王通. All rights reserved.
//

#import "UICommon.h"

void WIWarning(NSString *message, NSString *buttonTitle) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [alert addAction:okAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
        }];
    });
}
