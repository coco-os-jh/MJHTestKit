//
//  UILabel + AddUnit.m
//  GyennoMedical
//
//  Created by lmzqm on 2018/8/18.
//  Copyright © 2018年 Gyenno. All rights reserved.
//

#import "UILabel + AddUnit.h"
#import "NSString+Emoji.h"
#define MAX_LIMIT_NUMS 100

#import "GlobalHeader.h"


@implementation UILabel (AddUnit)

-(void)addTextViewDelegate:(UITextView*)textView{
    
    self.textView = textView;
    self.textView.delegate = self;
    
    
    
}

-(void)setTextView:(UITextView *)textView{
    objc_setAssociatedObject(self, @selector(textView), textView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UITextView*)textView{
   return  objc_getAssociatedObject(self, @selector(textView));
}

#pragma mark ================= TextViewDelegate =================
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *lang = [[[UIApplication sharedApplication] textInputMode] primaryLanguage];
    
    if (!lang) {
        return NO;
    }
    
    return YES;
    
}


-(void)textViewDidEndEditing:(UITextView *)textView {
    
    [textView setText:[NSString filterEmoji:textView.text]];
}


-(void)textViewDidChange:(UITextView *)textView {
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        
        [textView setText:s];
        
        existTextNum = s.length;
        
        
    }
    
    //不让显示负数
    self.text = [NSString stringWithFormat:@"%ld/%d",(long)existTextNum,MAX_LIMIT_NUMS];
    
}
@end
