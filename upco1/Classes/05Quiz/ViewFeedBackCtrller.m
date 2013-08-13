    //
//  ViewFeedBackCtrller.m
//  KrenMarketing
//
//  Created by Jayna Gandhi on 02/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewFeedBackCtrller.h"
#import "SHKItem.h"
#import "SHKActionSheet.h"
#import "DAL.h"
#import <MessageUI/MFMailComposeViewController.h>


@implementation ViewFeedBackCtrller

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

//Underlined
/*
-(void)setTextIsUnderlined:(BOOL)underlined range:(NSRange)range {
	int32_t style = underlined ? (kCTUnderlineStyleSingle|kCTUnderlinePatternSolid) : kCTUnderlineStyleNone;
	[self setTextUnderlineStyle:style range:range];
}*/
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil _page:(int)page{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		
		gPage = page;
    }
    return self;
}


#pragma mark Set Height Of Labels
- (float)calculateHeightOfTextFromWidth_dynamicData:(NSString*)text width:(float)_width 
{
	[text retain];
	
	CGSize suggestedSize = [text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(_width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap];
	
	[text release];
	
	
	return suggestedSize.height;
}
- (float)calculateHeightOfTextFromWidth:(NSString*)text width:(float)_width 
{
	[text retain];
	
	CGSize suggestedSize = [text sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(_width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap];
	
	[text release];
	
	
	return suggestedSize.height;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    

	//scrEmailFeedBack_verti.contentSize = CGSizeMake(0,1000);
	corans=0;
	//if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
	y_pos = 0;
	//feedbackViewBox.backgroundColor = [UIColor redColor];
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	NSDictionary *dict = [appDel.ansSetarr objectAtIndex:gPage];
	//NSLog(@"dict==%@",[dict objectForKey:@"Question"]);
	//NSLog(@"dict==%@",appDel.ansSetarr);
	//`NSLog(@"dict==%@",[dict objectForKey:@"Answer"]);
	
	lblQNo.text = [NSString stringWithFormat:@"Q%d.",gPage+1];
	lblQuestion.text = [dict objectForKey:@"Question"];
	//NSLog(@"questions -- >>%@",lblQuestion.text);
	lblanswer.text = [dict objectForKey:@"Answer"];
	
	if(gPage == 9)
		btnEmail.hidden = NO;
	else 
		btnEmail.hidden = YES;
	

	
	float y=0;
	float height;
	//float height = [self calculateHeightOfTextFromWidth:[dict objectForKey:@"Question"] width:575];
	//lblQuestion.frame = CGRectMake(lblQuestion.frame.origin.x, lblQuestion.frame.origin.y, lblQuestion.frame.size.width, height);
	
	//CGSize maximumLabelSize1 = CGSizeMake(500,9999);
//	CGSize expectedLabelSize1 = [[dict objectForKey:@"Question"] sizeWithFont:[UIFont fontWithName:@"Arial-Bold" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
//	height = expectedLabelSize1.height;
//	
//	height+=20;
	
	lblQuestion.frame = CGRectMake(lblQuestion.frame.origin.x,lblQuestion.frame.origin.y, lblQuestion.frame.size.width, height);

	
	CGSize maximumLabelSize2 = CGSizeMake(575,9999);
	CGSize expectedLabelSize2 = [lblQuestion.text sizeWithFont:lblQuestion.font constrainedToSize:maximumLabelSize2 lineBreakMode:lblQuestion.lineBreakMode];
	CGRect newFrame2 = lblQuestion.frame;
	newFrame2.size.height = expectedLabelSize2.height;
	lblQuestion.frame = newFrame2;
	
		
	//y=lblQuestion.frame.origin.y+height+15;
	
	y = lblQuestion.frame.size.height + lblQuestion.frame.origin.y + 15;
	
	height = [self calculateHeightOfTextFromWidth:[dict objectForKey:@"Answer"] width:580];
	
	lblanswer.frame = CGRectMake(lblanswer.frame.origin.x, y, lblanswer.frame.size.width, height);
	
	//CGSize maximumLabelSize1 = CGSizeMake(473,9999);
//	
//	CGSize expectedLabelSize1 = [lblRationale.text sizeWithFont:lblRationale.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblRationale.lineBreakMode];
//	
//	CGRect newFrame1 = lblRationale.frame;
//	newFrame1.size.height = expectedLabelSize1.height;
//	//`newFrame1.size.width = 570;
//	lblRationale.frame = newFrame1;
	
	
	//signImgView.frame = CGRectMake(signImgView.frame.origin.x, y, signImgView.frame.size.width, signImgView.frame.size.height);
	//lblanswer.backgroundColor = [UIColor redColor];
	//For correct image----------------
	//select other info from DB
	
	NSString *strQuery ;
	if(appDel.chNo==23)
	{
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%@' and QuestionNo='%d'",@"APPENDIX A",gPage+1];
	}
	else if(appDel.chNo ==24)
	{
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%@' and QuestionNo='%d'",@"APPENDIX B",gPage+1];
	}
	else
	{
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%d' and QuestionNo='%d'",appDel.chNo,gPage+1];
	}
	
	
	
	//NSString *strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%d' and QuestionNo='%d'",appDel.chNo,gPage+1];
	NSArray *arr_queset = [DAL ExecuteArraySet:strQuery];
	
	/*********************************/

	
	if([[dict objectForKey:@"Answer"] isEqualToString:@"NODATA"])
	{
		lblanswer.text = @"Unanswered";
		signImgView.image = [UIImage imageNamed:@"_0000_Layer-0.png"];
		signImgView.frame = CGRectMake(10, y-15, 50, 50);
		
	}
	else if([[[arr_queset objectAtIndex:0] objectForKey:@"Answer"] isEqualToString:[dict objectForKey:@"Answer"]])
	{
        corans++;
		signImgView.image = [UIImage imageNamed:@"_0001_Round-tick.png"];
		signImgView.frame = CGRectMake(10, y-15, 50, 50);
	}
	else {
		signImgView.image = [UIImage imageNamed:@"_0000_Round-cross.png"];
		signImgView.frame = CGRectMake(10, y-15, 50, 50);
	}
		
	
	/********************/
	
	
	
	y=lblanswer.frame.origin.y+height+15;
	//feedbackViewBox.frame = CGRectMake(lblQuestion.frame.origin.x-20, y, feedbackViewBox.frame.size.width, feedbackViewBox.frame.size.height);
//	
//	y+=feedbackViewBox.frame.size.height+30;
	
	//btnEmail.frame = CGRectMake(btnEmail.frame.origin.x, y, btnEmail.frame.size.width, btnEmail.frame.size.height);
	
	
	
	
	
	


	
	if(gPage == [appDel.ansSetarr count])
		btnEmail.hidden = NO;
	
	lblrelation = [[UILabel alloc] init];
	lblrelation.text = [[arr_queset objectAtIndex:0] objectForKey:@"Rationale"];
	lblrelation.backgroundColor = [UIColor clearColor];
	lblrelation.numberOfLines = 0;
	lblrelation.frame = CGRectMake(100, 160, 473, 42);
	
	CGSize maximumLabelSize12 = CGSizeMake(473,9999);
	
	CGSize expectedLabelSize12 = [lblrelation.text sizeWithFont:lblrelation.font constrainedToSize:maximumLabelSize12 lineBreakMode:lblrelation.lineBreakMode];
	
	CGRect newFrame12 = lblrelation.frame;
	newFrame12.size.height = expectedLabelSize12.height;
	lblrelation.frame = newFrame12;
	
	feedbackViewBox.frame = CGRectMake(lblQuestion.frame.origin.x-20, y, feedbackViewBox.frame.size.width, feedbackViewBox.frame.size.height+lblrelation.frame.size.height-100);
	
	y+=feedbackViewBox.frame.size.height+30;
	
	//[feedbackViewBox addSubview:lblrelation];
	
	//int heigh = [[dict objectForKey:@"Question"] length];
	
	//NSLog(@"%d",heigh);
	
	feedbackimage.frame = CGRectMake(1, 49, 590, 150+lblrelation.frame.size.height);
	
	//NSLog(@"fram == %f",feedbackimage.frame.size.height);
	
	//lblNeed.frame = CGRectMake(15, lblrelation.frame.size.height+170, 135, 21);
	
	//btnEmail.frame = CGRectMake(242, y, 193, 64);
	
	btnEmail.frame = CGRectMake(200, y+10, 193, 64);
	
	lblCorrectAns.text = [[arr_queset objectAtIndex:0] objectForKey:@"Answer"];
	lblTopic.text = [[arr_queset objectAtIndex:0] objectForKey:@"Category"];
	lblPage.text = [[arr_queset objectAtIndex:0] objectForKey:@"page"];
	lblLO.text = [[arr_queset objectAtIndex:0] objectForKey:@"learningObject"];
	lblRationale.text = [[arr_queset objectAtIndex:0] objectForKey:@"Rationale"];
	//lblRationale.text = @"Jayna";
	
	if([lblCorrectAns.text length] == 0)
		height = 21;
	else
	{
		height = [self calculateHeightOfTextFromWidth_dynamicData:lblCorrectAns.text width:400];
		
	}
	lblCorrectAns.frame = CGRectMake(lblCorrectAns.frame.origin.x, lblheadCorrectAns.frame.origin.y+2, 400, height);
	
	
	y+=height+5;
	
	y_pos = lblCorrectAns.frame.origin.y + lblCorrectAns.frame.size.height;
	
	lblheadTopic.frame = CGRectMake(lblheadTopic.frame.origin.x, y_pos + 2, lblheadTopic.frame.size.width, 21);
	//height = [self calculateHeightOfTextFromWidth_dynamicData:lblTopic.text width:400];
	lblTopic.font = [UIFont systemFontOfSize:15];
	lblTopic.frame = CGRectMake(lblTopic.frame.origin.x, y_pos + 4, lblTopic.frame.size.width, 30);
	
	CGSize maximumLabelSize3 = CGSizeMake(400,9999);
	CGSize expectedLabelSize3 = [lblTopic.text sizeWithFont:lblTopic.font constrainedToSize:maximumLabelSize3 lineBreakMode:lblTopic.lineBreakMode];
	CGRect newFrame3 = lblTopic.frame;
	newFrame3.size.height = expectedLabelSize3.height;
	lblTopic.frame = newFrame3;
	
	y_pos = 0;
	y_pos = lblTopic.frame.origin.y+lblTopic.frame.size.height;
	
	lblheadPage.frame = CGRectMake(lblheadPage.frame.origin.x, y_pos + 2, lblheadPage.frame.size.width, lblheadPage.frame.size.height);
	lblPage.frame = CGRectMake(lblPage.frame.origin.x, y_pos + 2, lblPage.frame.size.width, lblPage.frame.size.height);
	
	y_pos = 0;
	y_pos = lblheadPage.frame.origin.y+lblheadPage.frame.size.height;
	
	if(appDel.chNo ==24)
	{
		lblheadLO.hidden = TRUE;
		lblLO.hidden = TRUE;
		lblheadRationale.frame = CGRectMake(lblheadRationale.frame.origin.x, y_pos + 2, lblheadRationale.frame.size.width, lblheadRationale.frame.size.height);
		lblRationale.frame = CGRectMake(lblRationale.frame.origin.x, y_pos + 2, lblRationale.frame.size.width, 21);
	
		CGSize maximumLabelSize1 = CGSizeMake(473,9999);
	
		CGSize expectedLabelSize1 = [lblRationale.text sizeWithFont:lblRationale.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblRationale.lineBreakMode];
	
		CGRect newFrame1 = lblRationale.frame;
		newFrame1.size.height = expectedLabelSize1.height;
		//`newFrame1.size.width = 570;
		lblRationale.frame = newFrame1;
	}
	else 
	{
		lblLO.hidden = FALSE;
		lblheadLO.hidden = FALSE;
		
		lblheadLO.frame = CGRectMake(lblheadLO.frame.origin.x,y_pos+2 , lblheadLO.frame.size.width, lblheadLO.frame.size.height);
		lblLO.frame = CGRectMake(lblLO.frame.origin.x,y_pos+2 , lblLO.frame.size.width, lblLO.frame.size.height);
		
		y_pos = 0;
		y_pos = lblheadLO.frame.origin.y + lblheadLO.frame.size.height;
		
		lblheadRationale.frame = CGRectMake(lblheadRationale.frame.origin.x, y_pos + 2, lblheadRationale.frame.size.width, lblheadRationale.frame.size.height);
		lblRationale.frame = CGRectMake(lblRationale.frame.origin.x, y_pos + 4, lblRationale.frame.size.width, 21);
		
		CGSize maximumLabelSize1 = CGSizeMake(473,9999);
		
		CGSize expectedLabelSize1 = [lblRationale.text sizeWithFont:lblRationale.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblRationale.lineBreakMode];
		
		CGRect newFrame1 = lblRationale.frame;
		newFrame1.size.height = expectedLabelSize1.height;
		//`newFrame1.size.width = 570;
		lblRationale.frame = newFrame1;
		
	}
	
//	feedbackimage.frame = CGRectMake(1, 49, 590, 190+lblRationale.frame.size.height);
	feedbackimage.frame = CGRectMake(1, 49, 590, lblRationale.frame.origin.y+lblRationale.frame.size.height+2);
	NSLog(@"Rational -- > %@",lblRationale.text);
	
	//[lblRationale setFont:[UIFont fontWithName:@"Helvetica" size:18]];
	lblRationale.hidden = NO;
	/***********jayna270112************/
/*	y=lblheadCorrectAns.frame.origin.y;
	height = [self calculateHeightOfTextFromWidth_dynamicData:lblCorrectAns.text width:400];
	lblCorrectAns.frame = CGRectMake(lblCorrectAns.frame.origin.x, lblheadCorrectAns.frame.origin.y+2, lblCorrectAns.frame.size.width, height);
	 
	y+=height+5;
	lblheadTopic.frame = CGRectMake(lblheadTopic.frame.origin.x, y, lblheadTopic.frame.size.width, 21);
	height = [self calculateHeightOfTextFromWidth_dynamicData:lblTopic.text width:400];
	lblTopic.font = [UIFont systemFontOfSize:15];
	lblTopic.frame = CGRectMake(lblTopic.frame.origin.x, y+2, lblTopic.frame.size.width, height);

	y+=height+5;
	lblheadPage.frame = CGRectMake(lblheadPage.frame.origin.x, y, lblheadPage.frame.size.width, 21);
	height = [self calculateHeightOfTextFromWidth_dynamicData:lblPage.text width:400];
	lblPage.frame = CGRectMake(lblPage.frame.origin.x, y+2, lblPage.frame.size.width, height);
	
	
	y+=height+5;
	lblheadLO.frame = CGRectMake(lblheadLO.frame.origin.x, y, lblheadLO.frame.size.width, 21);
	height = [self calculateHeightOfTextFromWidth_dynamicData:lblLO.text width:400];
	lblLO.frame = CGRectMake(lblLO.frame.origin.x, y+2, lblLO.frame.size.width, height);
	
	y+=height+5;
	/*lblRationale.backgroundColor = [UIColor clearColor];
	lblheadRationale.frame = CGRectMake(lblheadRationale.frame.origin.x, y, lblheadRationale.frame.size.width, 21);
	height = [self calculateHeightOfTextFromWidth_dynamicData:lblRationale.text width:473];
	if(height == 38)
		height = 21;
	lblRationale.frame = CGRectMake(lblRationale.frame.origin.x, y+2, lblRationale.frame.size.width, height);*/
/*	lblRationale.font = [UIFont systemFontOfSize:15];
	lblheadRationale.frame = CGRectMake(lblheadRationale.frame.origin.x, y, lblheadRationale.frame.size.width, 21);
	
	
	lblRationale.frame = CGRectMake(lblRationale.frame.origin.x, y+2, lblRationale.frame.size.width, 21);
	
	 maximumLabelSize1 = CGSizeMake(473,9999);
	
	 expectedLabelSize1 = [lblRationale.text sizeWithFont:lblRationale.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblRationale.lineBreakMode];
	
	 newFrame1 = lblRationale.frame;
	newFrame1.size.height = expectedLabelSize1.height;
	lblRationale.frame = newFrame1;
	
	/***************************/

	//lblStudyingneeds.text = [[arr_queset objectAtIndex:0] objectForKey:@"studindNeeds"];
	[self.view bringSubviewToFront:btnEmail];

	UIImage *imgScreen = [self captureScreenInRect:CGRectMake(0,0 ,700, btnEmail.frame.origin.y)];
	CGRect cropRect = CGRectMake(0,0,700,btnEmail.frame.origin.y);
	CGImageRef imageRef = CGImageCreateWithImageInRect([imgScreen CGImage], cropRect);
	
	UIImage *image = [UIImage imageWithCGImage:imageRef]; 
	CGImageRelease(imageRef);
	[appDel.arr_emailImages_Quiz addObject:image];
	
		
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(didRotate:) 
												 name:UIApplicationDidChangeStatusBarOrientationNotification
											   object:nil];

	
	[self didRotate:nil];
	
	
	
	
	
	
	//UIImage *imgScreen = [self captureScreenInRect:CGRectMake(0,0 ,700,y-51)];
//	CGRect cropRect = CGRectMake(0,0,700,y-51);
//	CGImageRef imageRef = CGImageCreateWithImageInRect([imgScreen CGImage], cropRect);
//	
//	UIImage *image = [UIImage imageWithCGImage:imageRef]; 
//	CGImageRelease(imageRef);
//	[appDel.arr_emailImages_Quiz addObject:image];
	
	}
    [super viewDidLoad];
}
- (void) didRotate:(NSNotification *)notification
{
	if(appDel.ori == 0)
		appDel.ori = [[UIDevice currentDevice] orientation];
	feedbackHeader.image = [UIImage imageNamed:@"_0011_Feedback-A1.png"];
	NSDictionary *dict = [appDel.ansSetarr objectAtIndex:gPage];
	
	NSString *strQuery ;
	if(appDel.chNo==23)
	{
		strQuery =[NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%@' and QuestionNo='%d'",@"APPENDIX A",gPage+1];
	}
	else if(appDel.chNo ==24)
	{
		strQuery =[NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%@' and QuestionNo='%d'",@"APPENDIX B",gPage+1];
	}
	else
	{
		strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%d' and QuestionNo='%d'",appDel.chNo,gPage+1];
	}
	
	
	
	//NSString *strQuery = [NSString stringWithFormat:@"SELECT *FROM QT Where ChapterNo='%d' and QuestionNo='%d'",appDel.chNo,gPage+1];
	NSArray *arr_queset = [DAL ExecuteArraySet:strQuery];
	
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		//feedbackViewBox.backgroundColor = [UIColor purpleColor];
		feedbackHeader.frame = CGRectMake(feedbackHeader.frame.origin.x, feedbackHeader.frame.origin.y, 590, 54);
		feedbackViewBox.frame = CGRectMake(feedbackViewBox.frame.origin.x, feedbackViewBox.frame.origin.y, 590, feedbackViewBox.frame.size.height+2);
		
		
		/***********jayna280112************/
		CGFloat y=lblheadCorrectAns.frame.origin.y;
		float height = 0;
		if([[dict objectForKey:@"Answer"] isEqualToString:@"NODATA"])
		{
			lblCorrectAns.hidden = NO;
			lblheadCorrectAns.hidden = NO;
			if([lblCorrectAns.text length] == 0)
				height = 21;
			else
			{
				height = [self calculateHeightOfTextFromWidth_dynamicData:lblCorrectAns.text width:400];
				
			}
			lblCorrectAns.frame = CGRectMake(lblCorrectAns.frame.origin.x, lblheadCorrectAns.frame.origin.y+2, 400, height);
			
		}
		else if([arr_queset count] > 0)
		{
			if([[[arr_queset objectAtIndex:0] objectForKey:@"Answer"] isEqualToString:[dict objectForKey:@"Answer"]])
			{
				lblCorrectAns.hidden = YES;
				lblheadCorrectAns.hidden = YES;
				y-=10;
			}
			else {
				lblCorrectAns.hidden = NO;
				lblheadCorrectAns.hidden = NO;
				if([lblCorrectAns.text length] == 0)
					height = 21;
				else
				{
					height = [self calculateHeightOfTextFromWidth_dynamicData:lblCorrectAns.text width:400];
					
				}
				lblCorrectAns.frame = CGRectMake(lblCorrectAns.frame.origin.x, lblheadCorrectAns.frame.origin.y+2, 400, height);
				
			}
			
			
		}
		
		
		y+=height+15;
		lblheadTopic.frame = CGRectMake(lblheadTopic.frame.origin.x, y, lblheadTopic.frame.size.width, 21);
		height = [self calculateHeightOfTextFromWidth_dynamicData:lblTopic.text width:505];
		lblTopic.font = [UIFont systemFontOfSize:15];
		lblTopic.frame = CGRectMake(lblTopic.frame.origin.x, y+2, 505, height);
		
		y+=height+5;
		lblheadPage.frame = CGRectMake(lblheadPage.frame.origin.x, y, lblheadPage.frame.size.width, 21);
		height = [self calculateHeightOfTextFromWidth_dynamicData:lblPage.text width:400];
		lblPage.frame = CGRectMake(lblPage.frame.origin.x, y+2, 400, height);
		
		
		y+=height+5;
		
		if(appDel.chNo ==24)
		{
			lblRationale.font = [UIFont systemFontOfSize:15];
			lblheadRationale.frame = CGRectMake(lblheadRationale.frame.origin.x, y, lblheadRationale.frame.size.width, 21);
			
			
			lblRationale.frame = CGRectMake(lblRationale.frame.origin.x, y+2, lblRationale.frame.size.width, 21);
			
			CGSize maximumLabelSize1 = CGSizeMake(473,9999);
			
			CGSize expectedLabelSize1 = [lblRationale.text sizeWithFont:lblRationale.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblRationale.lineBreakMode];
			
			CGRect newFrame1 = lblRationale.frame;
			newFrame1.size.height = expectedLabelSize1.height;
			//newFrame1.size.width = 473;
			lblRationale.frame = newFrame1;
			
		}
		else 
		{
			lblLO.hidden = FALSE;
			lblheadLO.hidden = FALSE;
			
			lblheadLO.frame = CGRectMake(lblheadLO.frame.origin.x, y, lblheadLO.frame.size.width, 21);
					if([lblLO.text length] == 0)
					{
						height = 21;
					}
					else
					{
						height = [self calculateHeightOfTextFromWidth_dynamicData:lblLO.text width:400];
					}
					lblLO.frame = CGRectMake(lblLO.frame.origin.x, y+2, 400, height);
			
					y+=height+5;
					lblRationale.font = [UIFont systemFontOfSize:15];
					lblheadRationale.frame = CGRectMake(lblheadRationale.frame.origin.x, y, lblheadRationale.frame.size.width, 21);
					
					
					lblRationale.frame = CGRectMake(lblRationale.frame.origin.x, y+2, lblRationale.frame.size.width, 21);
					
					CGSize maximumLabelSize1 = CGSizeMake(473,9999);
					
					CGSize expectedLabelSize1 = [lblRationale.text sizeWithFont:lblRationale.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblRationale.lineBreakMode];
					
					CGRect newFrame1 = lblRationale.frame;
					newFrame1.size.height = expectedLabelSize1.height;
					//newFrame1.size.width = 473;
					lblRationale.frame = newFrame1;
			
		}
		
		//lblheadLO.frame = CGRectMake(lblheadLO.frame.origin.x, y, lblheadLO.frame.size.width, 21);
//		if([lblLO.text length] == 0)
//		{
//			height = 21;
//		}
//		else
//		{
//		height = [self calculateHeightOfTextFromWidth_dynamicData:lblLO.text width:400];
//		}
//		lblLO.frame = CGRectMake(lblLO.frame.origin.x, y+2, 400, height);
		
		//y+=height+5;
		/*lblRationale.backgroundColor = [UIColor clearColor];
		 lblheadRationale.frame = CGRectMake(lblheadRationale.frame.origin.x, y, lblheadRationale.frame.size.width, 21);
		 height = [self calculateHeightOfTextFromWidth_dynamicData:lblRationale.text width:473];
		 if(height == 38)
		 height = 21;
		 lblRationale.frame = CGRectMake(lblRationale.frame.origin.x, y+2, lblRationale.frame.size.width, height);*/
		//lblRationale.font = [UIFont systemFontOfSize:15];
//		lblheadRationale.frame = CGRectMake(lblheadRationale.frame.origin.x, y, lblheadRationale.frame.size.width, 21);
//		
//		
//		lblRationale.frame = CGRectMake(lblRationale.frame.origin.x, y+2, lblRationale.frame.size.width, 21);
//		
//		CGSize maximumLabelSize1 = CGSizeMake(473,9999);
//		
//		CGSize expectedLabelSize1 = [lblRationale.text sizeWithFont:lblRationale.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblRationale.lineBreakMode];
//		
//		CGRect newFrame1 = lblRationale.frame;
//		newFrame1.size.height = expectedLabelSize1.height;
//		//newFrame1.size.width = 473;
//		lblRationale.frame = newFrame1;
		
		/***************************/
		//y+=newFrame1.size.height+lblRationale.frame.origin.y+20;
		
		feedbackimage.frame = CGRectMake(feedbackimage.frame.origin.x, feedbackimage.frame.origin.y, 590, lblRationale.frame.size.height+lblRationale.frame.origin.y);
		y=feedbackimage.frame.origin.y+feedbackimage.frame.size.height;
		/*if(appDel.chNo == 1 )
		 btnEmail.frame = CGRectMake(242, y+40, 193, 64);
		 else if (appDel.chNo == 2)
		 btnEmail.frame = CGRectMake(242, y+80, 193, 64);
		 if(appDel.chNo == 9)
		 btnEmail.frame = CGRectMake(242, y+20, 193, 64);
		 if(appDel.chNo == 20)
		 btnEmail.frame = CGRectMake(242, y+50, 193, 64);
		 else*/
		btnEmail.frame = CGRectMake(200, y+10, 193, 64);
		feedbackViewBox.frame = CGRectMake(feedbackViewBox.frame.origin.x, feedbackViewBox.frame.origin.y, 673, y+15+64);
		
		
		
		
		
	}
	else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
			appDel.ori == UIInterfaceOrientationLandscapeRight)
	{
		//feedbackViewBox.backgroundColor = [UIColor redColor];
		feedbackHeader.frame = CGRectMake(feedbackHeader.frame.origin.x, feedbackHeader.frame.origin.y, 673, 54);
		
		feedbackViewBox.frame = CGRectMake(feedbackViewBox.frame.origin.x, feedbackViewBox.frame.origin.y, 673, feedbackViewBox.frame.size.height+2);
		
		/***********jayna280112************/
		CGFloat y=lblheadCorrectAns.frame.origin.y;
		float height = 0 ;
		
		if([[dict objectForKey:@"Answer"] isEqualToString:@"NODATA"])
		{
			lblCorrectAns.hidden = NO;
			lblheadCorrectAns.hidden = NO;
			
			if([lblCorrectAns.text length] == 0)
				height = 21;
			else
				height = [self calculateHeightOfTextFromWidth_dynamicData:lblCorrectAns.text width:500];
			
			
			lblCorrectAns.frame = CGRectMake(lblCorrectAns.frame.origin.x, lblheadCorrectAns.frame.origin.y+2, 500, height);
		}
		else if([arr_queset count] > 0)
		{
			
			if([[[arr_queset objectAtIndex:0] objectForKey:@"Answer"] isEqualToString:[dict objectForKey:@"Answer"]])
			{
				lblCorrectAns.hidden = YES;
				lblheadCorrectAns.hidden = YES;
				y-=10;
			}
			else
			{
				
				lblCorrectAns.hidden = NO;
				lblheadCorrectAns.hidden = NO;
				if([lblCorrectAns.text length] == 0)
					height = 21;
				else
					height = [self calculateHeightOfTextFromWidth_dynamicData:lblCorrectAns.text width:500];
				
				
				lblCorrectAns.frame = CGRectMake(lblCorrectAns.frame.origin.x, lblheadCorrectAns.frame.origin.y+2, 500, height);
			}
		}
		y+=height+15;
		lblheadTopic.frame = CGRectMake(lblheadTopic.frame.origin.x, y, lblheadTopic.frame.size.width, 21);
		height = [self calculateHeightOfTextFromWidth_dynamicData:lblTopic.text width:570];
		lblTopic.font = [UIFont systemFontOfSize:15];
		lblTopic.frame = CGRectMake(lblTopic.frame.origin.x, y+2, 570, height);
		
		y+=height+5;
		lblheadPage.frame = CGRectMake(lblheadPage.frame.origin.x, y, lblheadPage.frame.size.width, 21);
		height = [self calculateHeightOfTextFromWidth_dynamicData:lblPage.text width:570];
		lblPage.frame = CGRectMake(lblPage.frame.origin.x, y+2, 570, height);
		
		
		y+=height+5;
		
		if(appDel.chNo ==24)
		{
			lblRationale.font = [UIFont systemFontOfSize:15];
			lblheadRationale.frame = CGRectMake(lblheadRationale.frame.origin.x, y, lblheadRationale.frame.size.width, 21);
			
			
			lblRationale.frame = CGRectMake(lblRationale.frame.origin.x, y+2, lblRationale.frame.size.width, 21);
			
			CGSize maximumLabelSize1 = CGSizeMake(473,9999);
			
			CGSize expectedLabelSize1 = [lblRationale.text sizeWithFont:lblRationale.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblRationale.lineBreakMode];
			
			CGRect newFrame1 = lblRationale.frame;
			newFrame1.size.height = expectedLabelSize1.height;
			//newFrame1.size.width = 473;
			lblRationale.frame = newFrame1;
			
		}
		else 
		{
			lblLO.hidden = FALSE;
			lblheadLO.hidden = FALSE;
			
			lblheadLO.frame = CGRectMake(lblheadLO.frame.origin.x, y, lblheadLO.frame.size.width, 21);
			if([lblLO.text length] == 0)
			{
				height = 21;
			}
			else
			{
				height = [self calculateHeightOfTextFromWidth_dynamicData:lblLO.text width:400];
			}
			lblLO.frame = CGRectMake(lblLO.frame.origin.x, y+2, 400, height);
			
			y+=height+5;
			lblRationale.font = [UIFont systemFontOfSize:15];
			lblheadRationale.frame = CGRectMake(lblheadRationale.frame.origin.x, y, lblheadRationale.frame.size.width, 21);
			
			
			lblRationale.frame = CGRectMake(lblRationale.frame.origin.x, y+2, lblRationale.frame.size.width, 21);
			
			CGSize maximumLabelSize1 = CGSizeMake(473,9999);
			
			CGSize expectedLabelSize1 = [lblRationale.text sizeWithFont:lblRationale.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblRationale.lineBreakMode];
			
			CGRect newFrame1 = lblRationale.frame;
			newFrame1.size.height = expectedLabelSize1.height;
			//newFrame1.size.width = 473;
			lblRationale.frame = newFrame1;
			
		}
		
		/*
		lblheadLO.frame = CGRectMake(lblheadLO.frame.origin.x, y, lblheadLO.frame.size.width, 21);
		if([lblLO.text length] == 0)
			height = 21;
		else
		{
			
		height = [self calculateHeightOfTextFromWidth_dynamicData:lblLO.text width:570];
		}
		lblLO.frame = CGRectMake(lblLO.frame.origin.x, y+2, 570, height);
		
		y+=height+5;
		
		lblRationale.font = [UIFont systemFontOfSize:15];
		lblheadRationale.frame = CGRectMake(lblheadRationale.frame.origin.x, y, lblheadRationale.frame.size.width, 21);
		lblRationale.frame = CGRectMake(lblRationale.frame.origin.x, y+2, lblRationale.frame.size.width, 21);
		
		CGSize maximumLabelSize1 = CGSizeMake(473,9999);
		
		CGSize expectedLabelSize1 = [lblRationale.text sizeWithFont:lblRationale.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblRationale.lineBreakMode];
		
		CGRect newFrame1 = lblRationale.frame;
		newFrame1.size.height = expectedLabelSize1.height;
		lblRationale.frame = newFrame1;
		*/
		
		/***************************/
		//    y+=newFrame1.size.height+lblRationale.frame.origin.y+20;
		feedbackimage.frame = CGRectMake(feedbackimage.frame.origin.x, feedbackimage.frame.origin.y, 672, lblRationale.frame.size.height+lblRationale.frame.origin.y);
		
		/*if(appDel.chNo  == 1 )
		 btnEmail.frame = CGRectMake(242, y+20, 193, 64);
		 else if (appDel.chNo  == 2)
		 btnEmail.frame = CGRectMake(242, y+80, 193, 64);
		 if(appDel.chNo == 9)
		 btnEmail.frame = CGRectMake(242, y+20, 193, 64);
		 if(appDel.chNo == 20)
		 btnEmail.frame = CGRectMake(242, y+50, 193, 64);
		 else
		 btnEmail.frame = CGRectMake(242, y, 193, 64);*/
		
		y=feedbackimage.frame.origin.y+feedbackimage.frame.size.height;
		//NSLog(@"%f %f %f",y,feedbackimage.frame.origin.y,feedbackimage.frame.size.height);
		//btnEmail.frame = CGRectMake(242, y+30, 193, 64);
		
		btnEmail.frame = CGRectMake(200, y+10, 193, 64);
		feedbackViewBox.frame = CGRectMake(feedbackViewBox.frame.origin.x, feedbackViewBox.frame.origin.y, 673, y+15+64);
		//    150+lblrelation.frame.size.height
		
	}
	
}

