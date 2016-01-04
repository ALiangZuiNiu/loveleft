
//
//  ArticleTableViewCell.m
//  loveleft
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ArticleTableViewCell.h"

@implementation ArticleTableViewCell



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createUI];
    }
    
    return self;
}

-(void)createUI
{
    // 图片
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, 120, 90) imageName:nil];
    [self.contentView addSubview:_imageView];
    
    // 时间
    _timeLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _imageView.frame.origin.y + _imageView.frame.size.height + 10, 180, 20) text:nil textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:_timeLabel];
    
    //  作者
    _authorLabel = [FactoryUI createLabelWithFrame:CGRectMake(SCREEN_W - 120, _timeLabel.frame.origin.y, 100, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:_authorLabel];
    
    
    // 标题
    _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(_imageView.frame.origin.x + _imageView.frame.size.width + 10, 30, 200, 40) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:15]];
    
    // 拆行
    _titleLabel.numberOfLines = 0;
    _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    [self.contentView addSubview:_titleLabel];
}

-(void)refreshUI:(ArticleModel *)model
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabel.text  = model.title;
    _authorLabel.text = model.author;
    _timeLabel.text = model.createtime;
}


- (void)awakeFromNib {
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
