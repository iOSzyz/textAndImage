//
//  ZYZ_Node.h
//  imgAndText
//
//  Created by 张亚哲 on 2017/7/22.
//  Copyright © 2017年 张亚哲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CONTENT_IMG,
    CONTENT_TEXT,
} CONTENT_CELL_TYPE;

/**
 节点信息
 */
@interface ZYZ_Node : NSObject

@property(nonatomic,assign)CONTENT_CELL_TYPE type;

/**
 文字内容
 */
@property(nonatomic,copy)NSString *content;

/**
 cell行高
 */
@property(nonatomic,assign)CGFloat cellHeight;
/**
 图片地址
 */
@property(nonatomic,copy)NSString *imgUrl;

/**
 选中图片
 */
@property(nonatomic,strong)UIImage *selectImage;
/**
 宽高比
 */
@property(nonatomic,assign)CGFloat widthScale;

/**
 是否上传了图片
 */
@property(nonatomic,assign)BOOL isUpload;

/**
 转字典
 */
-(NSDictionary *)toDict;

@end
