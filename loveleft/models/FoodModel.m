//
//  FoodModel.m
//  loveleft
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "FoodModel.h"

@implementation FoodModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
    if ([key isEqualToString:@"description"]) {
        self.detail = value;
    }
    
}

@end
