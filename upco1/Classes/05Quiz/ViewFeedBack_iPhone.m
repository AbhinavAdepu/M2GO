    //
//  ViewFeedBack_iPhone.m
//  KrenMarketing
//
//  Created by Jayna Gandhi on 27/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewFeedBack_iPhone.h"
#import "DAL.h"
#import <MessageUI/MFMailComposeViewController.h>

@implementation ViewFeedBack_iPhone

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil _page:(int)page{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		gPage = page;
        // Custom initialization.
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/
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
- (void)viewDidLoad
{
	txtDisplay = [[OHAttributedLabel alloc]init];
	txtDisplay.frame = CGRectMake(20, 49, 250, 200);
	txtDisplay.backgroundColor = [UIColor clearColor];
	[scrEmailFeedBack_verti addSubview:txtDisplay];
	
	scrEmailFeedBack_verti.contentSize = CGSizeMake(0,600);
	
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	NSDictionary *dict = [appDel.ansSetarr objectAtIndex:gPage];

	NSLog(@"dict==%@",dict);
	
	lblQNo.text = [NSString stringWithFormat:@"Q%d.",gPage+1];
	lblQuestion.text = [dict objectForKey:@"Question"];
	lblAnswer.text = [dict objectForKey:@"Answer"];
	
	if(gPage == 9)
		btnEmail.hidden = NO;
	else 
		btnEmail.hidden = YES;
	
	
	
	float y=0;
	float height=30;
	
	
	lblQuestion.frame = CGRectMake(lblQuestion.frame.origin.x,lblQuestion.frame.origin.y, lblQuestion.frame.size.width, height);
	
	
	CGSize maximumLabelSize2 = CGSizeMake(282,9999);
	CGSize expectedLabelSize2 = [lblQuestion.text sizeWithFont:lblQuestion.font constrainedToSize:maximumLabelSize2 lineBreakMode:lblQuestion.lineBreakMode];
	CGRect newFrame2 = lblQuestion.frame;
	newFrame2.size.height = expectedLabelSize2.height;
	lblQuestion.frame = newFrame2;
	
	
	y = lblQuestion.frame.size.height + lblQuestion.frame.origin.y + 10;
	
	CGSize maximumLabelSize3 = CGSizeMake(250,9999);
	CGSize expectedLabelSize3 = [[dict objectForKey:@"Answer"] sizeWithFont:lblAnswer.font constrainedToSize:maximumLabelSize3 lineBreakMode:lblAnswer.lineBreakMode];
	CGRect newFrame3 = lblAnswer.frame;
	newFrame3.size.height = expectedLabelSize3.height;
	lblAnswer.frame = newFrame3;
	
	//height = [self calculateHeightOfTextFromWidth:[dict objectForKey:@"Answer"] width:282];
	height = newFrame3.size.height;
	
	lblAnswer.frame = CGRectMake(lblAnswer.frame.origin.x, y, lblAnswer.frame.size.width, height);
	
		
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
	
	arr_queset = [[NSArray alloc]init];
	
	arr_queset = [DAL ExecuteArraySet:strQuery];
	
	/*********************************/
	
	if([[dict objectForKey:@"Answer"] isEqualToString:@"NODATA"])
	{
		lblAnswer.text = @"Unanswered";
		imgoption.image = [UIImage imageNamed:@"_0000_Layer-0.png"];
		imgoption.frame = CGRectMake(20, y-4, 25, 25);
		
	}
	else if([[[arr_queset objectAtIndex:0] objectForKey:@"Answer"] isEqualToString:[dict objectForKey:@"Answer"]])
	{
		imgoption.image = [UIImage imageNamed:@"_0001_Round-tick.png"];
		imgoption.frame = CGRectMake(20, y-4, 25, 25);
	}
	else {
		imgoption.image = [UIImage imageNamed:@"_0000_Round-cross.png"];
		imgoption.frame = CGRectMake(20, y-4, 25,25);
	}
	
	
	/********************/
	
	
	
	y=lblAnswer.frame.origin.y+height+5;

	
	
	if(gPage == [appDel.ansSetarr count])
		btnEmail.hidden = NO;
	
	
	feedbackViewBox.frame = CGRectMake(20, y, 280, feedbackViewBox.frame.size.height);
	
	//y+=feedbackViewBox.frame.size.height+30;

	feedbackimageHeader.frame = CGRectMake(0, 0, 280, 44);
	feedbackimage.frame = CGRectMake(20, 40, 280, 200);
	
	
	
	
	
	/*lblCorrectAns.text = [[arr_queset objectAtIndex:0] objectForKey:@"Answer"];
	lblTopic.text = [[arr_queset objectAtIndex:0] objectForKey:@"Category"];
	lblPage.text = [[arr_queset objectAtIndex:0] objectForKey:@"page"];
	lblLO.text = [[arr_queset objectAtIndex:0] objectForKey:@"learningObject"];
	lblRationale.text = [[arr_queset objectAtIndex:0] objectForKey:@"Rationale"];*/

	[self MainDescription];
	
	/*if([lblCorrectAns.text length] == 0)
		height = 21;
	else
	{
		height = [self calculateHeightOfTextFromWidth_dynamicData:lblCorrectAns.text width:190];
		
	}
	lblCorrectAns.frame = CGRectMake(lblCorrectAns.frame.origin.x, lblheadCorrectAns.frame.origin.y, 190, height);
	
	
	y+=height+5;
	
	y_pos = lblCorrectAns.frame.origin.y + lblCorrectAns.frame.size.height;
	
	lblheadTopic.frame = CGRectMake(lblheadTopic.frame.origin.x, y_pos + 2, lblheadTopic.frame.size.width, 21);
	
	lblTopic.font = [UIFont systemFontOfSize:12];
	lblTopic.frame = CGRectMake(lblTopic.frame.origin.x, y_pos + 4, lblTopic.frame.size.width, 21);
	
	CGSize maximumLabelSize3 = CGSizeMake(258,9999);
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
		
		CGSize maximumLabelSize1 = CGSizeMake(210,9999);
		
		CGSize expectedLabelSize1 = [lblRationale.text sizeWithFont:lblRationale.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblRationale.lineBreakMode];
		
		CGRect newFrame1 = lblRationale.frame;
		newFrame1.size.height = expectedLabelSize1.height;
		
		lblRationale.frame = newFrame1;
	}
	else 
	{
		lblLO.hidden = TRUE;
		lblheadLO.hidden = TRUE;
		
		lblheadLO.frame = CGRectMake(lblheadLO.frame.origin.x,y_pos+2 , lblheadLO.frame.size.width, lblheadLO.frame.size.height);
		lblLO.frame = CGRectMake(lblLO.frame.origin.x,y_pos+2 , lblLO.frame.size.width, lblLO.frame.size.height);
		
		y_pos = 0;
		y_pos = lblheadLO.frame.origin.y + lblheadLO.frame.size.height;
		
		lblheadRationale.frame = CGRectMake(lblheadRationale.frame.origin.x, y_pos + 2, lblheadRationale.frame.size.width, lblheadRationale.frame.size.height);
		lblRationale.frame = CGRectMake(lblRationale.frame.origin.x, y_pos + 4, lblRationale.frame.size.width, 21);
		
		CGSize maximumLabelSize1 = CGSizeMake(210,9999);
		
		CGSize expectedLabelSize1 = [lblRationale.text sizeWithFont:lblRationale.font constrainedToSize:maximumLabelSize1 lineBreakMode:lblRationale.lineBreakMode];
		
		CGRect newFrame1 = lblRationale.frame;
		newFrame1.size.height = expectedLabelSize1.height;
		lblRationale.frame = newFrame1;
		
	}
	
	
	feedbackimage.frame = CGRectMake(20, 40, 280,lblRationale.frame.origin.y+lblRationale.frame.size.height+10);
	
	feedbackViewBox.frame = CGRectMake(0, feedbackViewBox.frame.origin.y, 280, feedbackimage.frame.size.height+44);
	
	lblRationale.hidden = TRUE;

	btnEmail.frame = CGRectMake(61, feedbackViewBox.frame.origin.y+feedbackViewBox.frame.size.height, 198, 54);
	
	
	y_pos = btnEmail.frame.origin.y+btnEmail.frame.size.height + 200;
	scrEmailFeedBack_verti.contentSize = CGSizeMake(320, y_pos);*/
	
	
	
		
	
	



	
    [super viewDidLoad];
}

-(void)MainDescription
{
	NSString *str = @"";
	if([[arr_queset objectAtIndex:0] objectForKey:@"Answer"])
	{
		str = [str stringByAppendingString:[NSString stringWithFormat:@"Correct Answer: %@",[[arr_queset objectAtIndex:0] objectForKey:@"Answer"]]];
		str = [str stringByAppendingFormat:@"\n\n"];
	}
	if([[arr_queset objectAtIndex:0] objectForKey:@"Category"])
	{
		str = [str stringByAppendingString:[NSString stringWithFormat:@"Topic: %@",[[arr_queset objectAtIndex:0] objectForKey:@"Category"]]];
		str = [str stringByAppendingFormat:@"\n"];
	}
	if([[arr_queset objectAtIndex:0] objectForKey:@"page"])
	{
		str = [str stringByAppendingString:[NSString stringWithFormat:@"Page: %@",[[arr_queset objectAtIndex:0] objectForKey:@"page"]]];
		str = [str stringByAppendingFormat:@"\n"];
	}
	if([[[arr_queset objectAtIndex:0] objectForKey:@"learningObject"] length] > 0)
	{
		if([[arr_queset objectAtIndex:0] objectForKey:@"learningObject"])
		{
			
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Learning Objective: %@",[[arr_queset objectAtIndex:0] objectForKey:@"learningObject"]]];
			str = [str stringByAppendingFormat:@"\n"];
		}
	}
	if([[arr_queset objectAtIndex:0] objectForKey:@"Rationale"])
	{
		str = [str stringByAppendingString:[NSString stringWithFormat:@"Rationale: %@",[[arr_queset objectAtIndex:0] objectForKey:@"Rationale"]]];
		str = [str stringByAppendingFormat:@"\n"];
	}
	
	
	NSMutableAttributedString *strattr = [NSMutableAttributedString attributedStringWithString:str];
	[strattr setTextColor:[UIColor blackColor]];
	[strattr setFontFamily:@"Helvetica" size:14 bold:NO italic:NO range:[str rangeOfString:str]];
	
	if([[[arr_queset objectAtIndex:0] objectForKey:@"Answer"] length] > 0)
	{
		[strattr setTextBold:YES range:[str rangeOfString:@"Correct Answer:"]];
	}
	if([[[arr_queset objectAtIndex:0] objectForKey:@"Category"] length] > 0)
	{
		[strattr setTextBold:YES range:[str rangeOfString:@"Topic:"]];
	}
	if([[[arr_queset objectAtIndex:0] objectForKey:@"page"] length] > 0)
	{
		[strattr setTextBold:YES range:[str rangeOfString:@"Page:"]];
	}
	if([[[arr_queset objectAtIndex:0] objectForKey:@"learningObject"] length] > 0)
	{
		[strattr setTextBold:YES range:[str rangeOfString:@"Learning Objective:"]];
	}
	if([[[arr_queset objectAtIndex:0] objectForKey:@"Rationale"] length] > 0)
	{
		[strattr setTextBold:YES range:[str rangeOfString:@"Rationale:"]];
	}
	
	height = 0;
	CGSize maximumLabelSize1 = CGSizeMake(240,9999);
	CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
	height = expectedLabelSize1.height;		   
		
	txtDisplay.attributedText=strattr;
	txtDisplay.frame = CGRectMake(25, lblAnswer.frame.origin.y+lblAnswer.frame.size.height + 50, 250, height + 10);
	
	y_pos = txtDisplay.frame.size.height + txtDisplay.frame.origin.y;
	feedbackimage.frame = CGRectMake(0, 40, 280,txtDisplay.frame.size.height);
	

//	y_pos = feedbackimage.frame.origin.y + feedbackimage.frame.size.height;
	if(gPage == 9)
	{
	btnEmail.frame = CGRectMake(61, txtDisplay.frame.size.height+txtDisplay.frame.origin.y + 20, 213, 68);
	y_pos +=txtDisplay.frame.size.height - 20;
	}
	scrEmailFeedBack_verti.contentSize = CGSizeMake(320,y_pos+60);
	
	
	UIImage *imgScreen = [self captureScreenInRect];
	/*CGRect cropRect = CGRectMake(0,0,320,btnEmail.frame.origin.y);
	CGImageRef imageRef = CGImageCreateWithImageInRect([imgScreen CGImage], cropRect);
	
	UIImage *image = [UIImage imageWithCGImage:imageRef]; 
	CGImageRelease(imageRef);*/
	if(gPage == 9)
	{
		btnEmail.hidden = NO;
	}
	else {
		btnEmail.hidden = YES;
	}

	[appDel.arr_emailImages_Quiz addObject:imgScreen];
	
		   
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
    
	for(int i=0;i<[appDel.arr_emailImages_Quiz count];i++)
	{
		UIImage *img = [appDel.arr_emailImages_Quiz objectAtIndex:i];
		//NSData *imgData = UIImagePNGRepresentation(img);
		NSData *imgData = UIImageJPEGRepresentation(img, 1.0);
		
		[picker addAttachmentData:imgData mimeType:@"image/jpg" fileName:@"Result"];//[tmpBody release];
	}
    
     [picker setMessageBody:[NSString stringWithFormat:@"Out of 10 questions, you have answered %d correctly with a final grade of %d%%",appDel.correct,10*appDel.correct] isHTML:NO];
	
	picker.modalPresentationStyle =UIModalPresentationFullScreen;
	picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[appDel.iphonerootController presentModalViewController:picker animated:YES];
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
	//[self dismissModalViewControllerAnimated:YES];
	[appDel.iphonerootController dismissModalViewControllerAnimated:YES];
}

#pragma mark capture screen
- (UIImage *)captureScreenInRect{

	btnEmail.hidden = YES;
	UIImage* imageTemp = nil;
	UIGraphicsBeginImageContext(scrEmailFeedBack_verti.contentSize);
	{
		CGPoint savedContentOffset = scrEmailFeedBack_verti.contentOffset;
		CGRect savedFrame = scrEmailFeedBack_verti.frame;
		
		scrEmailFeedBack_verti.contentOffset = CGPointZero;
		if(gPage == 9)
		{
			scrEmailFeedBack_verti.frame = CGRectMake(0, 0, scrEmailFeedBack_verti.contentSize.width,scrEmailFeedBack_verti.contentSize.height);
		}
		else
			scrEmailFeedBack_verti.frame = CGRectMake(0, 0, scrEmailFeedBack_verti.contentSize.width, scrEmailFeedBack_verti.contentSize.height);
		
		[scrEmailFeedBack_verti.layer renderInContext: UIGraphicsGetCurrentContext()]; 
		imageTemp = UIGraphicsGetImageFromCurrentImageContext();
		
		scrEmailFeedBack_verti.contentOffset = savedContentOffset;
		scrEmailFeedBack_verti.frame = savedFrame;
	//        UIImageWriteToSavedPhotosAlbum(imageTemp, nil, nil, nil);
		
		}
	UIGraphicsEndImageContext();
	return imageTemp;
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
