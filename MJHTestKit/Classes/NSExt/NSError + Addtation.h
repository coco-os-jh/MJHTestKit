//
//  NSError + Addtation.h
//  GyennoSpoon
//
//  Created by lmzqm on 2018/7/12.
//  Copyright © 2018年 Gyenno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Addtation)

@property (nonatomic ,copy) NSString *desc;
@property (nonatomic ,assign) NSUInteger stateCode;

@end
