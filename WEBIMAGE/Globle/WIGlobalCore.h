//
//  ESClobalCore.h
//  DandelionPhone
//
//  Created by Tracy E on 12-11-30.
//  Copyright (c) 2012 China M-World Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * Tests if an object is an array which is not empty.
 */
BOOL MBIsArrayWithItems(id object);

/**
 * Tests if an object is a set which is not empty.
 */
BOOL MBIsSetWithItems(id object);

/**
 * Tests if an object is a string which is not empty.
 */
BOOL MBIsStringWithAnyText(id object);

/**
 * Swap the two method implementations on the given class.
 * Uses method_exchangeImplementations to accomplish this.
 */
void MBSwapMethods(Class cls, SEL originalSel, SEL newSel);

/**
 *  [NSNull null], nil, @"" to "--".
 *  NSNumber to NSString.
 *  true -> @"1" | false -> @"0".
 */
NSString* MBPlaceHolderString(id obj);

/**
 *  [NSNull null], nil, @"" to "-".
 *  NSNumber to NSString.
 *  true -> @"1" | false -> @"0".
 */
NSString* MBNonEmptyString_(id obj);

/**
 *  [NSNull null], nil, @"" to "".
 *  NSNumber to NSString.
 *  true -> @"1" | false -> @"0".
 */
NSString* MBNonEmptyString(id obj);

/**
 *  [NSNull null], nil, @"" to "".
 *  NSNumber to NSString.
 *  true -> @"1" | false -> @"0".
 */
NSString* MBNonEmptyStringNo_(id obj);

/**
 *  If target string contant ".",return YES;
 *  else return NO;
 */
BOOL MBIsStringContantDrop(id object);

/**
 *  如果是整形数字字符串,return YES;
 *  else return NO;
 */
BOOL MBIsPureInt(id obj);

/**
 *  如果是浮点形数字字符串,return YES;
 *  else return NO;
 */
BOOL MBIsPureFloat(id obj);

/**
 *  如果是纯数字字符串,return YES;
 *  else return NO;
 */
BOOL MBIsPureNumberCharacters(id obj);

/**
 *  根据年月 返回某个月的天数
 */
NSInteger MBDaysOfMonthAndYear(NSInteger month, NSInteger year);


