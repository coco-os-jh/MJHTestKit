//
//  UIAlertController+GYE.h
//  GyennoDoctor
//
//  Created by Mac on 2020/12/25.
//  Copyright © 2020 Gyenno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAlertController+Blocks.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (GYE)
+ (nonnull instancetype)showAlertWithTitle:(nullable NSString *)title
                                          message:(nullable NSString *)message
                                cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                           destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                                otherButtonTitles:(nullable NSArray *)otherButtonTitles
                                  tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;
@end

NS_ASSUME_NONNULL_END
