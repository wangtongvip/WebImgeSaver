//
//  FMDBHelper.h
//  charge
//
//  Created by 王通 on 2016/10/10.
//  Copyright © 2016年 YinWan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBHelper : NSObject

/**
 *  判断数据库中是否有某张表
 */
BOOL IsTableInDB(FMDatabase *db, NSString * tableName);

/**
 *  检查某张表中是否存在某列
 */
BOOL IsColumnInDBTable(FMDatabase *db, NSString * tableName, NSString *columnName);

/**
 *  检查某张表中是否存在某列，如果不存在就插入一列
 */
BOOL CheckColumnInDBTable(FMDatabase *db, NSString * tableName, NSArray *columnNames);

@end
