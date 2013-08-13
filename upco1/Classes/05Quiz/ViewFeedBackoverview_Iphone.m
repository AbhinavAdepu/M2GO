//
//  ViewFeedBackoverview_Iphone.m
//  KrenMarketing
//
//  Created by Jayna Gandhi on 27/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewFeedBackoverview_Iphone.h"
#import "FeedBackMailView_iPhone.h"


@implementation ViewFeedBackoverview_Iphone

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	lblCorrect.text = [NSString stringWithFormat:@"%d",appDel.correct];
	lblIncorrect.text =  [NSString stringWithFormat:@"%d",appDel.incorrect];
	lblUnAnswered.text =  [NSString stringWithFormat:@"%d",appDel.unanswered];
	if(appDel.chNo == 23)
		lblHeading.text = [NSString stringWithFormat:@"%@",@"Appendix A"];
	else if(appDel.chNo == 24)
		lblHeading.text = [NSString stringWithFormat:@"%@",@"Appendix B"];
	else
			lblHeading.text = [NSString stringWithFormat:@"Chapter %d",appDel.chNo];
	NSString *strTitleResult = [NSString stringWithFormat:@"Out of %d questions, you have answered %d correctly with a final grade of %d",10,appDel.correct,(appDel.correct*100)/10];
	NSString *str = @"%";
	strTitleResult = [strTitleResult stringByAppendingFormat:@"%@",str];
	
	lblHeaderQuiz.text = strTitleResult;
	[super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
	
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
-(IBAction)btnFeedBackPressed:(id)sender
{
	
	[self performSelector:@selector(changeView) withObject:nil afterDelay:0.1];
		
}
-(IBAction)BackToParent
{
	[self.navigationController popViewControllerAnimated:TRUE];
}
-(void)changeView
{
	[appDel.arr_emailImages_Quiz removeAllObjects];
	FeedBackMailView_iPhone *feedBackMailView_iPhone = [[FeedBackMailView_iPhone alloc]initWithNibName:@"FeedBackMailView_iPhone" bundle:nil];
	[self.navigationController pushViewController:feedBackMailView_iPhone animated:YES];
	[feedBackMailView_iPhone release];
	
}
- (void)dealloc {
    [super dealloc];
}


@end
