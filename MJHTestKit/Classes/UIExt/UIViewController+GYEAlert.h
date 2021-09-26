//
//  UIViewController+GYEAlert.h
//  GyennoMedical
//
//  Created by gyenno on 2020/10/23.
//  Copyright © 2020 Gyenno. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AlertClickBlock)(void);

typedef void(^ActionSheetClickBlock)(NSInteger index);

@interface UIViewController (GYEAlert)

/// 显示提示框（带左右按钮）
- (void)showTipAlertWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
             otherButtonTitle:(nullable NSString *)buttonTitle
              leftButtonTitle:(nullable NSString *)leftButtonTitle
                  rightHandle:(nullable AlertClickBlock)leftBtnClick
                   leftHandle:(nullable AlertClickBlock)rightBtnClick;

/// 显示自定义提示框
- (void)showCustomAlert:(nullable NSString *)title
                message:(nullable NSString *)message
        leftButtonTitle:(nullable NSString *)leftButtonTitle
       rightButtonTitle:(nullable NSString *)rightButtonTitle
           leftBtnClick:(nullable AlertClickBlock)leftBtnClick
          rightBtnClick:(nullable AlertClickBlock)rightBtnClick;

/// 显示输入框提示
- (void)showTextFieldAlertWithTitle:(NSString * __nullable)title
                            message:(NSString * __nullable)message
                        placeHolder:(NSString * __nullable)placeHolder
                          textColor:(UIColor * __nullable)textColor
                               font:(UIFont * __nullable)font
                    leftButtonTitle:(NSString * __nullable)leftButtonTitle rightButton:(NSString * __nullable)rightButtonTitle
                       leftBtnClick:(_Nullable AlertClickBlock)leftBtnClick
                      rightBtnClick:(_Nullable AlertClickBlock)rightBtnClick;

/// ActionSheet - 底部提示框
- (void)showActionSheetWithTitle:(nullable NSString *)title
                         message:(nullable NSString *)message
                          titles:(nonnull NSArray <NSString *> *)titles
clickBlock:(ActionSheetClickBlock)clickBlock;
@end

NS_ASSUME_NONNULL_END
