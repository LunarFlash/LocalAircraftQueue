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
    return [aircraftArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    UILabel *contentLabel = (UILabel*) [cell viewWithTag:100];
    Aircraft *aircraft = [aircraftArray objectAtIndex:indexPath.row];
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
        vc.aircraftArray = self.aircraftArray;
    }
}

- (IBAction)flushBarbuttonItemPressed:(id)sender {
    [self.aircraftArray removeAllObjects];
    [self.tableView reloadData];
}
- (IBAction)dequeueBarButtonItemPressed:(id)sender {
    // First see if we can find a large passenger aircraft. (This array is already sorted by time of insertion)
    int index = 0;
    Aircraft *aircraft = [self findNextAircraftOfType:@"passenger" size:@"large" fromIndex:index];
    if (aircraft) {
        // Found the first large passenger aircraft, remove it from queue in background thread
        //[self NSLogAirCraft:aircraft];
        
        [self.aircraftArray removeObject:aircraft];
        [self.tableView reloadData];
        
    }
    /*
    else {
        // Can't find a large passenger aircraft, lets see if we can find a small passenger aircraft
        aircraft = [self findNextAircraftOfType:@"passenger" size:@"small" fromIndex:0];
        if (aircraft) {
            // Found a small passenger plane
            [aircraft deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [self loadObjects];
            }];
        } else { //only caro planes
            // Don't have a large or small passenger plane, meaning there are only cargo planes
            aircraft = [self findNextAircraftOfType:@"cargo" size:@"large" fromIndex:0];
            if (aircraft) {
                // Found a large cargo
                [aircraft deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    [self loadObjects];
                }];
            } else {
                // No passenger or large cargo, see if we can find a small cargo
                aircraft = [self findNextAircraftOfType:@"cargo" size:@"small" fromIndex:0];
                if (aircraft) {
                    // Found small cargo plane
                    [aircraft deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        [self loadObjects];
                    }];
                } else {
                    NSLog(@"We dont have any large passenger, or small passenger, or large cargo, or small cargo aircrafts in queue");
                }
            }
        }
    }*/

    
    
    
     [self.tableView reloadData];
}





#pragma mark - Helper Functions
// Recursive function: Find the next aircraft of type  and size passed in, returns nil if nothing is found
- (Aircraft *) findNextAircraftOfType:(NSString *)type size:(NSString *)size fromIndex:(int) index {
    // Iterate through array of aircrafts returned from Parse until we find an aircraft with the criteria passed in, return nil if nothing is found
    if (index < [self.aircraftArray count]){
        Aircraft *aircraft = self.aircraftArray[index];
        if (aircraft && [aircraft.type isEqualToString:type] && [aircraft.size isEqualToString:size] && index < [self.aircraftArray count]) {
            return aircraft;
        } else {
            return [self findNextAircraftOfType:type size:size fromIndex:++index];
        }
    } else {
        return nil;
    }
}


// NSLog an aircraft for debugging
- (void) NSLogAirCraft: (Aircraft *)aircraft {
    NSString *createdAtString =  [self.dateFormatter stringFromDate:aircraft.createdAt];
    if ([createdAtString length] > 0) {
        createdAtString = [createdAtString substringToIndex:[createdAtString length] - 6];
    }
    NSLog(@"%@ %@ createdAt:%@", aircraft.size, aircraft.type, createdAtString);
}


@end
