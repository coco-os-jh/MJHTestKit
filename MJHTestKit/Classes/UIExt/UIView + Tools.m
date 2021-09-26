//
//  UIController + Tools.m
//  GyennoMedical
//
//  Created by fengwu on 4/25/16.
//  Copyright © 2016 Gyenno. All rights reserved.
//

#import "UIView + Tools.h"
#import "GlobalHeader.h"

static char ViewClcikBlockAddress;
@implementation UIView (Tools)
- (UIViewController*)getCurrentViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (void)showAlertView:(NSString*)infoTitle
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [SVProgressHUD showInfoWithStatus:infoTitle];
        [SVProgressHUD setMinimumDismissTimeInterval:1];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

-(void)showProgressHudWithTitle:(NSString *)title{

    [SVProgressHUD showWithStatus:title];
}

-(void)dismiss{
    
    [SVProgressHUD dismiss];
}

@end

@implementation UIView (Action)
static char isSeleced;
-(void)setSelected:(NSNumber*)selected{
    objc_setAssociatedObject(self, &isSeleced,selected , OBJC_ASSOCIATION_ASSIGN);
}

-(NSNumber*)selected{
    
    NSNumber *select =  objc_getAssociatedObject(self, &isSeleced);
    if (select == nil) {
        return [NSNumber numberWithBool:NO];
    }
    return select;
    
}

-(void)addTarget:(id)target action:(SEL)action{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer new] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
    
}

-(void)addTarget:(id)target selector:(SEL)selector{
    [self addTarget:self action:selector];
    
}


-(void)addBottomLineWithHeight:(CGFloat)heigt withColor:(UIColor *)color withLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace{
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = color;
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(leftSpace);
        make.right.equalTo(self).offset(-rightSpace);
        make.height.mas_equalTo(heigt*HEIGHTBILISCALE);
        make.bottom.equalTo(self);
    }];
}

- (void)addBottomLineWithHeight:(CGFloat)heigt withColor:(UIColor *)color {
    [self addBottomLineWithHeight:heigt withColor:color withLeftSpace:0 rightSpace:0];
}

- (void)addViewBottomLine {
    [self addBottomLineWithHeight:10 withColor:SystemBackgroundColor];
}

- (void)addBottomLine {
    [self addBottomLineWithHeight:0.5 withColor:SystemLineColor];
}

- (void)addBottomLineWithColor:(UIColor *)color {
    [self addBottomLineWithHeight:0.5 withColor:color];
}

-(void)addTopLine {
    [self addTopLineWithHeight:0.5 withColor:SystemLineColor withLeftSpace:0 rightSpace:0];
}

- (void)addTopLineWithHeight:(CGFloat)heigt withColor:(UIColor *)color withLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace {
    UIView *lineView = [UIView new];
    lineView.backgroundColor = color;
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(leftSpace);
        make.right.equalTo(self).offset(-rightSpace);
        make.height.mas_equalTo(heigt*HEIGHTBILISCALE);
        make.top.equalTo(self);
    }];
}

- (void)addBottomLineWIthLeftSpace:(CGFloat)leftSpace {
    [self addBottomLineWithHeight:0.5*HEIGHTBILISCALE withColor:SystemLineColor withLeftSpace:leftSpace rightSpace:0];
}
- (void)addCorverViewWithClickBlock:(void(^)(void))clickBlock {
    objc_setAssociatedObject(self, &ViewClcikBlockAddress, clickBlock, OBJC_ASSOCIATION_COPY);
    UIView *coverView = [UIView new];
    coverView.backgroundColor = [UIColor clearColor];
    [coverView addTarget:self action:@selector(clickAction)];
    [self addSubview:coverView];
    
    [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.bottom.equalTo(self);
    }];
  
}

-(void)clickAction{
    
    ClickBlock clickBlock = objc_getAssociatedObject(self, &ViewClcikBlockAddress);
    if (clickBlock ) {
        clickBlock();
        
    }
}

-(void)addRightLine{
    [self addRightLine:0];
}

-(void)addRightLine:(CGFloat)offset{
    
    CGRect rect =  self.frame;
    rect.origin = CGPointMake(rect.origin.x+rect.size.width-0.5*HEIGHTBILISCALE-offset, 0);
    rect.size = CGSizeMake(0.5*HEIGHTBILISCALE, rect.size.height);
    
    [self createLineLayerWithFrame:rect color:SystemLineColor];
}


-(CALayer *)createLineLayerWithFrame:(CGRect)frame color:(UIColor *)color{
    CALayer *layer = [CALayer new];
    layer.backgroundColor = color.CGColor;
    layer.frame = frame;
    [self.layer addSublayer:layer];
    
    return layer;
}

#pragma mark ================= UITextField =================
-(void)addLeftView{
    
    [self addLeftViewWithSpace:10.0*WIDTHSCALE];
}

-(void)addLeftViewWithSpace:(CGFloat)space{

    if ([self respondsToSelector:@selector(setLeftView:)]) {
        
        UIView *view = [UIView new];
        view.frame = CGRectMake(0, 0, space, self.frame.size.height);
        
  
        
        [self performSelector:@selector(setLeftView:) withObject:view];
    }
}

-(void)addCornorWithRadius:(CGFloat)radius{
    
        UIBezierPath *detailPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *detailLayer = [[CAShapeLayer alloc] init];
        detailLayer.frame = self.bounds;
        detailLayer.path = detailPath.CGPath;
        self.layer.mask = detailLayer;
   
    
}


@end
