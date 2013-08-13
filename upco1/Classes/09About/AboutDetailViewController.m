//
//  AboutDetailViewController.m
//  KrenMarketing
//
//  Created by Ankit Vyas on 07/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutDetailViewController.h"


@implementation AboutDetailViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil index:(int)index
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
		selectedindex = index;
        // Custom initialization.
    }
    return self;
} 



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	flag = TRUE;
    [super viewDidLoad];
	
	if(selectedindex == 0)
	{
		btnURLclicked.hidden = YES;
		lblHeader.text = @"Message from the Authors";
		imgAuthors.frame = CGRectMake(imgAuthors.frame.origin.x, imgAuthors.frame.origin.y, 320, 2411);
		imgAuthors.image = [UIImage imageNamed:@"MessageFrom_About_iphone.png"];
		scrollImages.contentSize = CGSizeMake(0, 2411);
	}
	else if(selectedindex == 1)
	{
		btnURLclicked.hidden = YES;
		lblHeader.text = @"About the Authors";
		imgAuthors.frame = CGRectMake(imgAuthors.frame.origin.x, imgAuthors.frame.origin.y, 320, 1350);
		imgAuthors.image = [UIImage imageNamed:@"AboutTheAuthors_About_iphone.png"];
		scrollImages.contentSize = CGSizeMake(0, 1350);
		
	}
	else if(selectedindex == 2)
	{
		btnURLclicked.hidden = NO;
		btnURLclicked.enabled = YES;
		//btnURLclicked.backgroundColor = [UIColor redColor];
		btnURLclicked.frame = CGRectMake(0,235,320,30);
		[imgAuthors bringSubviewToFront:btnURLclicked];
		lblHeader.text = @"About Connect";
		imgAuthors.frame = CGRectMake(imgAuthors.frame.origin.x, imgAuthors.frame.origin.y, 320, 976);
		imgAuthors.image = [UIImage imageNamed:@"AboutConnect_About_iphone.png"];
		scrollImages.contentSize = CGSizeMake(0,976);
	
		//double tap handling
		
		scrollImages.minimumZoomScale = 0.0;
		scrollImages.maximumZoomScale = 4.0;
		UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
		
		[doubleTap setNumberOfTapsRequired:2];
		
		[scrollImages addGestureRecognizer:doubleTap];
	
		
		[doubleTap release];
		
		
	
		

		
	}
	else if(selectedindex == 3)
	{
		btnURLclicked.hidden = NO;
		btnURLclicked.enabled = YES;
		//btnURLclicked.backgroundColor = [UIColor redColor];
		btnURLclicked.frame = CGRectMake(0,225,320,30);
		[imgAuthors bringSubviewToFront:btnURLclicked];
		lblHeader.text = @"Buy the Book";
		imgAuthors.frame = CGRectMake(imgAuthors.frame.origin.x, imgAuthors.frame.origin.y, 320, 416);
		imgAuthors.image = [UIImage imageNamed:@"BuyTheBook_About_iphone.png"];
		scrollImages.contentSize = CGSizeMake(0, 254);
		
	}
	
}
-(IBAction)btnURLclickedPressed:(id)sender
{
	if (selectedindex==3) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.coursesmart.com"]];
		
	}
	else {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://connect.mcgraw-hill.com"]];
		
	}
}
-(IBAction)BackToLibrary
{
	[self.navigationController popViewControllerAnimated:TRUE];
}

#pragma mark scrollView zoom

-(void)scale:(id)sender {
	
	//UIPinchGestureRecognizer *gestureRecognizer;
	if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        // Reset the last scale, necessary if there are multiple objects with different scales
        lastScale = [(UIPinchGestureRecognizer*)sender scale];
    }
	
    if ([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan || 
        [(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
		
        CGFloat currentScale = [[[(UIPinchGestureRecognizer*)sender view].layer valueForKeyPath:@"transform.scale"] floatValue];
		
        // Constants to adjust the max/min values of zoom
        const CGFloat kMaxScale = 2.0;
        const CGFloat kMinScale = 1.0;
		
        CGFloat newScale = 1 -  (lastScale - [(UIPinchGestureRecognizer*)sender scale]); 
        newScale = MIN(newScale, kMaxScale / currentScale);   
        newScale = MAX(newScale, kMinScale / currentScale);
        CGAffineTransform transform = CGAffineTransformScale([[(UIPinchGestureRecognizer*)sender view] transform], newScale, newScale);
        [(UIPinchGestureRecognizer*)sender view].transform = transform;
		
        lastScale = [(UIPinchGestureRecognizer*)sender scale];  // Store the previous scale factor for the next pinch gesture call  
    }
	
}
 
/*
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return
	imageViewFullScreen;
}*/
- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {  
	
	if(flag)
	{
		//scrollImages.minimumZoomScale = 1.0;
		//scrollImages.maximumZoomScale = 4.0;
		btnURLclicked.enabled = NO;
		//add pinch zoom gesture
		UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)];
		[pinchRecognizer setDelegate:self];
		[scrollImages addGestureRecognizer:pinchRecognizer];
		imgAuthors.hidden = YES;
		scrollImages.contentOffset = CGPointMake(0,0);
		scrollImages.contentSize = CGSizeMake(750, 400);
		scrollImages.scrollEnabled = YES;
		
		imageViewFullScreen.hidden = NO;
	}
	else {
		scrollImages.scrollEnabled = YES;
		imgAuthors.hidden = NO;
		btnURLclicked.enabled = YES;
		imageViewFullScreen.hidden = YES;
		scrollImages.contentOffset = CGPointMake(0,0);
		scrollImages.contentSize = CGSizeMake(0,976);
	}

	flag = !flag;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
