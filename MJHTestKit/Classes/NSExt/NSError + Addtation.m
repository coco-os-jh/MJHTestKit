//
//  NSError + Addtation.m
//  GyennoSpoon
//
//  Created by lmzqm on 2018/7/12.
//  Copyright © 2018年 Gyenno. All rights reserved.
//

#import "NSError + Addtation.h"
#import <objc/runtime.h>
static char DescStr;
static char StateCode;

@implementation NSError (Addtation)

-(void)setDesc:(NSString *)desc{
    
    objc_setAssociatedObject(self,&DescStr , desc, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)desc{
    
   return objc_getAssociatedObject(self, &DescStr);
}

-(NSUInteger)stateCode{
    
  return  [objc_getAssociatedObject(self, &StateCode) unsignedIntegerValue];
}

-(void)setStateCode:(NSUInteger)stateCode{
    
    objc_setAssociatedObject(self, &StateCode, @(stateCode), OBJC_ASSOCIATION_ASSIGN);
}

@end
