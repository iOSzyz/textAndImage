//
//  YZ_PublicTextCell.h
//  imgAndText
//
//  Created by 张亚哲 on 2017/7/22.
//  Copyright © 2017年 张亚哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYZ_Node.h"
/**
 发帖文字
 */
@interface YZ_PublicTextCell : UITableViewCell

@property(nonatomic,copy)void(^didChangeHeight)(CGFloat height,NSString *content);

@property (weak,nonatomic)UITableView * tableView;

@property (weak, nonatomic) IBOutlet UITextView *textView;

/**
 键盘操作 action 0 表情 1相册 2拍照 3模块 4键盘 location 光标位置
 */
@property(nonatomic,copy)void(^inputViewAction)(NSInteger action,NSInteger location);

-(void)configNode:(ZYZ_Node*)node;

@end
