//
//  DetailViewController.h
//  AVDemoPlay
//  released under mit license/lgpl dual license
//  Created by Michelle Cannon on 7/18/12.
//  Copyright (c) 2012 none. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
