//
//  IMB_BaseViewController.m
//  socialSecurity
//
//  Created by 张亚哲 on 15/5/12.
//  Copyright (c) 2015年 张亚哲. All rights reserved.
//

#import "IMB_BaseViewController.h"
#import "UIImage+IMB.h"
#import "IMB_Macro.h"
#import "IMB_NavButton.h"
#import "UIViewController+BackButtonHandler.h"

@interface IMB_BaseViewController ()

/**
 *  @author zhe, 15-08-20 15:08:35
 *
 *  网络不给力视图
 */
@property (nonatomic,strong)UIView *netWorkMsgView;

/**
 *  右边按钮target
 */
@property (nonatomic,copy)void (^didRightHandle)();

/**
 *  左边按钮target
 */
@property (nonatomic,copy)void (^didLeftHandle)();

@end

@implementation IMB_BaseViewController

#pragma mark - Override method
- (void)releaseResource{
    if (_tableView) {
        _tableView.dataSource = nil;
        _tableView.delegate = nil;
    }
    if (_netWorkMsgView) {
        _netWorkMsgView = nil;
    }
    if (_rightBtn) {
        _rightBtn = nil;
    }
}
//网络不给力视图创建
-(UIView *)netWorkMsgView{
    if (!_netWorkMsgView) {
        _netWorkMsgView = [[UIView alloc]initWithFrame:Rect(0, 0, kSCREEN_WIDTH,kSCREEN_HEIGHT)];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 50)];
        lab.text = @"网络不给力！！！！！！";
        lab.textColor = [UIColor whiteColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = GHFont(20);//[UIFont boldSystemFontOfSize:20];
        [_netWorkMsgView addSubview:lab];
        lab.center = _netWorkMsgView.center;
        _netWorkMsgView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_netWorkMsgView];
        [self.view sendSubviewToBack:_netWorkMsgView];
    }
    return _netWorkMsgView;
}

#pragma mark - Property method

- (void)setHasTableView:(BOOL)hasTableView{
    if (_hasTableView != hasTableView) {
        _hasTableView = hasTableView;
        if (_hasTableView) {
            // 创建列表视图
            _tableView = [[UITableView alloc]initWithFrame:Rect(0,0,kSCREEN_WIDTH,kSCREEN_HEIGHT) style:UITableViewStylePlain];
            if (IS_IOS_11) {
                if (@available(iOS 11.0, *)) {
                    _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                } else {
                    // Fallback on earlier versions
                }
            }
            self.automaticallyAdjustsScrollViewInsets = YES;
            _tableView.backgroundColor = [UIColor clearColor];
            _tableView.dataSource = self;
            _tableView.delegate = self;
            //            _tableView.scrollsToTop = YES;
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
            [self.view addSubview:_tableView];
        }
    }
}

- (void)setHasBackBtn:(BOOL)hasBackBtn{
    if (_hasBackBtn != hasBackBtn) {
        _hasBackBtn = hasBackBtn;
        if (_hasBackBtn) {
            UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //            backBtn.isLeftBarBtn = YES;
            [backBtn setBackgroundColor:[UIColor clearColor]];
            [backBtn setTitle:@"" forState:UIControlStateNormal];
            backBtn.titleLabel.font = GHFont(17);//[UIFont systemFontOfSize:17];
            [backBtn addTarget:self action:@selector(backToPreviousView) forControlEvents:UIControlEventTouchUpInside];
            backBtn.frame = Rect(0, 0, 44, 44);
            [backBtn setImage:IMAGE(@"back") forState:UIControlStateNormal];
            
            UIBarButtonItem *backBarBtnItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                               target:nil action:nil];
            negativeSpacer.width = -20;
            
            //            self.navigationItem.leftBarButtonItem = backBarBtnItem;
            if (IS_IOS_11) {
                [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -44, 0, 0)];
                self.navigationItem.leftBarButtonItems = @[backBarBtnItem];
            }else{
                [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
                self.navigationItem.leftBarButtonItems = @[negativeSpacer, backBarBtnItem];
            }
        }else{
            self.navigationItem.leftBarButtonItem = nil;
        }
    }
}

#pragma mark Override Method
- (void)uiInit{
    [super uiInit];
    self.navigationController.navigationBar.translucent = NO;//
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = HexRGB(0xf7f7f7);//[UIColor whiteColor];//HexRGB(0xf3f6f8);
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:orangeColor] forBarMetrics:UIBarMetricsDefault];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:18],NSFontAttributeName,nil];//[UIFont boldSystemFontOfSize:20]
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //    UIBarButtonItem *barItem=[UIBarButtonItem appearance];
    //    NSDictionary *fontDic=@{
    //                            NSForegroundColorAttributeName:[UIColor redColor],
    //                            NSFontAttributeName:[UIFont systemFontOfSize:14.f],
    //                            };
    //    [barItem setTitleTextAttributes:fontDic
    //                           forState:UIControlStateNormal];
    //    [barItem setTitleTextAttributes:fontDic
    //                           forState:UIControlStateHighlighted];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    [backItem setAction:@selector(backToPreviousView)];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // 5.设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    if (IS_IOS_7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navBarHasBg = YES;
}
-(BOOL)navigationShouldPopOnBackButton{
    [self backToPreviousView];
    return YES;
}

- (void)setNavBarHasBg:(BOOL)navBarHasBg{
    if (_navBarHasBg != navBarHasBg) {
        _navBarHasBg = navBarHasBg;
        if (_navBarHasBg) {
            // 设置设置导航栏背景颜色
            UIColor *bgCorlor = HexRGB(0x4e88ff);
            UIImage *barBgImage = [UIImage imageWithColor:bgCorlor];
            barBgImage = ResizableImageDataForMode(barBgImage, 0, 0, 1, 0, UIImageResizingModeStretch);
            [self.navigationController.navigationBar setBackgroundImage:barBgImage forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];//下边的那条线
        }
    }
}
#pragma mark Custom Method

