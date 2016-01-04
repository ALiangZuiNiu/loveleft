//
//  MusicListCell.m
//  loveleft
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "MusicListCell.h"


@implementation MusicListCell


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
    _imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, 100, 70) imageName:nil];
    [self.contentView addSubview:_imageView];
    
    _nameLabel = [FactoryUI createLabelWithFrame:CGRectMake(_imageView.frame.size.width + _imageView.frame.origin.x + 10, 20, 150, 20) text:nil textColor:[UIColor redColor] font:[UIFont systemFontOfSize:14]];
    
    [self.contentView addSubview:_nameLabel];
}

-(void)refreshUI:(MusicModel *)model{

    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.coverURL] placeholderImage:[UIImage imageNamed:@""]];
    
    _nameLabel.text = model.title;
    _singerLabel.text = model.artist;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
