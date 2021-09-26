//
//  UIButton+touch.m
//  GyennoMedical
//
//  Created by 尘浮 on 16/10/28.
//  Copyright © 2016年 Gyenno. All rights reserved.
//

#import "UIButton+touch.h"
#import <objc/runtime.h>

@interface UIButton ()
@property (nonatomic, assign) BOOL isNoAction;

@end

@implementation UIButton (touch)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selOne = @selector(sendAction:to:forEvent:);
        SEL selTwo = @selector(mySendAction:to:forEvent:);
        Method methodOne = class_getInstanceMethod(self, selOne);
        Method methodTwo = class_getInstanceMethod(self, selTwo);
        
        BOOL isAdd = class_addMethod(self, selOne, method_getImplementation(methodTwo), method_getTypeEncoding(methodTwo));
        
        if (isAdd) {
            class_replaceMethod(self, selTwo, method_getImplementation(methodOne), method_getTypeEncoding(methodOne));
        }else {
            method_exchangeImplementations(methodOne, methodTwo);
        }
        
    });

}


- (NSTimeInterval) unableTime {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void) setUnableTime:(NSTimeInterval)unableTime {
    objc_setAssociatedObject(self, @selector(unableTime), @(unableTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isNoAction {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void) setIsNoAction:(BOOL)isNoAction {
    objc_setAssociatedObject(self, @selector(isNoAction), @(isNoAction), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void) resetState {
    [self setIsNoAction:NO];
}

- (void) mySendAction:(SEL)action  to:(id)target forEvent:(UIEvent *)event {
    
    //添加例外
    if ( [NSStringFromClass([target class]) isEqualToString:@"NIMInputView"]) {
        [self mySendAction:action to:target forEvent:event];
        
        return;
    }
    
    
    if ([NSStringFromClass([self class]) isEqualToString:NSStringFromClass([UIButton class])]) {
        self.unableTime = self.unableTime == 0 ? DefaultTime :self.unableTime;
        if (self.isNoAction) {
            return;
        }else if (self.unableTime > 0){
            [self performSelector:@selector(resetState) withObject:nil afterDelay:self.unableTime];
        }
    }
    
    self.isNoAction = YES;
    [self mySendAction:action to:target forEvent:event];
}


@end

@implementation UIButton(edgeInsets)

@dynamic hitTestEdgeInsets;

static const NSString *KEY_HIT_TEST_EDGE_INSETS = @"HitTestEdgeInsets";

- (void) setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets) hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    
    if (value) {
        UIEdgeInsets edgeInsets; [value getValue:&edgeInsets]; return edgeInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL) pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) ||       !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}

@end
