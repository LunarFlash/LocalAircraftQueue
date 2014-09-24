//
//  NewAircraftViewController.m
//  AircraftQueueLocal
//
//  Created by Yi Wang on 9/23/14.
//  Copyright (c) 2014 Yi. All rights reserved.
//

#import "NewAircraftViewController.h"
#import "Aircraft.h"

@interface NewAircraftViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *aircraftSizeSegmentedControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *aircraftTypeSegmentedControl;


@end

@implementation NewAircraftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)submitAircraftButtonPressed:(id)sender {
    
    Aircraft *aircraft = [[Aircraft alloc] init];
    [aircraft setIndex:[self.dataStore.aircraftsArray count]];
    [aircraft setCreatedAt:[NSDate date]];
    
    // Assign type and size of aircraft depending on the state of the UISegmentedControls
    if (self.aircraftTypeSegmentedControl.selectedSegmentIndex == 0) {
        [aircraft setType:@"passenger"];
        if (self.aircraftSizeSegmentedControl.selectedSegmentIndex == 0) {
            // large passenger
            [aircraft setSize:@"large"];
            [self.dataStore.largePassengerArray addObject:aircraft];
        } else {
            // small passenger
            [aircraft setSize:@"small"];
            [self.dataStore.smallPassengerArray addObject:aircraft];
        }
        
    } else {
        [aircraft setType:@"cargo"];
        if (self.aircraftSizeSegmentedControl.selectedSegmentIndex == 0) {
            // large cargo
            [aircraft setSize:@"large"];
            [self.dataStore.largeCargoArray addObject:aircraft];
        } else {
            // small cargo
            [aircraft setSize:@"small"];
            [self.dataStore.smallCargoArray addObject:aircraft];
        }
    }
    
    [self.dataStore.aircraftsArray addObject:aircraft];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}


@end
