//
//  UIController + Tools.h
//  GyennoMedical
//
//  Created by fengwu on 4/25/16.
//  Copyright © 2016 Gyenno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (Tools)

- (UIViewController*)getCurrentViewController;

- (void)showAlertView:(NSString*)infoTitle;

-(void)showProgressHudWithTitle:(NSString *)title;

-(void)dismiss;
@end

typedef void(^ClickBlock)(void);

@interface UIView (Action)

@property (nonatomic ,strong) NSNumber *selected;



-(void)addTarget:(id)target action:(SEL)action;

-(void)addTarget:(id)target selector:(SEL)selector;

-(void)addBottomLine;
-(void)addBottomLineWithColor:(UIColor *)color;
-(void)addTopLine;
-(void)addViewBottomLine;
- (void)addTopLineWithHeight:(CGFloat)heigt withColor:(UIColor *)color withLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace;
-(void)addBottomLineWIthLeftSpace:(CGFloat)leftSpace;
-(void)addBottomLineWithHeight:(CGFloat)heigt withColor:(UIColor *)color withLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace;

-(void)addRightLine;
-(void)addRightLine:(CGFloat)offset;

-(void)addCorverViewWithClickBlock:(void(^)(void))clickBlock;


-(void)addLeftView;
-(void)addCornorWithRadius:(CGFloat)radius;


@end
