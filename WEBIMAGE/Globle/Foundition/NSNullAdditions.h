//
//  NSNull+Additions.h
//  BOCMBCI
//
//  Created by Tracy E on 13-5-14.
//  Copyright (c) 2013年 China M-World Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNull (Additions)

- (NSString *)stringValue;

- (NSString *)format4n4;

- (NSString *)formatMonery;

-(NSString *)formatAnyDecimal;

- (NSString *)formatMoneyWithCurrency:(NSString *)currency;

- (BOOL)isEqualToString:(NSString *)string;

- (NSUInteger)length;


- (NSString *)replace:(NSString *)oldString with:(NSString *)newString;

- (NSString *)phoneNumberTrim;

- (NSString *)formatAccount;

- (NSString *)formatMonerySpecial;

- (NSString *)formatMoneryThreeDecimal;

- (NSString *)formatMoneryFourDecimal;

- (NSString *)correctUserInput;

- (NSString *)mobileFormat;

- (NSString *)formatWhiteSpace;

- (NSString *)formatWhiteSpaceAndNewLineCharacterSet;

- (NSString *)formatBalance;

- (NSString *)formatMoneyUpper;

@end
