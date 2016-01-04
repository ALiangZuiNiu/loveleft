//
//  HomeModel.m
//  loveleft
//
//  Created by qianfeng on 15/12/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

// 防崩溃
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"])
    {
         self.dataID = value;
    }
}

@end
