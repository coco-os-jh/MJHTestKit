//
//  UIView+Addtion.h
//  GyennoDoctor
//
//  Created by lmzqm on 2019/2/15.
//  Copyright © 2019 Gyenno. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Addtion)

-(UIImageView*)getImageView;
-(UIImageView*)getImageViewWithImage:(UIImage*)image;
-(UIImageView*)getImageViewWithImageStr:(NSString*)imageStr;


-(UILabel*)getLabelWithFont:(UIFont*)font textColor:(UIColor*)color;
-(UILabel *)getLabel;

-(void)shaowView;
-(void)shadowWithRadius:(CGFloat )radius opacity:(CGFloat)opacity;
-(void)shadowWithRadius:(CGFloat )radius opacity:(CGFloat)opacity shadowColor:(UIColor *)color;

-(UIImage *)gye_corner;
-(void)cornorRadios;
-(UIImage *)createViewImage;


- (UILabel *)addLabelWithTextColor:(UIColor *)textColor andFont:(UIFont *)font andTextAlignment:(NSTextAlignment)alignment;

- (UIImageView *)addIcon;

-(UIButton *)getVerButtonWithImage:(NSString *)imagestr text:(NSString *)textStr;

-(void)addTarget:(id)target action:(nullable SEL)action;

-(UITableView *)getTableViewStyle:(UITableViewStyle)style;

- (UIView *)buildTextFieldRightView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
