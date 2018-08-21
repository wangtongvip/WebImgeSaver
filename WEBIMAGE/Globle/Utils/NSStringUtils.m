//
//  NSString+Utils.m
//  BOCMBCI
//
//  Created by Tracy E on 13-4-12.
//  Copyright (c) 2013年 China M-World Co.,Ltd. All rights reserved.
//

#import "NSStringUtils.h"
#import "WIGlobalCore.h"


@implementation NSString (Utils)

+ (NSString *)stringWithString:(NSString *)string times:(NSInteger)times{
    NSMutableString *result = [[NSMutableString alloc] init];
    for (int i = 0; i < times; i++) {
        [result appendString:string];
    }
    return result;
}

- (NSString *)replace:(NSString *)o with:(NSString *)n{
    return [self stringByReplacingOccurrencesOfString:o withString:n];
}

- (NSString *)format4n4{
    NSInteger len = self.length;
    if (len < 8) {
        return self;
    }
    NSRange range = NSMakeRange(4, len - 8);
    NSString *points = [NSString stringWithString:@"*" times:6];
    return [self stringByReplacingCharactersInRange:range withString:points];
}

- (NSString *)format434{
    NSInteger len = self.length;
    if (len < 8) {
        return self;
    }
    NSRange range = NSMakeRange(4, len - 8);
    NSString *points = [NSString stringWithString:@"*" times:3];
    return [self stringByReplacingCharactersInRange:range withString:points];
}


- (NSString *)format4444 {
    NSString *subString = @"";
    if ([MBNonEmptyString(self) length] <= 4) {
        subString = [NSString stringWithFormat:@"**** **** **** %@%@",[NSString stringWithString:@"*" times:4 - MBNonEmptyString(self) .length], MBNonEmptyString(self)];
    } else {
        subString = [NSString stringWithFormat:@"**** **** **** %@",[self substringWithRange:NSMakeRange(self.length - 4, 4)]];
    }
    return subString;
}


- (NSString *)mobileFormat
{
    NSInteger len = self.length;
    if (len <= 7) {
        return self;
    }
    NSRange range = NSMakeRange(3, len - 7);
    NSString *points = [NSString stringWithString:@"*" times:4];
    return [self stringByReplacingCharactersInRange:range withString:points];
}

- (NSString *)phoneNumberTrim{
    return [[[[[self replace:@"-" with:@""] replace:@"+86" with:@""] replace:@"(" with:@""] replace:@")" with:@""] replace:@" " with:@""];
}

//姓名加密返显
- (NSString *)formatSecretName {
    
    if ([self length] > 0) {
        NSRange range = NSMakeRange(0, 1);
        return [self stringByReplacingCharactersInRange:range withString:@"*"];
    } else {
        return self;
    }
}

- (NSString *)formatMonery{
    if ([self isKindOfClass:[NSNull class]] || self == nil) {
        return [@"0" formatMonery];
    }
    if ([self length] == 0) {
        return [@"0" formatMonery];
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];
    [formatter setNegativeFormat:@""];
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:[self replace:@"," with:@""]];
    NSString *result = [NSString stringWithFormat:@"￥%@",[formatter stringFromNumber:number]];
    return result;
}


//金额格式化（+99,888,000.00）
- (NSString *)formatMoneyAdd {
    return [[self formatMonery] replace:@"￥" with:@"+"];
}

//金额格式化（-99,888,000.00）
- (NSString *)formatMoneySubtract {
    return [[self formatMonery] replace:@"￥" with:@"-"];
}


//金额格式化（99,888,000.00）
- (NSString *)formatMoneyNoSign {
    return [[self formatMonery] replace:@"￥" with:@""];
}


- (NSString *)formatMonerySpecial{
    return [[self formatMonery] componentsSeparatedByString:@"."][0];
}

- (NSString *)formatMoneryThreeDecimal
{
    NSString * value = [NSString stringWithFormat:@"%.3f",
                        [[self replace:@"," with:@""] doubleValue]];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setCurrencySymbol:@""];
    
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:[value componentsSeparatedByString:@"."][0]];
    return [NSString stringWithFormat:@"%@.%@",
            [formatter stringFromNumber:number],
            [value componentsSeparatedByString:@"."][1]];
}

-(NSString *)formatBalance{
    return [[[self formatMonery] replace:@"," with:@""] substringToIndex:[[self formatMonery] replace:@"," with:@""].length-1];
}

