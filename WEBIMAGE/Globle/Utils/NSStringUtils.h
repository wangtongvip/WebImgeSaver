//
//  NSString+Utils.h
//  BOCMBCI
//
//  Created by Tracy E on 13-4-12.
//  Copyright (c) 2013年 China M-World Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

//字符串替换（如：[@"2013-05-01" replace:@"-" with@"/"];）
- (NSString *)replace:(NSString *)oldString with:(NSString *)newString;

//过滤手机号中一些特殊字符
- (NSString *)phoneNumberTrim;

//姓名加密返显
- (NSString *)formatSecretName;

//账户反显格式化(目前为4-6-4)
- (NSString *)format4n4;

//电话号码(目前为4-3-4)
- (NSString *)format434;

//**** **** **** 1234
- (NSString *)format4444;

//金额格式化 (￥99,888,000.00)
- (NSString *)formatMonery;

//金额格式化（+99,888,000.00）
- (NSString *)formatMoneyAdd;

//金额格式化（-99,888,000.00）
- (NSString *)formatMoneySubtract;

//金额格式化（99,888,000.00）
- (NSString *)formatMoneyNoSign;

//特殊币种格式化不要小数点 (99,888,000)
- (NSString *)formatMonerySpecial;

//金额币种格式化带小数点后3位
- (NSString *)formatMoneryThreeDecimal;

//金额小数位不做控制
-(NSString *)formatAnyDecimal;

//四舍五入
/* 这个方法有问题
-(NSString *)formatRound;
 */

//更正用户输入
//例如：用户在金额输入.11实际是正常的，应该做一下更正
- (NSString *)correctUserInput;

- (NSString *)mobileFormat;

//去除字符串前后空格
- (NSString *)formatWhiteSpace;


//去除字符串前后空格以及后面的换行
- (NSString *)formatWhiteSpaceAndNewLineCharacterSet;

//返回小数点后一位（不带逗号）
-(NSString *)formatBalance;


/**
 *  return string 2015-05
 */
- (NSString *)formatSystemMonthDate;

/**
 *  return string 2015-05-09
 */
- (NSString *)formatSystemDate;

/**
 *  return string 2015.05.09
 */
- (NSString *)formatPointDate;

/**
 *  return string 2015-05-09 10:15
 */
- (NSString *)formatMinuteDate;

/**
 *  return string 2015年05月09日 10:15
 */
- (NSString *)formatMinuteDateWithChinese;

/**
 *  return string 2015-05-09 10:15:30
 */
- (NSString *)formatFullSystemDate;

/**
 *  return string 05-09
 */
- (NSString *)formatMonthDayDate;

//金额四舍五入
- (NSString *)roundAmount;

- (NSString *)roundAmountHorn;

//金额四舍五入 保留小数点后三位
- (NSString *)roundAmountThree;

//金额四舍五入 保留小数点后四位
- (NSString *)roundAmountFour;

/**
 *  将 xxxx-xx-xx 的日期格式格式化成某个月的最后一天
 */
- (NSString *)formatLastMonthDate;

//字符串倒序
- (NSString *)formatReverse;

//去掉小数点后无效的0
- (NSString *)formatNoneZero;

//去掉小数点后无效的0 无效数据用返回""
- (NSString *)formatNoneZero_;

/**
 *  @return string 2016年3月
 */
- (NSString *)formatYearMonthChinese;

#pragma mark- 精确运算

/**
 *  两个数相加
 */
NSString* YWDecimalAdd(NSString *s1, NSString *s2);

/**
 *  多个数相加
 */
NSString* YWDecimalKeepAdd(NSArray *array);

/**
 *  两个数相减
 */
NSString* YWDecimalSubtract(NSString *s1, NSString *s2);

/**
 *  多个数相减
 */
NSString* YWDecimalKeepSubtract(NSArray *array);

/**
 *  两个数相乘
 */
NSString* YWDecimalMultiply(NSString *s1, NSString *s2);

/**
 *  两个数相除
 */
NSString* YWDecimalDivid(NSString *s1, NSString *s2);

@end
