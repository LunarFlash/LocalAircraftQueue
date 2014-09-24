//
//  Aircraft.h
//  AircraftQueueLocal
//
//  Created by Yi Wang on 9/23/14.
//  Copyright (c) 2014 Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Aircraft : NSObject

@property (strong, nonatomic) NSString *size;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSDate *createdAt;
@property NSUInteger index;

-(id) initWithSize:(NSString *)size type:(NSString *)type date:(NSDate *)date;

@end
