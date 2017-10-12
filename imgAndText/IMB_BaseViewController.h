//
//  IMB_BaseViewController.h
//  socialSecurity
//
//  Created by 张亚哲 on 15/5/12.
//  Copyright (c) 2015年 张亚哲. All rights reserved.
//

#import "IMB_ViewController.h"
#import "IMB_TableDataSource.h"

@interface IMB_BaseViewController : IMB_ViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign) BOOL navBarHasBg;
@property(nonatomic, assign) BOOL hasBackBtn;
@property(nonatomic, assign) BOOL hasTableView;
/*!
 *  @author YanFeng C, 16-08-19 18:08:46
 *
 *  @brief 右边按钮
 */
@property (nonatomic,strong) UIButton *rightBtn;

/**
 *  列表视图
 */
@property (nonatomic,strong) UITableView *tableView;

/**
 *  @author zhe, 15-08-20 15:08:35
 *
 *  显示网络不给力
 *
 *  @param errorMsg 错误信息
 */
-(void)showNetWorkError:(NSString *)errorMsg;

/**
 *  @author zhe, 15-08-20 15:08:27
 *
 *  网络不给力 视图消失
 */
-(void)netErrorMsgViewDismiss;

-(void)configTableViewWithDatasource:(IMB_TableDataSource *)datasource hasRefreshHeader:(BOOL)hasHeader loadMore:(BOOL)hasLoadMord;

/**
 *  创建文字类型nav btn
 *
 *  @param title 文字
 *  @param taget 操作
 */
//-(void)addRightNavBtnWith:(NSString *)title taget:(void (^)())taget;

/**
 *  创建文字类型nav btn
 *
 *  @param title 文字
 *  @param taget 操作
 *  @param left  是否是左边
 */
-(void)addRightNavBtnWith:(NSString *)title taget:(void (^)())taget left:(BOOL)left;
/*!
 *  @author YanFeng C, 16-08-19 18:08:30
 *
 *  @brief 改变按钮文字
 *
 *  @param item 内容
 */
- (void)changeRightItems:(NSString *)item;
/**
 *  创建图片类型nav btn
 *
 *  @param title 图片
 *  @param taget 操作
 *  @param left  是否是左边
 */
-(void)addRightNavBtnWithImageName:(NSString *)imageName taget:(void (^)())taget left:(BOOL)left;



@end
