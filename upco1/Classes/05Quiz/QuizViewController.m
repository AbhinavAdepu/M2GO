//
//  QuizViewController.m
//  KrenMarketing
//
//  Created by Silvertouch on 17/11/11.
//  Copyright 2011 SilverTouch Tech. Ltd. All rights reserved.
//

#import "QuizViewController.h"
#import "PerSetViewController.h"
#import "ViewFeedBackCtrller.h"
#import "QuizeCell-L.h"
#import "QuizeCell-P.h"
#import "DAL.h"
#import "ParentPerSetViewController.h"

static int NumberOfRows = 2;

@implementation QuizViewController
@synthesize pageControl;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
		
        // Custom initialization.
		
		//tblQuiz.frame = CGRectMake(0, 0, 20, 1024);
		//[self.view addSubview:tblQuiz];
    }
    return self;
}

#pragma mark UITableView Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight)
	{
		return 67;
	}
	else 
	{
		return 92;
	}
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return totNOOfRow;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
	
  /*  NSString *CellIdentifier = [NSString stringWithFormat:@"%d",indexPath.row];
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
    }
	
{	
	UIImageView *imgBg = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,184,92)];
	imgBg.image = [UIImage imageNamed:@"_0000_Layer-3.png"];
	[cell.contentView addSubview:imgBg];
	
	
	UILabel *lblHeading = [[UILabel alloc]initWithFrame:CGRectMake(0,0,150,92)];
	lblHeading.text = [NSString stringWithFormat:@"Question %d",indexPath.row+1];
	lblHeading.textAlignment = UITextAlignmentCenter;
	lblHeading.textColor = [UIColor blackColor];
	[cell.contentView addSubview:lblHeading];
	
	
	
	if([selectedindexes count] > 1)
	for(int i=0;i<[selectedindexes count];i++)
	{
		int temp = [[selectedindexes objectAtIndex:i]intValue];
		if(temp == indexPath.row)
		{
			imgBg.image = [UIImage imageNamed:@"_0001_Layer-4.png"];
			lblHeading.backgroundColor = [UIColor clearColor];
			lblHeading.textColor = [UIColor grayColor];
		}
	}
	if(selectedRow == indexPath.row)
	{
		imgBg.image = [UIImage imageNamed:@"_0003_Layer-5.png"];
		lblHeading.backgroundColor = [UIColor clearColor];
		lblHeading.textColor = [UIColor whiteColor];
	}
	}
    // Configure the cell...;
    //cell.textLabel.text = [NSString stringWithFormat:@"Question %d",indexPath.row+1];
	
	//cell.selectedImage
    return cell;*/
	
	
	
	
	
	
	
	
	//AMrit\
	
	
	if([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight)
	{
		
		static NSString *CellIdentifier = @"CustomCell";
		QuizeCell_L *cell = (QuizeCell_L *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"QuizeCell-L" owner:self options:nil];
			for (id currentObject in topLevelObjects){
				if ([currentObject isKindOfClass:[UITableViewCell class]]){
					cell =  (QuizeCell_L *) currentObject;
					break;
				}
			}
		}
		
		UIImageView *imgBg = [[[UIImageView alloc]initWithFrame:CGRectMake(0,0,360,67)] autorelease];
		imgBg.image = [UIImage imageNamed:@"_0029_Layer-1.png"];
		
		
		[cell.contentView addSubview:imgBg];
		
		
		UILabel *lblHeading = [[[UILabel alloc]initWithFrame:CGRectMake(20,0,300,67)] autorelease];
		lblHeading.text = [NSString stringWithFormat:@"Question %d",indexPath.row+1];
		lblHeading.textAlignment = UITextAlignmentLeft;
		lblHeading.font = [UIFont boldSystemFontOfSize:17];
		lblHeading.textColor = [UIColor blackColor];
		[cell.contentView addSubview:lblHeading];
		
		
		
		if([selectedindexes count] > 1)
			for(int i=0;i<[selectedindexes count];i++)
			{
				int temp = [[selectedindexes objectAtIndex:i]intValue];
				if(temp == indexPath.row)
				{
					if([self queColorChange:indexPath.row])
					{}
					else {
						
					imgBg.image = [UIImage imageNamed:@"_0027_Layer-2.png"];
					lblHeading.backgroundColor = [UIColor clearColor];
					lblHeading.textColor = [UIColor grayColor];
					}
				}
			}
		if(selectedRow == indexPath.row && selectPage == indexPath.row)
		{
			imgBg.image = [UIImage imageNamed:@"_0028_Layer-3.png"];
			lblHeading.backgroundColor = [UIColor clearColor];
			lblHeading.textColor = [UIColor whiteColor];
		}
		
		
		//cell.lblQuize.text = [NSString stringWithFormat:@"Question %d",indexPath.row+1];
		
		return cell;
	}
	
	else 
	{
		static NSString *CellIdentifier = @"CustomCell";
		QuizeCell_P *cell = (QuizeCell_P *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"QuizeCell-P" owner:self options:nil];
			for (id currentObject in topLevelObjects){
				if ([currentObject isKindOfClass:[UITableViewCell class]]){
					cell =  (QuizeCell_P *) currentObject;
					break;
				}
			}
		}
		
		UIImageView *imgBg = [[[UIImageView alloc]initWithFrame:CGRectMake(0,0,184,92)] autorelease];
		imgBg.image = [UIImage imageNamed:@"_0000_Layer-3.png"];
		[cell.contentView addSubview:imgBg];
		
		
		UILabel *lblHeading = [[[UILabel alloc]initWithFrame:CGRectMake(0,0,150,92)] autorelease];
		lblHeading.text = [NSString stringWithFormat:@"Question %d",indexPath.row+1];
		lblHeading.textAlignment = UITextAlignmentCenter;
		lblHeading.font = [UIFont boldSystemFontOfSize:17];
		lblHeading.textColor = [UIColor blackColor];
		[cell.contentView addSubview:lblHeading];
		
		
		
		if([selectedindexes count] > 1)
			for(int i=0;i<[selectedindexes count];i++)
			{
				int temp = [[selectedindexes objectAtIndex:i]intValue];
				if(temp == indexPath.row)
				{
					if([self queColorChange:indexPath.row])
					{}
					else {
						

					imgBg.image = [UIImage imageNamed:@"_0001_Layer-4.png"];
					lblHeading.backgroundColor = [UIColor clearColor];
					lblHeading.textColor = [UIColor grayColor];
					}
				}
			}
		if(selectedRow == indexPath.row && selectPage == indexPath.row)
		{
			imgBg.image = [UIImage imageNamed:@"_0003_Layer-5.png"];
			lblHeading.backgroundColor = [UIColor clearColor];
			lblHeading.textColor = [UIColor whiteColor];
		}
		
		
		//cell.lblQuize.text = [NSString stringWithFormat:@"Question %d",indexPath.row+1];
		
		return cell;
	}
	
	
	
	
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	scrQuizPage_Result.scrollEnabled = NO;
	scrQuizPage_Result.hidden = TRUE;
	
	selectedRow = indexPath.row;
	selectPage = indexPath.row;
	[selectedindexes addObject:[NSNumber numberWithInt:selectedRow]];
	UITableViewCell *cell = [tblQuizQue cellForRowAtIndexPath:indexPath];
	UILabel *lblHeading = [[UILabel alloc]init];
	UIImageView *imgBg = [[UIImageView alloc]init];
	if([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight)
	{
		imgBg.frame = CGRectMake(0,0,360,67);
		imgBg.image = [UIImage imageNamed:@"_0028_Layer-3.png"];
		lblHeading.frame = CGRectMake(0,0,360,67);
		
	}
	else 
	{
		imgBg.frame = CGRectMake(0,0,184,92);
		imgBg.image = [UIImage imageNamed:@"_0003_Layer-5.png"];
		lblHeading.frame = CGRectMake(0,0,150,92);
		
	}
	
	
	
	
	
	lblHeading.text = [NSString stringWithFormat:@"Question %d",indexPath.row+1];
	lblHeading.textAlignment = UITextAlignmentLeft;
	lblHeading.textColor = [UIColor whiteColor];
	[cell.contentView addSubview:imgBg];
	[cell.contentView addSubview:lblHeading];
	
	[imgBg release];
	[lblHeading release];
	
	[tblQuizQue reloadData];
	
	if(appDel.ori == UIInterfaceOrientationPortraitUpsideDown || 
	   appDel.ori == UIInterfaceOrientationPortrait)
	{
		[scrlForQuiz setContentOffset:CGPointMake(selectedRow*504, 0)];
	}
	else if(appDel.ori == UIInterfaceOrientationLandscapeLeft || 
			appDel.ori == UIInterfaceOrientationLandscapeRight)
	{
		[scrlForQuiz setContentOffset:CGPointMake(selectedRow*585, 0)];
		
	}
	
		
}

