//
//  MusicCollectionViewCell.m
//  loveleft
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "MusicCollectionViewCell.h"


@implementation MusicCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self createUI];
    }
    return self;
}

-(void)createUI

{
    self.imageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) imageName:nil];
    
    [self.contentView addSubview:self.imageView];
    
    self.titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height) text:@"" textColor:nil font:[UIFont systemFontOfSize:14]];
    [self.imageView addSubview:self.titleLabel];
}

@end
