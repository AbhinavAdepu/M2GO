    //
//  QRScanViewController.m
//  KrenMarketing
//
//  Created by Silvertouch on 14/11/11.
//  Copyright 2011 SilverTouch Tech. Ltd. All rights reserved.
//

#import "QRScanViewController.h"
#import "KrenMarketingViewController.h"



@implementation QRScanViewController

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
        // Custom initialization.
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(didRotate:) 
												 name:UIApplicationDidChangeStatusBarOrientationNotification
											   object:nil];
	
	[super viewDidLoad];
	
}

-(void)viewWillAppear:(BOOL)animated
{
	
}

-(void)setFrameOrientation_Portrait
{
	self.view.frame = CGRectMake(200+20, 0, 768-200-20, 1024);
	
	btnCamera.frame = CGRectMake(0,900,250,50);
	btnPhotoAlbum.frame = CGRectMake(260,900,250,50);
}
-(void)setFrameOrientation_LandScap
{
	self.view.frame = CGRectMake(200+20, 0, 768-200-20, 1024);
	
	btnCamera.frame = CGRectMake(0,650,400,50);
	btnPhotoAlbum.frame = CGRectMake(410,650,400,50);
	
}
- (void) didRotate:(NSNotification *)notification
{
	UIInterfaceOrientation ori = [[UIDevice currentDevice] orientation];
	if(ori == UIInterfaceOrientationPortrait)
	{
		
		[self setFrameOrientation_Portrait];
	}
	else if(ori == UIInterfaceOrientationLandscapeLeft)
	{
		
		[self setFrameOrientation_LandScap];
	}
	
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
	
	if(interfaceOrientation == UIInterfaceOrientationPortrait)
	{
		[self setFrameOrientation_Portrait];
				return YES;
	}
	else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
	{
		[self setFrameOrientation_LandScap];
		return YES;
	}
	else {
		
		return NO;
	}
	

}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
