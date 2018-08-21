//
//  ESClobalCore.m
//  DandelionPhone
//
//  Created by Tracy E on 12-11-30.
//  Copyright (c) 2012 China M-World Co.,Ltd. All rights reserved.
//

#import "WIGlobalCore.h"

#import <objc/runtime.h>

///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL MBIsArrayWithItems(id object) {
    return [object isKindOfClass:[NSArray class]] && [(NSArray*)object count] > 0;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL MBIsSetWithItems(id object) {
    return [object isKindOfClass:[NSSet class]] && [(NSSet*)object count] > 0;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL MBIsStringWithAnyText(id object) {
    return [object isKindOfClass:[NSString class]] && [(NSString*)object length] > 0;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
void SwapMethods(Class cls, SEL originalSel, SEL newSel) {
    Method originalMethod = class_getInstanceMethod(cls, originalSel);
    Method newMethod = class_getInstanceMethod(cls, newSel);
    method_exchangeImplementations(originalMethod, newMethod);
}

NSString* MBPlaceHolderString(id obj) {
    if (obj == nil || obj == [NSNull null] ||
        ([obj isKindOfClass:[NSString class]] && [obj length] == 0)) {
        return @"--";
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return MBNonEmptyString([obj stringValue]);
    }
    return obj;
}

NSString* MBNonEmptyString_(id obj) {
    if (obj == nil || obj == [NSNull null] ||
        ([obj isKindOfClass:[NSString class]] && [obj length] == 0)) {
        return @"-";
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return MBNonEmptyString([obj stringValue]);
    }
    return obj;
}

NSString* MBNonEmptyString(id obj){
    if (obj == nil || obj == [NSNull null] ||
        ([obj isKindOfClass:[NSString class]] && [obj length] == 0)) {
        return @"";
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return MBNonEmptyString([obj stringValue]);
    } else if ([obj isKindOfClass:[NSString class]] && ([[obj stringValue] isEqualToString:@"null"] || [[obj stringValue] isEqualToString:@"NULL"])) {
        return @"";
    }
    return obj;
}

NSString* MBNonEmptyStringNo_(id obj){
    if (obj == nil || obj == [NSNull null] ||
        ([obj isKindOfClass:[NSString class]] && [obj length] == 0)) {
        return @"";
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return MBNonEmptyString([obj stringValue]);
    }
    return obj;
}

NSInteger MBDaysOfMonthAndYear(NSInteger month, NSInteger year) {
    NSInteger days;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            days = 31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            days = 30;
            break;
        case 2:{
            days = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 ? 29 : 28;
            break;
        }
        default:
            days = 30;
            break;
    }
    return days;
}

BOOL MBIsStringContantDrop(id object){
    return [object isKindOfClass:[NSString class]] && [object rangeOfString:@"."].location != NSNotFound;
}

BOOL MBIsPureInt(id obj) {
    NSScanner *scan = [NSScanner scannerWithString:MBNonEmptyString(obj)];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

BOOL MBIsPureFloat(id obj) {
    NSScanner *scan = [NSScanner scannerWithString:MBNonEmptyString(obj)];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

BOOL MBIsPureNumberCharacters(id obj) {
    return MBIsPureInt(obj) || MBIsPureFloat(obj);
}