- (NSString *)correctUserInput
{
    NSString *result = self;
    if (result.length > 0)
    {
        if ([result hasPrefix:@"."])
        {
            result = [NSString stringWithFormat:@"0%@",result];
        }
    }
    return result;
}
-(NSString *)formatAnyDecimal{
    if ([[self componentsSeparatedByString:@"."] count]==1) {
        return [[self formatMonery] componentsSeparatedByString:@"."][0];
    }
    NSString *str=[self componentsSeparatedByString:@"."][1];
    NSString *value=[[self formatMonery] componentsSeparatedByString:@"."][0];
    if (!value) {
        return [NSString stringWithFormat:@"0.%@",str];
    }
    return [NSString stringWithFormat:@"%@.%@",value,str];
}

//四舍五入
/* 这个方法有问题
-(NSString *)formatRound {
    //四舍五入
    double temp = [self doubleValue];
    NSString *result = [NSString stringWithFormat:@"%f",round(temp * 100) / 100];
    return result;
}
 */


- (NSString *)formatWhiteSpace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)formatWhiteSpaceAndNewLineCharacterSet
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 *  return string 2015-05
 */
- (NSString *)formatSystemMonthDate
{
    NSDate *tempDate = [NSDate dateWithString:self formatString:@""];
    return MBNonEmptyString([tempDate dateTimeStringWithFormat:@"yyyy-MM"]);
}

/**
 *  return string 2015-05-09
 */
- (NSString *)formatSystemDate {
    NSDate *tempDate = [NSDate dateWithString:self formatString:@""];
    return MBNonEmptyString([tempDate dateTimeStringWithFormat:@"yyyy-MM-dd"]);
}

/**
 *  return string 2015.05.09
 */
- (NSString *)formatPointDate {
    NSDate *tempDate = [NSDate dateWithString:self formatString:@""];
    return MBNonEmptyString([tempDate dateTimeStringWithFormat:@"yyyy.MM.dd"]);
}

/**
 *  return string 2015-05-09 10:15
 */
- (NSString *)formatMinuteDate
{
    NSString *dateString = self;
    if (!MBIsStringWithAnyText(dateString) ||
        [MBNonEmptyString(dateString) length] < 12) {
        return @"--";
    }
    
    if ([MBNonEmptyString(dateString) length] > 12) {
        dateString = [dateString substringToIndex:12];
    }
    
    NSDate *tempDate = [NSDate dateWithString:dateString formatString:@"yyyyMMddHHmm"];
    if (MBIsStringWithAnyText([tempDate dateTimeStringWithFormat:@"yyyy-MM-dd HH:mm"])) {
        return MBNonEmptyString([tempDate dateTimeStringWithFormat:@"yyyy-MM-dd HH:mm"]);
    } else {
        return @"--";
    }
}

/**
 *  return string 2015年05月09日 10:15
 */
- (NSString *)formatMinuteDateWithChinese
{
    NSDate *tempDate = [NSDate dateWithString:self formatString:@""];
    return MBNonEmptyString([tempDate dateTimeStringWithFormat:@"yyyy年MM月dd日 HH:mm"]);
}

/**
 *  return string 2015-05-09 10:15:30
 */
- (NSString *)formatFullSystemDate
{
    NSDate *tempDate = [NSDate dateWithString:self formatString:@""];
    return MBNonEmptyString([tempDate dateTimeStringWithFormat:@"yyyy-MM-dd HH:mm:ss"]);
}

/**
 *  return string 05-09
 */
- (NSString *)formatMonthDayDate {
    NSDate *tempDate = [NSDate dateWithString:self formatString:@""];
    return MBNonEmptyString([tempDate dateTimeStringWithFormat:@"MM-dd"]);
}

//金额四舍五入
- (NSString *)roundAmount
{
    if (!self) {
        return @"";
    }
    NSString *tempSelf = [[self replace:@"," with:@""] replace:@"￥" with:@""];
    NSString *temp = @"";
    
    if ([self rangeOfString:@"."].location == NSNotFound) {
        temp = [NSString stringWithFormat:@"%.2f",[tempSelf doubleValue]];
        return temp;
    }
    
    NSArray *array = [self componentsSeparatedByString:@"."];
    if (array.count > 1 && [array[1] length] >= 3) {
        
        NSString *thr = [array[1] substringWithRange:NSMakeRange(2, 1)];
        
        if ([thr integerValue] == 5) {
            temp = [NSString stringWithFormat:@"%.2f",([tempSelf doubleValue] + 0.005)];
        }else if ([thr integerValue] == 6) {
            temp = [NSString stringWithFormat:@"%.2f",([tempSelf doubleValue] + 0.004)];
        }else if ([thr integerValue] == 7) {
            temp = [NSString stringWithFormat:@"%.2f",([tempSelf doubleValue] + 0.003)];
        }else if ([thr integerValue] == 8) {
            temp = [NSString stringWithFormat:@"%.2f",([tempSelf doubleValue] + 0.002)];
        }else if ([thr integerValue] == 9) {
            temp = [NSString stringWithFormat:@"%.2f",([tempSelf doubleValue] + 0.001)];
        }else if ([thr integerValue] < 5) {
            temp = [NSString stringWithFormat:@"%.2f",[tempSelf doubleValue]];
        }
        
        return temp;
        
    } else {
        temp = [NSString stringWithFormat:@"%.2f",[tempSelf doubleValue]];
        return temp;
    }
}

