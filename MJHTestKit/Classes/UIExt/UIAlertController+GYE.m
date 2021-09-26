//
//  UIAlertController+GYE.m
//  GyennoDoctor
//
//  Created by Mac on 2020/12/25.
//  Copyright © 2020 Gyenno. All rights reserved.
//

#import "UIAlertController+GYE.h"

@implementation UIAlertController (GYE)

+ (nonnull instancetype)showAlertWithTitle:(nullable NSString *)title
                                          message:(nullable NSString *)message
                                cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                           destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                                otherButtonTitles:(nullable NSArray *)otherButtonTitles
                                  tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock {
    return [UIAlertController showAlertInViewController:[UIApplication sharedApplication].delegate.window.rootViewController withTitle:title message:message cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles tapBlock:tapBlock];
}

@end
