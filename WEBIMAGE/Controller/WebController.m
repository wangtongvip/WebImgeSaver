//
//  WebController.m
//  WEBIMAGE
//
//  Created by 王通 on 2017/11/17.
//  Copyright © 2017年 王通. All rights reserved.
//

#import "WebController.h"

@interface WebController () <WKNavigationDelegate, WKUIDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) WKWebView *displayWeb;
@property (nonatomic, assign) BOOL banJump;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation WebController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAction:) name:@"webImage.notification.URLChange" object:nil];
    [self refreshAction:nil];
}

- (IBAction)backStepAction:(id)sender {
    if ([self.displayWeb canGoBack]) {
        [self.displayWeb goBack];
    } else {
        [self refreshAction:nil];
    }
}

- (IBAction)refreshAction:(id)sender {
    NSString *URLString = [[NSUserDefaults standardUserDefaults] objectForKey:@"webImage.set.defaultURLset"];
//    NSString *URLString = @"http://www.cocoachina.com/ios/20171128/21339.html";
    if (MBIsStringWithAnyText(URLString)) {
        [self.displayWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLString]]];
        [[DataManager shareDataManager] queryImageWithStatus:ImageStatusAll finish:^(NSMutableArray *images, BOOL success) {
            for (int i = 0; i < [images count]; i++) {
                NSLog(@"ID----------%@",[images[i] imageID]);
                NSLog(@"RA----------%@",[images[i] aspectRatio]);
            }
        }];
    } else {
        [self.displayWeb loadHTMLString:@"<p style=\"text-align:center;\"><br /><br /><br /></p><p style=\"text-align:center;\"><span style=\"color:#999999; font-size:60px;\">请在设置中添加地址后使用</span></p>" baseURL:nil];
    }
}

- (WKWebView *)displayWeb {
    if (!_displayWeb) {
        _displayWeb = [[WKWebView alloc] init];
        [_displayWeb setBackgroundColor:[UIColor blackColor]];
        [self.view insertSubview:_displayWeb atIndex:0];
        [_displayWeb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
        }];
        _displayWeb.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _displayWeb.contentMode = UIViewContentModeRedraw;
        _displayWeb.opaque = YES;
        _displayWeb.UIDelegate =self;
        _displayWeb.navigationDelegate = self;
        _displayWeb.allowsBackForwardNavigationGestures = YES;
        
        [_displayWeb addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [_displayWeb addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        longPress.minimumPressDuration = 1;
        longPress.delegate = self;
        [_displayWeb addGestureRecognizer:longPress];
    }
    return _displayWeb;
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)sender {
    if (sender.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    _banJump = YES;
    
    CGPoint touchPoint = [sender locationInView:_displayWeb];
    // 获取长按位置对应的图片url的JS代码
    NSString *imgJS = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
    // 执行对应的JS代码 获取url
    [_displayWeb evaluateJavaScript:imgJS completionHandler:^(id _Nullable imgUrl, NSError * _Nullable error) {
        if (imgUrl) {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
            UIImage *image = [UIImage imageWithData:data];
            if (!image) {
                WIWarning(@"读取图片失败", @"了解");
                _banJump = NO;
                return;
            }
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"保存图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[DataManager shareDataManager] insertImage:image imageURL:(NSString *)imgUrl];
                _banJump = NO;
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                _banJump = NO;
            }];
            
            [actionSheet addAction:okAction];
            [actionSheet addAction:cancelAction];
            [self presentViewController:actionSheet animated:YES completion:^{
            }];
        }
    }];
}

#pragma mark- KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == self.displayWeb) {
            [_progressView setProgress:self.displayWeb.estimatedProgress animated:YES];
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else if ([keyPath isEqualToString:@"title"]) {
        if (object == self.displayWeb) {
            self.navigationItem.title = self.displayWeb.title;
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark- UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

#pragma mark- WKNavigationDelegate

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [_progressView setProgress:0.0f];
    [_progressView setHidden:NO];
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [_progressView setHidden:YES];
    // 不执行前段界面弹出列表的JS代码
    [self.displayWeb evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    [_progressView setHidden:YES];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (_banJump) {
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

#pragma mark- WKUIDelegate

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
