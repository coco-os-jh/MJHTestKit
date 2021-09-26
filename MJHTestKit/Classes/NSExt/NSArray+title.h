//
//  NSArray+title.h
//  GyennoDoctor
//
//  Created by lmzqm on 2018/7/4.
//  Copyright © 2018年 Gyenno. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSArray (title)

@property (nonatomic ,copy) NSString *title;

-(NSArray*)predicateWithFormat:(NSString *)format;

@end
