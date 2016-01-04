//
//  ArticleTableViewCell.h
//  loveleft
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"

@interface ArticleTableViewCell : UITableViewCell
{

    UIImageView * _imageView;
    
    UILabel * _timeLabel;
    
    UILabel * _authorLabel;
    
    UILabel * _titleLabel;
    
}

-(void)refreshUI:(ArticleModel *)model;


@end
