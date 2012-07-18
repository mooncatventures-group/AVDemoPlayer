//
//  MasterViewController.h
//  testsnapPlayerNavNoARC
//
//  Created by Michelle Cannon on 7/18/12.
//  Copyright (c) 2012 none. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