#pragma mark FeedBackViewAdd
-(IBAction)backToQuestion:(id)sender
{
	
	
		//[button removeFromSuperview];
	
	
	[self.view bringSubviewToFront:btnBackTOchapters];
	
	[feedBackView removeFromSuperview];
	
}
-(BOOL)queColorChange:(int)rowInt
{
	BOOL flagAnswered;
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	NSDictionary *dict = [appDel.ansSetarr objectAtIndex:rowInt];
	//NSLog(@"dict==%@",[dict objectForKey:@"Question"]);
	//NSLog(@"dict==%@",appDel.ansSetarr);
	//NSLog(@"dict==%@",[dict objectForKey:@"Answer"]);
	
	if([[dict objectForKey:@"Answer"] isEqualToString:@"NODATA"])
	{
		flagAnswered = FALSE;
		
		
	}else {
		flagAnswered = TRUE;
	}

	//return flagAnswered;
	/*if([[dict objectForKey:@"Answer"] isEqualToString:@"NODATA"])
	{
		lblanswer.text = @"Unanswered";

		
	}
	else if([[[arr_queset objectAtIndex:0] objectForKey:@"Answer"] isEqualToString:[dict objectForKey:@"Answer"]])
	{
		signImgView.image = [UIImage imageNamed:@"_0001_Round-tick.png"];
	
	}
	else {
		signImgView.image = [UIImage imageNamed:@"_0000_Round-cross.png"];
		
	}*/
	/********************/
}
-(void)FeedBackViewAdd
{
	[arrPersetQue removeAllObjects];
	
	NSString *strTitleResult = [NSString stringWithFormat:@"Out of %d questions, you have answered %d correctly with a final grade of %d",totNOOfRow,appDel.correct,(appDel.correct*100)/totNOOfRow];
	NSString *str = @"%";
	strTitleResult = [strTitleResult stringByAppendingFormat:@"%@",str];
	//NSLog(@"%@",strTitleResult);
	
	[SubmitBtn setUserInteractionEnabled:YES];
	feedBackView.frame = CGRectMake(0, 38, 910, 956);
	lblunanswered.text = [NSString stringWithFormat:@"%d",appDel.unanswered];
	lblincorrect.text = [NSString stringWithFormat:@"%d",appDel.incorrect];
	lblcorrect.text = [NSString stringWithFormat:@"%d",appDel.correct];
	
	lblHeading_result.text = strTitleResult;
	
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		
		lblHeading_result.frame = CGRectMake(30, 0, 660, 75);
		
		
		lblcorrect.frame = CGRectMake(95, 470, 171, 78);
		lblincorrect.frame = CGRectMake(95+180, 470, 171, 78);
		lblunanswered.frame = CGRectMake(95+180+180, 470, 171, 78);
		
		btnViewfeedback.frame = CGRectMake(270, 600, 186, 58);
		//button.frame = CGRectMake(20, 2, 72.0, 37.0);
	}
	else{
		lblHeading_result.frame = CGRectMake(120, 0, 700, 75);
		//topGrayImageView.frame = CGRectMake(-12, 0, 960, 78);
		imgFeedBack.frame = CGRectMake(200, 220, 550, 164);
		lblcorrect.frame = CGRectMake(210, 294, 175, 80);
		lblincorrect.frame = CGRectMake(390, 294, 175, 80);
		lblunanswered.frame = CGRectMake(570, 294, 175, 80);
		btnViewfeedback.frame = CGRectMake(390, 420, 186, 58);
		
		/*if(oncePort == TRUE)
			button.frame = CGRectMake(10, 2, 72.0, 37.0);
		else
			button.frame = CGRectMake(20, 2, 72.0, 37.0);*/
		
	}
	
	
	
	[self.view addSubview:feedBackView];
	//[topLable1 bringSubviewToFront:btnBackTOchapters];
	
	//[self.view sendSubviewToBack:feedBackView];
	[self.view bringSubviewToFront:topImage];
	[self.view bringSubviewToFront:topLable1];
	[self.view bringSubviewToFront:btnBackTOchapters];
	//[self.view  addSubview:button];
	//button.hidden = NO;
	//[self.view bringSubviewToFront:button];
	
	
	
	
	
}

