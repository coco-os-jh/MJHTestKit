//
//  UITextField+Additions.m
//  GyennoMedical
//
//  Created by HeJida on 2018/10/10.
//  Copyright © 2018年 Gyenno. All rights reserved.
//

#import "UITextField+Additions.h"
#import "NSString+Emoji.h"

@implementation UITextField (Additions)

//浮点类型的TextField输入规则判断 (dotNum:小数点个数)
+ (BOOL)floatStyleTextFieldShouldChangeWithText:(NSString *)text
                              replacementString:(NSString *)string range:(NSRange)range
                                         dotNum:(NSInteger)dotNum
{
    BOOL isHaveDian = YES;
    if ([text rangeOfString:@"."].location==NSNotFound) {
        isHaveDian=NO;
    }
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为小数点
            if([text length]==0){
                if(single == '.'){
                    [text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
            }
            if([text length]==1 && [text isEqualToString:@"0"]){
                if(single != '.'){
                    [text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
            }
            if (single=='.')
            {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian=YES;
                    return YES;
                }else
                {
                    [text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else
            {
                if (isHaveDian)//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran=[text rangeOfString:@"."];
                    NSInteger tt=range.location-ran.location;
                    if (tt <= dotNum){
                        return YES;
                    }else{
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            [text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
}


-(NSRange)selectedRange{
    NSInteger location = [self offsetFromPosition:self.beginningOfDocument toPosition:self.selectedTextRange.start];
    NSInteger length = [self offsetFromPosition:self.selectedTextRange.start toPosition:self.selectedTextRange.end];
    return NSMakeRange(location, length);
}

-(void)setSelectedRange:(NSRange)selectedRange{
    UITextPosition *startPosition = [self positionFromPosition:self.beginningOfDocument offset:selectedRange.location];
    UITextPosition *endPosition = [self positionFromPosition:self.beginningOfDocument offset:selectedRange.location + selectedRange.length];
    UITextRange *selectedTextRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectedTextRange];
}



-(void)setMaxLength:(NSInteger)length{
}




//- (void)textFieldDidChangeWithMaxLength:(NSInteger)maxLength{
//{
//    UITextField *infoText = self;
//    int kMaxLength = maxLength;
//    NSString *toBeString = [infoText text];
//    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
//    // 键盘输入模式
//    if ([lang isEqualToString:@"zh-Hans"] || [lang isEqualToString:@"zh-Hant"]) { // 中文输入
//        UITextRange *selectedRange = [infoText markedTextRange];
//        //获取高亮部分
//        // 系统的UITextRange，有两个变量，一个是start，一个是end，这是对于的高亮区域
//        UITextPosition *position = [infoText positionFromPosition:selectedRange.start offset:0];
//        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
//        if (!position) {
//            if (toBeString.length > kMaxLength) {
//                infoText.text = [toBeString substringToIndex:kMaxLength];
//            }else{
//                infoText.text = toBeString;
//            }
//        }
//        // 有高亮选择的字符串，则暂不对文字进行统计和限制
//        else{
//            //            infoText.text = toBeString;
//        }
//    }
//    else{
//
//        if (toBeString.length > kMaxLength) {// 表情之类的，中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
//
//            infoText.text = [toBeString substringToIndex:kMaxLength];
//        }else{
//            infoText.text = toBeString;
//        }
//    }
//
//}


@end
