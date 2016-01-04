//
//  MusicListCell.h
//  loveleft
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"

@interface MusicListCell : UITableViewCell
{
    UIImageView * _imageView;
    UILabel * _singerLabel;
    UILabel * _nameLabel;
    
}

-(void)refreshUI:(MusicModel *)model;

@end