#pragma mark emailbtn_click
-(IBAction)emailbtn_click:(id)sender
{
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"EmailClickFrameSet" object:nil];

	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
	}
	

	/*NSString *text=@"hello";
	
	SHKItem *item = [SHKItem image:imgScreen title:nil];
	[NSClassFromString(@"SHKMail") performSelector:@selector(shareItem:) withObject:item];
	*/
	
	
}
-(void)displayComposerSheet
{
	//UIImage *imgScreen = [self captureScreenInRect:CGRectMake(0,0 ,700, btnEmail.frame.origin.y)];

	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
    
    [picker setSubject:[NSString stringWithFormat:@"Quiz - Chapter %d Feedback",gPage]];

  // *lblTopic,*lblPage,*lblLO,*lblStudyingneeds,*lblNeed,*lblCorrectAns;
	//IBOutlet UILabel *lblheadTopic,*lblheadPage,*lblheadLO,*lblheadStudyingneeds,*lblheadNeed,*lblheadCorrectAns,*lblheadRationale;

    NSLog(@"check:%@-%@-%@",lblLO.text,lblCorrectAns.text,lblheadLO.text);
    

    
      
	for(int i=0;i<[appDel.arr_emailImages_Quiz count];i++)
	{
		NSData *imgData = UIImagePNGRepresentation([appDel.arr_emailImages_Quiz objectAtIndex:i]);
		
		[picker addAttachmentData:imgData mimeType:@"image/jpg" fileName:@"Result"];//[tmpBody release];
	}
   
       
       
    [picker setMessageBody:[NSString stringWithFormat:@"Out of 10 questions, you have answered %d correctly with a final grade of %d%%",appDel.correct,10*appDel.correct] isHTML:NO];
   // NSLog(@"total correct ans:%d",appDel.correct);

	
	picker.modalPresentationStyle =UIModalPresentationFullScreen;
	picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[appDel.viewController presentModalViewController:picker animated:YES];
    [picker release];
}

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:jayna.gandhi@silvertouch.com?cc=second@example.com,third@example.com&subject=Hello from California!";
	NSString *body = @"&body=It is raining in sunny California!";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	//message.hidden = NO;
	
	[appDel.viewController dismissModalViewControllerAnimated:YES];
}

#pragma mark capture screen



- (UIImage *)captureScreenInRect:(CGRect)captureFrame {
    CALayer *layer;
    layer = self.view.layer;
    UIGraphicsBeginImageContext(self.view.bounds.size); 
    CGContextClipToRect (UIGraphicsGetCurrentContext(),captureFrame);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenImage;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
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