-(void)FeedBackViewAdd_submitALL
{
	SubmitBtn.userInteractionEnabled = TRUE;
	[SubmitBtn setImage:[UIImage imageNamed:@"_0026_Normal-State.png"] forState:UIControlStateNormal];
}
-(IBAction)viewFeedbackPressed:(id)sender
{
	//btnBackTOchapters.hidden = YES;
	fromViewFeedBack = TRUE;
	[scrlForQuiz removeFromSuperview];
	[scrlForQuiz release];
	scrlForQuiz = nil;
	pageControl.hidden = NO;
	
		
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		

		pageControl.frame = CGRectMake(75, 940, 569, 34);
	scrQuizPage_Result.contentSize = CGSizeMake(768*totNOOfRow, 0);
	}
	else {
			pageControl.frame = CGRectMake(310, 700, 300, 34);
		scrQuizPage_Result.contentSize = CGSizeMake(1024*totNOOfRow, 0);
		
	}

	[scrQuizPage_Result setHidden:NO];
	scrQuizPage_Result.scrollEnabled = YES;
	
	
	pageControl.numberOfPages = totNOOfRow;
	
	[self.view bringSubviewToFront:scrQuizPage_Result];
	[self.view bringSubviewToFront:pageControl];
	if([viewControllers retainCount] > 0)
	{
		[viewControllers release];
		viewControllers = nil;
	}
	viewControllers = [[NSMutableArray alloc] init];
	for (unsigned i = 0; i < totNOOfRow; i++) 
	{
			ViewFeedBackCtrller *ViewFeedBackCtrller_obj = [[ViewFeedBackCtrller alloc] initWithNibName:@"ViewFeedBackCtrller" bundle:nil _page:i];
			//[viewControllers replaceObjectAtIndex:i withObject:ViewFeedBackCtrller_obj];
			
	
		[viewControllers addObject:ViewFeedBackCtrller_obj];
	}
	
	
	pageControl.currentPage = 0;
	
	[self setupPage_FeedBackPage];
}
-(void)EmailClickFrameSet
{
	
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{		
		
	}
	else 
	{
		topGrayImageView.frame = CGRectMake(-12, 0, 960, 78);
		//lblHeading_result.frame = CGRectMake(80, 0, 700, 75);
		//topLable1.frame = CGRectMake(-2, -5, 940, 48);
		//		tempvctrl.view.frame =CGRectMake(40+tblQuizQue.frame.size.width,48,self.view.frame.size.width - tblQuizQue.frame.size.width,tblQuizQue.frame.size.height);
		//		
		
	}
		
}
#pragma mark btnQuizChapterPressed
-(IBAction)btnSubmitALLPressed:(id)sender
{
	int correct=0;
	int incorrect=0;
	int unanswered=0;
	
	NSString *strQuery ;
	if(appDel.chNo==23)
	{
		topLable1.text = [NSString stringWithFormat:@"Quiz - Chapter %@",@"APPENDIX A"];
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%@'",@"APPENDIX A"];
	}
	else if(appDel.chNo==24)
	{
		topLable1.text = [NSString stringWithFormat:@"Quiz - Chapter %@",@"APPENDIX B"];
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%@'",@"APPENDIX B"];
	}
	else
	{
		topLable1.text = [NSString stringWithFormat:@"Quiz - Chapter %d",appDel.chNo];
		
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%d'",appDel.chNo];
	}
	//NSString *strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%d'",appDel.chNo];
	NSDictionary *Dict_queset = [DAL ExecuteDataSet:strQuery];
	
	for(int i=0;i<[Dict_queset count];i++)
	{
		NSString *key = [NSString stringWithFormat:@"Table%d",i+1];
		////NSLog(@"%@",[[Dict_queset objectForKey:key] objectForKey:@"Answer"]);
		//NSLog(@"%@",[appDel.ansSetarr objectAtIndex:i]);
		
		//if([[appDel.ansSetarr objectAtIndex:i] isEqualToString:@"NODATA"])
		//		{
		//			unanswered++;
		//		}
		//else 
		if([[[Dict_queset objectForKey:key] objectForKey:@"Answer"] isEqualToString:[[appDel.ansSetarr objectAtIndex:i]objectForKey:@"Answer"]])
		{
			correct++;
		}
		else if([[[appDel.ansSetarr objectAtIndex:i]objectForKey:@"Answer"] isEqualToString:@"NODATA"])
		{
			unanswered++;
		}
		else {
			incorrect++;
		}
		
		
		
	}
	//unanswered = 5 - (correct+incorrect);
	//NSLog(@"correct==%d  incorrect==%d  unanswers==%d",correct,incorrect,unanswered);
	
	appDel.correct = correct;
	appDel.incorrect = incorrect;
	appDel.unanswered = unanswered;
	
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"FeedBackViewAdd" object:nil];
	
	
}
-(IBAction)btnChapterClicked:(id)sender
{
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
//	SubmitBtn.userInteractionEnabled = NO;
	SubmitBtn.userInteractionEnabled = YES;
	[SubmitBtn setImage:[UIImage imageNamed:@"_0026_Normal-State.png"] forState:UIControlStateNormal];
	
	[viewQuizCh removeFromSuperview];
	appDel.chNo = [sender tag]+1;
	NSString *strQuery ;
	if([sender tag]==22)
	{
		topLable1.text = [NSString stringWithFormat:@"Quiz - Chapter %@",@"APPENDIX A"];
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%@'",@"APPENDIX A"];
	}
	else if([sender tag]==23)
	{
		topLable1.text = [NSString stringWithFormat:@"Quiz - Chapter %@",@"APPENDIX B"];
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%@'",@"APPENDIX B"];
	}
	else
	{
		topLable1.text = [NSString stringWithFormat:@"Quiz - Chapter %d",[sender tag]+1];
	
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%d'",[sender tag]+1];
	}
	NSArray *Dict_queset = [DAL ExecuteArraySet:strQuery];
	
	
	
	for(int i=0;i<[Dict_queset count];i++)
	{
		NSDictionary *dictOpt = [NSDictionary dictionaryWithObjectsAndKeys:[[Dict_queset objectAtIndex:i] objectForKey:@"Question"],@"Question",@"NODATA",@"AnsOption",
								 @"NODATA",@"Answer",nil];
		[appDel.ansSetarr replaceObjectAtIndex:i withObject:dictOpt];
	}
	
	
	totNOOfRow = [Dict_queset count];
//	totNOOfRow=7;
	self.pageControl.numberOfPages = totNOOfRow;
	[arrPersetQue removeAllObjects];
	
	for(int i=0;i<totNOOfRow;i++)
	{
		NSString *strQuery;
		
		if([sender tag]==22)
		{
			strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%@' and QuestionNo='%d'",@"APPENDIX A" ,i+1];
		}
		else if([sender tag]==23)
		{
			strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%@' and QuestionNo='%d'",@"APPENDIX B" ,i+1];
		}
		else
		{
			strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%d' and QuestionNo='%d'",appDel.chNo ,i+1];
		}
		
		
		
		NSDictionary *Dict_queset1 = [DAL ExecuteDataSet:strQuery];
	
		
		perSetViewController = [[PerSetViewController alloc] initWithNibName:@"PerSetViewController" 
																	  bundle:nil 
																	_dictQue:Dict_queset1
																	  _queNo:i];
		[arrPersetQue addObject:perSetViewController];
	}
	
	selectedRow = 0;
	[selectedindexes addObject:[NSNumber numberWithInt:selectedRow]];
	[self.view bringSubviewToFront:btnBackTOchapters];

	
	//add scrollview for quizzz
	if([scrlForQuiz retainCount]>0)
	{
		[scrlForQuiz removeFromSuperview];
		[scrlForQuiz release];
		scrlForQuiz = nil;
	}
	scrlForQuiz.frame = CGRectMake(40+tblQuizQue.frame.size.width,48,self.view.frame.size.width - tblQuizQue.frame.size.width,tblQuizQue.frame.size.height);
	scrlForQuiz.pagingEnabled = YES;
	scrlForQuiz.tag = 2;
	[scrlForQuiz setBackgroundColor:[UIColor whiteColor]];
	scrlForQuiz.contentSize = CGSizeMake((self.view.frame.size.width - tblQuizQue.frame.size.width)*totNOOfRow,0);
	[self.view addSubview:scrlForQuiz];
	pageControl_ForQuiz.hidden = NO;
	//[self setupPage];
	/***************************/
	
	
	/*if([arrPersetQue count] > 0)
	{
		[tempvctrl.view removeFromSuperview];
		tempvctrl = (UIViewController *)[arrPersetQue objectAtIndex:0];
		//tempvctrl.view.frame =CGRectMake(40+tblQuizQue.frame.size.width,48,self.view.frame.size.width - tblQuizQue.frame.size.width,tblQuizQue.frame.size.height);
		tempvctrl.view.frame =CGRectMake(0,0,self.view.frame.size.width - tblQuizQue.frame.size.width,tblQuizQue.frame.size.height);
		
		[scrlForQuiz addSubview:tempvctrl.view];
	}*/
	[tblQuizQue reloadData];
	//[tblQuizQue selectRowAtIndexPath:0 animated:YES scrollPosition:UITableViewScrollPositionTop];
	
	//if(tblQuizQue)
//		[tblQuizQue removeFromSuperview];
	
	//scrQuizPage.delegate = self;
	[tblQuizQue setBackgroundColor:[UIColor whiteColor]];
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		
		//jayna	
		
		[self setFrameOrientation_Portrait];
		//tblQuizQue.frame = CGRectMake(0, 50, 160, 1004-50);
		
	}
	if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
	   appDel.ori == UIInterfaceOrientationLandscapeRight)
	{
		
		[self setFrameOrientation_LandScap];
		//tblQuizQue.frame = CGRectMake(0, 50, 200, 768-50);
	}
	
	[self.view addSubview:tblQuizQue];
	
	}
	else 
	{
		appDel.chNo = [sender tag]+1;
			ParentPerSetViewController *parentPerSetViewController = [[ParentPerSetViewController alloc] initWithNibName:@"ParentPerSetViewController" 
																	  bundle:nil];			
			
			[self.navigationController pushViewController:parentPerSetViewController animated:TRUE];
	//	}
	}

	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	 [super viewDidLoad];
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	appDel.arr_emailImages_Quiz = [[[NSMutableArray alloc]init] retain];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		
	cx =0;
	
	pageControl.hidden = YES;
	pageControl_ForQuiz.hidden = YES;
	kNumberOfPages = 10;
	selectedRow = -1;
	firstTime = TRUE;
	oncePort = FALSE;
	if([selectedindexes retainCount] > 0)
	{
		[selectedindexes release];
		selectedindexes = nil;
	}
	selectedindexes = [[NSMutableArray alloc] init];
	
	pageControl.hidden = YES;
	pageControl.imageNormal = [UIImage imageNamed:@"_0001_Gray-dot.png"];
	pageControl.imageCurrent = [UIImage imageNamed:@"_0000_Black-dot.png"];
	
	[pageControl setImageNormal:[UIImage imageNamed:@"_0001_Gray-dot.png"]];
	[pageControl setImageCurrent:[UIImage imageNamed:@"_0000_Black-dot.png"]];
	
	pageControl_ForQuiz.imageNormal = [UIImage imageNamed:@"_0001_Gray-dot.png"];
	pageControl_ForQuiz.imageCurrent = [UIImage imageNamed:@"_0000_Black-dot.png"];
	
	[pageControl_ForQuiz setImageNormal:[UIImage imageNamed:@"_0001_Gray-dot.png"]];
	[pageControl_ForQuiz setImageCurrent:[UIImage imageNamed:@"_0000_Black-dot.png"]];
	
	
	scrlForQuiz = [[UIScrollView alloc]initWithFrame:CGRectZero];
				   scrQuizPage_Result.tag = 1;
		[[NSNotificationCenter defaultCenter] removeObserver:self name:@"didRotate" object:nil];
    	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(didRotate:) 
												 name:UIApplicationDidChangeStatusBarOrientationNotification
											   object:nil];
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(FeedBackViewAdd) 
												 name:@"FeedBackViewAdd"
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(FeedBackViewAdd_submitALL) 
												 name:@"FeedBackViewAdd_submitALL"
											   object:nil];
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(EmailClickFrameSet) 
												 name:@"EmailClickFrameSet"
											   object:nil];
	
	/*[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(callLandScap) 
												 name:@"callLandScap"
											   object:nil];*/
	 
	
	
	
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	    appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		
		mainImage.frame = CGRectMake(14, 0, 700, 1024);
		mainImage.image = [UIImage imageNamed:@"Red_Layer-1.png"];
		
		topImage.image = [UIImage imageNamed:@"_0009_top-red-band.png"];
		topImage.frame = CGRectMake(0, 0, 600, 48);
		topLable.frame = CGRectMake(11, -5, 700, 48);
		
		
		whiteLayer.frame = CGRectMake(14, 38, 768, 38);
		whiteLayer.image = [UIImage imageNamed:@"Layer-76.png"];
		
		labelWhite.frame = CGRectMake(10, 38, 700, 38);
		
		imgFeedBack.frame = CGRectMake(94,245,565,169);
		modVal = 4;
	}
	else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
			 appDel.ori == UIInterfaceOrientationLandscapeRight)
	{
		mainImage.frame = CGRectMake(13, 38, 1024, 768);
		mainImage.image = [UIImage imageNamed:@"red-bg.png"];
		
		topImage.image = [UIImage imageNamed:@"_0006_top-red-band910.png"];
		topImage.frame = CGRectMake(0, 0, 1004, 48);
		topLable.frame = CGRectMake(0, 0, 940, 48);
		
		whiteLayer.frame = CGRectMake(0, 38, 1004, 38);
		whiteLayer.image = [UIImage imageNamed:@"Layer-76.png"];
		
		labelWhite.frame = CGRectMake(0, 38, 940, 38);
		modVal = 6;
		
		
	}
	//[viewQuizCh addSubview:mainImage];
	//[viewQuizCh addSubview:topImage];
	//[viewQuizCh addSubview:topLable];
	
	CGFloat x=81;
	CGFloat y=48+38+17;
	CGFloat Width = 34;
	CGFloat Height = 35;
	if([btnChapterArr retainCount] > 0)
	{
		[btnChapterArr release];
		btnChapterArr=nil;
	}
	btnChapterArr = [[NSMutableArray alloc]init];
	
	for(int i=0;i<24;i++)
	{
		
		UIButton *btnChapter = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnChapter setTag:i];
        
      
		[btnChapter setTitle:[NSString stringWithFormat:[NSString stringWithFormat:@"%d",i+1]] forState:UIControlStateNormal];
		btnChapter.titleLabel.font = [UIFont fontWithName:@"Cantoria MT Std" size:44];
		[btnChapter setContentEdgeInsets:UIEdgeInsetsMake(15, 0, 0, 10)];
		[btnChapter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnChapter setBackgroundImage:[UIImage imageNamed:@"Copy of _0054_1-.png"] forState:UIControlStateNormal];
        [btnChapter addTarget:self action:@selector(btnChapterClicked:) forControlEvents:UIControlEventTouchUpInside];
        [viewQuizCh addSubview:btnChapter];
		[self.view bringSubviewToFront:btnChapter];
		
			
		if(i%modVal == 0 && i>0)
		{
			x=81;
			y+=Height+116;
		}
		else {
			//NSLog(@"ld===%i",i);
		}
		
		if(i==22)
			[btnChapter setTitle:@"A" forState:UIControlStateNormal];
		if(i==23)
			[btnChapter setTitle:@"B" forState:UIControlStateNormal];
		btnChapter.frame = CGRectMake(x, y, 117, 116);
		x+=Width+117;
		
		[btnChapterArr addObject:btnChapter];
		
		
	}
	if([arrPersetQue retainCount] > 0)
	{
		[arrPersetQue release];
		arrPersetQue = nil;
	}
	arrPersetQue = [[NSMutableArray alloc]init];
	[self.view addSubview:viewQuizCh];
	
	[self didRotate:nil];
	
	//button = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	//[button addTarget:self 
	//		   action:@selector(backToQuestion:)
	// forControlEvents:UIControlEventTouchDown];
	//[button setImage:[UIImage imageNamed:@"Potrait__Back-arrow-icon.png"] forState:UIControlStateNormal];
	//button.frame = CGRectMake(20, 2, 72.0, 37.0);
	//button.hidden = YES;
	
	
	
   
	}
	else 
	{
		iphonPageControl.imageNormal = [UIImage imageNamed:@"Untitled-2_0012_1-copy-82.png"];
		iphonPageControl.imageCurrent = [UIImage imageNamed:@"Untitled-2_0011_1-copy-83.png"];
		
		[iphonPageControl setImageNormal:[UIImage imageNamed:@"Untitled-2_0012_1-copy-82.png"]];
		[iphonPageControl setImageCurrent:[UIImage imageNamed:@"Untitled-2_0011_1-copy-83.png"]];
		
		btnScrollView.showsHorizontalScrollIndicator = NO;
		
		[self setupPage];	
			//	[iphonPageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
	}
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
#pragma mark pageControl Methods



