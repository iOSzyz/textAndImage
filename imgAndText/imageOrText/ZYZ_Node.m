//
//  ZYZ_Node.m
//  imgAndText
//
//  Created by 张亚哲 on 2017/7/22.
//  Copyright © 2017年 张亚哲. All rights reserved.
//

#import "ZYZ_Node.h"

@interface ZYZ_Node ()

@property(nonatomic,strong)UITextView *heightTextView;

@end

@implementation ZYZ_Node

-(UITextView *)heightTextView{
    if (!_heightTextView) {
        _heightTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 32, 10)];
        _heightTextView.bounces = NO;
        _heightTextView.font = [UIFont systemFontOfSize:14];
        _heightTextView.scrollEnabled = NO;
    }
    return _heightTextView;
}

-(void)setContent:(NSString *)content{
    _content = content;
    self.heightTextView.text = content;
    CGSize size = [self.heightTextView sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 32 - 16, CGFLOAT_MAX)];
    CGFloat height = size.height;
    _cellHeight = height + 20;
}

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
