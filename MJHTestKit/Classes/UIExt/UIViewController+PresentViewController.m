//
//  UIViewController+PresentViewController.m
//  GyennoMedical
//
//  Created by Mac on 2020/10/22.
//  Copyright © 2020 Gyenno. All rights reserved.
//

#import "UIViewController+PresentViewController.h"
#import "GlobalHeader.h"

@implementation UIViewController (PresentViewController)

+ (void)load {
    swizzleMethod([self class], @selector(presentViewController:animated:completion:), @selector(gye_presentViewController:animated:completion:));
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)gye_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
//    UIViewController *presentingVC = self;
//    if (![self isKindOfClass:NSClassFromString(@"UIApplicationRotationFollowingController")]) {
//        if ([[self topController] isKindOfClass:[GYEVideoCallViewController class]]) {
//            // 当前为视频通话控制器
//            GYEVideoCallViewController *videoCallVc = (GYEVideoCallViewController *)[self topController];
//            if (videoCallVc.view.superview.hidden) {
//                // 视频通话最小化的时候，需要present到通话控制器上面
//                presentingVC = videoCallVc;
//            }
//        }
//    }
//    [presentingVC gye_presentViewController:viewControllerToPresent animated:flag completion:completion];
//    if (![viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
//        [[GYEAVChatManager shareInstance] bringFloatingViewToFront];
//    }
}

/// 最上面的控制器
- (UIViewController *)topController {
    UIViewController *rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    UIViewController *topVC = rootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

@end