-(void)setupPage_FeedBackPage
{
	//pageControl.numberOfPages=totNOOfRow;
	
	if([scrQuizPage_Result retainCount] > 0)
	{
		[scrQuizPage_Result removeFromSuperview];
		[scrQuizPage_Result release];
		scrQuizPage_Result = nil;
	}
	scrQuizPage_Result = [[UIScrollView alloc]init];
	scrQuizPage_Result.tag = 1;
	
	[scrQuizPage_Result setBackgroundColor:[UIColor clearColor]];
	[scrQuizPage_Result setCanCancelContentTouches:NO];
	
	scrQuizPage_Result.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrQuizPage_Result.clipsToBounds = YES;
	scrQuizPage_Result.scrollEnabled = YES;
	scrQuizPage_Result.pagingEnabled = YES;
	scrQuizPage_Result.delegate = self;
	
	//NSUInteger nimages = 0;
	CGFloat cx1 = 0;
	
	//NSString *docDirtemp = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	for(int i=0;i<totNOOfRow;i++)
	{
		
	
		
		if(appDel.ori == UIInterfaceOrientationPortraitUpsideDown || 
		   appDel.ori == UIInterfaceOrientationPortrait)
		{
			
			scrQuizPage_Result.frame = CGRectMake(35,109,768,900);
			rect.size.width = 768; 
			rect.size.height = 900;
			rect.origin.x = ((scrQuizPage_Result.frame.size.width - rect.size.width)/2)  + cx1 ;
			
		}
		else if(appDel.ori == UIInterfaceOrientationLandscapeLeft || 
				appDel.ori == UIInterfaceOrientationLandscapeRight)
		{
			
			scrQuizPage_Result.frame = CGRectMake(0,109,1024,900);
			rect.size.width = 1024; 
			rect.size.height = 900;
			rect.origin.x = ((scrQuizPage_Result.frame.size.width - rect.size.width)/2)  + cx1+120 ;
		}	
		
		
		
		
		ViewFeedBackCtrller *ViewFeedBackCtrller_obj = [viewControllers objectAtIndex:i];
				rect.origin.y = 0 ;
		ViewFeedBackCtrller_obj.view.frame = rect;
		[scrQuizPage_Result addSubview:ViewFeedBackCtrller_obj.view];		
	
		cx1 += scrQuizPage_Result.frame.size.width;
	}
	
	self.pageControl.numberOfPages = totNOOfRow;
	[scrQuizPage_Result setContentSize:CGSizeMake(cx1, [scrQuizPage_Result bounds].size.height)];
	scrQuizPage_Result.backgroundColor=[UIColor whiteColor];
	[self.view addSubview:scrQuizPage_Result];
	[self.view bringSubviewToFront:pageControl];
	
}

