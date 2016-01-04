//
//  RecordModel.h
//  loveleft
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordModel : NSObject

// 头像
@property(nonatomic,strong)NSString * publisher_icon_urlString;
// 时间
@property(nonatomic,strong)NSString * pub_timeString;
// 文字
@property(nonatomic,strong)NSString * textString;
// 网名
@property(nonatomic,strong)NSString * publisher_nameString;

// 图片
@property(nonatomic,strong)NSString *image_url;

// id
@property(nonatomic,strong)NSString * dataID;

@end
