//
//  EventDesignedTempViewController.m
//  KrenMarketing
//
//  Created by Ankit Vyas on 03/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "EventDesignedTempViewController.h"
#import "EventDTDetail.h"
#import "BusinessCardDetailViewController.h"
#import "InvitationDetailViewController.h"
#import "IDBadgeDetailViewController.h"
#import "CourseInfoViewController.h"

@implementation EventDesignedTempViewController

@synthesize strHeader,strFlag;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

-(void)viewWillAppear:(BOOL)animated
{
	
	
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	scr_Templates.contentSize = CGSizeMake(500,0);
	lblHeading.text = strHeader;
	covers = [[NSArray arrayWithObjects:
			   [UIImage imageNamed:@"Event-bg-Shadow.jpg"],[UIImage imageNamed:@"BusinessCard-bg-Shadow.jpg"],
			   [UIImage imageNamed:@"IDBadge-bg-Shadow.jpg"],[UIImage imageNamed:@"Invitation-bg-shadow.jpg"],
			   [UIImage imageNamed:@"CourseInfo-bg-Shadow.jpg"],[UIImage imageNamed:@"New-bg-Shadow.jpg"],[UIImage imageNamed:@"New1-bg-Shadow.jpg"],[UIImage imageNamed:@"Blank-bg-Shadow.jpg"],nil] retain];
	
	
	coversOriginal = [[NSArray arrayWithObjects:
					   [UIImage imageNamed:@"Event-bg.png"],[UIImage imageNamed:@"BusinessCard-bg.png"],
					   [UIImage imageNamed:@"ID-Badge-bg.png"],[UIImage imageNamed:@"Invitation-bg.png"],
					   [UIImage imageNamed:@"CourseInfo-bg.png"],[UIImage imageNamed:@"New-bg.jpg"],[UIImage imageNamed:@"New1-bg.jpg"],[UIImage imageNamed:@"Blank-bg.jpg"],nil] retain];
	
	[self setupPages_BusinessCardTemplates];
	
	pageController_TemplatesCards.imageNormal = [UIImage imageNamed:@"Untitled-2_0012_1-copy-82.png"];
	pageController_TemplatesCards.imageCurrent = [UIImage imageNamed:@"Untitled-2_0011_1-copy-83.png"];
	
	[pageController_TemplatesCards setImageNormal:[UIImage imageNamed:@"Untitled-2_0012_1-copy-82.png"]];
	[pageController_TemplatesCards setImageCurrent:[UIImage imageNamed:@"Untitled-2_0011_1-copy-83.png"]];
	
	
	
    [super viewDidLoad];
}

-(IBAction)btnChoosePressed:(id)sender
{
	if(appDel.indexForTemplate == 0)
	{
		EventDTDetail *eventDTDetail = [[EventDTDetail alloc]initWithNibName:@"EventDTDetail" bundle:nil];
		eventDTDetail.image_Card = [coversOriginal objectAtIndex:pageController_TemplatesCards.currentPage];
		eventDTDetail.btnIndex = pageController_TemplatesCards.currentPage;
		eventDTDetail.strFlag = strFlag;
		[self.navigationController pushViewController:eventDTDetail animated:TRUE];
		
		[eventDTDetail release];
		
	}
	else if(appDel.indexForTemplate == 1)
	{
		BusinessCardDetailViewController *businessCardDetailViewController = [[BusinessCardDetailViewController alloc]initWithNibName:@"BusinessCardDetailViewController" bundle:nil];
		businessCardDetailViewController.image_Card = [coversOriginal objectAtIndex:pageController_TemplatesCards.currentPage];
		businessCardDetailViewController.btnIndex = pageController_TemplatesCards.currentPage;
		
		[self.navigationController pushViewController:businessCardDetailViewController animated:TRUE];
		[businessCardDetailViewController release];
	}
	else if(appDel.indexForTemplate == 2)
	{
		InvitationDetailViewController *invitationDetailViewController = [[InvitationDetailViewController alloc]initWithNibName:@"InvitationDetailViewController" bundle:nil];
		invitationDetailViewController.image_Card = [coversOriginal objectAtIndex:pageController_TemplatesCards.currentPage];
		invitationDetailViewController.btnIndex = pageController_TemplatesCards.currentPage;
		
		[self.navigationController pushViewController:invitationDetailViewController animated:TRUE];
		[invitationDetailViewController release];
	}
	
	else if(appDel.indexForTemplate == 3)
	{
		IDBadgeDetailViewController *iDBadgeDetailViewController = [[IDBadgeDetailViewController alloc]initWithNibName:@"IDBadgeDetailViewController" bundle:nil];
		iDBadgeDetailViewController.image_Card = [coversOriginal objectAtIndex:pageController_TemplatesCards.currentPage];
		iDBadgeDetailViewController.btnIndex = pageController_TemplatesCards.currentPage;
		
		[self.navigationController pushViewController:iDBadgeDetailViewController animated:TRUE];
		[iDBadgeDetailViewController release];
	}
	
	else if(appDel.indexForTemplate == 4)
	{
		CourseInfoViewController *courseInfoViewController = [[CourseInfoViewController alloc]initWithNibName:@"CourseInfoViewController" bundle:nil];
		courseInfoViewController.image_Card = [coversOriginal objectAtIndex:pageController_TemplatesCards.currentPage];
		courseInfoViewController.btnIndex = pageController_TemplatesCards.currentPage;
		
		
		[self.navigationController pushViewController:courseInfoViewController animated:TRUE];
		[courseInfoViewController release];
	}
	
	
}
-(void)setupPages_BusinessCardTemplates
{
	CGFloat x1=0;
	for(int i=0;i<8;i++)
	{
		UIImageView *imgview1 = [[UIImageView alloc]initWithFrame:CGRectMake(x1+15,0,291,219)];
		imgview1.backgroundColor = [UIColor redColor];
		imgview1.image = [covers objectAtIndex:i];
		[scr_Templates addSubview:imgview1];
		x1+=320;
	}
	scr_Templates.contentSize = CGSizeMake(x1,0);
}


-(IBAction)changePage:(id)sender 
{
		CGRect frame = scr_Templates.frame;
		frame.origin.x = frame.size.width * pageController_TemplatesCards.currentPage;
		frame.origin.y = 0;
		
		[scr_Templates scrollRectToVisible:frame animated:YES];
	[scr_Templates setContentOffset:CGPointMake(frame.origin.x,0)];
		/*
		 *	When the animated scrolling finishings, scrollViewDidEndDecelerating will turn this off
		 */
		pageControlIsChangingPage = YES;
		
	
}

-(IBAction)btnBackPressed:(id)sender
{
	
	[self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)btnHomePressed:(id)sender
{
	
	[self.navigationController popToViewController:[[self.navigationController viewControllers]objectAtIndex:1] animated:YES];
}

#pragma mark UIScrollViewDelegate stuff
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView 
{
    pageControlIsChangingPage = NO;
}
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    if (pageControlIsChangingPage) {
        return;
    }
	CGFloat pageWidth = _scrollView.frame.size.width;
	int selectPage1 = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	pageController_TemplatesCards.currentPage = selectPage1;
	[pageController_TemplatesCards updateCurrentPageDisplay];
	
	
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
