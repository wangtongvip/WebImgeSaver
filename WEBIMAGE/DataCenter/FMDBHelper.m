//
//  FMDBHelper.m
//  charge
//
//  Created by 王通 on 2016/10/10.
//  Copyright © 2016年 YinWan. All rights reserved.
//

#import "FMDBHelper.h"
#import "FMDatabaseAdditions.h"

@implementation FMDBHelper

BOOL IsTableInDB(FMDatabase *db,NSString * tableName) {
    FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        NSLog(@"isTableOK %d", count);
        if (0 == count) {
            return NO;
        } else {
            return YES;
        }
    }
    return NO;
}

BOOL IsColumnInDBTable(FMDatabase *db, NSString * tableName, NSString *columnName) {
    return [db columnExists:MBNonEmptyString(columnName) inTableWithName:tableName];
}

BOOL CheckColumnInDBTable(FMDatabase *db, NSString * tableName, NSArray *columnNames) {
    BOOL isOk = YES;
    for (NSString *column in columnNames) {
        if (MBIsStringWithAnyText(column)) {
            if (![db columnExists:MBNonEmptyString(column) inTableWithName:tableName]) {
                NSString *alertStr = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ text",tableName, MBNonEmptyString(column)];
                if (![db executeUpdate:alertStr]) {
                    isOk = NO;
                }
            }
        }
    }
    return isOk;
}

@end
