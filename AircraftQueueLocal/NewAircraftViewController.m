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
    
    // Assign type and size of aircraft depending on the state of the UISegmentedControls
    if (self.aircraftTypeSegmentedControl.selectedSegmentIndex == 0) {
        [aircraft setType:@"passenger"];
    } else {
        [aircraft setType:@"cargo"];
    }
    
    if (self.aircraftSizeSegmentedControl.selectedSegmentIndex == 0) {
        [aircraft setSize:@"large"];
    } else {
        [aircraft setSize:@"small"];
    }
    [aircraft setCreatedAt:[NSDate date]];
    [self.aircraftArray addObject:aircraft];
    
     NSLog(@"inside new arcraft... aircraftArray.count:%lu", [self.aircraftArray count]);
    [self dismissViewControllerAnimated:YES completion:nil];

}


@end
