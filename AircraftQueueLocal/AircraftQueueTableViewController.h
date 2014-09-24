//
//  AircraftQueueTableViewController.h
//  AircraftQueueLocal
//
//  Created by Yi Wang on 9/23/14.
//  Copyright (c) 2014 Yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Aircraft.h"
#import "DataStore.h"
@interface AircraftQueueTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *aircraftArray;
@property (strong, nonatomic) DataStore *dataStore;

@end