- (NSString *)roundAmountHorn
{
    /* 舍掉分
     if (!self) {
     return @"";
     }
     NSString *tempSelf = [[self replace:@"," with:@""] replace:@"￥" with:@""];
     NSString *temp = @"";
     
     if ([self rangeOfString:@"."].location == NSNotFound) {
     temp = [NSString stringWithFormat:@"%.2f",[tempSelf doubleValue]];
     return temp;
     }
     
     NSArray *array = [self componentsSeparatedByString:@"."];
     NSString *roundStr = @"";
     if (array.count > 1 && [array[1] length] >= 2) {
     roundStr = [array[1] substringToIndex:1];
     return [NSString stringWithFormat:@"%@.%@0",array[0],roundStr];
     } else {
     return [tempSelf roundAmount];
     }*/
    
    
    //四舍五入至角
    if (!self) {
        return @"";
    }
    NSString *tempSelf = [[self replace:@"," with:@""] replace:@"￥" with:@""];
    NSString *temp = @"";
    
    if ([self rangeOfString:@"."].location == NSNotFound) {
        temp = [NSString stringWithFormat:@"%.2f",[tempSelf doubleValue]];
        return temp;
    }
    
    
    NSArray *array = [self componentsSeparatedByString:@"."];
    if (array.count > 1 && [array[1] length] >= 2) {
        
        NSString *two = [array[1] substringWithRange:NSMakeRange(1, 1)];
        
        if ([two integerValue] == 5) {
            temp = [NSString stringWithFormat:@"%.1f",([tempSelf doubleValue] + 0.05)];
        }else if ([two integerValue] == 6) {
            temp = [NSString stringWithFormat:@"%.1f",([tempSelf doubleValue] + 0.04)];
        }else if ([two integerValue] == 7) {
            temp = [NSString stringWithFormat:@"%.1f",([tempSelf doubleValue] + 0.03)];
        }else if ([two integerValue] == 8) {
            temp = [NSString stringWithFormat:@"%.1f",([tempSelf doubleValue] + 0.02)];
        }else if ([two integerValue] == 9) {
            temp = [NSString stringWithFormat:@"%.1f",([tempSelf doubleValue] + 0.01)];
        }else if ([two integerValue] < 5) {
            temp = [NSString stringWithFormat:@"%.1f",[tempSelf doubleValue]];
        }
        
        return temp = [NSString stringWithFormat:@"%@%@",temp,@"0"];
        
    } else {
        temp = [NSString stringWithFormat:@"%.2f",[tempSelf doubleValue]];
        return temp;
    }
    
}

//金额四舍五入 保留小数点后三位
- (NSString *)roundAmountThree
{
    if (!self) {
        return @"";
    }
    NSString *tempSelf = [[self replace:@"," with:@""] replace:@"￥" with:@""];
    NSString *temp = @"";
    
    if ([self rangeOfString:@"."].location == NSNotFound) {
        temp = [NSString stringWithFormat:@"%.3f",[tempSelf doubleValue]];
        return temp;
    }
    
    NSArray *array = [self componentsSeparatedByString:@"."];
    if (array.count > 1 && [array[1] length] >= 4) {
        
        NSString *thr = [array[1] substringWithRange:NSMakeRange(3, 1)];
        
        if ([thr integerValue] == 5) {
            temp = [NSString stringWithFormat:@"%.3f",([tempSelf doubleValue] + 0.0005)];
        }else if ([thr integerValue] == 6) {
            temp = [NSString stringWithFormat:@"%.3f",([tempSelf doubleValue] + 0.0004)];
        }else if ([thr integerValue] == 7) {
            temp = [NSString stringWithFormat:@"%.3f",([tempSelf doubleValue] + 0.0003)];
        }else if ([thr integerValue] == 8) {
            temp = [NSString stringWithFormat:@"%.3f",([tempSelf doubleValue] + 0.0002)];
        }else if ([thr integerValue] == 9) {
            temp = [NSString stringWithFormat:@"%.3f",([tempSelf doubleValue] + 0.0001)];
        }else if ([thr integerValue] < 5) {
            temp = [NSString stringWithFormat:@"%.3f",[tempSelf doubleValue]];
        }
        
        return temp;
        
    } else {
        temp = [NSString stringWithFormat:@"%.3f",[tempSelf doubleValue]];
        return temp;
    }
}

