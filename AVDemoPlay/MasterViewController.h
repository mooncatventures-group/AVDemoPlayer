//
//  MasterViewController.h
//  AV demo player
//
//  Created by Michelle Cannon on 7/18/12.
//  Copyright (c) 2012 none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StreamMorePlay/GLPlayer.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController{
    GLPlayer *player;

}

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
