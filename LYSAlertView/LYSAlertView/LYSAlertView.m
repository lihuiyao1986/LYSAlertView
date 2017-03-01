//
//  LYSAlertView.m
//  LYSAlertView
//
//  Created by jk on 2017/3/1.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "LYSAlertView.h"

#define trimNull(str,defaultStr) ((str && str.length > 0) ? str : defaultStr)
#define titleH 40.f
#define btnH 40.f
#define lineH 0.5
#define minContentH 50.f
#define contentHoriPadding 10.f
#define containerW ([UIScreen mainScreen].bounds.size.width * 0.5)

#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
    @interface LYSAlertView ()<CAAnimationDelegate>{
#else
    @interface LYSAlertView (){
#endif
    
    // 标题
    UILabel *_titleLb;
    
    // 内容
    UILabel *_contentLb;
    
    // 左按钮
    UIButton *_leftBtn;
    
    // 右按钮
    UIButton *_rightBtn;
    
    // 容器
    UIView *_containerView;
    
    // 分割线
    UIView *_lineView;
    
}


@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong)NSString *content;

@property(nonatomic,strong)NSString *leftTitle;

@property(nonatomic,strong)NSString *rightTitle;

@end

@implementation LYSAlertView


#pragma mark - 初始化方法
- (instancetype)initWithTitle:(NSString*)title content:(NSString*)content leftTitle:(NSString*)leftTitle rightTitle:(NSString*)rightTitle
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _title = title;
        _content = content;
        _leftTitle = trimNull(leftTitle,@"取消");
        _rightTitle = rightTitle;
        _leftBtnColor = [self colorWithHexString:@"666666" alpha:1.0];
        _leftBtnTintColor = [self colorWithHexString:@"65c5e9" alpha:1.0];
        _rightBtnColor = [self colorWithHexString:@"65c5e9" alpha:1.0];
        _rightBtnTintColor = [self colorWithHexString:@"65c5e9" alpha:0.8];
        _titleFont = [UIFont systemFontOfSize:16];
        _titleColor = [self colorWithHexString:@"414141" alpha:1.0];
        _btnFont = [UIFont systemFontOfSize:14];
        _contentFont = [UIFont systemFontOfSize:14];
        _contentColor = [self colorWithHexString:@"414141" alpha:1.0];
        _lineColor = [self colorWithHexString:@"e3e2e2" alpha:1.0];
        _cancelOnTouchOutside = NO;
        [self initConfig];
    }
    return self;
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    _lineView.backgroundColor = _lineColor;
    [_rightBtn viewWithTag:100].backgroundColor = _lineColor;
}

-(void)setContentColor:(UIColor *)contentColor{
    _contentColor = contentColor;
    _contentLb.textColor = _contentColor;
}

-(void)setContentFont:(UIFont *)contentFont{
    _contentFont = contentFont;
    _contentLb.font = _contentFont;
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    _titleLb.textColor = _titleColor;
}

-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    _titleLb.font = _titleFont;
}

-(void)setRightBtnTintColor:(UIColor *)rightBtnTintColor{
    _rightBtnTintColor = rightBtnTintColor;
    [_rightBtn setTitleColor:_rightBtnTintColor forState:UIControlStateHighlighted];
}

-(void)setRightBtnColor:(UIColor *)rightBtnColor{
    _rightBtnColor = rightBtnColor;
    [_rightBtn setTitleColor:_rightBtnColor forState:UIControlStateNormal];
}

-(void)setBtnFont:(UIFont *)btnFont{
    _btnFont = btnFont;
    _leftBtn.titleLabel.font = _btnFont;
    _rightBtn.titleLabel.font = _btnFont;
}

-(void)setLeftBtnColor:(UIColor *)leftBtnColor{
    _leftBtnColor = leftBtnColor;
    [_leftBtn setTitleColor:_leftBtnColor forState:UIControlStateNormal];
}

-(void)setLeftBtnTintColor:(UIColor *)leftBtnTintColor{
    _leftBtnTintColor = leftBtnTintColor;
    [_leftBtn setTitleColor:_leftBtnTintColor forState:UIControlStateHighlighted];
}

#pragma mark - 初始化配置
-(void)initConfig{
    self.backgroundColor = [self colorWithHexString:@"000000" alpha:0.4];
    [self setupUI];
}

#pragma mark - 初始化ui
-(void)setupUI{
    
    _containerView = [[UIView alloc]init];
    _containerView.backgroundColor = [UIColor whiteColor];
    _containerView.layer.cornerRadius = 8;
    _containerView.layer.masksToBounds = YES;
    
    [self addSubview:_containerView];
    
    // 标题
    _titleLb = [[UILabel alloc]init];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.font = _titleFont;
    _titleLb.textColor = _titleColor;
    
    
    // 内容
    _contentLb = [[UILabel alloc]init];
    _contentLb.textColor = _contentColor;
    _contentLb.font = _contentFont;
    _contentLb.numberOfLines = 0;
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = _lineColor;

    // 左按钮
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.titleLabel.font = _btnFont;
    [_leftBtn setTitleColor:_leftBtnColor forState:UIControlStateNormal];
    [_leftBtn setTitleColor:_leftBtnTintColor forState:UIControlStateHighlighted];
    
    UIView *_middleLineV = [[UIView alloc]init];
    _middleLineV.tag = 100;
    _middleLineV.backgroundColor = _lineColor;
    
    // 右按钮
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.titleLabel.font = _btnFont;
    [_rightBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_rightBtn setTitleColor:_rightBtnColor forState:UIControlStateNormal];
    [_rightBtn setTitleColor:_rightBtnTintColor forState:UIControlStateHighlighted];
    [_rightBtn addSubview:_middleLineV];
    
    [_containerView addSubview:_titleLb];
    [_containerView addSubview:_contentLb];
    [_containerView addSubview:_lineView];
    [_containerView addSubview:_leftBtn];
    [_containerView addSubview:_rightBtn];
    
}

