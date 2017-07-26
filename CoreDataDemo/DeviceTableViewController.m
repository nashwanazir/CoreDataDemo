//
//  DeviceTableViewController.m
//  CoreDataDemo
//
//  Created by Nashwa on 7/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

#import "DeviceTableViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "DeviceDetailViewController.h"

@interface DeviceTableViewController ()

  @property(strong)NSMutableArray *devices;
@end

@implementation DeviceTableViewController

- (NSManagedObjectContext *)managedObjectContext
{
  NSManagedObjectContext *context = nil;
  id delegate = [[UIApplication sharedApplication] delegate];
  
  if( [delegate performSelector:@selector(persistentContainer)]){
    
    context = [[delegate persistentContainer] viewContext];
  }
  
  return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  // Fetch the devices from persistent data store
  NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Device"];
  self.devices = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
  [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.devices.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  
  // Configure the cell...
  NSManagedObject *device = [self.devices objectAtIndex:indexPath.row];
  [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@",[device valueForKey:@"name"], [device valueForKey:@"version"]]];
  [cell.detailTextLabel setText:[device valueForKey:@"company"]];
 
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
  
  return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  NSManagedObjectContext *context = [self managedObjectContext];
  
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    // Delete object from database
    [context deleteObject:[self.devices objectAtIndex:indexPath.row]];
    
    NSError *error = nil;
    if (![context save:&error]) {
      NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
      return;
    }
    
    // Remove device from table view
    [self.devices removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([[segue identifier] isEqualToString:@"UpdateDevice"]) {
    NSManagedObject *selectedDevice = [self.devices objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    DeviceDetailViewController *destViewController = segue.destinationViewController;
    destViewController.device = selectedDevice;
  }
}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
