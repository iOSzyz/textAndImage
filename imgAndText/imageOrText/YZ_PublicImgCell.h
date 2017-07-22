//
//  YZ_PublicImgCell.h
//  imgAndText
//
//  Created by 张亚哲 on 2017/7/22.
//  Copyright © 2017年 张亚哲. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 发帖图片
 */
@interface YZ_PublicImgCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIProgressView *progressV;

@property(nonatomic,copy)void(^deleteImage)();

@end
