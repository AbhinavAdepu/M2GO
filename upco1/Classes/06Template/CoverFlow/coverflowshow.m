//
//  coverflowshow.m
//  coverflow1
//
//  Created by gaurang patel on 4/7/11.
//  Copyright 2011 silvertouch. All rights reserved.
//

#import "coverflowshow.h"
#import "TKCoverflowView.h"
#import "TKCoverflowCoverView.h"

@implementation coverflowshow

@synthesize coverflow;
@synthesize imagename,img_ImageNameFromFlow,selectedImageIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil _frame:(CGRect)frame{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
		frame_CoverFlow = frame;
        // Custom initialization.
    }
    return self;
}
-(void)setFrame:(CGRect)frame {
	frame_CoverFlow = frame;
}
- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	//[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque]; 
}

- (void) viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[coverflow bringCoverAtIndexToFront:[covers count]*2 animated:YES];
}

- (void) viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	//[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void) viewDidLoad {
    [super viewDidLoad];
	
	imagename.text=@"hardik";
    [covers removeAllObjects];
    [coversOriginal removeAllObjects];
	
	covers = [[NSArray arrayWithObjects:
			   [UIImage imageNamed:@"Event-bg-Shadow.jpg"],[UIImage imageNamed:@"BusinessCard-bg-Shadow.jpg"],
			   [UIImage imageNamed:@"IDBadge-bg-Shadow.jpg"],[UIImage imageNamed:@"Invitation-bg-shadow.jpg"],
			   [UIImage imageNamed:@"CourseInfo-bg-Shadow.jpg"],[UIImage imageNamed:@"New-bg-Shadow.jpg"],[UIImage imageNamed:@"New1-bg-Shadow.jpg"],[UIImage imageNamed:@"Blank-bg-Shadow.jpg"],nil] retain];
	
	coverflow = [[TKCoverflowView alloc] initWithFrame:frame_CoverFlow];
	coverflow.coverflowDelegate = self;
	coverflow.dataSource = self;
    [coverflow setNumberOfCovers:8];
	[self.view addSubview:coverflow];
	
	
	coversOriginal = [[NSArray arrayWithObjects:
					[UIImage imageNamed:@"Event-bg.png"],[UIImage imageNamed:@"BusinessCard-bg.png"],
					[UIImage imageNamed:@"ID-Badge-bg.png"],[UIImage imageNamed:@"Invitation-bg.png"],
					[UIImage imageNamed:@"CourseInfo-bg.png"],[UIImage imageNamed:@"New-bg.jpg"],[UIImage imageNamed:@"New1-bg.jpg"],[UIImage imageNamed:@"Blank-bg.jpg"],nil] retain];
	
	
	UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 00, 482, 35) ];
	lbl1.text = @"Use Designed Templates";
	lbl1.textAlignment = UITextAlignmentCenter;
	lbl1.backgroundColor = [UIColor clearColor];
	//[self.view addSubview:lbl1];
	//[self.view bringSubviewToFront:lbl1];
	
	btnChoose.frame = CGRectMake(480-50, 430, 70, 30);
	//[self.view bringSubviewToFront:btnChoose];
	//[self.view addSubview:btnChoose];
	
	//UILabel *imagelabel=[[UILabel alloc] initWithFrame:CGRectMake(480-50, 300-30, 50,30)];
	//[imagelabel setText:@"gaurang"];
	
}
-(IBAction)btnChoosePressed:(id)sender
{
	NSLog(@"btnChoosePressed");
	[[NSNotificationCenter defaultCenter] postNotificationName:@"reloadSign" object:nil];
}
- (void) info
{
	//[self dismissModalViewControllerAnimated:YES];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void) coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasBroughtToFront:(int)index
{
	NSLog(@"Front %d",index);
	selectedImageIndex = index;
	img_ImageNameFromFlow = [coversOriginal objectAtIndex:index];
}
- (TKCoverflowCoverView*) coverflowView:(TKCoverflowView*)coverflowView coverAtIndex:(int)index
{
	
	TKCoverflowCoverView *cover = [coverflowView dequeueReusableCoverView];
	
	if(cover == nil){
		cover = [[[TKCoverflowCoverView alloc] initWithFrame:CGRectMake(0, 0, 407, 254)] autorelease]; // 224
		cover.baseline = 224;
		
	}
    NSLog(@"index[covers count]==%d",index%[covers count]);
	cover.image = [covers objectAtIndex:index%[covers count]];
	
	return cover;
	
}

- (void) coverflowView:(TKCoverflowView*)coverflowView coverAtIndexWasDoubleTapped:(int)index{
	
	
	NSString *temp=[[NSString alloc] initWithFormat:@"%d",index+1];
	imagename.text=temp;
	
	/*TKCoverflowCoverView *cover = [coverflowView coverAtIndex:index];
	if(cover == nil) return;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cover cache:YES];
	[UIView commitAnimations];*/
	NSLog(@"Index: %d",index);
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
//{
//    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) 
//	{
//		return YES;
//	}
//	if (interfaceOrientation == UIInterfaceOrientationPortrait) 
//	{
//		NSLog(@"protait is call");
//		prflag=TRUE;
//	}
//	
//	//return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
//    if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft || interfaceOrientation==UIInterfaceOrientationLandscapeRight)
//	{
//		return YES;
//	}	
//    return NO;
    return YES;
}
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}
- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}
- (void)dealloc {
	[infoButton release];
	[coverflow release];
	//[covers release];
    [super dealloc];
}


@end