- (IBAction)setupPage 
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		
		
		pageControl.numberOfPages=totNOOfRow;
		
		if([scrlForQuiz retainCount] > 0)
		{
			[scrlForQuiz removeFromSuperview];
			[scrlForQuiz release];
			scrlForQuiz = nil;
		}
		scrlForQuiz = [[UIScrollView alloc]init];
		
		
		[scrlForQuiz setBackgroundColor:[UIColor clearColor]];
		[scrlForQuiz setCanCancelContentTouches:NO];
		
		scrlForQuiz.indicatorStyle = UIScrollViewIndicatorStyleWhite;
		scrlForQuiz.clipsToBounds = YES;
		scrlForQuiz.scrollEnabled = YES;
		scrlForQuiz.pagingEnabled = YES;
		scrlForQuiz.delegate = self;
		scrlForQuiz.tag = 2;
		//NSUInteger nimages = 0;
		CGFloat cx = 0;
		
		/*if([arrPersetQue count] == 0)
		 {
		 for(int i=0;i<totNOOfRow;i++)
		 {
		 NSString *strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%d' and QuestionNo='%d'",appDel.chNo ,i+1];
		 NSDictionary *Dict_queset1 = [DAL ExecuteDataSet:strQuery];
		 
		 
		 perSetViewController = [[PerSetViewController alloc] initWithNibName:@"PerSetViewController" 
		  bundle:nil 
		 _dictQue:Dict_queset1
		  _queNo:i];
		 [arrPersetQue addObject:perSetViewController];
		 }
		 }*/
		//NSString *docDirtemp = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		for(int i=0;i<totNOOfRow;i++)
		{
			if([arrPersetQue count] > 0)
			{
				tempvctrl = (UIViewController *)[arrPersetQue objectAtIndex:i];
				rect = tempvctrl.view.frame;
				
				
				if(appDel.ori == UIInterfaceOrientationPortraitUpsideDown || 
				    appDel.ori == UIInterfaceOrientationPortrait)
				{
					pageControl_ForQuiz.frame = CGRectMake(40+tblQuizQue.frame.size.width,945,504,30);
					scrlForQuiz.frame = CGRectMake(40+tblQuizQue.frame.size.width,48,504,965);
					rect.size.width = 504; 
					rect.size.height = 965;
					rect.origin.x = ((scrlForQuiz.frame.size.width - rect.size.width)/2) + cx ;
					
				}
				else if(appDel.ori == UIInterfaceOrientationLandscapeLeft || 
						appDel.ori == UIInterfaceOrientationLandscapeRight)
				{
					pageControl_ForQuiz.frame = CGRectMake(40+tblQuizQue.frame.size.width,750-40,585,30);
					scrlForQuiz.frame = CGRectMake(40+tblQuizQue.frame.size.width,48,585,750);
					rect.size.width = 585; 
					rect.size.height = 750;
					rect.origin.x = ((scrlForQuiz.frame.size.width - rect.size.width)/2) + cx ;
				}	
				
				rect.origin.y = 0 ;
				tempvctrl.view.frame = rect;
				
				[scrlForQuiz addSubview:tempvctrl.view];
				
				cx += scrlForQuiz.frame.size.width;
			}
			
			
		}
		
		
		self.pageControl.numberOfPages = totNOOfRow;
		[scrlForQuiz setContentSize:CGSizeMake(cx, [scrlForQuiz bounds].size.height)];
		scrlForQuiz.backgroundColor=[UIColor whiteColor];
		[self.view addSubview:scrlForQuiz];
		
		if([arrPersetQue count] > 0)
			[self.view bringSubviewToFront:pageControl_ForQuiz];
	}
	else 
	{
		iphonPageControl.numberOfPages = NumberOfRows;
		
		CGFloat x_pos = 50;
		CGFloat x =20;
		int count=0;
		for(int i =0 ; i< NumberOfRows;i++)
		{
			modVal = 4;
			if(i==0)
			{
				x=20;
			}
			if(i==1)
			{
				x=340;
			}
			if(i==2)
			{
				x=650;
			}
			CGFloat y=20;
			CGFloat Width = 30;
			CGFloat Height = 30;
			
			for(int j=1;j<=16;j++)
			{
				
				UIButton *btnChapter = [UIButton buttonWithType:UIButtonTypeCustom];
				[btnChapter setTag:count];
				[btnChapter setTitle:[NSString stringWithFormat:[NSString stringWithFormat:@"%d",count+1]] forState:UIControlStateNormal];
				
				if(count == 22)
				{
					[btnChapter setTitle:[NSString stringWithFormat:[NSString stringWithFormat:@"%@",@"A"]] forState:UIControlStateNormal];
					
				}
				if(count == 23)
				{
					[btnChapter setTitle:[NSString stringWithFormat:[NSString stringWithFormat:@"%@",@"B"]] forState:UIControlStateNormal];
					
				}
					btnChapter.titleLabel.font = [UIFont fontWithName:@"Cantoria MT Std" size:25];
				[btnChapter setContentEdgeInsets:UIEdgeInsetsMake(10, -3, 0, 0)];
				[btnChapter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
				[btnChapter setBackgroundImage:[UIImage imageNamed:@"Copy of _0054_1-.png"] forState:UIControlStateNormal];
				[btnChapter addTarget:self action:@selector(btnChapterClicked:) forControlEvents:UIControlEventTouchUpInside];
				[btnChapter setFrame : CGRectMake(x, y, 58, 58)];
				[btnScrollView addSubview:btnChapter];
				x += 75;
				count++;
				if(j%modVal == 0 && j>0)
				{
					if(i==0)
					{
						x =20;
						y+= 67;
					}
					if(i==1)
					{
						x=340;
						y+=67;
					}
					
					
				}
				if(j == 16)
				{
					if(i==1)
					{
						x=320;
					}
					
				}
				else 
				{
					//NSLog(@"ld===%i",i);
				}
				
				if( count > 24)
				{
					btnChapter.hidden = TRUE;
				}
			}	
			
		}
		
		btnScrollView.contentSize = CGSizeMake(btnScrollView.frame.size.width * NumberOfRows, btnScrollView.frame.size.height);
	}
	/*if([arrPersetQue count] <= 0)
	 [pageControl_ForQuiz removeFromSuperview];*/
}

