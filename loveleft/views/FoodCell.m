//
//  FoodCell.m
//  loveleft
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "FoodCell.h"

@interface FoodCell ()
{
    FoodModel * _foodModel;
}
@end

@implementation FoodCell

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
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, (SCREEN_W - 20)/2 - 20, 130) imageName:nil];
    
    _imageView.userInteractionEnabled = YES;
    
    _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _imageView.frame.size.height+_imageView.frame.origin.y+5, _imageView.frame.size.width, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:15]];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    
    _descLabel = [FactoryUI createLabelWithFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y+_titleLabel.frame.size.height, _titleLabel.frame.size.width, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:12]];
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_descLabel];
    [self.contentView addSubview:_imageView];
    
    
    // 播放按钮
    UIButton * playerButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 40, 40) title:nil titleColor:nil imageName:@"iconfont-bofang" backgroundImageName:nil target:self selector:@selector(playerButtonClick)];
    playerButton.center = _imageView.center;
    [_imageView addSubview:playerButton];
}


// 播放按钮
-(void)playerButtonClick
{
    if([_delegate respondsToSelector:@selector(play:)]){
        [_delegate play:_foodModel];
    }
}


-(void)refreshUI:(FoodModel *)model
{
    _foodModel = model;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabel.text = model.title;
    _descLabel.text = model.detail;
}


@end
