//
//  YZ_PublicImgCell.m
//  imgAndText
//
//  Created by 张亚哲 on 2017/7/22.
//  Copyright © 2017年 张亚哲. All rights reserved.
//

#import "YZ_PublicImgCell.h"

@implementation YZ_PublicImgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)delegateAction:(id)sender {
    if (_deleteImage) {
        _deleteImage();
    }
}

@end
