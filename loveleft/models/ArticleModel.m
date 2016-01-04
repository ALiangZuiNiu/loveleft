//
//  ArticleModel.m
//  loveleft
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"])
    {
        self.dataID = value;
    }
}


@end
