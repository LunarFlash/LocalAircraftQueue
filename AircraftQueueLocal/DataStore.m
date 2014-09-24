//
//  DataStore.m
//  AircraftQueueLocal
//
//  Created by Yi Wang on 9/24/14.
//  Copyright (c) 2014 Yi. All rights reserved.
//

#import "DataStore.h"
#import "Aircraft.h"

@implementation DataStore

-(id) initArrays{
    if ((self = [super init])) {

        _largePassengerArray = [NSMutableArray array];
        _smallPassengerArray = [NSMutableArray array];
        _largeCargoArray = [NSMutableArray array];
        _smallCargoArray = [NSMutableArray array];
    }
    return self;
}

- (void)removeAllObjects {
    [_largePassengerArray removeAllObjects];
    [_smallPassengerArray removeAllObjects];
    [_largeCargoArray removeAllObjects];
    [_smallPassengerArray removeAllObjects];
}



@end
