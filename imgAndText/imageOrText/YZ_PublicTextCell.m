//
//  YZ_PublicTextCell.m
//  imgAndText
//
//  Created by 张亚哲 on 2017/7/22.
//  Copyright © 2017年 张亚哲. All rights reserved.
//

#import "YZ_PublicTextCell.h"
#import "InputView.h"

@interface YZ_PublicTextCell ()<UITextViewDelegate>

@property(nonatomic,assign)NSInteger loaction;

@end

@implementation YZ_PublicTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"请输入内容";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightTextColor];
    [placeHolderLabel sizeToFit];
    [_textView addSubview:placeHolderLabel];
    
    // same font
    _textView.font = [UIFont systemFontOfSize:15.f];
    placeHolderLabel.font = [UIFont systemFontOfSize:15.f];
    
    [_textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    self.textView.scrollEnabled = false;
    _textView.delegate = self;
    InputView *view = [[NSBundle mainBundle] loadNibNamed:@"InputView" owner:nil options:nil][0];
    view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
    __weak typeof(self) weakSelf = self;
    view.inputViewAction = ^(NSInteger action) {
//      action 0 表情 1相册 2拍照 3模块 4键盘
        if (weakSelf.inputViewAction) {
            weakSelf.inputViewAction(action, weakSelf.loaction);
        }
    };
    _textView.inputAccessoryView = view;
}
-(void)textViewDidChange:(UITextView *)textView{
    [self.tableView beginUpdates];
    CGSize size = [textView sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 32, CGFLOAT_MAX)];
    CGFloat height = size.height;
    NSLog(@"%.2f",height);
    if (height < 50) {
        //self.heightConstraint.constant = 50;
        if (_didChangeHeight) {
            _didChangeHeight(50 + 16,textView.text);
        }
    }else{
        if (_didChangeHeight) {
            _didChangeHeight(height + 16,textView.text);
        }
    }
    [self.tableView endUpdates];
}
- (void)textViewDidChangeSelection:(UITextView *)textView{
    NSRange range = textView.selectedRange;
    NSLog(@"光标位置%@",NSStringFromRange(range));
    _loaction = range.location;
}

-(void)configNode:(ZYZ_Node*)node{
    _textView.text = node.content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
