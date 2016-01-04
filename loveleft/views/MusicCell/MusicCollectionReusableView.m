//
//  MusicCollectionReusableView.m
//  loveleft
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "MusicCollectionReusableView.h"

@implementation MusicCollectionReusableView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, 0, self.bounds.size.width, self.bounds.size.height) text:nil textColor:nil font:[UIFont systemFontOfSize:15]];
        [self addSubview:self.titleLabel];
    }
    return self;
}

@end