-(IBAction)changePage:(id)sender 
{
    NSLog(@"changing page:");
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{

	CGRect frame = scrQuizPage_Result.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
	
    [scrQuizPage_Result scrollRectToVisible:frame animated:YES];
	
	/*
	 *	When the animated scrolling finishings, scrollViewDidEndDecelerating will turn this off
	 */
    pageControlIsChangingPage = YES;
	
	}
	else 
	{
		
				
	}
}


// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl

- (IBAction)changePage_ForQuiz:(id)sender
{
    NSLog(@"page changed");
	CGRect frame = scrlForQuiz.frame;
    frame.origin.x = frame.size.width * pageControl_ForQuiz.currentPage;
    frame.origin.y = 0;
	//selectPage = ;
    [scrlForQuiz scrollRectToVisible:frame animated:YES];
	[selectedindexes addObject:[NSNumber numberWithInt:pageControl_ForQuiz.currentPage]];
	selectedRow = pageControl_ForQuiz.currentPage;
	selectPage = pageControl_ForQuiz.currentPage;
	[tblQuizQue reloadData];
	/*
	 *	When the animated scrolling finishings, scrollViewDidEndDecelerating will turn this off
	 */
    pageControlIsChangingPage = YES;
	
}
#pragma mark UIScrollViewDelegate stuff

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    if (pageControlIsChangingPage) {
        return;
    }
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        NSLog(@"page changed is");
if(_scrollView.tag == 1)
{
	CGFloat pageWidth = _scrollView.frame.size.width;
	selectPage1 = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	self.pageControl.currentPage = selectPage1;
	[self.pageControl updateCurrentPageDisplay];

}
	else {
		CGFloat pageWidth = _scrollView.frame.size.width;
		selectPage = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		
		pageControl_ForQuiz.currentPage = selectPage;
		[pageControl_ForQuiz updateCurrentPageDisplay];
	
			
	}
	}
	else {
		CGFloat pageWidth = _scrollView.frame.size.width;
		selectPage = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		
		iphonPageControl.currentPage = selectPage;
		[iphonPageControl updateCurrentPageDisplay];
	}


	
}
 



- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView 
{
    NSLog(@"page no chanfws %d",selectPage);
    pageControlIsChangingPage = NO;
	if(_scrollView.tag == 2)
	{
		[selectedindexes addObject:[NSNumber numberWithInt:selectPage]];
		selectedRow = selectPage;
		[tblQuizQue reloadData];
	}
}








#pragma mark set Orientation

//jayna16121111.45
-(void)callLandScap
{
	/*firstTime = TRUE;
	oncePort = FALSE;
	[self setFrameOrientation_LandScap];*/
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
	if(interfaceOrientation == UIInterfaceOrientationPortrait ||
	   interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
	{
		modVal = 4;
		[self setFrameOrientation_Portrait];
		return YES;
	}
	else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation== UIInterfaceOrientationLandscapeRight)
	{
		modVal = 6;
		[self setFrameOrientation_LandScap];
		return YES;
	}
	else {
		
		return NO;
	}
	}
	else 
	{
		return NO;
	}
}


