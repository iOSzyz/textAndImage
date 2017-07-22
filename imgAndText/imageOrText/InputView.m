//
//  InputView.m
//  imgAndText
//
//  Created by 张亚哲 on 2017/7/22.
//  Copyright © 2017年 张亚哲. All rights reserved.
//

#import "InputView.h"

@implementation InputView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)biaoqingAction:(id)sender {
    if (_inputViewAction) {
        _inputViewAction(0);
    }
}
- (IBAction)xiangceAction:(id)sender {
    if (_inputViewAction) {
        _inputViewAction(1);
    }
}
- (IBAction)paizhaoAction:(id)sender {
    if (_inputViewAction) {
        _inputViewAction(2);
    }
}
- (IBAction)bankuaiAction:(id)sender {
    if (_inputViewAction) {
        _inputViewAction(3);
    }
}
- (IBAction)jianpanAction:(id)sender {
    if (_inputViewAction) {
        _inputViewAction(4);
    }
}


@end