//金额四舍五入 保留小数点后四位
- (NSString *)roundAmountFour
{
    if (!self) {
        return @"";
    }
    NSString *tempSelf = [[self replace:@"," with:@""] replace:@"￥" with:@""];
    NSString *temp = @"";
    
    if ([self rangeOfString:@"."].location == NSNotFound) {
        temp = [NSString stringWithFormat:@"%.4f",[tempSelf doubleValue]];
        return temp;
    }
    
    NSArray *array = [self componentsSeparatedByString:@"."];
    if (array.count > 1 && [array[1] length] >= 5) {
        
        NSString *thr = [array[1] substringWithRange:NSMakeRange(4, 1)];
        
        if ([thr integerValue] == 5) {
            temp = [NSString stringWithFormat:@"%.4f",([tempSelf doubleValue] + 0.00005)];
        }else if ([thr integerValue] == 6) {
            temp = [NSString stringWithFormat:@"%.4f",([tempSelf doubleValue] + 0.00004)];
        }else if ([thr integerValue] == 7) {
            temp = [NSString stringWithFormat:@"%.4f",([tempSelf doubleValue] + 0.00003)];
        }else if ([thr integerValue] == 8) {
            temp = [NSString stringWithFormat:@"%.4f",([tempSelf doubleValue] + 0.00002)];
        }else if ([thr integerValue] == 9) {
            temp = [NSString stringWithFormat:@"%.4f",([tempSelf doubleValue] + 0.00001)];
        }else if ([thr integerValue] < 5) {
            temp = [NSString stringWithFormat:@"%.4f",[tempSelf doubleValue]];
        }
        
        return temp;
        
    } else {
        temp = [NSString stringWithFormat:@"%.4f",[tempSelf doubleValue]];
        return temp;
    }
}

/**
 *  将 xxxx-xx-xx 的日期格式格式化成某个月的最后一天
 */
- (NSString *)formatLastMonthDate {
    if ([MBNonEmptyString(self) length] < 10) {
        return self;
    }
    
    if ([MBNonEmptyString(self) rangeOfString:@"-"].location == NSNotFound) {
        return self;
    }
    
    NSArray *array = [self componentsSeparatedByString:@"-"];
    if ([array count] < 2) {
        return self;
    }
    NSInteger year = [array[0] integerValue];
    NSString *yearString = [NSString stringWithFormat:@"%d",(int)year];
    NSInteger month = [array[1] integerValue];
    NSString *monthString = [NSString stringWithFormat:@"%d",(int)month];
    if (month < 10) {
        monthString = [NSString stringWithFormat:@"0%d",(int)month];
    }
    NSInteger day = MBDaysOfMonthAndYear(month, year);
    NSString *dayString = [NSString stringWithFormat:@"%d",(int)day];
    if (day < 10) {
        dayString = [NSString stringWithFormat:@"0%d",(int)day];
    }
    
    return [NSString stringWithFormat:@"%@-%@-%@",yearString,monthString,dayString];
}

//字符串倒序
- (NSString *)formatReverse
{
    if (!self || self.length == 0) {
        return @"";
    }
    
    NSString * str = self;
    NSMutableString * reverseString = [NSMutableString string];
    for(int i = 0 ; i < str.length; i ++){
        //倒序读取字符并且存到可变数组数组中
        unichar c = [str characterAtIndex:str.length- i -1];
        [reverseString appendFormat:@"%c",c];
    }
    str = reverseString;
    return str;
}

//去掉小数点后无效的0
- (NSString *)formatNoneZero
{
    if (!self || [self isKindOfClass:[NSNull class]] || self.length == 0 || self.floatValue == 0) {
        return @"0.00";
    }
    
    NSMutableArray *temps = [NSMutableArray array];
    for (NSInteger i=0; i<self.length; i++) {
        NSString *str = [self substringWithRange:NSMakeRange(self.length-i-1, 1)];
        if ([str isEqualToString:@"0"] || [str isEqualToString:@"."]) {
            [temps addObject:str];
        }else{
            break;
        }
    }
    
    NSString *str = [self substringToIndex:(self.length - temps.count)];
    
    return str ? str : @"0.00";
}

