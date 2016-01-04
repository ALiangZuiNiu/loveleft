//
//  RecordCell.h
//  loveleft
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordModel.h"

@interface RecordCell : UITableViewCell
{
    //  头像
    UIImageView *_imageIcon;
    
    UIImageView *_imageView;
    UILabel *_timeLabel;
    UILabel *_textLabel;
    UILabel *_nameLabel;
}

@property(nonatomic,assign)CGFloat cellHeight;

-(void)refreshUI:(RecordModel *)model;

@end