-(void)setFrameOrientation_Portrait
{
	oncePort = TRUE;
	firstTime = FALSE;

	mainImage.frame = CGRectMake(34, 0, 654, 1024);
	mainImage.image = [UIImage imageNamed:@"Red_Layer-1.png"];
		
	topImage.image = [UIImage imageNamed:@"_0009_top-red-band.png"];
	topImage.frame = CGRectMake(0, 00, 768, 48);
	
	topLable.frame = CGRectMake(11, -5, 700, 48);
	
	whiteLayer.frame = CGRectMake(0, 38, 768, 38);
	whiteLayer.image = [UIImage imageNamed:@"Layer-76.png"];
	
	labelWhite.frame = CGRectMake(10, 38, 700, 38);
	
	imgFeedBack.frame = CGRectMake(79,390,565,169);
	
	topRedImage.image = [UIImage imageNamed:@"Quiz.png"];
	topRedImage.frame = CGRectMake(34, 0, 654, 48);

	
btnBackTOchapters.frame = CGRectMake(20,0,72, 37);
	viewQuizCh.frame = CGRectMake(0, 0, 768, 1024);
	
	tblQuizQue.frame = CGRectMake(34, 85, 184, 965);
	tblBGImage.frame = CGRectMake(34, 39, 189, 965);
	tblBGImage.image = [UIImage imageNamed:@"_0005_Layer-2.png"];
	//tblQuizQue.hidden = YES;
	
	topLable1.frame = CGRectMake(-21, -5, 768, 48);
	SubmitBtn.frame = CGRectMake(65, 38, 120, 47);
	
	
	tempvctrl.view.frame =CGRectMake(40+tblQuizQue.frame.size.width,48,self.view.frame.size.width - tblQuizQue.frame.size.width,tblQuizQue.frame.size.height);

	lblcorrect.frame = CGRectMake(95, 470, 171, 78);
	lblincorrect.frame = CGRectMake(95+180, 470, 171, 78);
	lblunanswered.frame = CGRectMake(95+180+180, 470, 171, 78);
	
	btnViewfeedback.frame = CGRectMake(270, 600, 186, 58);
	
	lblHeading_result.frame = CGRectMake(30, 0, 660, 75);
	
		//button.frame = CGRectMake(20.0, 0, 72.0, 37.0);
	CGFloat x=81;
	CGFloat y=48+38+17;
	CGFloat Width = 34;
	CGFloat Height = 35;
	
	for(int i=0;i<24;i++)
	{
		
		if(i%modVal == 0 && i>0)
		{
			
			x=81;
			y+=Height+116;
		}
		else {
			//NSLog(@"ld===%i",i);
		}
		[[btnChapterArr objectAtIndex:i]setFrame : CGRectMake(x, y, 117, 116)];
		x+=Width+117;
		[self.view bringSubviewToFront:[btnChapterArr objectAtIndex:i]];
	}
	//button.frame = CGRectMake(20, 2, 72.0, 37.0);
	pageControl.frame = CGRectMake(210, 940, 300, 34);
	pageControl_ForQuiz.frame = CGRectMake(40+tblQuizQue.frame.size.width,945,504,30);

	if(fromViewFeedBack == TRUE)
	{
		[self setupPage_FeedBackPage];
		
		CGRect frame = scrQuizPage_Result.frame;
		frame.origin.x = frame.size.width * selectPage1;
		frame.origin.y = 0;
		[scrQuizPage_Result scrollRectToVisible:frame animated:NO];
	}
	else {
	

	[self setupPage];
	CGRect frame = scrlForQuiz.frame;
    frame.origin.x = frame.size.width * selectPage;
    frame.origin.y = 0;
	[scrlForQuiz scrollRectToVisible:frame animated:NO];
	}

}
-(void)setFrameOrientation_LandScap
{
	
	topRedImage.image = [UIImage imageNamed:@"Quize.png"];
	
	/*
	if(firstTime == TRUE)
	{
		firstTime = FALSE;
		
		btnBackTOchapters.frame = CGRectMake(10,0,72, 37);
		tblQuizQue.frame = CGRectMake(35, 79, 360, 750);
		tblBGImage.frame = CGRectMake(35, 38, 365, 709);
		SubmitBtn.frame = CGRectMake(273, 36, 120, 47);
		topImage.frame = CGRectMake(7, 0, 1004, 48);
		topLable.frame = CGRectMake(20, 0, 940, 48);
		topRedImage.frame = CGRectMake(0, 0, 1004, 48);
		labelWhite.frame = CGRectMake(40, 38, 910, 38);
		//button.frame = CGRectMake(20, 2, 72.0, 37.0);
		//topGrayImageView.frame = CGRectMake(10, 0, 960, 78);
		
		topGrayImageView.frame = CGRectMake(9, 0, 960, 78);
		lblHeading_result.frame = CGRectMake(70, 0, 700, 75);
		whiteLayer.frame = CGRectMake(20, 38, 1004, 38);
		topLable1.frame = CGRectMake(20, -5, 940, 48);
		CGFloat x=55;
		CGFloat y=48+38+40;
		CGFloat Width = 34;
		CGFloat Height = 35;
		
		for(int i=0;i<24;i++)
		{
			
			if(i%modVal == 0 && i>0)
			{
				
				x=55;
				y+=Height+116;
			}
			else {
				//NSLog(@"ld===%i",i);
			}
			UIButton *tmpBtn = (UIButton *)[btnChapterArr objectAtIndex:i];
			[tmpBtn setFrame : CGRectMake(x, y, 117, 116)];
			x+=Width+117;
			//[self.view bringSubviewToFront:[btnChapterArr objectAtIndex:i]];
		}
		
		
		
		
	}
	else {
		
		if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
		   appDel.ori == UIInterfaceOrientationLandscapeRight)
		{
			btnBackTOchapters.frame = CGRectMake(10,0,72, 37);
			tblQuizQue.frame = CGRectMake(35, 79, 360, 750);
			tblBGImage.frame = CGRectMake(35, 38, 365, 709);
			SubmitBtn.frame = CGRectMake(273, 36, 120, 47);
			topImage.frame = CGRectMake(7, 0, 1004, 48);
			topLable.frame = CGRectMake(20, 0, 940, 48);
			topRedImage.frame = CGRectMake(0, 0, 1004, 48);
			labelWhite.frame = CGRectMake(40, 38, 910, 38);
			//button.frame = CGRectMake(20, 2, 72.0, 37.0);
			//topGrayImageView.frame = CGRectMake(10, 0, 960, 78);
			
			topGrayImageView.frame = CGRectMake(9, 0, 960, 78);
			lblHeading_result.frame = CGRectMake(70, 0, 700, 75);
			topLable1.frame = CGRectMake(20, -5, 940, 48);
			CGFloat x=55;
			CGFloat y=48+38+40;
			CGFloat Width = 34;
			CGFloat Height = 35;
			
			for(int i=0;i<24;i++)
			{
				
				if(i%modVal == 0 && i>0)
				{
					
					x=55;
					y+=Height+116;
				}
				else {
					//NSLog(@"ld===%i",i);
				}
				UIButton *tmpBtn = (UIButton *)[btnChapterArr objectAtIndex:i];
				[tmpBtn setFrame : CGRectMake(x, y, 117, 116)];
				x+=Width+117;
			}
			
			
			whiteLayer.frame = CGRectMake(20, 38, 1004, 38);
			
		}
		if(oncePort == TRUE)
		{
			btnBackTOchapters.frame = CGRectMake(10,0,72, 37);
			tblQuizQue.frame = CGRectMake(13, 79, 360, 750);
			tblBGImage.frame = CGRectMake(13, 38, 365, 709);
			SubmitBtn.frame = CGRectMake(253, 36, 120, 47);
			topImage.frame = CGRectMake(-13, 0, 1004, 48);
			topLable.frame = CGRectMake(0, 0, 940, 48);
			topRedImage.frame = CGRectMake(-30, 0, 1004, 48);
			labelWhite.frame = CGRectMake(20, 38, 910, 38);
			topGrayImageView.frame = CGRectMake(-12, 0, 960, 78);
			lblHeading_result.frame = CGRectMake(100, 0, 700, 75);
			topLable1.frame = CGRectMake(0, -5, 940, 48);
			//button.frame = CGRectMake(0, 2, 72.0, 37.0);
			//button.frame = CGRectMake(0.0, 0, 72.0, 37.0);
			CGFloat x=35;
			CGFloat y=48+38+40;
			CGFloat Width = 34;
			CGFloat Height = 35;
			
			for(int i=0;i<24;i++)
			{
				
				if(i%modVal == 0 && i>0)
				{
					
					x=35;
					y+=Height+116;
				}
				else {
					//NSLog(@"ld===%i",i);
				}
				UIButton *tmpBtn = (UIButton *)[btnChapterArr objectAtIndex:i];
				[tmpBtn setFrame : CGRectMake(x, y, 117, 116)];
				x+=Width+117;
			}
			
			
			whiteLayer.frame = CGRectMake(-20, 38, 1004, 38);
		}
		else {
			btnBackTOchapters.frame = CGRectMake(20,0,72, 37);
			tblQuizQue.frame = CGRectMake(35, 79, 360, 750);
			tblBGImage.frame = CGRectMake(35, 38, 365, 709);
			SubmitBtn.frame = CGRectMake(273, 36, 120, 47);
			topImage.frame = CGRectMake(7, 0, 1004, 48);
			topLable.frame = CGRectMake(20, 0, 940, 48);
			topRedImage.frame = CGRectMake(0, 0, 1004, 48);
			labelWhite.frame = CGRectMake(40, 38, 910, 38);
			//button.frame = CGRectMake(20, 2, 72.0, 37.0);
			//	topGrayImageView.frame = CGRectMake(10, 0, 960, 78);
			
			topGrayImageView.frame = CGRectMake(9, 0, 960, 78);
			lblHeading_result.frame = CGRectMake(70, 0, 700, 75);
			topLable1.frame = CGRectMake(20, -5, 940, 48);
			CGFloat x=55;
			CGFloat y=48+38+40;
			CGFloat Width = 34;
			CGFloat Height = 35;
			
			for(int i=0;i<24;i++)
			{
				
				if(i%modVal == 0 && i>0)
				{
					
					x=55;
					y+=Height+116;
				}
				else {
					//NSLog(@"ld===%i",i);
				}
				UIButton *tmpBtn = (UIButton *)[btnChapterArr objectAtIndex:i];
				[tmpBtn setFrame : CGRectMake(x, y, 117, 116)];
				x+=Width+117;
			}
			
			
			whiteLayer.frame = CGRectMake(20, 38, 1004, 38);
		}
		
	}
	*/
	
	btnBackTOchapters.frame = CGRectMake(10,0,72, 37);
	tblQuizQue.frame = CGRectMake(13, 79, 360, 750);
	tblBGImage.frame = CGRectMake(13, 38, 365, 709);
	SubmitBtn.frame = CGRectMake(253, 36, 120, 47);
	topImage.frame = CGRectMake(-13, 0, 1004, 48);
	topLable.frame = CGRectMake(0, 0, 940, 48);
	topRedImage.frame = CGRectMake(-30, 0, 1004, 48);
	labelWhite.frame = CGRectMake(20, 38, 910, 38);
	topGrayImageView.frame = CGRectMake(-12, 0, 960, 78);
	lblHeading_result.frame = CGRectMake(100, 0, 700, 75);
	topLable1.frame = CGRectMake(0, -5, 940, 48);
	//button.frame = CGRectMake(0, 2, 72.0, 37.0);
	//button.frame = CGRectMake(0.0, 0, 72.0, 37.0);
	CGFloat x=35;
	CGFloat y=48+38+40;
	CGFloat Width = 34;
	CGFloat Height = 35;
	
	for(int i=0;i<24;i++)
	{
		
		if(i%modVal == 0 && i>0)
		{
			
			x=35;
			y+=Height+116;
		}
		else {
			//NSLog(@"ld===%i",i);
		}
		UIButton *tmpBtn = (UIButton *)[btnChapterArr objectAtIndex:i];
		[tmpBtn setFrame : CGRectMake(x, y, 117, 116)];
		x+=Width+117;
	}
	
	
	whiteLayer.frame = CGRectMake(-20, 38, 1004, 38);
	
	
	tblBGImage.image = [UIImage imageNamed:@"_0030_Answer-following-questions.-copy.png"];
	
	
	mainImage.frame = CGRectMake(13, 38, 1024, 768);
	mainImage.image = [UIImage imageNamed:@"red-bg.png"];
	
	
	
	topImage.image = [UIImage imageNamed:@"_0006_top-red-band910.png"];
	
	
	
	whiteLayer.image = [UIImage imageNamed:@"Layer-76.png"];
	
	imgFeedBack.frame = CGRectMake(200, 220, 550, 164);
	lblcorrect.frame = CGRectMake(210, 294, 175, 80);
	lblincorrect.frame = CGRectMake(390, 294, 175, 80);
	lblunanswered.frame = CGRectMake(570, 294, 175, 80);
	
	
	viewQuizCh.frame = CGRectMake(0, 0, 1024, 768);
	
	btnViewfeedback.frame = CGRectMake(390, 420, 186, 58);
	
	
	pageControl.frame = CGRectMake(170, 700, 569, 34);
	pageControl_ForQuiz.frame = CGRectMake(40+tblQuizQue.frame.size.width,750-40,585,30);
	
	[SubmitBtn setTitle:@"Answer the following questions: Submit All" forState:UIControlStateNormal];
	
		
	if(fromViewFeedBack == TRUE)
	{
		[self setupPage_FeedBackPage];
		
		CGRect frame = scrQuizPage_Result.frame;
		frame.origin.x = frame.size.width * selectPage1;
		frame.origin.y = 0;
		[scrQuizPage_Result scrollRectToVisible:frame animated:NO];
		
	}
	else {
		
	[self setupPage];
	CGRect frame = scrlForQuiz.frame;
    frame.origin.x = frame.size.width * selectPage;
    frame.origin.y = 0;
	[scrlForQuiz scrollRectToVisible:frame animated:NO];
	}
}

