//
//  RecordCell.m
//  loveleft
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "RecordCell.h"

@implementation RecordCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    //头像
    _imageIcon = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, 40, 40) imageName:nil];
    _imageIcon.layer.cornerRadius = 20;
//    [self.contentView addSubview:_imageIcon];
    
    //网名
    _nameLabel = [FactoryUI createLabelWithFrame:CGRectMake(_imageIcon.frame.size.width + _imageIcon.frame.origin.x + 10, 30, 100, 20) text:nil textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:16]];
    [self.contentView addSubview:_nameLabel];
    
    //时间
    _timeLabel = [FactoryUI createLabelWithFrame:CGRectMake(SCREEN_W - 160, 30, 150, 20) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:12]];
    
    [self.contentView addSubview:_timeLabel];
    
    //图片
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, _imageIcon.frame.size.height + 10, SCREEN_W - 20, 160) imageName:nil];
    [self.contentView addSubview:_imageView];
    
    //文字
//    _textLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _imageView.frame.size.height  + _imageView.frame.origin.y , SCREEN_W - 20, 70) text:nil textColor:nil font:[UIFont systemFontOfSize:14]];
//    _textLabel.numberOfLines = 0;
//    _textLabel.lineBreakMode = NSLineBreakByCharWrapping;
//    
//    [self.contentView addSubview:_textLabel];
    
    _textLabel = [[UILabel alloc]init];
    _textLabel.textColor = [UIColor darkGrayColor];
    _textLabel.font = [UIFont systemFontOfSize:17];
    _textLabel.numberOfLines = 0;
    _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:_textLabel];
}


- (void)refreshUI:(RecordModel *)model
{
//    _textLabel.text = model.textString;
    
    _timeLabel.text = model.pub_timeString;
    _nameLabel.text = model.publisher_nameString;
    
    [_imageIcon sd_setImageWithURL:[NSURL URLWithString:model.publisher_icon_urlString] placeholderImage:[UIImage imageNamed:@"special_palcehold"]];
    
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"special_palcehold"]];
    
    // 计算内容的大小
    CGSize contentSize = [model.textString boundingRectWithSize:CGSizeMake(SCREEN_W-20, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _textLabel.frame = CGRectMake(10, _imageView.frame.size.height + _imageView.frame.origin.y + 10, SCREEN_W - 20, contentSize.height + 20);
    _textLabel.text = model.textString;
    
    self.cellHeight = CGRectGetMaxY(_textLabel.frame) + 10;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
