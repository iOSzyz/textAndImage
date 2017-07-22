//
//  ZYZ_Node.m
//  imgAndText
//
//  Created by 张亚哲 on 2017/7/22.
//  Copyright © 2017年 张亚哲. All rights reserved.
//

#import "ZYZ_Node.h"

@implementation ZYZ_Node

-(NSDictionary *)toDict{
    return @{};
}

-(void)setSelectImage:(UIImage *)selectImage{
    if (_selectImage != selectImage) {
        _selectImage = selectImage;
        _isUpload = NO;
        _cellHeight = selectImage.size.height/selectImage.size.width * ([UIScreen mainScreen].bounds.size.width - 40);
        _widthScale = selectImage.size.width/selectImage.size.height;
        [self uploadImage];
    }
}

-(void)uploadImage{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.isUpload = YES;
    });
}

@end
