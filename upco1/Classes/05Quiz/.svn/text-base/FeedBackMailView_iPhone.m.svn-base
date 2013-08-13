//
//  FeedBackMailView_iPhone.m
//  KrenMarketing
//
//  Created by Jayna Gandhi on 27/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedBackMailView_iPhone.h"
#import "ViewFeedBack_iPhone.h"


@implementation FeedBackMailView_iPhone

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
		selectPage1 = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		pageControl.currentPage = selectPage1;
		[pageControl updateCurrentPageDisplay];
		
	
}
-(IBAction)changePage:(id)sender 
{
		CGRect frame = scrFeedbackmail_hori.frame;
		frame.origin.x = frame.size.width * pageControl.currentPage;
		frame.origin.y = 0;
		
		[scrFeedbackmail_hori scrollRectToVisible:frame animated:YES];
		
		/*
		 *	When the animated scrolling finishings, scrollViewDidEndDecelerating will turn this off
		 */
		pageControlIsChangingPage = YES;

	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	scrFeedbackmail_hori.contentSize = CGSizeMake(320*10, 0);
	
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	pageControl.imageNormal = [UIImage imageNamed:@"Untitled-2_0012_1-copy-82.png"];
	pageControl.imageCurrent = [UIImage imageNamed:@"Untitled-2_0011_1-copy-83.png"];
	
	[pageControl setImageNormal:[UIImage imageNamed:@"Untitled-2_0012_1-copy-82.png"]];
	[pageControl setImageCurrent:[UIImage imageNamed:@"Untitled-2_0011_1-copy-83.png"]];

	
	
	if(appDel.chNo == 23)
		lblHeading.text = [NSString stringWithFormat:@"%@",@"Appendix A"];
	else if(appDel.chNo == 24)
		lblHeading.text = [NSString stringWithFormat:@"%@",@"Appendix B"];
	else
	lblHeading.text = [NSString stringWithFormat:@"Chapter %d",appDel.chNo];
	NSString *strTitleResult = [NSString stringWithFormat:@"Out of %d questions, you have answered %d correctly with a final grade of %d",10,appDel.correct,(appDel.correct*100)/10];
	NSString *str = @"%";
	strTitleResult = [strTitleResult stringByAppendingFormat:@"%@",str];
	
	lblshowsCorrectAns.text = strTitleResult;
	spinner.hidden = NO;
	[self performSelector:@selector(viewFeedbackPresseds) withObject:nil afterDelay:1.0];
	//[self viewFeedbackPresseds];
    [super viewDidLoad];
}
-(void)viewFeedbackPresseds
{
	//btnBackTOchapters.hidden = YES;
	
	
	
	viewControllers = [[NSMutableArray alloc] init];
	for (unsigned i = 0; i < 10; i++) 
	{
		ViewFeedBack_iPhone *ViewFeedBackCtrller_obj = [[ViewFeedBack_iPhone alloc] initWithNibName:@"ViewFeedBack_iPhone" bundle:nil _page:i];
		//[viewControllers replaceObjectAtIndex:i withObject:ViewFeedBackCtrller_obj];
		
		
		[viewControllers addObject:ViewFeedBackCtrller_obj];
	}
	
	
	//pageControl.currentPage = 0;
	
	[self setupPage_FeedBackPage];
}
-(IBAction)btnback_QuiChapter:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
-(void)setupPage_FeedBackPage
{
	//pageControl.numberOfPages=totNOOfRow;
	spinner.hidden = YES;
		//NSUInteger nimages = 0;
	CGFloat cx1 = 0;
	
	//NSString *docDirtemp = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	for(int i=0;i<10;i++)
	{
		
			//scrFeedbackmail_hori.frame = CGRectMake(35,109,320,460);
		CGRect rect;
			rect.size.width = 320; 
			rect.size.height = 255;
			rect.origin.x = ((scrFeedbackmail_hori.frame.size.width - rect.size.width)/2)  + cx1 ;
			ViewFeedBack_iPhone *ViewFeedBackCtrller_obj = [viewControllers objectAtIndex:i];
		rect.origin.y = 0 ;
		ViewFeedBackCtrller_obj.view.frame = rect;
		[scrFeedbackmail_hori addSubview:ViewFeedBackCtrller_obj.view];		
		//[self.view addSubview:ViewFeedBackCtrller_obj.view];		
		
		cx1 += scrFeedbackmail_hori.frame.size.width;
	}
	
	pageControl.numberOfPages = 10;
	[scrFeedbackmail_hori setContentSize:CGSizeMake(cx1, 0)];
	scrFeedbackmail_hori.backgroundColor=[UIColor whiteColor];
	[self.view addSubview:scrFeedbackmail_hori];
	[self.view bringSubviewToFront:pageControl];
	
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
