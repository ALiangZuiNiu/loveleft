//
//  RecordModel.m
//  loveleft
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "RecordModel.h"

@implementation RecordModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        
        self.dataID = value;
    }
}


@end
