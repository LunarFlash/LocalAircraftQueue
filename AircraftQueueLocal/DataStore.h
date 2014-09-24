//
//  DataStore.h
//  AircraftQueueLocal
//
//  Created by Yi Wang on 9/24/14.
//  Copyright (c) 2014 Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStore : NSObject

@property (strong, nonatomic) NSMutableArray *aircraftsArray;
@property (strong, nonatomic) NSMutableArray *largePassengerArray;
@property (strong, nonatomic) NSMutableArray *smallPassengerArray;
@property (strong, nonatomic) NSMutableArray *largeCargoArray;
@property (strong, nonatomic) NSMutableArray *smallCargoArray;

-(id)initArrays;
- (void)removeAllObjects;
- (void)dequeueLargePassenger;
- (void)dequeueSmallPassenger;
- (void)dequeueLargeCargo;
- (void)dequeueSmallCargo;

@end
