//
//  UIButton+touch.h
//  GyennoMedical
//
//  Created by 尘浮 on 16/10/28.
//  Copyright © 2016年 Gyenno. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DefaultTime  0.5

@interface UIButton (touch)

@property (nonatomic, assign) NSTimeInterval unableTime;

@end


@interface UIButton (edgeInsets)

@property(nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;

@end
