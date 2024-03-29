//
//  MasterViewController.m
//  AVDemoPlay
//released under mit license/lgpl dual license
//  Created by Michelle Cannon on 7/18/12.
//  Copyright (c) 2012 none. All rights reserved.
//

#import "MasterViewController.h"
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>
#import <FFmpegDecoder/libavdevice/avdevice.h>
#import "DetailViewController.h"


@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

@synthesize detailViewController = _detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    return self;
}
							
- (void)dealloc
{
    [_detailViewController release];
    [_objects release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"AVDemo Player";
	// Do any additional setup after loading the view, typically from a nib.
  //  self.navigationItem.leftBarButtonItem = self.editButtonItem;
      [self insertNewObject:nil];
   // UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)] autorelease];
  //  self.navigationItem.rightBarButtonItem = addButton;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:NO];
    [player closeStreams];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    NSString *movie = @"rtsp://10.0.1.16:5554/live.sdp";
    [_objects insertObject:movie atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
       
    
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }


    NSDate *object = [_objects objectAtIndex:indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CGRect frame = CGRectMake(0, 0, 320, 480);
    player = [[GLPlayer alloc] initWithFrame:frame movie:[_objects objectAtIndex:indexPath.row] aspectRatio:(16.0/9.0) useTCP:YES];

   
    // force aspect ratio = 4/3 standard tv 
    //[player forceAspect:4.0/3] ;
    //
    
    // force aspect ratio = 16/9 high def tv
   // [player forceAspect:16.0/9];
     //
    
    /*
     #define VIDEO_QUEUE_SIZE_MAX 5 * 256 * 1024
     #define AUDIO_QUEUE_SIZE_MAX 5 * 16 * 1024
     */
    
    [player setMaxAudioBuffer:(5*16*1024)];
    [player setMaxVideoBuffer:(5*25*1024)];
 
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    [detailViewController.view addSubview:player];
    [player release];
  
    
    
    // NSDate *object = [_objects objectAtIndex:indexPath.row];
    
    
    
    
    // self.detailViewController.detailItem = object;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}


@end
