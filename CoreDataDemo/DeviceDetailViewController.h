//
//  DeviceDetailViewController.h
//  CoreDataDemo
//
//  Created by Nashwa on 7/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *version;
@property (weak, nonatomic) IBOutlet UITextField *company;
- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
@property (strong) NSManagedObjectModel *device;

@end
