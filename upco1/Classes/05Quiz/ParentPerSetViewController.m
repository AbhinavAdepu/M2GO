//
//  ParentPerSetViewController.m
//  KrenMarketing
//
//  Created by Jayna Gandhi on 28/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ParentPerSetViewController.h"
#import "PerSetViewController.h"
#import "DAL.h"

@implementation ParentPerSetViewController

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
	arrPersetQue = [[NSMutableArray alloc]init];
	
	
	[self setupPape_IphoneQuestions];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(FeedBackViewAdd_iPhone) 
												 name:@"FeedBackViewAdd_iPhone"
											   object:nil];
    
    
    pageCntrl_iPhoneQuiz.imageNormal = [UIImage imageNamed:@"Untitled-2_0012_1-copy-82.png"];
	pageCntrl_iPhoneQuiz.imageCurrent = [UIImage imageNamed:@"Untitled-2_0011_1-copy-83.png"];
	
	[pageCntrl_iPhoneQuiz setImageNormal:[UIImage imageNamed:@"Untitled-2_0012_1-copy-82.png"]];
	[pageCntrl_iPhoneQuiz setImageCurrent:[UIImage imageNamed:@"Untitled-2_0011_1-copy-83.png"]];

    
	
    [super viewDidLoad];
}

-(void)setupPape_IphoneQuestions
{
	for(int i=0;i<10;i++)
	{
		NSString *strQuery;
		
		
		if(appDel.chNo==23)
		{
			lblTitle.text = [NSString stringWithFormat:@"%@",@"Appendix A"];
			strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%@' and QuestionNo='%d'",@"APPENDIX A" ,i+1];
		}
		else if(appDel.chNo==24)
		{
			lblTitle.text = [NSString stringWithFormat:@"%@",@"Appendix B"];
			strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%@' and QuestionNo='%d'",@"APPENDIX B" ,i+1];
		}
		else
		{
			lblTitle.text = [NSString stringWithFormat:@"Chapter %d",appDel.chNo];
			strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%d' and QuestionNo='%d'",appDel.chNo ,i+1];
		}
		
		
		
		NSDictionary *Dict_queset1 = [DAL ExecuteDataSet:strQuery];
		NSArray *Dict_queset = [DAL ExecuteArraySet:strQuery];
		
		//for(int i=0;i<[Dict_queset count];i++)
		{
			NSDictionary *dictOpt = [NSDictionary dictionaryWithObjectsAndKeys:[[Dict_queset objectAtIndex:0] objectForKey:@"Question"],@"Question",@"NODATA",@"AnsOption",
									 @"NODATA",@"Answer",nil];
			[appDel.ansSetarr replaceObjectAtIndex:i withObject:dictOpt];
		}
		

		
		
		perSetViewController = [[PerSetViewController alloc] initWithNibName:@"PerSetViewController" 
																	  bundle:nil 
																	_dictQue:Dict_queset1
																	  _queNo:i];
		[arrPersetQue addObject:perSetViewController];
	}
	scr_Questions.contentSize = CGSizeMake(self.view.frame.size.width*10,0);
	[self setIndividualPage];
	
}
-(IBAction)btnbackPressed:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
-(void)setIndividualPage
{
    
    
	CGFloat cx1 = 0;
	
	for(int i=0;i<10;i++)
	{
		
		CGRect rect;
		rect.size.width = 320; 
		rect.size.height = 460;
		rect.origin.x = ((scr_Questions.frame.size.width - rect.size.width)/2)  + cx1 ;
		PerSetViewController *perSetViewController_obj = [arrPersetQue objectAtIndex:i];
		rect.origin.y = 0 ;
		perSetViewController_obj.view.frame = rect;
		[scr_Questions addSubview:perSetViewController_obj.view];		
		
		cx1 += scr_Questions.frame.size.width;
	}
	
	//pageControl.numberOfPages = 10;
	[scr_Questions setContentSize:CGSizeMake(cx1, 0)];
	scr_Questions.backgroundColor=[UIColor whiteColor];
	
	//[self.view bringSubviewToFront:pageControl];
	
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
	selectPage1 = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	pageCntrl_iPhoneQuiz.currentPage = selectPage1;
	[pageCntrl_iPhoneQuiz updateCurrentPageDisplay];
	
	
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)FeedBackViewAdd_iPhone
{
	ViewFeedBackoverview_Iphone *viewFeedBackoverview_Iphone =[ [ViewFeedBackoverview_Iphone alloc]initWithNibName:@"ViewFeedBackoverview_Iphone" bundle:nil];
	[self.navigationController pushViewController:viewFeedBackoverview_Iphone animated:YES];
	[viewFeedBackoverview_Iphone release];
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