-(void)addRightNavBtnWith:(NSString *)title taget:(void (^)())taget{
    _didRightHandle = taget;
    UIButton *btn = [[UIButton alloc]initWithFrame:Rect(0, 0, title.length * 20 < 60 ? 60:title.length * 20, 44)];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitle:title forState:UIControlStateNormal];
    //    [btn.titleLabel sizeToFit];
    btn.titleLabel.font = GHFont(15);//[UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(addMember) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -20;
    
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,item];
}

-(void)addRightNavBtnWith:(NSString *)title taget:(void (^)())taget left:(BOOL)left{
    if (left) {
        _didLeftHandle = taget;
    }else{
        _didRightHandle = taget;
    }
    _rightBtn = [[UIButton alloc]initWithFrame:Rect(0, 0, title.length * 20 < 60 ? 60:title.length * 20 , 44)];
    _rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_rightBtn setTitle:title forState:UIControlStateNormal];
    //    [btn.titleLabel sizeToFit];
    _rightBtn.titleLabel.font = GHFont(15);//[UIFont systemFontOfSize:15];
    if (left) {
        [_rightBtn addTarget:self action:@selector(addleft) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [_rightBtn addTarget:self action:@selector(addMember) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -20;
    if (IS_IOS_11) {
        if (left) {
            [_rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
            self.navigationItem.leftBarButtonItems = @[item];
        }else{
            [_rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
            self.navigationItem.rightBarButtonItems = @[item];
        }
    }else if (IS_IOS_ABOVE_7) {
        if (left) {
            self.navigationItem.leftBarButtonItems = @[negativeSpacer,item];
        }else{
            self.navigationItem.rightBarButtonItems = @[negativeSpacer,item];
        }
    }else{
        if (left) {
            self.navigationItem.leftBarButtonItem = item;
        }else{
            self.navigationItem.rightBarButtonItem = item;
        }
    }
}
- (void)changeRightItems:(NSString *)item{
    [self.rightBtn setTitle:item forState:UIControlStateNormal];
}
/**
 *  创建图片类型nav btn
 *
 *  @param title 图片
 *  @param taget 操作
 *  @param left  是否是左边
 */
-(void)addRightNavBtnWithImageName:(NSString *)imageName taget:(void (^)())taget left:(BOOL)left{
    if (left) {
        _didLeftHandle = taget;
    }else{
        _didRightHandle = taget;
    }
    UIButton *btn = [[UIButton alloc]initWithFrame:Rect(0, 0, 44 , 44)];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setImage:IMAGE(imageName) forState:UIControlStateNormal];
    //    [btn.titleLabel sizeToFit];
    //    btn.titleLabel.font = GHFont(15);//[UIFont systemFontOfSize:15];
    if (left) {
        [btn addTarget:self action:@selector(addleft) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [btn addTarget:self action:@selector(addRight) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -16;
    if (IS_IOS_11) {
        if (left) {
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
            self.navigationItem.leftBarButtonItems = @[item];
        }else{
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
            self.navigationItem.rightBarButtonItems = @[item];
        }
    }else if (IS_IOS_ABOVE_7) {
        if (left) {
            self.navigationItem.leftBarButtonItems = @[negativeSpacer,item];
        }else{
            self.navigationItem.rightBarButtonItems = @[negativeSpacer,item];
        }
    }else{
        if (left) {
            self.navigationItem.leftBarButtonItem = item;
        }else{
            self.navigationItem.rightBarButtonItem = item;
        }
    }
}

-(void)changeRightNavBtnTitleWith:(NSString *)title{
    UIBarButtonItem *barItem = self.navigationItem.rightBarButtonItems[1];
    UIButton *btn = (UIButton *)barItem.customView;
    [btn setTitle:title forState:UIControlStateNormal];
}

-(void)addMember{
    if (_didRightHandle) {
        _didRightHandle();
    }
}
- (void)addleft{
    if (_didLeftHandle) {
        _didLeftHandle();
    }
}
- (void)addRight{
    if (_didRightHandle) {
        _didRightHandle();
    }
}

#pragma mark NetWorkShowView

-(void)showNetWorkError:(NSString *)errorMsg{
    self.netWorkMsgView.hidden = NO;
    [self.view bringSubviewToFront:self.netWorkMsgView];
}

-(void)netErrorMsgViewDismiss{
    _netWorkMsgView.hidden = YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

#pragma mark table

-(void)configTableViewWithDatasource:(IMB_TableDataSource *)datasource hasRefreshHeader:(BOOL)hasHeader loadMore:(BOOL)hasLoadMord{
    self.tableView.tableFooterView = [UIView new];
    self.tableView.dataSource = datasource;
    self.tableView.delegate = datasource;
    datasource.tableView = self.tableView;
    datasource.hasRefreshHeader = hasHeader;
    datasource.hasLoadMoreFooter = hasLoadMord;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#warning 假状态栏
    //创建一个高20的假状态栏
    //    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 20)];
    //    //设置成绿色
    //    statusBarView.backgroundColor=[UIColor whiteColor];
    //    // 添加到 navigationBar 上
    //    [self.navigationController.navigationBar addSubview:statusBarView];
}

-(void)dealloc{
    _tableView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 设置 是否支持旋转
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(BOOL)shouldAutorotate
{
    return NO;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
    
}
//设置字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//白色
}
/**
 *  @author zhe, 15-08-04 09:08:56
 *
 *  ios 8 分割线
 */
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
