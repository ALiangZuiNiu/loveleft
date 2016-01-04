//
//  FoodCell.h
//  loveleft
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"

@protocol playDelegate <NSObject>

-(void)play:(FoodModel *)model;

@end

@interface FoodCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * descLabel;

//声明一个代理的对象 ,代理修饰符用week，主要是为了防止循环引用导致的内存泄露，ARC下的strong和week就相当于MRC下的retain和assign
@property (nonatomic,weak) id<playDelegate>delegate;

-(void)refreshUI:(FoodModel *)model;

@end
