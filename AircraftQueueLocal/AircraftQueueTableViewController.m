//
//  AircraftQueueTableViewController.m
//  AircraftQueueLocal
//
//  Created by Yi Wang on 9/23/14.
//  Copyright (c) 2014 Yi. All rights reserved.
//

#import "AircraftQueueTableViewController.h"
#import "NewAircraftViewController.h"

@interface AircraftQueueTableViewController ()

// NSDateFormatter is pretty expensive to create, so we create 1 instance and reuse it for each cell
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation AircraftQueueTableViewController
@synthesize aircraftArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    aircraftArray = [NSMutableArray array];
    
    self.dataStore = [[DataStore alloc] initArrays];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss a"];
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.dataStore.aircraftsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    UILabel *contentLabel = (UILabel*) [cell viewWithTag:100];
    Aircraft *aircraft = [self.dataStore.aircraftsArray objectAtIndex:indexPath.row];
    contentLabel.text = [NSString stringWithFormat:@"%@ %@ plane", aircraft.size, aircraft.type];
    
    UILabel *createdAtLabel = (UILabel*) [cell viewWithTag:101];
    NSString *createdAtString =  [self.dateFormatter stringFromDate:aircraft.createdAt];
    createdAtLabel.text = createdAtString;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"QueueToNewAircraftSegue"]) {
        NewAircraftViewController *vc = [segue destinationViewController];
        vc.dataStore = self.dataStore;
    }
}

- (IBAction)flushBarbuttonItemPressed:(id)sender {
    [self.dataStore removeAllObjects];
    [self.tableView reloadData];
}
- (IBAction)dequeueBarButtonItemPressed:(id)sender {
    // First we dequeue the large passenger planes
    if ([self.dataStore.largePassengerArray count] > 0) {
        [self.dataStore dequeueLargePassenger];
    } else {
        // no more large passenger planes left, dequeue small passenger planes
        if ([self.dataStore.smallPassengerArray count] > 0) {
            [self.dataStore dequeueSmallPassenger];
        } else {
            // no more passenger planes left, dequeue large cargo
            if ([self.dataStore.largeCargoArray count] > 0) {
                [self.dataStore dequeueLargeCargo];
            } else {
                if ([self.dataStore.smallCargoArray count] > 0)  {
                    [self.dataStore dequeueSmallCargo];
                }
            }
        }

    }
    
    [self.tableView reloadData];
   
}





#pragma mark - Helper Functions
// NSLog an aircraft for debugging
- (void) NSLogAirCraft: (Aircraft *)aircraft {
    NSString *createdAtString =  [self.dateFormatter stringFromDate:aircraft.createdAt];
    if ([createdAtString length] > 0) {
        createdAtString = [createdAtString substringToIndex:[createdAtString length] - 6];
    }
    NSLog(@"Found %@ %@ createdAt:%@", aircraft.size, aircraft.type, createdAtString);
}


@end
