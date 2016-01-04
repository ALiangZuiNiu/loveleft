//
//  FoodTitleCell.m
//  loveleft
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "FoodTitleCell.h"

@implementation FoodTitleCell

-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, (SCREEN_W-20)/2, 30) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

@end
