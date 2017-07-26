//
//  DeviceDetailViewController.m
//  CoreDataDemo
//
//  Created by Nashwa on 7/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

#import "DeviceDetailViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface DeviceDetailViewController ()

@end

@implementation DeviceDetailViewController

@synthesize device;

- (NSManagedObjectContext *)managedObjectContext
{
  NSManagedObjectContext *context = nil;
  id delegate = [[UIApplication sharedApplication] delegate];
  // call "persistentContainer" not "managedObjectContext"
  if( [delegate performSelector:@selector(persistentContainer)] ){
    // call viewContext from persistentContainer not "managedObjectContext"
    context = [[delegate persistentContainer] viewContext];
  }
  return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  if (self.device) {
    [self.name setText:[self.device valueForKey:@"name"]];
    [self.version setText:[self.device valueForKey:@"version"]];
    [self.company setText:[self.device valueForKey:@"company"]];
  }
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

- (IBAction)save:(id)sender {
  NSManagedObjectContext *context = [self managedObjectContext];
  
  if (self.device) {
    // Update existing device
    [self.device setValue:self.name.text forKey:@"name"];
    [self.device setValue:self.version.text forKey:@"version"];
    [self.device setValue:self.company.text forKey:@"company"];
    
  } else {
  
  NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
  [newDevice setValue:self.name.text forKey:@"name"];
  [newDevice setValue:self.version.text forKey:@"version"];
  [newDevice setValue:self.company.text forKey:@"company"];
  }
  NSError *error = nil;
  // Save the object to persistent store
  if (![context save:&error]) {
    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
  }
  
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
  
  [self dismissViewControllerAnimated:YES completion:nil];
}


@end
