//
//  ViewController.m
//  imgAndText
//
//  Created by 张亚哲 on 2017/7/22.
//  Copyright © 2017年 张亚哲. All rights reserved.
//

#import "ViewController.h"
#import "ZYZ_Node.h"
#import "YZ_PublicTextCell.h"
#import "YZ_PublicImgCell.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;

@property(nonatomic,strong)NSMutableArray *dataArr;;

/**
 选中的索引
 */
@property(nonatomic,assign)NSInteger selectIndex;

/**
 选中图片
 */
@property(nonatomic,copy)void(^selImageComplete)(UIImage *iamge);

@end

@implementation ViewController

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    for (int i = 0; i < 1; i++) {
        ZYZ_Node *node = [[ZYZ_Node alloc]init];
        node.cellHeight = 66;
        node.content = @"";
        node.type = CONTENT_TEXT;
        [self.dataArr addObject:node];
    }
    self.table.tableFooterView = [UIView new];
    self.table.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZYZ_Node *node = self.dataArr[indexPath.row];
    return node.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZYZ_Node *node = self.dataArr[indexPath.row];
    if (node.type == CONTENT_IMG) {
        static NSString *cellID = @"YZ_PublicImgCell";
        YZ_PublicImgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"YZ_PublicImgCell" owner:nil options:nil][0];
        }
        cell.img.image = node.selectImage;
        __weak typeof(self) weakSelf = self;
        cell.deleteImage = ^{
            [weakSelf deleteNode:node];
        };
        return cell;
    }else{
        static NSString *cellID = @"YZ_PublicTextCell";
        YZ_PublicTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"YZ_PublicTextCell" owner:nil options:nil][0];
        }
        
        [cell configNode:node];
        __weak typeof(node) weakNode = node;
        __weak typeof(self) weakSelf = self;
        cell.didChangeHeight = ^(CGFloat height, NSString *content) {
            weakNode.content = content;
        };
        cell.tableView = _table;
        cell.inputViewAction = ^(NSInteger action, NSInteger location) {
          //      action 0 表情 1相册 2拍照 3模块 4键盘
//            NSLog(@"%d|||||||%d",action,location);
            switch (action) {
                case 0:{
                    
                }break;
                case 1:{
//                    相册
                    [weakSelf insertImageWithSelectIndex:indexPath.row location:location node:node];
                }break;
                case 2:{
                    
                }break;
                case 3:{
                    
                }break;
                case 4:{
                    [weakSelf.view endEditing:YES];
                }break;
                default:
                    break;
            }
        };
        return cell;
    }
}

/**
 插入图片

 @param idx 索引位置
 @param location 图片位置
 */
-(void)insertImageWithSelectIndex:(NSInteger)idx location:(NSInteger)location node:(ZYZ_Node *)node{
    if (idx == -1) {
        //在末尾插入
        ZYZ_Node *node = self.dataArr.lastObject;
        if (node.content.length == 0) {
            [self showImageVCWithComplete:^(UIImage *image) {
                ZYZ_Node *ImageNode = [[ZYZ_Node alloc]init];
                ImageNode.cellHeight = 0;
                ImageNode.selectImage = image;
//                ImageNode.content = @"";
                ImageNode.type = CONTENT_IMG;
                [self.dataArr insertObject:ImageNode atIndex:self.dataArr.count - 1];
                _selectIndex = self.dataArr.count - 2;
                [self.table reloadData];
            }];
        }else{
            [self showImageVCWithComplete:^(UIImage *image) {
                ZYZ_Node *ImageNode = [[ZYZ_Node alloc]init];
                ImageNode.cellHeight = 0;
                ImageNode.selectImage = image;
//                ImageNode.content = @"";
                ImageNode.type = CONTENT_IMG;
                [self.dataArr addObject:ImageNode];
                _selectIndex = self.dataArr.count - 1;
                
                ZYZ_Node *node = [[ZYZ_Node alloc]init];
                node.cellHeight = 66;
                node.content = @"";
                node.type = CONTENT_TEXT;
                [self.dataArr addObject:node];
                [self.table reloadData];
            }];
        }
    }else{
        //在中间位置插入
        if (node.content.length == location) {
            [self showImageVCWithComplete:^(UIImage *image) {
                if (node.content.length == 0) {
                    [self.dataArr removeObject:node];
                }
                //在文字末尾插入
                ZYZ_Node *ImageNode = [[ZYZ_Node alloc]init];
                ImageNode.cellHeight = 0;
                ImageNode.selectImage = image;
//                ImageNode.content = @"";
                ImageNode.type = CONTENT_IMG;
                [self.dataArr addObject:ImageNode];
                _selectIndex = self.dataArr.count - 1;
                
                ZYZ_Node *node = [[ZYZ_Node alloc]init];
                node.cellHeight = 66;
                node.content = @"";
                node.type = CONTENT_TEXT;
                [self.dataArr addObject:node];
                [self.table reloadData];
            }];
        }else{
            //在文字中间插入
            [self showImageVCWithComplete:^(UIImage *image) {
                NSString *firstStr = [node.content substringToIndex:location];
                NSString *secondStr = [node.content substringFromIndex:location];
                ZYZ_Node *secondNode = [[ZYZ_Node alloc]init];
                secondNode.content = secondStr;
                secondNode.type = CONTENT_TEXT;
                [self.dataArr insertObject:secondNode atIndex:idx];
                
                ZYZ_Node *ImageNode = [[ZYZ_Node alloc]init];
                ImageNode.cellHeight = 0;
                ImageNode.selectImage = image;
                //                ImageNode.content = @"";
                ImageNode.type = CONTENT_IMG;
                [self.dataArr insertObject:ImageNode atIndex:idx];
                
                ZYZ_Node *firstNode = [[ZYZ_Node alloc]init];
                firstNode.content = firstStr;
                firstNode.type = CONTENT_TEXT;
                [self.dataArr insertObject:firstNode atIndex:idx];
                [self.dataArr removeObjectAtIndex:idx + 3];
                [self.table reloadData];
            }];
        }
    }
}

- (void)showImageVCWithComplete:(void(^)(UIImage *image))complete{
//    [self.view endEditing:YES];
    _selImageComplete = complete;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    __weak typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        NSURL *assetURL = info[UIImagePickerControllerReferenceURL];
        UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (image) {
            _selImageComplete(image);
        }
    }];
}

-(void)deleteNode:(ZYZ_Node *)node{
    [self.dataArr removeObject:node];
    [self.table reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