#pragma mark - 按钮被点击
-(void)btnClicked:(UIButton*)sender{
    if (sender == _rightBtn) {
        [self dismiss];
        if(self.rightBlock){
            self.rightBlock();
        }
    }else{
        [self dismiss];
        if(self.leftBlock){
            self.leftBlock();
        }
    }
}


#pragma mark - 生成16进制颜色
-(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

#pragma mark - 标题的高度
-(CGFloat)getTitleH{
    return _title.length > 0 ? titleH : 0.f;
}

#pragma mark - 容器高度
-(CGFloat)getContainerH{
    return [self getTitleH] + [self getContentH] + btnH + lineH;
}

#pragma mark - 内容的高度
-(CGFloat)getContentH{
    return MAX([self heightForFont:_contentLb.font width:self.frame.size.width - 2 * contentHoriPadding withStr:self.content], minContentH);
}


#pragma mark - 左按钮的宽度
-(CGFloat)leftBtnW{
    return self.rightTitle.length > 0 ? containerW / 2 : containerW;
}

#pragma mark - 右按钮的高度
-(CGFloat)rightBtnW{
    return self.rightTitle.length > 0 ? containerW / 2 : 0;
}


- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode withStr:(NSString*)str {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [str boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [str sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (CGFloat)widthForFont:(UIFont *)font withStr:(NSString*)str {
    CGSize size = [self sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping withStr:str];
    return size.width;
}

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width withStr:(NSString*)str{
    CGSize size = [self sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping withStr:str];
    return size.height;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _containerView.frame = CGRectMake((CGRectGetWidth(self.frame) - containerW)/2, (CGRectGetHeight(self.frame) - [self getContainerH])/2, containerW, [self getContainerH]);
    _titleLb.frame = CGRectMake(0, 0, containerW, [self getTitleH]);
    _contentLb.frame = CGRectMake(contentHoriPadding, CGRectGetMaxY(_titleLb.frame),containerW - 2 * contentHoriPadding , [self getContentH]);
    _lineView.frame = CGRectMake(0, CGRectGetMaxY(_contentLb.frame), containerW , lineH);
    _leftBtn.frame = CGRectMake(0, CGRectGetMaxY(_lineView.frame), [self leftBtnW], btnH);
    _rightBtn.frame = CGRectMake(CGRectGetMaxX(_leftBtn.frame), CGRectGetMaxY(_lineView.frame), [self rightBtnW], btnH);
    [_rightBtn viewWithTag:100].frame = CGRectMake(0, 0, 0.5, btnH);
    NSLog(@"%@",NSStringFromCGRect(_rightBtn.frame));
}


#pragma mark - 关闭
-(void)dismiss{
    CABasicAnimation *_animation = [CABasicAnimation animation];
    _animation.keyPath = @"transform.scale";
    _animation.fromValue = @(1.0);
    _animation.toValue = @(0);
    _animation.duration = 0.35;
    _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    _animation.fillMode = kCAFillModeForwards;
    _animation.removedOnCompletion = NO;
    _animation.delegate = self;
    [_containerView.layer addAnimation:_animation forKey:nil];
}

-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"动画开始");
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self removeFromSuperview];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    _contentLb.text = self.content;
    _titleLb.text = self.title;
    [_leftBtn setTitle:self.leftTitle forState:UIControlStateNormal];
    [_leftBtn setTitle:self.leftTitle forState:UIControlStateHighlighted];
    [_rightBtn setTitle:self.rightTitle forState:UIControlStateNormal];
    [_rightBtn setTitle:self.rightTitle forState:UIControlStateHighlighted];
}

#pragma mark - 显示
-(void)showInView:(UIView *)targetView{
    [self removeFromSuperview];
    [targetView addSubview:self];
    _containerView.transform = CGAffineTransformMakeScale(0.1,0.1);
    [UIView animateWithDuration:0.35f//动画持续时间
                          delay:0.f//动画延迟执行的时间
         usingSpringWithDamping:0.5f//震动效果，范围0~1，数值越小震动效果越明显
          initialSpringVelocity:0.f//初始速度，数值越大初始速度越快
                        options:UIViewAnimationOptionCurveEaseInOut//动画的过渡效果
                     animations:^{
                         //执行的动画
                         _containerView.transform = CGAffineTransformMakeScale(1.0,1.0);
                     }
                     completion:^(BOOL finished) {
                         //动画执行完毕后的操作
                         _containerView.transform = CGAffineTransformIdentity;
                     }];
}

#pragma mark - touchesBegan
-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint currentLocation = [[touches anyObject] locationInView:self];
    if(!CGRectContainsPoint(_containerView.frame, currentLocation) && _cancelOnTouchOutside){
        [self dismiss];
    }
}

@end
