//
//  CheatSheetViewController.m
//  CheatSheet
//
//  Created by Andrew Homeyer on 6/15/10.
//  Copyright Near Infinity 2010. All rights reserved.
//

#import "CheatSheetViewController.h"
#import "CheatSheetListViewController.h"
#import "CheatSheet.h"

@interface CheatSheetViewController ()
@property (nonatomic, retain) UIPopoverController *popoverController;
- (void)configureView;
@end



@implementation CheatSheetViewController

@synthesize toolbar, popoverController, cheatSheet, detailWebView;

- (void)viewDidLoad {
	[super viewDidLoad];
}

/*
 When setting the detail item, update the view and dismiss the popover controller if it's showing.
 */
- (void)setCheatSheet:(id)newCheatSheet {
    if (cheatSheet != newCheatSheet) {
        [cheatSheet release];
        cheatSheet = [newCheatSheet retain];
        
        // Update the view.
        [self configureView];
    }

    if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
    }        
}


- (void)configureView {
    // Update the user interface for the cheat sheet
	
	NSURLRequest *request = [NSURLRequest requestWithURL:self.cheatSheet.url];
	[self.detailWebView loadRequest:request];
	
}


#pragma mark -
#pragma mark Split view support

- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
    
    barButtonItem.title = @"Cheat Sheets";
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = pc;
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items removeObjectAtIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = nil;
}


#pragma mark -
#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -
#pragma mark View lifecycle

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
 */

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.popoverController = nil;
}


#pragma mark -
#pragma mark Memory management

/*
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
*/

- (void)dealloc {
    [popoverController release];
    [toolbar release];
    
    [cheatSheet release];
    [super dealloc];
}

@end
