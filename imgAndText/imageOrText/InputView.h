//
//  InputView.h
//  imgAndText
//
//  Created by 张亚哲 on 2017/7/22.
//  Copyright © 2017年 张亚哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputView : UITableViewCell

/**
 键盘操作 action 0 表情 1相册 2拍照 3模块 4键盘
 */
@property(nonatomic,copy)void(^inputViewAction)(NSInteger action);

@end
