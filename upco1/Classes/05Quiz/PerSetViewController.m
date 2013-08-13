//
//  PerSetViewController.m
//  DeansQuestionBank
//
//  Created by Alpesh Harsoda on 31/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PerSetViewController.h"
#import "QuizViewController.h"
#import "DAL.h"
@implementation PerSetViewController


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil _dictQue:(NSDictionary *)dictQue _queNo:(int)queNo {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
		DictQue_perset = [[NSDictionary alloc] initWithDictionary:dictQue];
		queNo1 = queNo;
        
		
		
		
    }
    return self;
}


#pragma mark Set Height Of Labels
- (float)calculateHeightOfTextFromWidth:(NSString*)text width:(float)_width _size:(float)size
{
	[text retain];
	
	CGSize suggestedSize = [text sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:CGSizeMake(_width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap];
	
	[text release];
	
	
	return suggestedSize.height;
}
-(IBAction)btnSubmitClicked:(id)sender
{
	
	
	int correct=0;
	int incorrect=0;
	int unanswered=0;
	
	NSString *strQuery ;
	if(appDel.chNo==23)
	{
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%@'",@"APPENDIX A"];
	}
	else if(appDel.chNo ==24)
	{
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%@'",@"APPENDIX B"];
	}
	else
	{
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%d'",appDel.chNo];
	}

	
	
	
	NSDictionary *Dict_queset = [DAL ExecuteDataSet:strQuery];
	
	for(int i=0;i<[Dict_queset count];i++)
	{
		NSString *key = [NSString stringWithFormat:@"Table%d",i+1];
		//NSLog(@"%@",[[Dict_queset objectForKey:key] objectForKey:@"Answer"]);
		NSLog(@"%@",[[Dict_queset objectForKey:key] objectForKey:@"Answer"]);
		
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
	NSLog(@"correct==%d  incorrect==%d  unanswers==%d",correct,incorrect,unanswered);
	
	appDel.correct = correct;
	appDel.incorrect = incorrect;
	appDel.unanswered = unanswered;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:@"FeedBackViewAdd" object:nil];
	}
	else {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"FeedBackViewAdd_iPhone" object:nil];
	}


	
}
-(IBAction)btnoptSelect:(id)sender
{
	NSString *strQuery ;
	if(appDel.chNo==23)
	{
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%@'",@"APPENDIX A"];
	}
	else if(appDel.chNo ==24)
	{
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%@'",@"APPENDIX B"];
	}
	else
	{
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%d'",appDel.chNo];
	}

	
	//NSString *strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%d'",appDel.chNo];
	NSDictionary *Dict_queset = [DAL ExecuteDataSet:strQuery];
	
	if(queNo1 == [Dict_queset count]-1)
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:@"FeedBackViewAdd_submitALL" object:nil];
		//btnSubmit.hidden = FALSE;
	}
	
	
		if([sender tag] == 0)
		{
			//lblOp1.backgroundColor = [UIColor colorWithRed:0.6118 green:0.6118 blue:0.6118 alpha:1];
			lblopt2.backgroundColor = [UIColor clearColor];
			lblopt3.backgroundColor = [UIColor clearColor];
			lblopt4.backgroundColor = [UIColor clearColor];
			lblopt5.backgroundColor = [UIColor clearColor];
			
			if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			{
				[btn1 setImage:[UIImage imageNamed:@"_0020_Layer-4.png"] forState:UIControlStateNormal];
				[btn2 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
				[btn3 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
				[btn4 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
				[btn5 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
			}
			else 
			{
				[btn1 setImage:[UIImage imageNamed:@"answerradiosel_iPhone.png"] forState:UIControlStateNormal];
				[btn2 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				[btn3 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				[btn4 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				[btn5 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				
			}

		}
		if([sender tag] == 1)
		{
			//lblopt2.backgroundColor = [UIColor colorWithRed:0.6118 green:0.6118 blue:0.6118 alpha:1];
			lblOp1.backgroundColor = [UIColor clearColor];
			lblopt3.backgroundColor = [UIColor clearColor];
			lblopt4.backgroundColor = [UIColor clearColor];
			lblopt5.backgroundColor = [UIColor clearColor];
			if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			{
				
				[btn1 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
				[btn2 setImage:[UIImage imageNamed:@"_0020_Layer-4.png"] forState:UIControlStateNormal];
				[btn3 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
				[btn4 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
				[btn5 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
			}
			else 
			{
				[btn1 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				[btn2 setImage:[UIImage imageNamed:@"answerradiosel_iPhone.png"] forState:UIControlStateNormal];
				[btn3 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				[btn4 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				[btn5 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				
			}
		}
		if([sender tag] == 2)
		{
			//lblopt3.backgroundColor = [UIColor colorWithRed:0.6118 green:0.6118 blue:0.6118 alpha:1];
			lblOp1.backgroundColor = [UIColor clearColor];
			lblopt2.backgroundColor = [UIColor clearColor];
			lblopt4.backgroundColor = [UIColor clearColor];
			lblopt5.backgroundColor = [UIColor clearColor];
			if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			{

				[btn1 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
				[btn2 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
				[btn3 setImage:[UIImage imageNamed:@"_0020_Layer-4.png"] forState:UIControlStateNormal];
				[btn4 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
				[btn5 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
			}
			else 
			{
				[btn1 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				[btn2 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				[btn3 setImage:[UIImage imageNamed:@"answerradiosel_iPhone.png"] forState:UIControlStateNormal];
				[btn4 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				[btn5 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				
			}
		}
		if([sender tag] == 3)
		{
			//lblopt4.backgroundColor = [UIColor colorWithRed:0.6118 green:0.6118 blue:0.6118 alpha:1];
			lblOp1.backgroundColor = [UIColor clearColor];
			lblopt2.backgroundColor = [UIColor clearColor];
			lblopt3.backgroundColor = [UIColor clearColor];
			lblopt5.backgroundColor = [UIColor clearColor];
			if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			{
				
			
			[btn1 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
			[btn2 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
			[btn3 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
			[btn4 setImage:[UIImage imageNamed:@"_0020_Layer-4.png"] forState:UIControlStateNormal];
			[btn5 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
			}
			else 
			{
				[btn1 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				[btn2 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				[btn3 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				[btn4 setImage:[UIImage imageNamed:@"answerradiosel_iPhone.png"] forState:UIControlStateNormal];
				[btn5 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				
			}
			
		}
		if([sender tag] == 4)
		{
			//lblopt5.backgroundColor = [UIColor colorWithRed:0.6118 green:0.6118 blue:0.6118 alpha:1];
			lblOp1.backgroundColor = [UIColor clearColor];
			lblopt2.backgroundColor = [UIColor clearColor];
			lblopt3.backgroundColor = [UIColor clearColor];
			lblopt4.backgroundColor = [UIColor clearColor];
			if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			{
				
				
			[btn1 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
			[btn2 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
			[btn3 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
			[btn4 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
			[btn5 setImage:[UIImage imageNamed:@"_0020_Layer-4.png"] forState:UIControlStateNormal];
			}
			else 
			{
				[btn1 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				[btn2 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				[btn3 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				[btn4 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
				[btn5 setImage:[UIImage imageNamed:@"answerradiosel_iPhone.png"] forState:UIControlStateNormal];
				
			}
			
		}
	
	
	

	NSLog(@"");
	NSString *opt;
	NSString *ans;
	if([sender tag] == 0)
	{
		opt = @"A";
		ans = [[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option1"];
	}
	else if([sender tag] == 1)
	{
		opt = @"B";
		ans = [[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option2"];
	}
	else if([sender tag] == 2)
	{
		opt = @"C";
		ans = [[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option3"];
	}
	else if([sender tag] == 3)
	{	
		opt = @"D";
		ans = [[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option4"];
	}
	else
	{	
		opt = @"E";
		ans = [[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option5"];
	}
	NSDictionary *dictOpt = [NSDictionary dictionaryWithObjectsAndKeys:[[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Question"],@"Question",opt,@"AnsOption",
							 ans,@"Answer",nil];
	
	//dictAns = [NSDictionary dictionaryWithObjectsAndKeys:dictOpt,[[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Question"], nil];
	
	[appDel.ansSetarr replaceObjectAtIndex:queNo1 withObject:dictOpt];
	
}

// Load the view nib and initialize the pageNumber ivar.
- (id)initWithPageNumber:(int)page {
    NSLog(@"page no:%d",page);
    if (self = [super initWithNibName:@"PerSetViewController" bundle:nil]) {
       // PageNumber = page;
    }
	
    return self;
}
- (id)initWithPageNumber:(int)page questions:(NSString *)Question queNo:(NSString *)QNo options:(NSArray *)optionForQue correct:(NSString *)correct_ans btn:(UIButton *)btnHandIn
{
    
	if (self = [super initWithNibName:@"PerSetViewController" bundle:nil]) {
       // PageNumber = page;
		//btnHandIN_Page = btnHandIn;
    }
	
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	NSString *strQuery ;
	if(appDel.chNo==23)
	{
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%@'",@"APPENDIX A"];
	}
	else if(appDel.chNo ==24)
	{
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%@'",@"APPENDIX B"];
	}
	else
	{
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%d'",appDel.chNo];
	}
	
	
	Dict_queset = [DAL ExecuteDataSet:strQuery];
	if(queNo1 == [Dict_queset count]-1)
	{
		//[[NSNotificationCenter defaultCenter] postNotificationName:@"FeedBackViewAdd_submitALL" object:nil];
		btnSubmit.hidden = FALSE;
	}
	else
	{
		
		btnSubmit.hidden = TRUE;
	}
	
	
	//float height = [self calculateHeightOfTextFromWidth:[[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Question"] width:400 _size:20];
	
	//lblQue.frame = CGRectMake(27, 44, 435, height);
	
	
	
	lblQue.text = [[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Question"];
	lblOp1.text= [[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option1"];
	lblopt2.text= [[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option2"];
	lblopt3.text= [[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option3"];
	lblopt4.text= [[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option4"];
	lblopt5.text= [[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option5"];
	
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        int x=0;
        int sizey=0;
	//NSString *strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%d'",appDel.chNo];

	//Question
        lblQNO_iPhone.hidden = YES;
	lblQue.frame = CGRectMake(lblQue.frame.origin.x, lblQue.frame.origin.y , 380, 30);
	CGSize maximumLabelSize1 = CGSizeMake(380,9999);
	
	CGSize expectedLabelSize1 = [lblQue.text sizeWithFont:lblQue.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblQue.lineBreakMode];
	
	CGRect newFrame1 = lblQue.frame;
	newFrame1.size.height = expectedLabelSize1.height;
	lblQue.frame = newFrame1;
	
	//opt1
	int y = newFrame1.size.height+44+x;
	maximumLabelSize1 = CGSizeMake(250,9999);
	
	expectedLabelSize1 = [lblOp1.text sizeWithFont:lblOp1.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblOp1.lineBreakMode];
	
	newFrame1 = lblOp1.frame;
	newFrame1.size.height = expectedLabelSize1.height;
	
	
//	height = [self calculateHeightOfTextFromWidth:[[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option1"] width:380 _size:15];
	lblOp1.frame = CGRectMake(70, y, lblOp1.frame.size.width, newFrame1.size.height +x);
	btn1.frame = CGRectMake(37, y-2+sizey, 24, 27);
        NSLog(@"%@",lblOp1.text);
	
	//opt2
	y += newFrame1.size.height + 13 + x;
	maximumLabelSize1 = CGSizeMake(250,9999);
	
	expectedLabelSize1 = [lblopt2.text sizeWithFont:lblopt2.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblopt2.lineBreakMode];
	
	newFrame1 = lblopt2.frame;
	newFrame1.size.height = expectedLabelSize1.height;
	
	
	//height = [self calculateHeightOfTextFromWidth:[[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option2"] width:380 _size:15];
	lblopt2.frame = CGRectMake(70, y, lblopt2.frame.size.width, newFrame1.size.height+x);
	btn2.frame = CGRectMake(37, y-2+sizey, 24, 27);
	
	
	//opt3
	y += newFrame1.size.height + 13;
	maximumLabelSize1 = CGSizeMake(250,9999);
        NSString *tempopt3=lblopt3.text;
        NSLog(@"#%@#",tempopt3);
      tempopt3=  [tempopt3 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        lblopt3.text=tempopt3;
	expectedLabelSize1 = [lblopt3.text sizeWithFont:lblopt3.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblopt3.lineBreakMode];
	
	newFrame1 = lblopt3.frame;
	newFrame1.size.height = expectedLabelSize1.height;
	
	//height = [self calculateHeightOfTextFromWidth:[[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option3"] width:380 _size:15];
	lblopt3.frame = CGRectMake(70, y, lblopt3.frame.size.width, newFrame1.size.height+x);
	btn3.frame = CGRectMake(37, y-2+sizey, 24, 27);
	
	//opt4
	y += newFrame1.size.height + 13+x;
	maximumLabelSize1 = CGSizeMake(250,9999);
	
	expectedLabelSize1 = [lblopt4.text sizeWithFont:lblopt4.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblopt4.lineBreakMode];
	
	newFrame1 = lblopt4.frame;
	newFrame1.size.height = expectedLabelSize1.height;
	
	//height = [self calculateHeightOfTextFromWidth:[[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option4"] width:380 _size:15];
	lblopt4.frame = CGRectMake(70, y, lblopt4.frame.size.width, newFrame1.size.height+x);
	btn4.frame = CGRectMake(37, y-2+sizey, 24, 27);
	
	//opt5
	y += newFrame1.size.height + 13+x;
	maximumLabelSize1 = CGSizeMake(250,9999);
	
	expectedLabelSize1 = [lblopt5.text sizeWithFont:lblopt5.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblopt5.lineBreakMode];
	
	newFrame1 = lblopt5.frame;
	newFrame1.size.height = expectedLabelSize1.height+x;
	
	//height = [self calculateHeightOfTextFromWidth:[[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option5"] width:380 _size:15];	
	lblopt5.frame = CGRectMake(70, y, lblopt5.frame.size.width, newFrame1.size.height);
	btn5.frame = CGRectMake(37, y-2+sizey, 24, 27);
	
	
	btnSubmit.frame = CGRectMake(156, y+44+sizey+50, 137, 52);

	//NSLog(@"val%@",[[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Question"]);
		
	}
	else 
	{
		
		//lblQNO_iPhone.textAlignment = UITextAlignmentCenter;
		[btn1 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
		[btn2 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
		[btn3 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
		[btn4 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
		[btn5 setImage:[UIImage imageNamed:@"answerradio_iPhone.png"] forState:UIControlStateNormal];
			

		
		lblQNO_iPhone.frame = CGRectMake(30, 18, 38, 30);
		
		lblQNO_iPhone.font = [UIFont boldSystemFontOfSize:14.0];
		lblQue.font = [UIFont boldSystemFontOfSize:14.0];
		lblOp1.font = [UIFont systemFontOfSize:14.0];
		lblopt2.font = [UIFont systemFontOfSize:14.0];
		lblopt3.font = [UIFont systemFontOfSize:14.0];
		lblopt4.font = [UIFont systemFontOfSize:14.0];
		lblopt5.font = [UIFont systemFontOfSize:14.0];
		
		lblOp1.frame = CGRectMake(lblOp1.frame.origin.x, lblOp1.frame.origin.y, 230, 0);
		lblopt2.frame = CGRectMake(lblopt2.frame.origin.x, lblopt2.frame.origin.y, 230, 0);
		lblopt3.frame = CGRectMake(lblopt3.frame.origin.x, lblopt3.frame.origin.y, 230, 0);
		lblopt4.frame = CGRectMake(lblopt4.frame.origin.x, lblopt4.frame.origin.y, 230, 0);
		lblopt5.frame = CGRectMake(lblopt5.frame.origin.x, lblopt5.frame.origin.y, 230, 0);
		
        lblQNO_iPhone.hidden = NO;
        lblQNO_iPhone.text = [NSString stringWithFormat:@"Q%d.",queNo1+1];
		UIScrollView *scrlVert_Questions = [[UIScrollView alloc]initWithFrame:CGRectMake(5,0,320,322)];
        
        
		lblQue.frame = CGRectMake(lblQNO_iPhone.frame.origin.x+33, lblQue.frame.origin.y-10 , 230, 30);
		CGSize maximumLabelSize1 = CGSizeMake(230,9999);
		
		CGSize expectedLabelSize1 = [lblQue.text sizeWithFont:lblQue.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblQue.lineBreakMode];
		
		CGRect newFrame1 = lblQue.frame;
		newFrame1.size.height = expectedLabelSize1.height;
		lblQue.frame = newFrame1;
		
		//opt1
		int y = newFrame1.size.height+44;
		maximumLabelSize1 = CGSizeMake(230,9999);
		
		expectedLabelSize1 = [lblOp1.text sizeWithFont:lblOp1.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblOp1.lineBreakMode];
		
		newFrame1 = lblOp1.frame;
		newFrame1.size.height = expectedLabelSize1.height;
		
		
		//	height = [self calculateHeightOfTextFromWidth:[[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option1"] width:380 _size:15];
		lblOp1.frame = CGRectMake(64, y, lblOp1.frame.size.width, newFrame1.size.height);
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			btn1.frame = CGRectMake(30, y-2, 24, 27);
		}
		else {
			btn1.frame = CGRectMake(30, y+1, 20, 20);
		}
		
		
		
		
		//opt2
		y += newFrame1.size.height + 13;
		maximumLabelSize1 = CGSizeMake(230,9999);
		
		expectedLabelSize1 = [lblopt2.text sizeWithFont:lblopt2.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblopt2.lineBreakMode];
		
		newFrame1 = lblopt2.frame;
		newFrame1.size.height = expectedLabelSize1.height;
		
		
		//height = [self calculateHeightOfTextFromWidth:[[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option2"] width:380 _size:15];
		lblopt2.frame = CGRectMake(64, y, lblopt2.frame.size.width, newFrame1.size.height);
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			btn2.frame = CGRectMake(30, y-2, 24, 27);
		}
		else {
			btn2.frame = CGRectMake(30, y+1, 20, 20);
		}
		
		
		
		//opt3
		y += newFrame1.size.height + 13;
		maximumLabelSize1 = CGSizeMake(230,9999);
		
		expectedLabelSize1 = [lblopt3.text sizeWithFont:lblopt3.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblopt3.lineBreakMode];
		
		newFrame1 = lblopt3.frame;
		newFrame1.size.height = expectedLabelSize1.height;
		
		//height = [self calculateHeightOfTextFromWidth:[[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option3"] width:380 _size:15];
		lblopt3.frame = CGRectMake(64, y, lblopt3.frame.size.width, newFrame1.size.height);
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			btn3.frame = CGRectMake(30, y-2, 24, 27);
		}
		else {
			btn3.frame = CGRectMake(30, y+1, 20, 20);
		}
		
		
		
		//opt4
		y += newFrame1.size.height + 13;
		maximumLabelSize1 = CGSizeMake(230,9999);
		
		expectedLabelSize1 = [lblopt4.text sizeWithFont:lblopt4.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblopt4.lineBreakMode];
		
		newFrame1 = lblopt4.frame;
		newFrame1.size.height = expectedLabelSize1.height;
		
		//height = [self calculateHeightOfTextFromWidth:[[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option4"] width:380 _size:15];
		lblopt4.frame = CGRectMake(64, y, lblopt4.frame.size.width, newFrame1.size.height);
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			btn4.frame = CGRectMake(30, y-2, 24, 27);
		}
		else {
			btn4.frame = CGRectMake(30, y+1, 20, 20);
		}
		
		
		//opt5
		y += newFrame1.size.height + 13;
		maximumLabelSize1 = CGSizeMake(230,9999);
		
		expectedLabelSize1 = [lblopt5.text sizeWithFont:lblopt5.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblopt5.lineBreakMode];
		
		newFrame1 = lblopt5.frame;
		newFrame1.size.height = expectedLabelSize1.height;
		
		//height = [self calculateHeightOfTextFromWidth:[[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option5"] width:380 _size:15];	
		lblopt5.frame = CGRectMake(64, y, lblopt5.frame.size.width, newFrame1.size.height);
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			btn5.frame = CGRectMake(30, y-2, 24, 27);
		}
		else {
			btn5.frame = CGRectMake(30, y+1, 20, 20);
		}
		
		
		
		y= lblopt5.frame.origin.y+lblopt5.frame.size.height+10;
		btnSubmit.frame = CGRectMake((320-149)/2, y, 149, 68);
		
		y=btnSubmit.frame.origin.y+btnSubmit.frame.size.height;
		
		[btnSubmit setImage:[UIImage imageNamed:@"btnsubmit_iPhone.png"] forState:UIControlStateNormal];
		
		[btnSubmit setImage:[UIImage imageNamed:@"btnsubmitclicked_iPhone.png"] forState:UIControlStateHighlighted];
		
		
		//[btnSubmit setBackgroundImage:[UIImage imageNamed:@"btnsubmit_iPhone.png"] forState:UIControlStateNormal];
		
        [scrlVert_Questions addSubview:lblQNO_iPhone];
		[scrlVert_Questions addSubview:lblQue];
		[scrlVert_Questions addSubview:lblOp1];
		[scrlVert_Questions addSubview:lblopt2];
		[scrlVert_Questions addSubview:lblopt3];
		[scrlVert_Questions addSubview:lblopt4];
		[scrlVert_Questions addSubview:lblopt5];
		
		[scrlVert_Questions addSubview:btn1];
		[scrlVert_Questions addSubview:btn2];
		[scrlVert_Questions addSubview:btn3];
		[scrlVert_Questions addSubview:btn4];
		[scrlVert_Questions addSubview:btn5];
		
		[scrlVert_Questions addSubview:btnSubmit];
		scrlVert_Questions.contentSize = CGSizeMake(0,y+100);
		[self.view addSubview:scrlVert_Questions];
	}
	    
	

	
}

/*-(void)setupFrames
{
	
	lblQuestion.frame = CGRectMake(10, 10, 300, 30);
	lblQuestion.numberOfLines = 0;
	lblQuestion.lineBreakMode = UILineBreakModeWordWrap;
	CGSize maximumLabelSize1 = CGSizeMake(300,9999);
	CGSize expectedLabelSize1 = [lblQuestion.text sizeWithFont:lblQuestion.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblQuestion.lineBreakMode];
	CGRect newFrame1 = lblQuestion.frame;
	newFrame1.size.height = expectedLabelSize1.height;
	lblQuestion.frame = newFrame1;
	
	//opt1
	int y = newFrame1.size.height+44+20;
		lblOption1.frame = CGRectMake(10, 10, 300, 30);
	lblOption1.numberOfLines=0;
	lblOption1.lineBreakMode = UILineBreakModeWordWrap;
	maximumLabelSize1 = CGSizeMake(300,9999);
	expectedLabelSize1 = [lblOption1.text sizeWithFont:lblOption1.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblOption1.lineBreakMode];
	newFrame1 = lblOption1.frame;
	newFrame1.size.height = expectedLabelSize1.height;

	lblOption1.frame = CGRectMake(70, y, lblOption1.frame.size.width, newFrame1.size.height);
	
	UIButton *btnOption1 = [UIButton buttonWithType:UIButtonTypeCustom];
	[btnOption1 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
	btnOption1.frame = CGRectMake(37, y-2, 24, 27);
	
	
	//opt2
	y += newFrame1.size.height + 13;
	
	lblOption2.frame = CGRectMake(10, 10, 300, 30);
	lblOption2.numberOfLines=0;
	lblOption2.lineBreakMode = UILineBreakModeWordWrap;
	maximumLabelSize1 = CGSizeMake(250,9999);
	expectedLabelSize1 = [lblOption2.text sizeWithFont:lblOption2.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblOption2.lineBreakMode];
	newFrame1 = lblOption2.frame;
	newFrame1.size.height = expectedLabelSize1.height;
	lblOption2.frame = CGRectMake(70, y, lblOption2.frame.size.width, newFrame1.size.height);
	
	
	UIButton *btnOption2 = [UIButton buttonWithType:UIButtonTypeCustom];
	[btnOption2 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
	btnOption2.frame = CGRectMake(37, y-2, 24, 27);
	
	[QueView.view  addSubview:lblQuestion];
	[QueView.view addSubview:btnOption1];
	[QueView.view addSubview:lblOption1];
	[QueView.view addSubview:btnOption2];
	//opt3
	
	/*
	y += newFrame1.size.height + 13;
	maximumLabelSize1 = CGSizeMake(250,9999);
	
	expectedLabelSize1 = [lblopt3.text sizeWithFont:lblopt3.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblopt3.lineBreakMode];
	
	newFrame1 = lblopt3.frame;
	newFrame1.size.height = expectedLabelSize1.height;
	
	//height = [self calculateHeightOfTextFromWidth:[[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option3"] width:380 _size:15];
	lblopt3.frame = CGRectMake(70, y, lblopt3.frame.size.width, newFrame1.size.height);
	btn3.frame = CGRectMake(37, y-2, 24, 27);
	
	//opt4
	y += newFrame1.size.height + 13;
	maximumLabelSize1 = CGSizeMake(250,9999);
	
	expectedLabelSize1 = [lblopt4.text sizeWithFont:lblopt4.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblopt4.lineBreakMode];
	
	newFrame1 = lblopt4.frame;
	newFrame1.size.height = expectedLabelSize1.height;
	
	//height = [self calculateHeightOfTextFromWidth:[[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option4"] width:380 _size:15];
	lblopt4.frame = CGRectMake(70, y, lblopt4.frame.size.width, newFrame1.size.height);
	btn4.frame = CGRectMake(37, y-2, 24, 27);
	
	//opt5
	y += newFrame1.size.height + 13;
	maximumLabelSize1 = CGSizeMake(380,9999);
	
	expectedLabelSize1 = [lblopt5.text sizeWithFont:lblopt5.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblopt5.lineBreakMode];
	
	newFrame1 = lblopt5.frame;
	newFrame1.size.height = expectedLabelSize1.height;
	
	//height = [self calculateHeightOfTextFromWidth:[[DictQue_perset objectForKey:@"Table1"] objectForKey:@"Option5"] width:380 _size:15];	
	lblopt5.frame = CGRectMake(70, y, lblopt5.frame.size.width, newFrame1.size.height);
	btn5.frame = CGRectMake(37, y-2, 24, 27);
	
	*/
	
//}

/*- (IBAction)setupPage  
{
	pageControl.numberOfPages = 10;
	int y_pos = 0;
	
	for(int i =0 ; i<10;i++)
	{
		int y=0;
		
		QueView = [[UIViewController alloc]init];
		
		que_scroll = [[[UIScrollView alloc]init]autorelease];
		que_scroll.frame = CGRectMake(0, 0, 320, 370);
		
		lblQuestion = [[[UILabel alloc]init]autorelease];
		lblQuestion.text = [[pageHistory objectAtIndex:i]valueForKey:@"Question"];
		lblQuestion.numberOfLines = 0;
		lblQuestion.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
		lblQuestion.lineBreakMode = UILineBreakModeWordWrap;
		lblQuestion.frame = CGRectMake(10, 10, 300, 30);
		lblQuestion.backgroundColor = [UIColor clearColor];
		if([lblQuestion.text length]>0)
		{
		CGSize maximumLabelSize1 = CGSizeMake(300,9999);
		CGSize expectedLabelSize1 = [lblQuestion.text sizeWithFont:lblQuestion.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblQuestion.lineBreakMode];
		CGRect newFrame1 = lblQuestion.frame;
		newFrame1.size.height = expectedLabelSize1.height;
		lblQuestion.frame = newFrame1;
		}
		
		y = lblQuestion.frame.origin.y + lblQuestion.frame.size.height + 20;
		
		btnOption1= [UIButton buttonWithType:UIButtonTypeCustom];
		[btnOption1 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
		[btnOption1 addTarget:self action:@selector(btnoptSelect:) forControlEvents:UIControlEventTouchUpInside];
		btnOption1.tag = 0;
		btnOption1.frame = CGRectMake(10, y-2, 24, 27);
		
		lblOption1 = [[[UILabel alloc]init]autorelease];
		lblOption1.text = [[pageHistory objectAtIndex:i]valueForKey:@"Option1"];
		lblOption1.numberOfLines = 0;
		lblOption1.lineBreakMode = UILineBreakModeWordWrap;
		lblOption1.frame = CGRectMake(40, y, 250, 30);
		lblOption1.backgroundColor = [UIColor clearColor];
		if([lblOption1.text length]>0)
		{
		CGSize maximumLabelSize1 = CGSizeMake(250,9999);
		CGSize expectedLabelSize1 = [lblOption1.text sizeWithFont:lblOption1.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblOption1.lineBreakMode];
		CGRect newFrame1 = lblOption1.frame;
		newFrame1.size.height = expectedLabelSize1.height;
		lblOption1.frame = newFrame1;
		}
		
		y = lblOption1.frame.origin.y + lblOption1.frame.size.height + 10;
		btnOption2 = [UIButton buttonWithType:UIButtonTypeCustom];
		[btnOption2 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
		[btnOption2 addTarget:self action:@selector(btnoptSelect:) forControlEvents:UIControlEventTouchUpInside];
		btnOption2.tag = 1;
		btnOption2.frame = CGRectMake(10, y-2, 24, 27);
		
		lblOption2 = [[[UILabel alloc]init]autorelease];
		lblOption2.text = [[pageHistory objectAtIndex:i]valueForKey:@"Option2"];
		lblOption2.numberOfLines = 0;
		lblOption2.lineBreakMode = UILineBreakModeWordWrap;
		lblOption2.frame = CGRectMake(40, y, 250, 30);
		lblOption2.backgroundColor = [UIColor clearColor];
		if([lblOption2.text length]>0)
		{
			CGSize maximumLabelSize1 = CGSizeMake(250,9999);
			CGSize expectedLabelSize1 = [lblOption2.text sizeWithFont:lblOption2.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblOption2.lineBreakMode];
			CGRect newFrame1 = lblOption2.frame;
			newFrame1.size.height = expectedLabelSize1.height;
			lblOption2.frame = newFrame1;
		}
		
		y = lblOption2.frame.origin.y + lblOption2.frame.size.height + 10;
		btnOption3 = [UIButton buttonWithType:UIButtonTypeCustom];
		[btnOption3 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
		[btnOption3 addTarget:self action:@selector(btnoptSelect:) forControlEvents:UIControlEventTouchUpInside];
		btnOption3.tag = 2;
		btnOption3.frame = CGRectMake(10, y-2, 24, 27);
		
		lblOption3 = [[[UILabel alloc]init]autorelease];
		lblOption3.text = [[pageHistory objectAtIndex:i]valueForKey:@"Option3"];
		lblOption3.numberOfLines = 0;
		lblOption3.lineBreakMode = UILineBreakModeWordWrap;
		lblOption3.frame = CGRectMake(40, y, 250, 30);
		lblOption3.backgroundColor = [UIColor clearColor];
		if([lblOption3.text length]>0)
		{
			CGSize maximumLabelSize1 = CGSizeMake(250,9999);
			CGSize expectedLabelSize1 = [lblOption3.text sizeWithFont:lblOption3.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblOption3.lineBreakMode];
			CGRect newFrame1 = lblOption3.frame;
			newFrame1.size.height = expectedLabelSize1.height;
			lblOption3.frame = newFrame1;
		}
		
		y = lblOption3.frame.origin.y + lblOption3.frame.size.height + 10;
		btnOption4 = [UIButton buttonWithType:UIButtonTypeCustom];
		[btnOption4 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
		[btnOption4 addTarget:self action:@selector(btnoptSelect:) forControlEvents:UIControlEventTouchUpInside];
		btnOption4.tag = 3;
		btnOption4.frame = CGRectMake(10, y-2, 24, 27);
		
		lblOption4 = [[[UILabel alloc]init]autorelease];
		lblOption4.text = [[pageHistory objectAtIndex:i]valueForKey:@"Option4"];
		lblOption4.numberOfLines = 0;
		lblOption4.lineBreakMode = UILineBreakModeWordWrap;
		lblOption4.frame = CGRectMake(40, y, 250, 30);
		lblOption4.backgroundColor = [UIColor clearColor];
		if([lblOption4.text length]>0)
		{
			CGSize maximumLabelSize1 = CGSizeMake(250,9999);
			CGSize expectedLabelSize1 = [lblOption4.text sizeWithFont:lblOption4.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblOption4.lineBreakMode];
			CGRect newFrame1 = lblOption4.frame;
			newFrame1.size.height = expectedLabelSize1.height;
			lblOption4.frame = newFrame1;
		}
		
		y = lblOption4.frame.origin.y + lblOption4.frame.size.height + 10;
		btnOption5 = [UIButton buttonWithType:UIButtonTypeCustom];
		[btnOption5 setImage:[UIImage imageNamed:@"_0023_radio-btn-base-copy.png"] forState:UIControlStateNormal];
		[btnOption5 addTarget:self action:@selector(btnoptSelect:) forControlEvents:UIControlEventTouchUpInside];
		btnOption5.tag = 4;
		btnOption5.frame = CGRectMake(10, y-2, 24, 27);
		
		lblOption5 = [[[UILabel alloc]init]autorelease];
		lblOption5.text = [[pageHistory objectAtIndex:i]valueForKey:@"Option4"];
		lblOption5.numberOfLines = 0;
		lblOption5.lineBreakMode = UILineBreakModeWordWrap;
		lblOption5.frame = CGRectMake(40, y, 250, 30);
		lblOption5.backgroundColor = [UIColor clearColor];
		if([lblOption5.text length]>0)
		{
			CGSize maximumLabelSize1 = CGSizeMake(250,9999);
			CGSize expectedLabelSize1 = [lblOption5.text sizeWithFont:lblOption5.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblOption5.lineBreakMode];
			CGRect newFrame1 = lblOption5.frame;
			newFrame1.size.height = expectedLabelSize1.height;
			lblOption5.frame = newFrame1;
		}
			
		y = lblOption5.frame.origin.y + lblOption5.frame.size.height + 10;
		
		if(i==9)
		{
		UIButton *btnsubmit = [UIButton buttonWithType:UIButtonTypeCustom];
		[btnsubmit setImage:[UIImage imageNamed:@"_0019_Normal-State.png"] forState:UIControlStateNormal];
		btnsubmit.frame = CGRectMake((320-100)/2, y+10, 100, 35);
			[btnsubmit addTarget:self action:@selector(btnSubmitClicked_iPhone:) forControlEvents:UIControlEventTouchUpInside];
		[que_scroll addSubview:btnsubmit];
			
			y = btnsubmit.frame.origin.y + btnsubmit.frame.size.height + 10;
		}
		
		
		
		[que_scroll addSubview:lblQuestion];
		[que_scroll addSubview:btnOption1];
		[que_scroll addSubview:lblOption1];
		[que_scroll addSubview:btnOption2];
		[que_scroll addSubview:lblOption2];
		[que_scroll addSubview:btnOption3];
		[que_scroll addSubview:lblOption3];
		[que_scroll addSubview:btnOption4];
		[que_scroll addSubview:lblOption4];
		[que_scroll addSubview:btnOption5];
		[que_scroll addSubview:lblOption5];
		/*
		[QueView addSubview:lblOp1];
		[QueView addSubview:lblopt2];
		[QueView addSubview:lblopt3];
		[QueView addSubview:lblopt4];
		[QueView addSubview:lblopt5];
		*/
		
	/*	que_scroll.contentSize = CGSizeMake(30, y+10);
		
		[QueView.view  setFrame : CGRectMake(x_pos, y_pos, 320, 370)];
		
		[QueView.view addSubview:que_scroll];
		[paging_scroll addSubview:QueView.view];
		
		
		
		x_pos += 320;
	}
	
	paging_scroll.contentSize = CGSizeMake(paging_scroll.frame.size.width * 10, paging_scroll.frame.size.height);
		
}*/

-(IBAction)BackToLibrary
{
	[self.navigationController popViewControllerAnimated:TRUE];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	

	
    [super dealloc];
}


@end
