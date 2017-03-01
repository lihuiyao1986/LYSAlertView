//
//  LYSAlertView.h
//  LYSAlertView
//
//  Created by jk on 2017/3/1.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LeftBlock)(void);

typedef void(^RightBlock)(void);

@interface LYSAlertView : UIView

#pragma mark - 初始化方法
- (instancetype)initWithTitle:(NSString*)title content:(NSString*)content leftTitle:(NSString*)leftTitle rightTitle:(NSString*)rightTitle;

#pragma mark - 左按钮颜色
@property(nonatomic,strong)UIColor *leftBtnColor;

#pragma mark - 右按钮颜色
@property(nonatomic,strong)UIColor *rightBtnColor;

#pragma mark - 左按钮按下时的颜色
@property(nonatomic,strong)UIColor *leftBtnTintColor;

#pragma mark - 右按钮按下时的颜色
@property(nonatomic,strong)UIColor *rightBtnTintColor;

#pragma mark - 标题颜色
@property(nonatomic,strong)UIColor *titleColor;

#pragma mark - 内容颜色
@property(nonatomic,strong)UIColor *contentColor;

#pragma mark - 按钮字体
@property(nonatomic,strong)UIFont *btnFont;

#pragma mark - 内容字体
@property(nonatomic,strong)UIFont *contentFont;

#pragma mark - 标题字体
@property(nonatomic,strong)UIFont *titleFont;

#pragma mark - 左按钮点击回调
@property(nonatomic,strong)LeftBlock leftBlock;

#pragma mark - 右按钮点击回调
@property(nonatomic,strong)RightBlock rightBlock;

#pragma mark - 分割线的颜色
@property(nonatomic,strong)UIColor *lineColor;

#pragma mark - 点击外层是否关闭窗口
@property(nonatomic,assign)BOOL cancelOnTouchOutside;

#pragma mark - 在targetView显示
-(void)showInView:(UIView*)targetView;

#pragma mark - 关闭窗口
-(void)dismiss;


@end
