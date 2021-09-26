//
//  UIButton+EventInterval.m
//  GyennoMedical
//
//  Created by gyenno on 2020/9/29.
//  Copyright © 2020 Gyenno. All rights reserved.
//

#import "UIButton+EventInterval.h"
#import <objc/runtime.h>

//static char * const lj_eventIntervalKey = "lj_eventIntervalKey";
//static char * const eventUnavailableKey = "eventUnavailableKey";

@interface UIButton ()
@property (nonatomic, assign) BOOL eventUnavailable;
@end

@implementation UIButton (EventInterval)

//+ (void)load {
//    Method method1 = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
//    Method method2 = class_getInstanceMethod(self, @selector(lj_sendAction:to:forEvent:));
//    method_exchangeImplementations(method1, method2);
//}
//
//- (void)lj_sendAction:(SEL)sel to:(id)target forEvent:(UIEvent *)event
//{
//    if ([self isMemberOfClass:[UIButton class]]) {
//        if (!self.eventUnavailable) {
//            self.eventUnavailable = YES;
//            [self lj_sendAction:sel to:target forEvent:event];
//            [self performSelector:@selector(setEventUnavailable:) withObject:0];
//        }
//    } else {
//        [self lj_sendAction:sel to:target forEvent:event];
//    }
//}
//
//- (NSTimeInterval)lj_eventInterval {
//    return [objc_getAssociatedObject(self, lj_eventIntervalKey) doubleValue];
//}
//
//- (void)setLj_eventInterval:(NSTimeInterval)lj_eventInterval {
//    objc_setAssociatedObject(self, lj_eventIntervalKey, @(lj_eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (BOOL)eventUnavailable {
//    return [objc_getAssociatedObject(self, eventUnavailableKey) boolValue];
//}
//
//- (void)setEventUnavailable:(BOOL)eventUnavailable {
//    objc_setAssociatedObject(self, eventUnavailableKey, @(eventUnavailable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

@end


