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
        _aircraftsArray = [NSMutableArray array];
        _largePassengerArray = [NSMutableArray array];
        _smallPassengerArray = [NSMutableArray array];
        _largeCargoArray = [NSMutableArray array];
        _smallCargoArray = [NSMutableArray array];
    }
    return self;
}

- (void)removeAllObjects {
    [_aircraftsArray removeAllObjects];
    [_largePassengerArray removeAllObjects];
    [_smallPassengerArray removeAllObjects];
    [_largeCargoArray removeAllObjects];
    [_smallPassengerArray removeAllObjects];
}

- (void)dequeueLargePassenger {
    if ([_largePassengerArray count] > 0) {
        Aircraft *aircraft = _largePassengerArray[0];
        [_aircraftsArray removeObjectAtIndex:aircraft.index];
        [_largePassengerArray removeObjectAtIndex:0];
    }
}

- (void)dequeueSmallPassenger {
    if ([_smallPassengerArray count] > 0) {
        Aircraft *aircraft = _smallPassengerArray[0];
        [_aircraftsArray removeObjectAtIndex:aircraft.index];
        [_smallPassengerArray removeObjectAtIndex:0];
    }
}

- (void)dequeueLargeCargo {
    if ([_largeCargoArray count] > 0) {
        Aircraft *aircraft = _largeCargoArray[0];
        [_aircraftsArray removeObjectAtIndex:aircraft.index];
        [_largeCargoArray removeObjectAtIndex:0];
    }
    
}

- (void)dequeueSmallCargo {
    if ([_smallCargoArray count] > 0) {
        Aircraft *aircraft = _smallCargoArray[0];
        [_aircraftsArray removeObjectAtIndex:aircraft.index];
        [_smallCargoArray removeObjectAtIndex:0];
    }
}



@end