//去掉小数点后无效的0
- (NSString *)formatNoneZero_
{
    if (!MBIsStringWithAnyText(self)) {
        return @"";
    }
    
    NSMutableArray *temps = [NSMutableArray array];
    for (NSInteger i = 0; i < self.length; i++) {
        NSString *str = [self substringWithRange:NSMakeRange(self.length-i-1, 1)];
        if ([str isEqualToString:@"0"]) {
            [temps addObject:str];
        } else if ([str isEqualToString:@"."]) {
            [temps addObject:str];
            break;
        } else{
            break;
        }
    }
    
    NSString *str = [self substringToIndex:(self.length - temps.count)];
    
    return str ? str : @"";
}

- (NSString *)formatYearMonthChinese
{
    if (!self || [self isKindOfClass:[NSNull class]] || self.length == 0) {
        return @"";
    }

    if (self.length < 6) {
        return self;
    }
    
    NSString *year = MBNonEmptyString([self substringToIndex:4]);
    NSString *month = [NSString stringWithFormat:@"%ld",(long)[MBNonEmptyString([self substringWithRange:NSMakeRange(4, 2)]) integerValue]];
    
    return [NSString stringWithFormat:@"%@年%@月",year,month];
}

NSString* YWDecimalAdd(NSString *s1, NSString *s2) {
    
    if ([MBNonEmptyString(s1) length] == 0) {
        s1 = @"0";
    }
    
    if ([MBNonEmptyString(s2) length] == 0) {
        s2 = @"0";
    }
    
    
    NSDecimalNumber *n1 = [NSDecimalNumber decimalNumberWithString:s1];
    
    NSDecimalNumber *n2 = [NSDecimalNumber decimalNumberWithString:s2];
    
    NSDecimalNumber *result = [n1 decimalNumberByAdding:n2];
    
    return [NSString stringWithFormat:@"%f",result.doubleValue];
}

NSString* YWDecimalKeepAdd(NSArray *array) {
    
    if (!array || array.count == 0) {
        return @"0";
    }
    
    NSString *result = @"0";
    for (NSInteger i=0; i<array.count; i++) {
        NSString *s = MBNonEmptyString(array[i]);
        result = YWDecimalAdd(result, s);
    }
    
    return result;
}


NSString* YWDecimalSubtract(NSString *s1, NSString *s2) {
    
    if ([MBNonEmptyString(s1) length] == 0) {
        s1 = @"0";
    }
    
    if ([MBNonEmptyString(s2) length] == 0) {
        s2 = @"0";
    }
    
    
    NSDecimalNumber *n1 = [NSDecimalNumber decimalNumberWithString:s1];
    
    NSDecimalNumber *n2 = [NSDecimalNumber decimalNumberWithString:s2];
    
    NSDecimalNumber *result = [n1 decimalNumberBySubtracting:n2];
    
    return [NSString stringWithFormat:@"%f",result.doubleValue];
}

NSString* YWDecimalKeepSubtract(NSArray *array) {
    
    if (!array || array.count == 0) {
        return @"0";
    }
    
    NSString *result = MBNonEmptyString(array[0]);
    for (NSInteger i=0; i<array.count; i++) {
        NSString *s = MBNonEmptyString(array[i]);
        if (i == 0) {
            s = @"0";
        }
        result = YWDecimalSubtract(result, s);
    }
    
    return result;
}

NSString* YWDecimalMultiply(NSString *s1, NSString *s2) {
    
    if ([MBNonEmptyString(s1) length] == 0) {
        s1 = @"0";
    }
    
    if ([MBNonEmptyString(s2) length] == 0) {
        s2 = @"0";
    }
    
    
    NSDecimalNumber *n1 = [NSDecimalNumber decimalNumberWithString:s1];
    
    NSDecimalNumber *n2 = [NSDecimalNumber decimalNumberWithString:s2];
    
    NSDecimalNumber *result = [n1 decimalNumberByMultiplyingBy:n2];
    
    return [NSString stringWithFormat:@"%f",result.doubleValue];
}

NSString* YWDecimalDivid(NSString *s1, NSString *s2) {
    
    if ([MBNonEmptyString(s1) length] == 0) {
        s1 = @"0";
    }
    
    if ([MBNonEmptyString(s2) length] == 0) {
        s2 = @"0";
    }
    
    
    NSDecimalNumber *n1 = [NSDecimalNumber decimalNumberWithString:s1];
    
    NSDecimalNumber *n2 = [NSDecimalNumber decimalNumberWithString:s2];
    
    NSDecimalNumber *result = [n1 decimalNumberByDividingBy:n2];
    
    return [NSString stringWithFormat:@"%f",result.doubleValue];
}

@end
