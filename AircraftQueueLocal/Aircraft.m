//
//  Aircraft.m
//  AircraftQueueLocal
//
//  Created by Yi Wang on 9/23/14.
//  Copyright (c) 2014 Yi. All rights reserved.
//

#import "Aircraft.h"

@implementation Aircraft

-(id) initWithSize:(NSString *)size type:(NSString *)type date:(NSDate *)date {
    if ((self = [super init])) {
        _size = size;
        _type = type;
        _createdAt = date;
    }
    return self;
}

@end
