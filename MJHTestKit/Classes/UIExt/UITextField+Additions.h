//
//  UITextField+Additions.h
//  GyennoMedical
//
//  Created by HeJida on 2018/10/10.
//  Copyright © 2018年 Gyenno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Additions)

@property(nonatomic,assign) NSRange selectedRange;

-(void)setMaxLength:(NSInteger)length;


///浮点类型的TextField输入规则判断 (dotNum:小数点个数)
+ (BOOL)floatStyleTextFieldShouldChangeWithText:(NSString *)text
                              replacementString:(NSString *)string range:(NSRange)range
                                         dotNum:(NSInteger)dotNum;



@end
