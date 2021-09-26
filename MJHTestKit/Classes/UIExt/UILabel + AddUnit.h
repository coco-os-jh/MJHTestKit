//
//  UILabel + AddUnit.h
//  GyennoMedical
//
//  Created by lmzqm on 2018/8/18.
//  Copyright © 2018年 Gyenno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AddUnit) <UITextViewDelegate>

@property (nonatomic ,weak) UITextView *textView;


-(void)addTextViewDelegate:(UITextView*)textView;

@end
