//
//  WebSelectController.m
//  WEBIMAGE
//
//  Created by 王通 on 2017/11/17.
//  Copyright © 2017年 王通. All rights reserved.
//

#import "SetController.h"

@interface SetController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *setTabelView;
@property (strong, nonatomic) NSMutableDictionary *dataSource;
@property (strong, nonatomic) NSString *lastInputURL;
@property (strong, nonatomic) NSString *currentSelectURL;

@end

@implementation SetController

- (void)viewDidLoad {
    [super viewDidLoad];
    _setTabelView.delegate = self;
    _setTabelView.dataSource = self;
    _dataSource = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:SET_URL_GROUPSET]];
    _currentSelectURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"webImage.set.defaultURLset"];
    /*
    if (!MBIsStringWithAnyText(_currentSelectURL) && [_dataSource[URL_section] count] > 0) {
        _currentSelectURL = MBNonEmptyString(_dataSource[URL_section][0]);
        [[NSUserDefaults standardUserDefaults] setObject:MBNonEmptyString(_dataSource[URL_section][0]) forKey:@"webImage.set.defaultURLset"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [self cellHeight:indexPath];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [_dataSource[SET_URL_GROUPSET_URLSECTION] count] + 2;
            break;
            
        case 1:
            return [_dataSource[SET_URL_GROUPSET_GROUPSECTION] count] + 1;
            break;
            
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 60;
            break;
            
        case 1:
            return 60;
            break;
            
        default:
            return 60;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *v = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 60)];
    
    switch (section) {
        case 0:
            v.textLabel.text = @"您可以在这里管理常用的访问网址";
            break;
            
        case 1:
            v.textLabel.text = @"您可以在这里管理图片组";
            break;
            
        default:
            break;
    }
    
    return v;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == [_dataSource[SET_URL_GROUPSET_URLSECTION] count]) {
                [cell.textLabel setText:@"添加网址"];
                [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
                [cell.textLabel setTextColor:self.view.tintColor];
                cell.accessoryType = UITableViewCellAccessoryNone;
            } else if (indexPath.row == [_dataSource[SET_URL_GROUPSET_URLSECTION] count] + 1) {
                [cell.textLabel setText:@"清空默认网址"];
                [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
                [cell.textLabel setTextColor:self.view.tintColor];
                cell.accessoryType = UITableViewCellAccessoryNone;
            } else {
                [cell.textLabel setText:MBNonEmptyString(_dataSource[SET_URL_GROUPSET_URLSECTION][indexPath.row])];
                [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
                [cell.textLabel setTextColor:[UIColor blackColor]];
                
                if ([MBNonEmptyString(_dataSource[SET_URL_GROUPSET_URLSECTION][indexPath.row]) isEqualToString:MBNonEmptyString(_currentSelectURL)]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            }
            break;
        case 1:
            if (indexPath.row == [_dataSource[SET_URL_GROUPSET_GROUPSECTION] count]) {
                [cell.textLabel setText:@"添加"];
                [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
                [cell.textLabel setTextColor:self.view.tintColor];
            }
            break;
            
        default:
            break;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == [_dataSource[SET_URL_GROUPSET_URLSECTION] count]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入要访问的网址" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    if (MBIsStringWithAnyText(_lastInputURL)) {
                        textField.text = _lastInputURL;
                    }
                }];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (MBIsArrayWithItems(alert.textFields)) {
                        NSString *URLString = [(UITextField *)alert.textFields[0] text];
                        if (MBIsStringWithAnyText(URLString) && [self validateURL:URLString]) {
                            _lastInputURL = @"";
                            
                            NSMutableArray *URLArray = [NSMutableArray arrayWithArray:_dataSource[SET_URL_GROUPSET_URLSECTION]];
                            [URLArray addObject:MBNonEmptyString(URLString)];
                            [_dataSource setObject:URLArray forKey:SET_URL_GROUPSET_URLSECTION];
                            
                            [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                            
                            [[NSUserDefaults standardUserDefaults] setObject:_dataSource forKey:SET_URL_GROUPSET];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
                        } else {
                            _lastInputURL = MBNonEmptyString(URLString);
                            WIWarning(@"网址格式不正确", @"了解");
                        }
                    }
                }];
                
                [alert addAction:cancelAction];
                [alert addAction:okAction];
                
                [self presentViewController:alert animated:YES completion:^{
                }];
            } else if (indexPath.row == [_dataSource[SET_URL_GROUPSET_URLSECTION] count] + 1) {
                _currentSelectURL = @"";
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"webImage.set.defaultURLset"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"webImage.notification.URLChange" object:nil];
                [_setTabelView reloadData];
                WIWarning(@"默认网址已清空", @"了解");
            } else {
                _currentSelectURL = MBNonEmptyString(_dataSource[SET_URL_GROUPSET_URLSECTION][indexPath.row]);
                [[NSUserDefaults standardUserDefaults] setObject:MBNonEmptyString(_dataSource[SET_URL_GROUPSET_URLSECTION][indexPath.row]) forKey:@"webImage.set.defaultURLset"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"webImage.notification.URLChange" object:nil];
                [_setTabelView reloadData];
            }
            break;
        case 1:
            if (indexPath.row == [_dataSource[SET_URL_GROUPSET_GROUPSECTION] count]) {
            }
            break;
            
        default:
            break;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == [_dataSource[SET_URL_GROUPSET_URLSECTION] count]) {
                return NO;
            } else {
                return YES;
            }
            break;
        case 1:
            if (indexPath.row == [_dataSource[SET_URL_GROUPSET_GROUPSECTION] count]) {
                return NO;
            } else {
                return YES;
            }
            break;
            
        default:
            return NO;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//
//        if ([MBNonEmptyString(_myAddressList[indexPath.row][[BSPayQueryHisAddList isDefault]]) isEqualToString:@"1"]) {
//            return @"";
//        }else{
//            return @"默认";
//        }
//    }
    
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            if (editingStyle == UITableViewCellEditingStyleDelete) {
                NSMutableArray *URLArray = [NSMutableArray arrayWithArray:_dataSource[SET_URL_GROUPSET_URLSECTION]];
                [URLArray removeObjectAtIndex:indexPath.row];
                [_dataSource setObject:URLArray forKey:SET_URL_GROUPSET_URLSECTION];

                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                
                [[NSUserDefaults standardUserDefaults] setObject:_dataSource forKey:SET_URL_GROUPSET];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            break;
        case 1:
            break;
            
        default:
            break;
    }
    if (indexPath.section == 0) {
//        if (editingStyle == UITableViewCellEditingStyleDelete) {
//            NSString *houseId = MBNonEmptyString(_myAddressList[indexPath.row][[BSPayQueryHisAddList houseId]]);
//            [self setDefaultAddress:houseId];
//        }
        
    } else {
//        if (editingStyle == UITableViewCellEditingStyleDelete) {
//            [self deleteAddress:indexPath];
//        }
//        else if (editingStyle == UITableViewCellEditingStyleInsert) {
//
//        }
    }
    
}

- (BOOL)validateURL:(NSString *)URL {
//    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSString *regex = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSString *regex = @"(http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:MBNonEmptyString(URL)];
}

/**
 *  网址正则验证 1或者2使用哪个都可以
 *
 *  @param string 要验证的字符串
 *
 *  @return 返回值类型为BOOL
 */
- (BOOL)urlValidation:(NSString *)string {
    NSError *error;
    // 正则1
//    NSString *regulaStr =@"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    // 正则2
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    if (MBIsArrayWithItems(arrayOfAllMatches)) {
        return YES;
    }
//    for (NSTextCheckingResult *match in arrayOfAllMatches){
//        NSString* substringForMatch = [string substringWithRange:match.range];
//        NSLog(@"匹配");
//        return YES;
//    }
    return NO;
}

@end