- (void) didRotate:(NSNotification *)notification
{
	

	[tblQuizQue reloadData];
	if(appDel.ori == 0)
		appDel.ori = [[UIDevice currentDevice] orientation];
	
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		modVal = 4;
		
		[self setFrameOrientation_Portrait];
	}
	else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
		appDel.ori == UIInterfaceOrientationLandscapeRight)
	{
		modVal = 6;
		[self setFrameOrientation_LandScap];
	}
	
}
-(IBAction)btnBackPressed:(id)sender
{
	for(int i=0;i<totNOOfRow;i++)
	{
		if([arrPersetQue count] > 0)
		{
		tempvctrl = (UIViewController *)[arrPersetQue objectAtIndex:i];
		
		
			[tempvctrl.view removeFromSuperview];
		}
		
	}

	[tblQuizQue removeFromSuperview];
	[arrPersetQue removeAllObjects];
	[selectedindexes removeAllObjects];
	for(int i=0;i<[[scrQuizPage_Result subviews] count];i++)
	{
		[[[scrQuizPage_Result subviews] objectAtIndex:i] removeFromSuperview];
	}
	for(int i=0;i<[[scrlForQuiz subviews] count];i++)
	{
		[[[scrlForQuiz subviews] objectAtIndex:i] removeFromSuperview];
	}
	
	[appDel.arr_emailImages_Quiz removeAllObjects];	
	scrQuizPage_Result.hidden = YES;
	[scrlForQuiz removeFromSuperview];
	[scrlForQuiz release];
	scrlForQuiz = nil;
	[feedBackView removeFromSuperview];
	selectPage = 0;
	selectPage1 = 0;
	pageControl.currentPage = 0;
	pageControl_ForQuiz.currentPage = 0;
	pageControl.hidden = TRUE;
	pageControl_ForQuiz.hidden = TRUE;
	[scrlForQuiz setContentOffset:CGPointMake(0,0)];
	fromViewFeedBack = FALSE;
	[self.view addSubview:viewQuizCh];
		
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
	
	[pageControl release];
	[viewQuizCh release];
	[tblQuizQue release];
	[viewControllers release];
    [super dealloc];
}


@end
