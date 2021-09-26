//
//  NSArray+title.m
//  GyennoDoctor
//
//  Created by lmzqm on 2018/7/4.
//  Copyright © 2018年 Gyenno. All rights reserved.
//

#import "NSArray+title.h"
#import <objc/runtime.h>
static char titleKey;

@implementation NSArray (title)

-(void)setTitle:(NSString *)title{
    objc_setAssociatedObject(self, &titleKey, title,OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString*)title{
     NSString *str = objc_getAssociatedObject(self, &titleKey);
    return str;
}

-(NSArray*)predicateWithFormat:(NSString *)format{
  
    NSPredicate *predicate = [NSPredicate predicateWithFormat:format];
    NSArray *arr = [self filteredArrayUsingPredicate:predicate];
    NSLog(@"arr9 = %@",arr);
    return arr;
}

@end
