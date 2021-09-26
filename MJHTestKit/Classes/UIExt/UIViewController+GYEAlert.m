//
//  UIViewController+GYEAlert.m
//  GyennoMedical
//
//  Created by gyenno on 2020/10/23.
//  Copyright © 2020 Gyenno. All rights reserved.
//

#import "UIViewController+GYEAlert.h"

@implementation UIViewController (GYEAlert)

#pragma mark - 显示提示框（带左右按钮）
- (void)showTipAlertWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
             otherButtonTitle:(nullable NSString *)buttonTitle
              leftButtonTitle:(nullable NSString *)leftButtonTitle
                  rightHandle:(nullable AlertClickBlock)leftBtnClick
                   leftHandle:(nullable AlertClickBlock)rightBtnClick
{
    if (title.length == 0) {
        title = nil;
    }
    if (message.length == 0) {
        message = nil;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (leftButtonTitle.length > 0) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:leftButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (leftBtnClick) {
                leftBtnClick();
            }
        }];
        [alert addAction:action1];
    }
    if (buttonTitle.length > 0) {
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (rightBtnClick) {
                rightBtnClick();
            }
        }];
        [alert addAction:action2];
    }
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - 显示自定义弹窗
- (void)showCustomAlert:(nullable NSString *)title
                message:(nullable NSString *)message
        leftButtonTitle:(nullable NSString *)leftButtonTitle
       rightButtonTitle:(nullable NSString *)rightButtonTitle
           leftBtnClick:(nullable AlertClickBlock)leftBtnClick
          rightBtnClick:(nullable AlertClickBlock)rightBtnClick
{
    if (title.length == 0) {
        title = nil;
    }
    if (message.length == 0) {
        message = nil;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (leftButtonTitle.length > 0) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:leftButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (leftBtnClick) {
                leftBtnClick();
            }
        }];
        [alert addAction:action];
    }
    if (rightButtonTitle.length > 0) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:rightButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (rightBtnClick) {
                rightBtnClick();
            }
        }];
        [alert addAction:action];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 显示输入框提示
- (void)showTextFieldAlertWithTitle:(NSString * __nullable)title
                            message:(NSString * __nullable)message
                        placeHolder:(NSString * __nullable)placeHolder
                          textColor:(UIColor * __nullable)textColor
                               font:(UIFont * __nullable)font
                    leftButtonTitle:(NSString * __nullable)leftButtonTitle rightButton:(NSString * __nullable)rightButtonTitle
                       leftBtnClick:(_Nullable AlertClickBlock)leftBtnClick
                      rightBtnClick:(_Nullable AlertClickBlock)rightBtnClick
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeHolder;
        textField.textColor = textColor;
        textField.font = font;
    }];
    if (leftButtonTitle && leftButtonTitle.length > 0) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:leftButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (leftBtnClick) {
                leftBtnClick();
            }
        }];
        [alert addAction:action1];
    }
    if (rightButtonTitle && rightButtonTitle.length > 0) {
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:rightButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (rightBtnClick) {
                rightBtnClick();
            }
        }];
        [alert addAction:action2];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - ActionSheet
- (void)showActionSheetWithTitle:(nullable NSString *)title
                         message:(nullable NSString *)message
                          titles:(nonnull NSArray <NSString *> *)titles
clickBlock:(ActionSheetClickBlock)clickBlock
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSInteger i = 0; i < titles.count; i++) {
        NSString *title = titles[i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (clickBlock) {
                clickBlock(i);
            }
        }];
        [alert addAction:action];
    }
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
