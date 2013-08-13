//
//  TemplateViewController.m
//  KrenMarketing
//
//  Created by Silvertouch on 17/11/11.
//  Copyright 2011 SilverTouch Tech. Ltd. All rights reserved.
//
//kerin marketing 
#import <QuartzCore/QuartzCore.h>
#import "TemplateViewController.h"
#import "DatePicker.h"
#import "ViewController.h"
#import "SHKItem.h"
#import "SHKActionSheet.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "DAL.h"
#import "LibraryCell.h"
#import "LibraryCell-Landscape.h"
#import "StartEndDayController.h"
#import "TemplateOptionchoiceController.h"



//#define NUMBERS @"+-1234567890"
#define NUMBERS @" ()-1234567890"
#define ZIP @"1234567890"
#define CHAR @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ " " "
#define kOFFSET_FOR_KEYBOARD	100.0;

@implementation TemplateViewController
@synthesize str_TM_SelectedItem,str_date;
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

///deval adfadsafdf
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void)viewWillAppear:(BOOL)animated
{
		
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        [self addCoverFlow];
		[self didRotate:nil];
	}
	else 
	{
		appDel.QRImageFromLib = nil;
		//[tbl_allCat reloadData];
		
	}
}
UIPopoverController* photoPop;

- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
	tv_Notes.font = [UIFont fontWithName:@"Helvetica" size:18];
	FlagForCoverFlow=FALSE;
	FlagEvent=FALSE;
	coverFloWView = [[UIView alloc] init];
	libraryView = [[UIView alloc] init];
	scrl_Event.contentSize = CGSizeMake(700, 550);
	scrl_Event.scrollsToTop=YES;
	scrl_Event.scrollEnabled=FALSE;
	scrl_BusinessCard.contentSize = CGSizeMake(700, 850);
	scrl_BusinessCard.scrollsToTop=YES;
	scrl_BusinessCard.scrollEnabled=FALSE;
	selectedRow = -1;
	colorSelected = 1;
	
	/*******/
	//scrl_Invitation = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 780, 280)];
//	scrl_Invitation.contentSize = CGSizeMake(780, 100);
//	scrl_Invitation.showsVerticalScrollIndicator=YES;
//	scrl_Invitation.scrollEnabled=TRUE;
//	scrl_Invitation.backgroundColor = [UIColor redColor];
//	[eventView addSubview:scrl_Invitation];
	//jayna16121111.45
	/*[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(callLandScap) 
												 name:@"callLandScap"
											   object:nil];
	*/
	/*****/
	
	
	//jayna141211
	firstTime = TRUE;
	oncePort = FALSE;
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	appDel.fromTwitter = FALSE;
	NSString *strQuery = @"SELECT *FROM library";
	array_catagory = [DAL ExecuteArraySet:strQuery];
	[array_catagory retain];
	arrImg = [[NSMutableArray alloc]init];
		
	
	
	
	//jayna141211
	for(int i=0;i<[array_catagory count];i++)
	{
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
		NSLog(@"paths : %@",paths);
		NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
		//NSLog(@"documentsDirectory : %@",documentsDirectory);    
		NSString *newPath = documentsDirectory;
		[[NSFileManager defaultManager] createDirectoryAtPath:newPath withIntermediateDirectories:NO attributes:nil error:nil];
		
		
		if (![[NSFileManager defaultManager] fileExistsAtPath:newPath])
		{
			[[NSFileManager defaultManager] createDirectoryAtPath:newPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
		}
		
		NSString * strImage = [newPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[[array_catagory objectAtIndex:i] objectForKey:@"Image"]]];    
		UIImage *image1 = [UIImage imageWithContentsOfFile:strImage];
		[arrImg addObject:image1];
	}
	
		[[NSNotificationCenter defaultCenter] removeObserver:self name:@"didRotate" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(didRotate:) 
												 name:UIApplicationDidChangeStatusBarOrientationNotification
											   object:nil];
	
	
	//Jayna 131211
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(bg_ChangeTempColor) 
												 name:@"bg_ChangeTempColor"
											   object:nil];
	
	
	/// For image processing start
	ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal-White.png"];
	str_Flag_Gradient = @"Black";
	str_flagForAlignmentClick=@"Bottom";
	/// For image processing end
	
	//[self didRotate:nil];
	
	btnCreate = [UIButton buttonWithType:UIButtonTypeCustom];
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		btn_OpenCamera_UCD.frame = CGRectMake(570, 398, 47, 47);
		
		[btn_Event setBackgroundImage:[UIImage imageNamed:@"event-hover-p.png"] forState:UIControlStateNormal];
		[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard-p.png"] forState:UIControlStateNormal];
		[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation-p.png"] forState:UIControlStateNormal];
		[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge-p.png"] forState:UIControlStateNormal];
		[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo-p.png"] forState:UIControlStateNormal];
		[iv_SeperationLine setImage:[UIImage imageNamed:@"seperation-line-p.png"]];
		[iv_SeperationBorder setImage:[UIImage imageNamed:@"seperation-border-p.png"]];
		btnCreate.frame=CGRectMake(260, 700, 115, 57);//jayna1512113.05
		btn_Back.frame=CGRectMake(49, 5, 26, 30);
		coverFloWView.frame=CGRectMake(0, 0, 655, 600);
		if ([str_TM_SelectedItem isEqualToString:@"Event"]||[str_TM_SelectedItem isEqualToString:@"BusinessCard"]) {
			ivGradient.frame = CGRectMake(95, 182, 485, 140);
			tv_EventView.frame = CGRectMake(105, 187, 465, 130);
			lbl_EventTitleStatic.frame = CGRectMake(110, 200, 76, 21);
			lbl_EventTitle.frame = CGRectMake(186, 200, 165, 21);
			lbl_StartStatic.frame = CGRectMake(110, 230, 79, 21);
			lbl_Start.frame = CGRectMake(188, 230, 162, 21);
			lbl_EndStatic.frame = CGRectMake(110, 248, 74, 21);
			lbl_End.frame = CGRectMake(184, 248, 165, 21);
			lbl_NotesStatic.frame = CGRectMake(112, 285, 46, 21);
			//lbl_Notes.frame = CGRectMake(110, 300, 245, 21);
//			lbl_AddressStatic.frame = CGRectMake(360, 200, 66, 21);
//			lbl_Address.frame = CGRectMake(360, 223, 200, 100);
//			lbl_Address.numberOfLines=6;
			
			lbl_Notes.frame = CGRectMake(112, 288, 450, 63);
			CGSize maximumLabelSize = CGSizeMake(450,9999);
			CGSize expectedLabelSize = [lbl_Notes.text sizeWithFont:lbl_Notes.font constrainedToSize:maximumLabelSize lineBreakMode:lbl_Notes.lineBreakMode];
			CGRect newFrame = lbl_Notes.frame;
			newFrame.size.height = expectedLabelSize.height;
			lbl_Notes.frame = newFrame;
			lbl_Notes.numberOfLines=0; 
			lbl_AddressStatic.frame = CGRectMake(360, 185, 66, 21);
			lbl_Address.frame = CGRectMake(360, 188, 200, 120);
			CGSize maximumLabelSize2 = CGSizeMake(200,9999);
			CGSize expectedLabelSize2 = [lbl_Address.text sizeWithFont:lbl_Address.font constrainedToSize:maximumLabelSize2 lineBreakMode:lbl_Address.lineBreakMode];
			CGRect newFrame2 = lbl_Address.frame;
			newFrame2.size.height = expectedLabelSize2.height;
			lbl_Address.frame = newFrame2;
			lbl_Address.numberOfLines=0;
			
			////  14/12/2011 start
			//BusinessView Lables 
			lbl_CompanyStatic.frame = CGRectMake(110, 200, 76, 21);
			lbl_Company.frame = CGRectMake(180, 200, 165, 21);
			lbl_JobTitleStatic.frame = CGRectMake(110, 223, 79, 21);
			lbl_JobTitle.frame = CGRectMake(175, 223, 162, 21);
			lbl_NameStatic.frame = CGRectMake(110, 248, 74, 21);
			lbl_Name.frame = CGRectMake(155, 248, 190, 21);
			lbl_EmailStatic.frame = CGRectMake(110, 275, 46, 21);
			lbl_Email.frame = CGRectMake(155, 275, 190, 21);
			lbl_PhoneStatic.frame = CGRectMake(110, 300, 245, 21);
			lbl_Phone.frame = CGRectMake(160, 300, 190, 21);
			lbl_AddressStatic_BusinessCard.frame = CGRectMake(360, 200, 66, 21);
			//lbl_Address_BusinessCard.frame = CGRectMake(360, 223, 200, 100);
//			lbl_Address_BusinessCard.numberOfLines=6;
			
			lbl_Address_BusinessCard.frame = CGRectMake(360, 203, 200, 120);
			CGSize maximumLabelSize25 = CGSizeMake(200,9999);
			CGSize expectedLabelSize25 = [lbl_Address_BusinessCard.text sizeWithFont:lbl_Address_BusinessCard.font constrainedToSize:maximumLabelSize25 lineBreakMode:lbl_Address_BusinessCard.lineBreakMode];
			CGRect newFrame25 = lbl_Address_BusinessCard.frame;
			newFrame25.size.height = expectedLabelSize25.height;
			lbl_Address_BusinessCard.frame = newFrame25;
			lbl_Address_BusinessCard.numberOfLines=0;
			////  14/12/2011 start
			
		}
		else if ([str_TM_SelectedItem isEqualToString:@"Invitation"]||[str_TM_SelectedItem isEqualToString:@"IDBadge"] ){
		}
		else {
			ivGradient.frame = CGRectMake(95, 187, 485, 130);
			tv_EventView.frame = CGRectMake(105, 192, 465, 120);
		}
	}
	else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
			appDel.ori == UIInterfaceOrientationLandscapeRight)
	{
		btn_OpenCamera_UCD.frame = CGRectMake(640, 348, 47, 47);
		
		[btn_Event setBackgroundImage:[UIImage imageNamed:@"event-hover.png"] forState:UIControlStateNormal];
		[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard.png"] forState:UIControlStateNormal];
		[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation.png"] forState:UIControlStateNormal];
		[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge.png"] forState:UIControlStateNormal];
		[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo.png"] forState:UIControlStateNormal];
		btnCreate.frame=CGRectMake(330, 580, 115, 57);
		btn_Back.frame=CGRectMake(50, 5, 26, 30);
		coverFloWView.frame=CGRectMake(0, 0, 795, 500);
		[iv_SeperationLine setImage:[UIImage imageNamed:@"seperation-line-L.png"]];
		[iv_SeperationBorder setImage:[UIImage imageNamed:@"seperation-border-l.png"]];
		
		if ([str_TM_SelectedItem isEqualToString:@"Event"]||[str_TM_SelectedItem isEqualToString:@"BusinessCard"]) {
			ivGradient.frame = CGRectMake(155, 245, 485, 140);
			tv_EventView.frame = CGRectMake(165, 250, 465, 130);
			int x=60;
			lbl_EventTitleStatic.frame = CGRectMake(110+x, 200+x, 76, 21);
			lbl_EventTitle.frame = CGRectMake(186+x, 200+x, 165, 21);
			lbl_StartStatic.frame = CGRectMake(110+x, 230+x, 79, 21);
			lbl_Start.frame = CGRectMake(188+x, 230+x, 162, 21);
			lbl_EndStatic.frame = CGRectMake(110+x, 248+x, 74, 21);
			lbl_End.frame = CGRectMake(184+x, 248+x, 165, 21);
			lbl_NotesStatic.frame = CGRectMake(112+x, 285+x, 46, 21);
			//lbl_Notes.frame = CGRectMake(110+x, 300+x, 245, 21);
//			lbl_AddressStatic.frame = CGRectMake(360+x, 200+x, 66, 21);
//			lbl_Address.frame = CGRectMake(360+x, 223+x, 200, 100);
//			lbl_Address.numberOfLines=6;
			
			lbl_Notes.frame = CGRectMake(112+x, 288+x, 450, 63);
			CGSize maximumLabelSize = CGSizeMake(450,9999);
			CGSize expectedLabelSize = [lbl_Notes.text sizeWithFont:lbl_Notes.font constrainedToSize:maximumLabelSize lineBreakMode:lbl_Notes.lineBreakMode];
			CGRect newFrame = lbl_Notes.frame;
			newFrame.size.height = expectedLabelSize.height;
			lbl_Notes.frame = newFrame;
			
			lbl_AddressStatic.frame = CGRectMake(360+x, 185+x, 66, 21);
			lbl_Address.frame = CGRectMake(360+x, 188+x, 200, 120);
			CGSize maximumLabelSize2 = CGSizeMake(200,9999);
			CGSize expectedLabelSize2 = [lbl_Address.text sizeWithFont:lbl_Address.font constrainedToSize:maximumLabelSize2 lineBreakMode:lbl_Address.lineBreakMode];
			CGRect newFrame2 = lbl_Address.frame;
			newFrame2.size.height = expectedLabelSize2.height;
			lbl_Address.frame = newFrame2;
			lbl_Address.numberOfLines=0;
			
			////  14/12/2011 start
			//BusinessView Lables 
			lbl_CompanyStatic.frame = CGRectMake(110+x, 200+x, 76, 21);
			lbl_Company.frame = CGRectMake(180+x, 200+x, 165, 21);
			lbl_JobTitleStatic.frame = CGRectMake(110+x, 223+x, 79, 21);
			lbl_JobTitle.frame = CGRectMake(175+x, 223+x, 162, 21 );
			lbl_NameStatic.frame = CGRectMake(110+x, 248+x, 74, 21);
			lbl_Name.frame = CGRectMake(155+x, 248+x, 190, 21);
			lbl_EmailStatic.frame = CGRectMake(110+x, 275+x, 46, 21);
			lbl_Email.frame = CGRectMake(155+x, 275+x, 190, 21);
			lbl_PhoneStatic.frame = CGRectMake(110+x, 300+x, 245, 21);
			lbl_Phone.frame = CGRectMake(160+x, 300+x, 190, 21);
			lbl_AddressStatic_BusinessCard.frame = CGRectMake(360+x, 200+x, 66, 21);
			//lbl_Address_BusinessCard.frame = CGRectMake(360+x, 223+x, 200, 100);
//			lbl_Address_BusinessCard.numberOfLines=6;
			
			lbl_Address_BusinessCard.frame = CGRectMake(360+x, 203+x, 200, 120);
			CGSize maximumLabelSize26 = CGSizeMake(200,9999);
			CGSize expectedLabelSize26 = [lbl_Address_BusinessCard.text sizeWithFont:lbl_Address_BusinessCard.font constrainedToSize:maximumLabelSize26 lineBreakMode:lbl_Address_BusinessCard.lineBreakMode];
			CGRect newFrame26 = lbl_Address_BusinessCard.frame;
			newFrame26.size.height = expectedLabelSize26.height;
			lbl_Address_BusinessCard.frame = newFrame26;
			lbl_Address_BusinessCard.numberOfLines=0;
			////  14/12/2011 start
			
		}
		else if ([str_TM_SelectedItem isEqualToString:@"Invitation"]||[str_TM_SelectedItem isEqualToString:@"IDBadge"] ){
		}
		else {
			ivGradient.frame = CGRectMake(155, 255, 485, 130);
			tv_EventView.frame = CGRectMake(165, 260, 465, 120);
		}
	}
	//Open Flow integration
	[btnCreate setBackgroundImage:[UIImage imageNamed:@"choose.png"] forState:UIControlStateNormal];
	[btnCreate addTarget:self action:@selector(onCreateClick) forControlEvents:UIControlEventTouchUpInside];	
	[mainView addSubview:btnCreate];
	str_TM_SelectedItem = @"Event";
	eventView.hidden=TRUE;
	businessView.hidden=TRUE;
	invitationView.hidden=TRUE;
	idbadgeView.hidden=TRUE;
	courseinfoView.hidden=TRUE;
	imageProcessingView.hidden=TRUE;
	PreviewShareView.hidden=TRUE;
	barcodeView.hidden=TRUE;
	btn_Back.hidden=TRUE;
	btn_UDT.selected=TRUE;
	strFlag = @"UDT";
	flagForBackClick=FALSE;
	flagImgPrcsBack=FALSE;
	FlagForPhotoFromInvitation=FALSE;
	[btn_UDT setBackgroundImage:[UIImage imageNamed:@"UDT_Black.png"] forState:UIControlStateNormal];
	lbl_TemplateTitle.text = @"Use Designed Templates";
		
	ivLibrary = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 465, 290)];
	ivLibrary.center = CGPointMake(327, 300);
	ivLibrary.autoresizingMask = UIViewAutoresizingNone;
	ivLibrary.image = [UIImage imageNamed:@"Blank-bg.jpg"];
	[libraryView addSubview:ivLibrary];
	btn_OpenCamera_UCD.frame = CGRectMake(570, 398, 47, 47);
	[libraryView addSubview:btn_OpenCamera_UCD];
	//coverFloWView.backgroundColor=[UIColor blueColor];
	//libraryView.backgroundColor=[UIColor blackColor];
	
	ftbimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 755, 654, 56)];
	ftbimage.image = [UIImage imageNamed:@"_0000_portrait.png"];
	[PreviewShareView addSubview:ftbimage];
	
	//[self addCoverFlow];
	[mainView addSubview:coverFloWView];
	[mainView addSubview:libraryView];
	libraryView.hidden=TRUE;
	// CoverFlow implementation 
	UIImage *stetchLeftTrack = [[UIImage imageNamed:@"slidermin.png"]
								stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
	[slider setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
	[slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
	
	///////14/12/2011 start
	/// For image Processing View
	
		
	//for businessview
	lbl_Company.hidden=TRUE;
	lbl_CompanyStatic.hidden=TRUE;
	lbl_JobTitle.hidden=TRUE;
	lbl_JobTitleStatic.hidden=TRUE;
	lbl_Name.hidden=TRUE;
	lbl_NameStatic.hidden=TRUE;
	lbl_Email.hidden=TRUE;
	lbl_EmailStatic.hidden=TRUE;
	lbl_Phone.hidden=TRUE;
	lbl_PhoneStatic.hidden=TRUE;
	lbl_Address_BusinessCard.hidden=TRUE;
	lbl_AddressStatic_BusinessCard.hidden=TRUE;
	
	///////14/12/2011 start
	
	///15/12/2011 start
	// for course ifo view
	lbl_CourseName.hidden=TRUE;
	lbl_CourseNameStatic.hidden=TRUE;
	lbl_CourseCodeStatic.hidden=TRUE;
	lbl_CourseCode.hidden=TRUE;
	lbl_Professor.hidden=TRUE;
	lbl_ProfessorStatic.hidden=TRUE;
	lbl_DateTime.hidden=TRUE;
	lbl_DateTimeStatic.hidden=TRUE;
	
	
	//for invitationview;
	lbl_Title_Invitation.hidden=TRUE;
	lbl_TitleStatic_Invitation.hidden=TRUE;
	lbl_Address_Invitation.hidden=TRUE;
	lbl_AddressStatic_Invitation.hidden=TRUE;
	//15/12/2011 end
	
	// for idbadge view
	lbl_Company_IDBadge.hidden=TRUE;
	lbl_CompanyStatic_IDBadge.hidden=TRUE;
	lbl_NameStatic_IDBadge.hidden=TRUE;
	lbl_Name_IDBadge.hidden=TRUE;
	lbl_JobTitle_IDBadge.hidden=TRUE;
	lbl_JobTitleStatic_IDBadge.hidden=TRUE;
	
	///// For Add Gestures /////////
	longpressGestureEvent = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandler:)];
    longpressGestureEvent.minimumPressDuration = 1;
    [longpressGestureEvent setDelegate:self];
	[btn_Barcode_EventView addGestureRecognizer:longpressGestureEvent];
	[longpressGestureEvent release];
	
	longpressGestureBusiness = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandler:)];
    longpressGestureBusiness.minimumPressDuration = 1;
    [longpressGestureBusiness setDelegate:self];
	[btn_Barcode_BusinessView addGestureRecognizer:longpressGestureBusiness];
	[longpressGestureBusiness release];
	
	longpressGestureInvitation = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandler:)];
    longpressGestureInvitation.minimumPressDuration = 1;
    [longpressGestureInvitation setDelegate:self];
	[btn_Barcode_InvitationView addGestureRecognizer:longpressGestureInvitation];
	[longpressGestureInvitation release];
	
	longpressGestureIDBadge = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandler:)];
    longpressGestureIDBadge.minimumPressDuration = 1;
    [longpressGestureIDBadge setDelegate:self];
	[btn_Barcode_IDBadgeView addGestureRecognizer:longpressGestureIDBadge];
	[longpressGestureIDBadge release];
	
	longpressGestureCourseInfo = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandler:)];
    longpressGestureCourseInfo.minimumPressDuration = 1;
    [longpressGestureCourseInfo setDelegate:self];
	[btn_Barcode_CourseInfo addGestureRecognizer:longpressGestureCourseInfo];
	[longpressGestureCourseInfo release];
	activetxt = [[UITextField alloc]init];
	activetxtview=[[UITextView alloc]init];
	}
	else 
	{
			appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
		selectedRow = -1;
		arrCategory_iPhone = [[NSArray alloc] initWithObjects:@"Event",@"Business Cards",@"Invitation",
							  @"ID Badge",@"Course Info",nil];
		
		array_NormalImages = [[NSMutableArray alloc] initWithObjects:@"Event_iphoneNormal.png",@"BusinessCard_iphoneNormal.png",@"Invitation_iphone.png",@"IDBadge_iphoneNormal.png",@"CourseInfo_iphoneNormal.png",nil];
		array_SelectedImages = [[NSMutableArray alloc] initWithObjects:@"Event_IphoneSelected.png",@"BusinessCard_iphoneSelected.png",@"Invitation_iphoneSelected.png",@"IDBadge_iphoneSelected.png",@"CourseInfo_iphoneSelected.png",nil];
		

		
		
		NSLog(@"Template - Iphone");
	}
	
  //  [self didRotate:nil];
	//[self viewWillAppear:YES];


 }


- (void)longPressHandler:(UILongPressGestureRecognizer *)gestureRecognizer {
	//NSLog(@"longPressHandler");
	//if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure, you want to delete QR Code?" delegate:self  cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok",nil];
//		alert.tag = 1000;
//		[alert show];
//		[alert release];
//    }
	if(UIGestureRecognizerStateBegan == gestureRecognizer.state) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure, you want to delete QR Code?" delegate:self  cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok",nil];
		alert.tag = 1000;
		[alert show];
		[alert release];
    }
	
}
- (void)sliderAction:(id)sender
{
    // UISlider *slider = (UISlider *)sender;
   //  NSLog(@"sliderAction: value = %f", [slider value]);
	ivGradient.alpha=[slider value];
}
-(void)addCoverFlow
{ 
	txt_EventTitle.text=@"";
	txt_Address.text=@"";
	txt_Start.text=@"";
	txt_End.text=@"";
	txt_City.text=@"";
	txt_State.text=@"";
	txt_ZipCode.text=@"";
	txt_Country.text=@"";
	txt_CompanyName.text=@"";
	txt_Name.text=@"";
	txt_JobTitle.text=@"";
	txt_Email.text=@"";
	txt_Phone.text=@"";
	txt_Add.text=@"";
	txt_City_BusinessCard.text=@"";
	txt_State_BusinessCard.text=@"";
	txt_ZipCode_BusinessCard.text=@"";
	txt_Country_BusinessCard.text=@"";
	txt_Title_Invitation.text=@"";
	txt_Add_Invitation.text=@"";
	txt_City_Invitation.text=@"";
	txt_State_Invitation.text=@"";
	txt_ZipCode_Invitation.text=@"";
	txt_Country_Invitation.text=@"";
	if([vc retainCount] > 0)
	{
		[vc.view removeFromSuperview];
		[vc release];
		vc = nil;
	}
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		vc=[[coverflowshow alloc] initWithNibName:@"coverflowshow_iPad" bundle:nil _frame:CGRectMake(20, 0, 615, 700)];
	}
	else {
		vc=[[coverflowshow alloc] initWithNibName:@"coverflowshow_iPad" bundle:nil _frame:CGRectMake(20, 0, 755, 700)];
	}
	CGRect r = coverFloWView.frame;
	vc.view.frame = r;
	[coverFloWView addSubview:vc.view];
}
-(IBAction)onCreateClick
{
	
	if ([strFlag isEqualToString:@"UDT"]) {
	libraryView.hidden=TRUE;
	coverFloWView.hidden=TRUE;
	btn_Back.hidden=FALSE;
	
	if ([str_TM_SelectedItem isEqualToString:@"Event"]) {
		eventView.hidden=FALSE;
		lblNotes.hidden=FALSE;
		tv_Notes.text=@"";
		txt_EventTitle.text=@"";
		txt_Address.text=@"";
		txt_Start.text=@"";
		txt_End.text=@"";
		ivBarcode.image=[UIImage imageNamed:@"ivBackground.png"];
	}
	else if ([str_TM_SelectedItem isEqualToString:@"BusinessCard"]){
		businessView.hidden=FALSE;
		txt_CompanyName.text=@"";
		txt_Name.text=@"";
		txt_JobTitle.text=@"";
		txt_Email.text=@"";
		txt_Phone.text=@"";
		txt_Add.text=@"";
		ivBarcode_BusinessCard.image=[UIImage imageNamed:@"ivBackground.png"];
	}
	else if ([str_TM_SelectedItem isEqualToString:@"Invitation"]){
		invitationView.hidden=FALSE;
		txt_Title_Invitation.text=@"";
		txt_Add_Invitation.text=@"";
		ivBarcode_Invitation.image=[UIImage imageNamed:@"ivBackground.png"];
		ivPhoto_Invitation.image=[UIImage imageNamed:@"photoBachground.png"];
	}
	else if ([str_TM_SelectedItem isEqualToString:@"IDBadge"]){
		idbadgeView.hidden=FALSE;
		txt_Company_IDBadge.text=@"";
		txt_Name_IDBadge.text=@"";
		txt_JobTitle_IDBadge.text=@"";
		ivBarcode_IDBadge.image=[UIImage imageNamed:@"ivBackground.png"];
		ivPhoto_IDBadge.image=[UIImage imageNamed:@"photoBachground.png"];
	}
	else if ([str_TM_SelectedItem isEqualToString:@"CourseInfo"]){
		courseinfoView.hidden=FALSE;
		txt_CourseName.text=@"";
		txt_CourseCode.text=@"";
		txt_Professor.text=@"";
		txt_DateTime.text=@"";
		ivBarcode_CourseInfo.image=[UIImage imageNamed:@"ivBackground.png"];
	}
	}
	else {
		//jayna141211
		//if (!imageCopy) {
//			imageCopy = [UIImage imageNamed:@"ivBackground.png"];
//		}
//		[self saveToLibSection:imageCopy];
//		UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Suceess" message:@"Image is successfully saved into Library Section" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		[av show];
		strFlag = @"UCD";
		[self onCreateClick_ImageProcessing];
		[libraryView setHidden:YES];
		[mainView addSubview:PreviewShareView];
		btn_Back.hidden=FALSE;

	}
}
-(IBAction)onBackClick
{
	
	if ([strFlag isEqualToString:@"UCD"])
	{
		PreviewShareView.hidden=TRUE;
		btn_Back.hidden=TRUE;
		btn_Plus.hidden=TRUE;
		[self onClickUCD:nil];
	}
	else {
	FlagEvent=FALSE;
	if (!barcodeView.hidden) {
		barcodeView.hidden=TRUE;
	}
	else {

	if (flagImgPrcsBack==TRUE) {
		
		[PreviewShareView removeFromSuperview];
		btn_Plus.hidden=TRUE;
		
		flagImgPrcsBack=FALSE;
	}
	else {
	if (flagForBackClick==TRUE) {
		imageProcessingView.hidden=TRUE;
		flagForBackClick=FALSE;
	}
	else {
	if ([strFlag isEqualToString:@"UDT"]) {
		coverFloWView.hidden=FALSE;
		libraryView.hidden=TRUE;
	}
	else {
		coverFloWView.hidden=TRUE;
		libraryView.hidden=FALSE;
	}
	btn_Back.hidden=TRUE;
	if ([str_TM_SelectedItem isEqualToString:@"Event"]) {
		eventView.hidden=TRUE;
		[txt_EventTitle resignFirstResponder];
		[txt_Address resignFirstResponder];
		[tv_Notes resignFirstResponder];
	}
	else if ([str_TM_SelectedItem isEqualToString:@"BusinessCard"]){
		businessView.hidden=TRUE;
		[txt_CompanyName resignFirstResponder];
		[txt_Name resignFirstResponder];
		[txt_JobTitle resignFirstResponder];
		[txt_Email resignFirstResponder];
		[txt_Phone resignFirstResponder];
		[txt_Add resignFirstResponder];
	}
	else if ([str_TM_SelectedItem isEqualToString:@"Invitation"]){
		invitationView.hidden=TRUE;
		[txt_Title_Invitation resignFirstResponder];
		[txt_Add_Invitation resignFirstResponder];
	}
	else if ([str_TM_SelectedItem isEqualToString:@"IDBadge"]){
		idbadgeView.hidden=TRUE;
		[txt_Company_IDBadge resignFirstResponder];
		[txt_Name_IDBadge resignFirstResponder];
		[txt_JobTitle_IDBadge resignFirstResponder];
	}
	else if ([str_TM_SelectedItem isEqualToString:@"CourseInfo"]){
		appDel.mon=FALSE;
		appDel.tue=FALSE;
		appDel.wed=FALSE;
		appDel.thu=FALSE;
		appDel.fri=FALSE;
		appDel.sat=FALSE;
		appDel.sun=FALSE;
		appDel.strStartTime=@"";
		appDel.strEndTime=@"";
		courseinfoView.hidden=TRUE;
		[txt_CourseName resignFirstResponder];
		[txt_CourseCode resignFirstResponder];
		[txt_Professor resignFirstResponder];
		[txt_DateTime resignFirstResponder];
	}
		[self addCoverFlow];
	}
	}}
	}
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
	
	if(interfaceOrientation == UIInterfaceOrientationPortrait ||
	   interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
	{
		[self setFrameOrientation_Portrait];
		return YES;
	}
	else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation== UIInterfaceOrientationLandscapeRight)
	{
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

- (void) didRotate:(NSNotification *)notification
{	
	
	[activetxt resignFirstResponder];
	[activetxtview resignFirstResponder];
	[self dismissPopover];
	[self dismissdatePopOver];
	appDel.fromTwitter = FALSE;
	[tbl_Barcode reloadData];
	if ([str_TM_SelectedItem isEqualToString:@"Event"]) {
		if(appDel.ori == UIInterfaceOrientationPortrait ||
		   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
		{
			[btn_Event setBackgroundImage:[UIImage imageNamed:@"event-hover-p.png"] forState:UIControlStateNormal];
			[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard-p.png"] forState:UIControlStateNormal];
			[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation-p.png"] forState:UIControlStateNormal];
			[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge-p.png"] forState:UIControlStateNormal];
			[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo-p.png"] forState:UIControlStateNormal];
			
		}
		else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
				appDel.ori == UIInterfaceOrientationLandscapeRight)
		{
			[btn_Event setBackgroundImage:[UIImage imageNamed:@"event-hover.png"] forState:UIControlStateNormal];
			[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard.png"] forState:UIControlStateNormal];
			[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation.png"] forState:UIControlStateNormal];
			[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge.png"] forState:UIControlStateNormal];
			[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo.png"] forState:UIControlStateNormal];
		}
	}
	else if ([str_TM_SelectedItem isEqualToString:@"BusinessCard"]){
		if(appDel.ori == UIInterfaceOrientationPortrait ||
		   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
		{
			[btn_Event setBackgroundImage:[UIImage imageNamed:@"event-p.png"] forState:UIControlStateNormal];
			[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard-hover-p.png"] forState:UIControlStateNormal];
			[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation-p.png"] forState:UIControlStateNormal];
			[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge-p.png"] forState:UIControlStateNormal];
			[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo-p.png"] forState:UIControlStateNormal];
			
		}
		else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
				appDel.ori == UIInterfaceOrientationLandscapeRight)
		{
			[btn_Event setBackgroundImage:[UIImage imageNamed:@"event.png"] forState:UIControlStateNormal];
			[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard-hover.png"] forState:UIControlStateNormal];
			[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation.png"] forState:UIControlStateNormal];
			[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge.png"] forState:UIControlStateNormal];
			[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo.png"] forState:UIControlStateNormal];
		}
	}
	else if ([str_TM_SelectedItem isEqualToString:@"Invitation"]){
		if(appDel.ori == UIInterfaceOrientationPortrait ||
		   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
		{
			[btn_Event setBackgroundImage:[UIImage imageNamed:@"event-p.png"] forState:UIControlStateNormal];
			[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard-p.png"] forState:UIControlStateNormal];
			[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation-hover-p.png"] forState:UIControlStateNormal];
			[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge-p.png"] forState:UIControlStateNormal];
			[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo-p.png"] forState:UIControlStateNormal];
			
		}
		else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
				appDel.ori == UIInterfaceOrientationLandscapeRight)
		{
			[btn_Event setBackgroundImage:[UIImage imageNamed:@"event.png"] forState:UIControlStateNormal];
			[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard.png"] forState:UIControlStateNormal];
			[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation-hover.png"] forState:UIControlStateNormal];
			[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge.png"] forState:UIControlStateNormal];
			[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo.png"] forState:UIControlStateNormal];
		}
	}
	else if ([str_TM_SelectedItem isEqualToString:@"IDBadge"]){
		if(appDel.ori == UIInterfaceOrientationPortrait ||
		   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
		{
			[btn_Event setBackgroundImage:[UIImage imageNamed:@"event-p.png"] forState:UIControlStateNormal];
			[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard-p.png"] forState:UIControlStateNormal];
			[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation-p.png"] forState:UIControlStateNormal];
			[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge-hover-p.png"] forState:UIControlStateNormal];
			[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo-p.png"] forState:UIControlStateNormal];
			
		}
		else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
				appDel.ori == UIInterfaceOrientationLandscapeRight)
		{
			[btn_Event setBackgroundImage:[UIImage imageNamed:@"event.png"] forState:UIControlStateNormal];
			[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard.png"] forState:UIControlStateNormal];
			[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation.png"] forState:UIControlStateNormal];
			[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge-hover.png"] forState:UIControlStateNormal];
			[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo.png"] forState:UIControlStateNormal];
		}
	}
	else if ([str_TM_SelectedItem isEqualToString:@"CourseInfo"]){
		if(appDel.ori == UIInterfaceOrientationPortrait ||
		   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
		{
			[btn_Event setBackgroundImage:[UIImage imageNamed:@"event-p.png"] forState:UIControlStateNormal];
			[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard-p.png"] forState:UIControlStateNormal];
			[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation-p.png"] forState:UIControlStateNormal];
			[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge-p.png"] forState:UIControlStateNormal];
			[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"course-hover-p.png"] forState:UIControlStateNormal];
			
		}
		else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
				appDel.ori == UIInterfaceOrientationLandscapeRight)
		{
			[btn_Event setBackgroundImage:[UIImage imageNamed:@"event.png"] forState:UIControlStateNormal];
			[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard.png"] forState:UIControlStateNormal];
			[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation.png"] forState:UIControlStateNormal];
			[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge.png"] forState:UIControlStateNormal];
			[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"course-hover.png"] forState:UIControlStateNormal];
		}
	}
	
	
	if(appDel.ori == 0)
		appDel.ori = [[UIDevice currentDevice] orientation];
	
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{		
		[self setFrameOrientation_Portrait];
	}
	else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
			appDel.ori == UIInterfaceOrientationLandscapeRight)
	{		
		[self setFrameOrientation_LandScap];
	}
}
//jayna16121111.45
-(void)callLandScap
{
	firstTime = TRUE;
	oncePort = FALSE;
	[self setFrameOrientation_LandScap];
	
}

-(void)setFrameOrientation_Portrait
{
	scrl_Event.scrollEnabled=FALSE;
	scrl_BusinessCard.scrollEnabled=FALSE;
	ivBarcode_BusinessCard.frame = CGRectMake(266, 508, 128, 128);
	btn_Barcode_BusinessView.frame = CGRectMake(266, 508, 128, 128);
	
	ivAddressBackGround.image = [UIImage imageNamed:@"eventaddressbox.png"];
	ivAddressBackGround.frame = CGRectMake(21, 162, 616, 202);
	ivAddressBackGround_Invitation.image = [UIImage imageNamed:@"eventaddressbox.png"];
	ivAddressBackGround_Invitation.frame = CGRectMake(21, 76, 616, 202);
	//if(firstTime == TRUE)
//	{
//		ivBarcode_IDBadge.frame = CGRectMake(186, 200, 137, 137);
//		btn_Barcode_IDBadgeView.frame = CGRectMake(186, 200, 137, 137);
//		ivPhoto_IDBadge.frame = CGRectMake(331, 200, 137, 137);
//		btn_ivPhoto_IDBadge.frame = CGRectMake(331, 200, 137, 137);
//		ivBarcode_Invitation.frame = CGRectMake(186, 305, 138, 138);//230
//		btn_Barcode_InvitationView.frame = CGRectMake(186, 305, 138, 138);
//		ivPhoto_Invitation.frame =  CGRectMake(331, 305, 138, 138);//420
//		btn_Barcode_Invitation.frame =  CGRectMake(331, 305, 138, 138);
//		
//	}
//	else {
//		ivBarcode_IDBadge.frame = CGRectMake(234, 200, 137, 137);
//		btn_Barcode_IDBadgeView.frame = CGRectMake(234, 200, 137, 137);
//		ivPhoto_IDBadge.frame = CGRectMake(421, 200, 137, 137);
//		btn_ivPhoto_IDBadge.frame = CGRectMake(421, 200, 137, 137);
//		ivBarcode_Invitation.frame = CGRectMake(230, 305, 138, 138);
//		btn_Barcode_InvitationView.frame = CGRectMake(230, 305, 138, 138);
//		//btn_Barcode_Invitation.frame = CGRectMake(377, 305, 138, 138);
//		ivPhoto_Invitation.frame =  CGRectMake(420, 305, 138, 138);
//		btn_Barcode_Invitation.frame =  CGRectMake(420, 305, 138, 138);
//		btn_Continue_BarcodeView.frame = CGRectMake(330, 640, 137, 52);
//		if(oncePort == FALSE)
//		{
//			btn_Continue_BarcodeView.frame = CGRectMake(330, 640, 137, 52);
//		}
//		
//	}
	//if(oncePort == TRUE)
//	{
		btn_Continue_BarcodeView.frame = CGRectMake(330, 640, 137, 52);
	//}
//	else {
//		//btn_Continue_BarcodeView.frame = CGRectMake(262, 640, 137, 52);
//	}
	
	FlagForCoverFlow=TRUE;    
	//for coverflow set frame
	[vc setFrame:CGRectMake(0, 0, 655, 600)];
	btn_OpenCamera_UCD.frame = CGRectMake(570, 398, 47, 47);
	//jayna141211
	oncePort = TRUE;
	firstTime = FALSE;
	
	int width = 130;
	Topimage.image=[UIImage imageNamed:@"_0009_top-red-band.png"];
	Topimage.frame=CGRectMake(0,0,768,48);
	btn_UDT.frame=CGRectMake(0, 967, 345, 37);
	btn_UCD.frame=CGRectMake(345, 967, 344, 37);
	mainView.frame=CGRectMake(33, 40, 655, 800);
	imageProcessingView.frame=CGRectMake(33, 40, 655, 800);
	PreviewShareView.frame=CGRectMake(33, 40, 655, 800);
	//imgtemplate.frame = CGRectMake(110, 430, 453, 425);
	imgtemplate.frame = CGRectMake(90, 37,ivMainImage.frame.size.width,290);
	coverFloWView.frame=CGRectMake(0, 0, 655, 600);
 	//vc.view.frame =  CGRectMake(0, 0, 655, 600);
	libraryView.frame=CGRectMake(0, 0, 655, 600);
	ivLibrary.center = CGPointMake(327, 300);
	eventView.frame=CGRectMake(33, 40, 655, 800);
	barcodeView.frame=CGRectMake(33, 40, 655, 800);
	btnCreate.frame=CGRectMake(270, 700, 115, 57);
	btn_Back.frame=CGRectMake(49, 5, 26, 30);
	businessView.frame=CGRectMake(33, 40, 655, 800);
	invitationView.frame=CGRectMake(33, 40, 655, 800);
	idbadgeView.frame=CGRectMake(33, 40, 655, 800);
	courseinfoView.frame=CGRectMake(33, 40, 655, 800);
	
	btn_Event.frame=CGRectMake(34, 848, width+1, 119);
	btn_BusinessCard.frame=CGRectMake(width+35, 848, width+1, 119);
	
	btn_Invitation.frame=CGRectMake(width*2+37, 848, width+1, 119);
	btn_IDBadge.frame=CGRectMake(width*3+38, 848, width, 119);
	btn_ContactInfo.frame=CGRectMake(width*4+38, 848, width+5, 119);
	
	iv_SeperationLine.frame=CGRectMake(165, 847, 394, 119);
	iv_SeperationBorder.frame=CGRectMake(34, 844, 654, 124);
	[iv_SeperationLine setImage:[UIImage imageNamed:@"seperation-line-p.png"]];
	[iv_SeperationBorder setImage:[UIImage imageNamed:@"seperation-border-p.png"]];
	
	
	//For image processing view
	ivMainImage.frame=CGRectMake(90, 37, 495, 290);
	colorView.frame=CGRectMake(90, 37, 495, 290);
	btn_ColorPicker.frame=CGRectMake(590, 230, 47, 47);
	btn_OpenCamera.frame=CGRectMake(590, 280, 47, 47);
	iv_photoLibImg.frame = ivMainImage.frame;
	//iv_photoLibImg.frame = CGRectMake(ivMainImage.frame.origin.x+495-90, ivMainImage.frame.origin.y+290-90, 70, 70);
	ivAlignment.frame=CGRectMake(181, 338, 299, 116);
	btn_Bottom.frame=CGRectMake(200, 390, 55, 36);
	btn_Top.frame=CGRectMake(268, 390, 55, 36);
	btn_Left.frame=CGRectMake(337, 390, 55, 36);
	btn_Right.frame=CGRectMake(406, 390, 55, 36);
	ivColor.frame=CGRectMake(250, 462, 167, 116);
	btn_White.frame=CGRectMake(268, 510, 55, 36);
	btn_Black.frame=CGRectMake(342, 510, 55, 36);
	
	ivTransparency.frame=CGRectMake(210, 587, 246, 116);
	slider.frame=CGRectMake(222, 640, 220, 23);
	btn_Create_ImageProcessing.frame=CGRectMake(270, 740, 115, 57);
	/*[btn_Event setBackgroundImage:[UIImage imageNamed:@"event-hover-p.png"] forState:UIControlStateNormal];
	[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard-p.png"] forState:UIControlStateNormal];
	[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation-p.png"] forState:UIControlStateNormal];
	[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge-p.png"] forState:UIControlStateNormal];
	[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo-p.png"] forState:UIControlStateNormal];
	*/
	if (!coverFloWView.hidden) {
		[self addCoverFlow];
	}
	
    
	
	//for image processing
	if ([str_flagForAlignmentClick isEqualToString:@"Left"]) {
		if ([str_Flag_Gradient isEqualToString:@"Black"]) {
			ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical-White.png"];
		}
		else {
			ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical.png"];
		}
		ivGradient.frame = CGRectMake(95, 42, 260, 280);
		tv_EventView.frame = CGRectMake(105, 47, 240, 270);
		int y=140;
		
		if ([str_TM_SelectedItem isEqualToString:@"Invitation"]||[str_TM_SelectedItem isEqualToString:@"IDBadge"] )
		{
			
			barCodeImgView.frame = CGRectMake(410, 75, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(410, 75, 100, 100);
			//jayna1512116.18
			imgInvitation.frame = CGRectMake(410, 75+100+10, 100, 100);
			
		}
		else {
			barCodeImgView.frame = CGRectMake(420, 120, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(420, 120, 100, 100);
		}
		
		lbl_EventTitleStatic.frame = CGRectMake(110, 200-y, 76, 21);
		lbl_EventTitle.frame = CGRectMake(186, 200-y, 165, 21);
		lbl_StartStatic.frame = CGRectMake(110, 230-y, 79, 21);
		lbl_Start.frame = CGRectMake(188, 230-y, 162, 21);
		lbl_EndStatic.frame = CGRectMake(110, 248-y, 74, 21);
		lbl_End.frame = CGRectMake(184, 248-y, 165, 21);
		lbl_NotesStatic.frame = CGRectMake(112, 278-y, 46, 21);
		//lbl_Notes.frame = CGRectMake(110, 300-y, 245, 21);
//		lbl_AddressStatic.frame = CGRectMake(110, 330-y, 66, 21);
//		lbl_Address.frame = CGRectMake(110, 353-y, 245, 100); 
//		lbl_Address.numberOfLines=6;
		
		lbl_Notes.frame = CGRectMake(112, 281-y, 245, 63);
		CGSize maximumLabelSize = CGSizeMake(245,9999);
		CGSize expectedLabelSize = [lbl_Notes.text sizeWithFont:lbl_Notes.font constrainedToSize:maximumLabelSize lineBreakMode:lbl_Notes.lineBreakMode];
		CGRect newFrame = lbl_Notes.frame;
		newFrame.size.height = expectedLabelSize.height;
		lbl_Notes.frame = newFrame;
		lbl_Notes.numberOfLines=0; 
		lbl_AddressStatic.frame = CGRectMake(112, 345-y, 66, 21);
		lbl_Address.frame = CGRectMake(112, 358-y, 200, 120);
		CGSize maximumLabelSize2 = CGSizeMake(200,9999);
		CGSize expectedLabelSize2 = [lbl_Address.text sizeWithFont:lbl_Address.font constrainedToSize:maximumLabelSize2 lineBreakMode:lbl_Address.lineBreakMode];
		CGRect newFrame2 = lbl_Address.frame;
		newFrame2.size.height = expectedLabelSize2.height;
		lbl_Address.frame = newFrame2;
		lbl_Address.numberOfLines=0;
		
		
		////  14/12/2011 start
		//BusinessView Lables 
		lbl_CompanyStatic.frame = CGRectMake(110, 200-y, 76, 21);
		lbl_Company.frame = CGRectMake(180, 200-y, 165, 21);
		lbl_JobTitleStatic.frame = CGRectMake(110, 223-y, 79, 21);
		lbl_JobTitle.frame = CGRectMake(175, 223-y, 162, 21);
		lbl_NameStatic.frame = CGRectMake(110, 248-y, 74, 21);
		lbl_Name.frame = CGRectMake(155, 248-y, 190, 21);
		lbl_EmailStatic.frame = CGRectMake(110, 275-y, 46, 21);
		lbl_Email.frame = CGRectMake(155, 275-y, 190, 21);
		lbl_PhoneStatic.frame = CGRectMake(110, 300-y, 245, 21);
		lbl_Phone.frame = CGRectMake(160, 300-y, 190, 21);
		lbl_AddressStatic_BusinessCard.frame = CGRectMake(110, 330-y, 66, 21);
		//lbl_Address_BusinessCard.frame = CGRectMake(110, 353-y, 237, 100);
//		lbl_Address_BusinessCard.numberOfLines=6;
		
		lbl_Address_BusinessCard.frame = CGRectMake(110, 333-y, 200, 120);
		CGSize maximumLabelSize12 = CGSizeMake(200,9999);
		CGSize expectedLabelSize12 = [lbl_Address_BusinessCard.text sizeWithFont:lbl_Address_BusinessCard.font constrainedToSize:maximumLabelSize12 lineBreakMode:lbl_Address_BusinessCard.lineBreakMode];
		CGRect newFrame12 = lbl_Address_BusinessCard.frame;
		newFrame12.size.height = expectedLabelSize12.height;
		lbl_Address_BusinessCard.frame = newFrame12;
		lbl_Address_BusinessCard.numberOfLines=0;
		////  14/12/2011 start
		
		/////15/12/2011 start
		//for course info
		int k=-65;
		lbl_CourseNameStatic.frame = CGRectMake(110, 200-y-k, 100, 21);
		lbl_CourseName.frame = CGRectMake(204, 200-y-k, 140, 21);
		lbl_CourseCodeStatic.frame = CGRectMake(110, 223-y-k, 100, 21);
		lbl_CourseCode.frame = CGRectMake(202, 223-y-k, 140, 21);
		lbl_ProfessorStatic.frame = CGRectMake(110, 248-y-k, 72, 21);
		lbl_Professor.frame = CGRectMake(181, 248-y-k, 140, 21);
		lbl_DateTimeStatic.frame = CGRectMake(110, 275-y-k, 100, 21);
		lbl_DateTime.frame = CGRectMake(212, 275-y-k, 140, 21);
		/////15/12/2011  end
		
		
		
		int zx=40;
		//for invitationview
		lbl_TitleStatic_Invitation.frame = CGRectMake(150-zx, 210-y-k, 76, 21);
		lbl_Title_Invitation.frame = CGRectMake(186-zx, 210-y-k, 230, 21);
		lbl_AddressStatic_Invitation.frame = CGRectMake(150-zx, 240-y-k, 76, 21);
		lbl_Address_Invitation.frame = CGRectMake(150-zx, 243-y-k, 180, 21);
		CGSize maximumLabelSize125 = CGSizeMake(180,9999);
		CGSize expectedLabelSize125 = [lbl_Address_Invitation.text sizeWithFont:lbl_Address_Invitation.font constrainedToSize:maximumLabelSize125 lineBreakMode:lbl_Address_Invitation.lineBreakMode];
		CGRect newFrame125 = lbl_Address_Invitation.frame;
		newFrame125.size.height = expectedLabelSize125.height;
		lbl_Address_Invitation.frame = newFrame125;
		lbl_Address_Invitation.numberOfLines=0;
		
		//for idbadge view
		lbl_CompanyStatic_IDBadge.frame = CGRectMake(150-zx, 210-y-k, 110, 21);
		lbl_Company_IDBadge.frame = CGRectMake(258-zx, 210-y-k, 135, 21);
		lbl_NameStatic_IDBadge.frame = CGRectMake(150-zx, 240-y-k, 76, 21);
		lbl_Name_IDBadge.frame = CGRectMake(195-zx, 240-y-k, 180, 21);
		lbl_JobTitleStatic_IDBadge.frame = CGRectMake(150-zx, 270-y-k, 100, 21);
		lbl_JobTitle_IDBadge.frame = CGRectMake(214-zx, 270-y-k, 170, 21);
	}
	else if ([str_flagForAlignmentClick isEqualToString:@"Right"]) {
		//ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical.png"];
		if ([str_Flag_Gradient isEqualToString:@"Black"]) {
			ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical-White.png"];
		}
		else {
			ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical.png"];
		}
		ivGradient.frame = CGRectMake(320, 42, 260, 280);
		tv_EventView.frame = CGRectMake(330, 47, 240, 270);
		int y=140,x=225;
		
		
		lbl_EventTitleStatic.frame = CGRectMake(110+x, 200-y, 76, 21);
		lbl_EventTitle.frame = CGRectMake(186+x, 200-y, 165, 21);
		lbl_StartStatic.frame = CGRectMake(110+x, 230-y, 79, 21);
		lbl_Start.frame = CGRectMake(188+x, 230-y, 162, 21);
		lbl_EndStatic.frame = CGRectMake(110+x, 248-y, 74, 21);
		lbl_End.frame = CGRectMake(184+x, 248-y, 165, 21);
		lbl_NotesStatic.frame = CGRectMake(112+x, 278-y, 46, 21);
		//lbl_Notes.frame = CGRectMake(110+x, 300-y, 245, 21);
//		lbl_AddressStatic.frame = CGRectMake(110+x, 330-y, 66, 21);
//		lbl_Address.frame = CGRectMake(110+x, 353-y, 245, 100);
//		lbl_Address.numberOfLines=6;
		
		lbl_Notes.frame = CGRectMake(112+x, 281-y, 245, 63);
		CGSize maximumLabelSize = CGSizeMake(245,9999);
		CGSize expectedLabelSize = [lbl_Notes.text sizeWithFont:lbl_Notes.font constrainedToSize:maximumLabelSize lineBreakMode:lbl_Notes.lineBreakMode];
		CGRect newFrame = lbl_Notes.frame;
		newFrame.size.height = expectedLabelSize.height;
		lbl_Notes.frame = newFrame;
		lbl_Notes.numberOfLines=0; 
		lbl_AddressStatic.frame = CGRectMake(112+x, 345-y, 66, 21);
		lbl_Address.frame = CGRectMake(112+x, 358-y, 200, 120);
		CGSize maximumLabelSize2 = CGSizeMake(200,9999);
		CGSize expectedLabelSize2 = [lbl_Address.text sizeWithFont:lbl_Address.font constrainedToSize:maximumLabelSize2 lineBreakMode:lbl_Address.lineBreakMode];
		CGRect newFrame2 = lbl_Address.frame;
		newFrame2.size.height = expectedLabelSize2.height;
		lbl_Address.frame = newFrame2;
		lbl_Address.numberOfLines=0;
		
		if ([str_TM_SelectedItem isEqualToString:@"Invitation"]||[str_TM_SelectedItem isEqualToString:@"IDBadge"] )
		{
			
			barCodeImgView.frame = CGRectMake(160, 75, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(160, 75, 100, 100);
			//jayna1512116.18
			imgInvitation.frame = CGRectMake(160, 75+100+10, 100, 100);
			
		}
		else {
			barCodeImgView.frame = CGRectMake(150, 120, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(150, 120, 100, 100);
		}
		
		////  14/12/2011 start
		//BusinessView Lables 
		lbl_CompanyStatic.frame = CGRectMake(110+x, 200-y, 76, 21);
		lbl_Company.frame = CGRectMake(180+x, 200-y, 165, 21);
		lbl_JobTitleStatic.frame = CGRectMake(110+x, 223-y, 79, 21);
		lbl_JobTitle.frame = CGRectMake(175+x, 223-y, 162, 21);
		lbl_NameStatic.frame = CGRectMake(110+x, 248-y, 74, 21);
		lbl_Name.frame = CGRectMake(155+x, 248-y, 190, 21);
		lbl_EmailStatic.frame = CGRectMake(110+x, 275-y, 46, 21);
		lbl_Email.frame = CGRectMake(155+x, 275-y, 190, 21);
		lbl_PhoneStatic.frame = CGRectMake(110+x, 300-y, 245, 21);
		lbl_Phone.frame = CGRectMake(160+x, 300-y, 190, 21);
		lbl_AddressStatic_BusinessCard.frame = CGRectMake(110+x, 330-y, 66, 21);
		//lbl_Address_BusinessCard.frame = CGRectMake(110+x, 353-y, 237, 100);
//		lbl_Address_BusinessCard.numberOfLines=6;
		
		lbl_Address_BusinessCard.frame = CGRectMake(110+x, 333-y, 200, 120);
		CGSize maximumLabelSize23 = CGSizeMake(200,9999);
		CGSize expectedLabelSize23 = [lbl_Address_BusinessCard.text sizeWithFont:lbl_Address_BusinessCard.font constrainedToSize:maximumLabelSize23 lineBreakMode:lbl_Address_BusinessCard.lineBreakMode];
		CGRect newFrame23 = lbl_Address_BusinessCard.frame;
		newFrame23.size.height = expectedLabelSize23.height;
		lbl_Address_BusinessCard.frame = newFrame23;
		lbl_Address_BusinessCard.numberOfLines=0;
		////  14/12/2011 start
		
		/////15/12/2011 start
		//for course info
		int k=-65;
		lbl_CourseNameStatic.frame = CGRectMake(110+x, 200-y-k, 100, 21);
		lbl_CourseName.frame = CGRectMake(204+x, 200-y-k, 140, 21);
		lbl_CourseCodeStatic.frame = CGRectMake(110+x, 223-y-k, 100, 21);
		lbl_CourseCode.frame = CGRectMake(202+x, 223-y-k, 140, 21);
		lbl_ProfessorStatic.frame = CGRectMake(110+x, 248-y-k, 72, 21);
		lbl_Professor.frame = CGRectMake(181+x, 248-y-k, 140, 21);
		lbl_DateTimeStatic.frame = CGRectMake(110+x, 275-y-k, 100, 21);
		lbl_DateTime.frame = CGRectMake(212+x, 275-y-k, 140, 21);
		/////15/12/2011  end
		
		//for invitationView
		int zx=40;
		//for invitationview
		lbl_TitleStatic_Invitation.frame = CGRectMake(150+x-zx, 210-y-k, 76, 21);
		lbl_Title_Invitation.frame = CGRectMake(186+x-zx, 210-y-k, 230, 21);
		lbl_AddressStatic_Invitation.frame = CGRectMake(150+x-zx, 240-y-k, 76, 21);
		lbl_Address_Invitation.frame = CGRectMake(150+x-zx, 243-y-k, 180, 21);
		CGSize maximumLabelSize125 = CGSizeMake(180,9999);
		CGSize expectedLabelSize125 = [lbl_Address_Invitation.text sizeWithFont:lbl_Address_Invitation.font constrainedToSize:maximumLabelSize125 lineBreakMode:lbl_Address_Invitation.lineBreakMode];
		CGRect newFrame125 = lbl_Address_Invitation.frame;
		newFrame125.size.height = expectedLabelSize125.height;
		lbl_Address_Invitation.frame = newFrame125;
		lbl_Address_Invitation.numberOfLines=0;
		
		//for idbadge view
		lbl_CompanyStatic_IDBadge.frame = CGRectMake(150+x-zx, 210-y-k, 110, 21);
		lbl_Company_IDBadge.frame = CGRectMake(258+x-zx, 210-y-k, 135, 21);
		lbl_NameStatic_IDBadge.frame = CGRectMake(150+x-zx, 240-y-k, 76, 21);
		lbl_Name_IDBadge.frame = CGRectMake(195+x-zx, 240-y-k, 180, 21);
		lbl_JobTitleStatic_IDBadge.frame = CGRectMake(150+x-zx, 270-y-k, 100, 21);
		lbl_JobTitle_IDBadge.frame = CGRectMake(214+x-zx, 270-y-k, 170, 21);
		
	}
	else if ([str_flagForAlignmentClick isEqualToString:@"Top"]) {
		//ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal.png"];
		if ([str_Flag_Gradient isEqualToString:@"Black"]) {
			ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal-White.png"];
		}
		else {
			ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal.png"];
		}
		int y=140;
		if ([str_TM_SelectedItem isEqualToString:@"Event"]||[str_TM_SelectedItem isEqualToString:@"BusinessCard"]) {
			ivGradient.frame = CGRectMake(95, 42, 485, 145);
			tv_EventView.frame = CGRectMake(105, 47, 465, 135);
			lbl_EventTitleStatic.frame = CGRectMake(110, 200-y, 76, 21);
			lbl_EventTitle.frame = CGRectMake(186, 200-y, 165, 21);
			lbl_StartStatic.frame = CGRectMake(110, 230-y, 79, 21);
			lbl_Start.frame = CGRectMake(188, 230-y, 162, 21);
			lbl_EndStatic.frame = CGRectMake(110, 248-y, 74, 21);
			lbl_End.frame = CGRectMake(184, 248-y, 165, 21);
			lbl_NotesStatic.frame = CGRectMake(112, 285-y, 46, 21);
			//lbl_Notes.frame = CGRectMake(110, 300-y, 245, 21);
//			lbl_AddressStatic.frame = CGRectMake(360, 200-y, 66, 21);
//			lbl_Address.frame = CGRectMake(360, 223-y, 200, 100);
//			lbl_Address.numberOfLines=6;
			
			lbl_Notes.frame = CGRectMake(112, 288-y, 450, 63);
			CGSize maximumLabelSize = CGSizeMake(450,9999);
			CGSize expectedLabelSize = [lbl_Notes.text sizeWithFont:lbl_Notes.font constrainedToSize:maximumLabelSize lineBreakMode:lbl_Notes.lineBreakMode];
			CGRect newFrame = lbl_Notes.frame;
			newFrame.size.height = expectedLabelSize.height;
			lbl_Notes.frame = newFrame;
			lbl_Notes.numberOfLines=0; 
			lbl_AddressStatic.frame = CGRectMake(360, 200-y, 66, 21);
			lbl_Address.frame = CGRectMake(360, 203-y, 200, 120);
			CGSize maximumLabelSize2 = CGSizeMake(200,9999);
			CGSize expectedLabelSize2 = [lbl_Address.text sizeWithFont:lbl_Address.font constrainedToSize:maximumLabelSize2 lineBreakMode:lbl_Address.lineBreakMode];
			CGRect newFrame2 = lbl_Address.frame;
			newFrame2.size.height = expectedLabelSize2.height;
			lbl_Address.frame = newFrame2;
			lbl_Address.numberOfLines=0;
			
			barCodeImgView.frame = CGRectMake(290, 205, 100, 100);//Jayna131211
			btn_Barcode_ImageProcessingView.frame = CGRectMake(290, 205, 100, 100);
			
			////  14/12/2011 start
			//BusinessView Lables 
			lbl_CompanyStatic.frame = CGRectMake(110, 200-y, 76, 21);
			lbl_Company.frame = CGRectMake(180, 200-y, 165, 21);
			lbl_JobTitleStatic.frame = CGRectMake(110, 223-y, 79, 21);
			lbl_JobTitle.frame = CGRectMake(175, 223-y, 162, 21);
			lbl_NameStatic.frame = CGRectMake(110, 248-y, 74, 21);
			lbl_Name.frame = CGRectMake(155, 248-y, 190, 21);
			lbl_EmailStatic.frame = CGRectMake(110, 275-y, 46, 21);
			lbl_Email.frame = CGRectMake(155, 275-y, 190, 21);
			lbl_PhoneStatic.frame = CGRectMake(110, 300-y, 245, 21);
			lbl_Phone.frame = CGRectMake(160, 300-y, 190, 21);
			lbl_AddressStatic_BusinessCard.frame = CGRectMake(360, 200-y, 66, 21);
			//lbl_Address_BusinessCard.frame = CGRectMake(360, 223-y, 200, 100);
//			lbl_Address_BusinessCard.numberOfLines=6;
			
			lbl_Address_BusinessCard.frame = CGRectMake(360, 203-y, 200, 120);
			CGSize maximumLabelSize2345 = CGSizeMake(200,9999);
			CGSize expectedLabelSize2345 = [lbl_Address_BusinessCard.text sizeWithFont:lbl_Address_BusinessCard.font constrainedToSize:maximumLabelSize2345 lineBreakMode:lbl_Address_BusinessCard.lineBreakMode];
			CGRect newFrame2345 = lbl_Address_BusinessCard.frame;
			newFrame2345.size.height = expectedLabelSize2345.height;
			lbl_Address_BusinessCard.frame = newFrame2345;
			lbl_Address_BusinessCard.numberOfLines=0;
			////  14/12/2011 start
		}
		else if ([str_TM_SelectedItem isEqualToString:@"Invitation"]||[str_TM_SelectedItem isEqualToString:@"IDBadge"] ){
			ivGradient.frame = CGRectMake(95, 42, 485, 130);
			tv_EventView.frame = CGRectMake(105, 47, 465, 120);
			barCodeImgView.frame = CGRectMake(235, 60+y, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(235, 60+y, 100, 100);
			//jayna1512116.18
			imgInvitation.frame = CGRectMake(235+100+10, 60+y, 100, 100);
			lbl_TitleStatic_Invitation.frame = CGRectMake(150, 210-y, 76, 21);
			lbl_Title_Invitation.frame = CGRectMake(186, 210-y, 230, 21);
			lbl_AddressStatic_Invitation.frame = CGRectMake(150, 240-y, 76, 21);
			lbl_Address_Invitation.frame = CGRectMake(150, 243-y, 270, 21);
			CGSize maximumLabelSize125 = CGSizeMake(270,9999);
			CGSize expectedLabelSize125 = [lbl_Address_Invitation.text sizeWithFont:lbl_Address_Invitation.font constrainedToSize:maximumLabelSize125 lineBreakMode:lbl_Address_Invitation.lineBreakMode];
			CGRect newFrame125 = lbl_Address_Invitation.frame;
			newFrame125.size.height = expectedLabelSize125.height;
			lbl_Address_Invitation.frame = newFrame125;
			lbl_Address_Invitation.numberOfLines=0;
			
			//for idbadge view
			lbl_CompanyStatic_IDBadge.frame = CGRectMake(150, 210-y, 110, 21);
			lbl_Company_IDBadge.frame = CGRectMake(258, 210-y, 230, 21);
			lbl_NameStatic_IDBadge.frame = CGRectMake(150, 240-y, 76, 21);
			lbl_Name_IDBadge.frame = CGRectMake(195, 240-y, 270, 21);
			lbl_JobTitleStatic_IDBadge.frame = CGRectMake(150, 270-y, 100, 21);
			lbl_JobTitle_IDBadge.frame = CGRectMake(214, 270-y, 230, 21);
			
		}
		else {
			ivGradient.frame = CGRectMake(95, 42, 485, 130);
			tv_EventView.frame = CGRectMake(105, 47, 465, 120);
			barCodeImgView.frame = CGRectMake(290, 205, 100, 100);//Jayna131211
			btn_Barcode_ImageProcessingView.frame = CGRectMake(290, 205, 100, 100);
			/////15/12/2011 start
			//for course info
			lbl_CourseNameStatic.frame = CGRectMake(110, 200-y, 100, 21);
			lbl_CourseName.frame = CGRectMake(204, 200-y, 250, 21);
			lbl_CourseCodeStatic.frame = CGRectMake(110, 223-y, 100, 21);
			lbl_CourseCode.frame = CGRectMake(202, 223-y, 250, 21);
			lbl_ProfessorStatic.frame = CGRectMake(110, 248-y, 72, 21);
			lbl_Professor.frame = CGRectMake(181, 248-y, 250, 21);
			lbl_DateTimeStatic.frame = CGRectMake(110, 275-y, 100, 21);
			lbl_DateTime.frame = CGRectMake(212, 275-y, 250, 21);
			/////15/12/2011  end
		}
	}
	else if ([str_flagForAlignmentClick isEqualToString:@"Bottom"]) {
		//ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal.png"];
		if ([str_Flag_Gradient isEqualToString:@"Black"]) {
			ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal-White.png"];
		}
		else {
			ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal.png"];
		}
		if ([str_TM_SelectedItem isEqualToString:@"Event"]||[str_TM_SelectedItem isEqualToString:@"BusinessCard"]) {
			ivGradient.frame = CGRectMake(95, 182, 485, 140);
			tv_EventView.frame = CGRectMake(105, 187, 465, 130);
			lbl_EventTitleStatic.frame = CGRectMake(110, 200, 76, 21);
			lbl_EventTitle.frame = CGRectMake(186, 200, 165, 21);
		//	lbl_EventTitle.backgroundColor=[UIColor redColor];
			lbl_StartStatic.frame = CGRectMake(110, 230, 79, 21);
			lbl_Start.frame = CGRectMake(188, 230, 162, 21);
			//lbl_Start.backgroundColor=[UIColor redColor];
			lbl_EndStatic.frame = CGRectMake(110, 248, 74, 21);
			lbl_End.frame = CGRectMake(184, 248, 165, 21);
			//lbl_End.backgroundColor = [UIColor redColor];
			lbl_NotesStatic.frame = CGRectMake(112, 285, 46, 21);
			//lbl_Notes.frame = CGRectMake(110, 300, 245, 21);
//			//lbl_Notes.backgroundColor = [UIColor redColor];
//			lbl_AddressStatic.frame = CGRectMake(360, 200, 66, 21);
//			lbl_Address.frame = CGRectMake(360, 223, 200, 100);
//			lbl_Address.numberOfLines=6;
			//lbl_Address.backgroundColor=[UIColor redColor];
			
			lbl_Notes.frame = CGRectMake(112, 288, 450, 63);
			CGSize maximumLabelSize = CGSizeMake(450,9999);
			CGSize expectedLabelSize = [lbl_Notes.text sizeWithFont:lbl_Notes.font constrainedToSize:maximumLabelSize lineBreakMode:lbl_Notes.lineBreakMode];
			CGRect newFrame = lbl_Notes.frame;
			newFrame.size.height = expectedLabelSize.height;
			lbl_Notes.frame = newFrame;
			lbl_Notes.numberOfLines=0; 
			lbl_AddressStatic.frame = CGRectMake(360, 200, 66, 21);
			lbl_Address.frame = CGRectMake(360, 203, 200, 120);
			CGSize maximumLabelSize2 = CGSizeMake(200,9999);
			CGSize expectedLabelSize2 = [lbl_Address.text sizeWithFont:lbl_Address.font constrainedToSize:maximumLabelSize2 lineBreakMode:lbl_Address.lineBreakMode];
			CGRect newFrame2 = lbl_Address.frame;
			newFrame2.size.height = expectedLabelSize2.height;
			lbl_Address.frame = newFrame2;
			lbl_Address.numberOfLines=0;
			
			barCodeImgView.frame = CGRectMake(290, 60, 100, 100);//Jayna131211
			btn_Barcode_ImageProcessingView.frame = CGRectMake(290, 60, 100, 100);//Jayna131211
			////  14/12/2011 start
			//BusinessView Lables 
			lbl_CompanyStatic.frame = CGRectMake(110, 200, 76, 21);
			lbl_Company.frame = CGRectMake(180, 200, 165, 21);
			lbl_JobTitleStatic.frame = CGRectMake(110, 223, 79, 21);
			lbl_JobTitle.frame = CGRectMake(175, 223, 162, 21);
			lbl_NameStatic.frame = CGRectMake(110, 248, 74, 21);
			lbl_Name.frame = CGRectMake(155, 248, 190, 21);
			lbl_EmailStatic.frame = CGRectMake(110, 275, 46, 21);
			lbl_Email.frame = CGRectMake(155, 275, 190, 21);
			lbl_PhoneStatic.frame = CGRectMake(110, 300, 245, 21);
			lbl_Phone.frame = CGRectMake(160, 300, 190, 21);
			lbl_AddressStatic_BusinessCard.frame = CGRectMake(360, 200, 66, 21);
			//lbl_Address_BusinessCard.frame = CGRectMake(360, 223, 200, 100);
//			lbl_Address_BusinessCard.numberOfLines=6;
			
			
			lbl_Address_BusinessCard.frame = CGRectMake(360, 203, 200, 120);
			CGSize maximumLabelSize25 = CGSizeMake(200,9999);
			CGSize expectedLabelSize25 = [lbl_Address_BusinessCard.text sizeWithFont:lbl_Address_BusinessCard.font constrainedToSize:maximumLabelSize25 lineBreakMode:lbl_Address_BusinessCard.lineBreakMode];
			CGRect newFrame25 = lbl_Address_BusinessCard.frame;
			newFrame25.size.height = expectedLabelSize25.height;
			lbl_Address_BusinessCard.frame = newFrame25;
			lbl_Address_BusinessCard.numberOfLines=0;
			////  14/12/2011 start
		}
		else if ([str_TM_SelectedItem isEqualToString:@"Invitation"]||[str_TM_SelectedItem isEqualToString:@"IDBadge"] ){
			ivGradient.frame = CGRectMake(95, 187, 485, 130);
			tv_EventView.frame = CGRectMake(105, 195, 465, 120);
			barCodeImgView.frame = CGRectMake(235, 60, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(235, 60, 100, 100);////jayna1512116.18
			//jayna1512116.18
			imgInvitation.frame = CGRectMake(235+100+10, 60, 100, 100);
			lbl_TitleStatic_Invitation.frame = CGRectMake(150, 210, 76, 21);
			lbl_Title_Invitation.frame = CGRectMake(186, 210, 230, 21);
			lbl_AddressStatic_Invitation.frame = CGRectMake(150, 240, 76, 21);
			lbl_Address_Invitation.frame = CGRectMake(150, 243, 270, 21);
			CGSize maximumLabelSize125 = CGSizeMake(270,9999);
			CGSize expectedLabelSize125 = [lbl_Address_Invitation.text sizeWithFont:lbl_Address_Invitation.font constrainedToSize:maximumLabelSize125 lineBreakMode:lbl_Address_Invitation.lineBreakMode];
			CGRect newFrame125 = lbl_Address_Invitation.frame;
			newFrame125.size.height = expectedLabelSize125.height;
			lbl_Address_Invitation.frame = newFrame125;
			lbl_Address_Invitation.numberOfLines=0;
			
			//for invitation view
			lbl_CompanyStatic_IDBadge.frame = CGRectMake(150, 210, 110, 21);
			lbl_Company_IDBadge.frame = CGRectMake(258, 210, 230, 21);
			lbl_NameStatic_IDBadge.frame = CGRectMake(150, 240, 76, 21);
			lbl_Name_IDBadge.frame = CGRectMake(195, 240, 270, 21);
			lbl_JobTitleStatic_IDBadge.frame = CGRectMake(150, 270, 100, 21);
			lbl_JobTitle_IDBadge.frame = CGRectMake(214, 270, 230, 21);
			
		}
		else {
			ivGradient.frame = CGRectMake(95, 187, 485, 130);
			tv_EventView.frame = CGRectMake(105, 195, 465, 120);
			barCodeImgView.frame = CGRectMake(290, 60, 100, 100);//Jayna131211
			btn_Barcode_ImageProcessingView.frame = CGRectMake(290, 60, 100, 100);//Jayna131211
			
			/////15/12/2011 start
			//for course info
			lbl_CourseNameStatic.frame = CGRectMake(110, 200, 100, 21);
			lbl_CourseName.frame = CGRectMake(204, 200, 250, 21);
			lbl_CourseCodeStatic.frame = CGRectMake(110, 223, 100, 21);
			lbl_CourseCode.frame = CGRectMake(202, 223, 250, 21);
			lbl_ProfessorStatic.frame = CGRectMake(110, 248, 72, 21);
			lbl_Professor.frame = CGRectMake(181, 248, 250, 21);
			lbl_DateTimeStatic.frame = CGRectMake(110, 275, 100, 21);
			lbl_DateTime.frame = CGRectMake(212, 275, 250, 21);
			/////15/12/2011  end
		}
	}
	
	lbl_TemplateTitle.frame = CGRectMake(200,5,294,30);
	PreviewShareView.frame = CGRectMake(0,0,800, 810);
	//shareKitView.frame = CGRectMake(0,810-50,800, 58);
	//imgBGShare.frame = CGRectMake(0,0,800, 58);
	//imgtemplate.frame = CGRectMake((654-465)/2, (770-290)/2,465,290);
	
	if ([strFlag isEqualToString:@"UCD"])
	{
		imgtemplate.frame = CGRectMake(ivLibrary.frame.origin.x-3, ivLibrary.frame.origin.y,467,290);//jayna16121114.44
	}
	else {
		imgtemplate.frame = CGRectMake(90, 37,ivMainImage.frame.size.width,290);
	}

	//jayna16121114.44
	shareKitView.frame = CGRectMake(0,810-59,800, 67);//jayna16121114.44
	imgBGShare.frame = CGRectMake(0,0,800, 67);//jayna16121114.44
	ftbimage.image = [UIImage imageNamed:@"_0000_portrait.png"];
	ftbimage.frame = CGRectMake(1, 755, 654, 56);
	//jayna16121114.44
	CGFloat x=100;
	btnFacebook.frame = CGRectMake(x,12,42,43);
	
	x+=43+100;
	btnTwitter.frame = CGRectMake(x,12,42,43);
	x+=43+100;
	btnEmail.frame = CGRectMake(x,12,42,43);
	x+=43+100;
	btnTrash.frame = CGRectMake(x,12,42,43);
	
	btn_Plus.frame=CGRectMake(620, 5, 33, 30);
	//btn_Plus.frame=CGRectMake(lbl_TemplateTitle.frame.origin.x + lbl_TemplateTitle.frame.size.width , 5, 33, 30);
	
}


-(void)setFrameOrientation_LandScap
{
	//ivBarcode_IDBadge.frame = CGRectMake(201, 200, 137, 137);
//	btn_Barcode_IDBadgeView.frame = CGRectMake(201, 200, 137, 137);
//	ivPhoto_IDBadge.frame = CGRectMake(316, 200, 137, 137);
//	btn_ivPhoto_IDBadge.frame = CGRectMake(316, 200, 137, 137);
	scrl_Event.scrollEnabled=TRUE;
	scrl_BusinessCard.scrollEnabled=TRUE;
	ivBarcode_BusinessCard.frame = CGRectMake(650, 297, 128, 128);
	btn_Barcode_BusinessView.frame = CGRectMake(650, 297, 128, 128);
	btn_Continue_BarcodeView.frame = CGRectMake(262, 610, 137, 52);
	ivAddressBackGround.image = [UIImage imageNamed:@"eventaddressbox-Landscape.png"];
	ivAddressBackGround.frame = CGRectMake(21, 162, 752, 202);
	ivAddressBackGround_Invitation.image = [UIImage imageNamed:@"eventaddressbox-Landscape.png"];
	ivAddressBackGround_Invitation.frame  = CGRectMake(21, 76, 752, 202);
	//ivBarcode_Invitation.frame = CGRectMake(200, 305, 138, 138);
//	btn_Barcode_InvitationView.frame = CGRectMake(200, 305, 138, 138);
//	ivPhoto_Invitation.frame =  CGRectMake(320, 305, 138, 138);
//	btn_Barcode_Invitation.frame =  CGRectMake(320, 305, 138, 138);
	FlagForCoverFlow=TRUE;
	int y=256,w=400,height=141;
	btn_OpenCamera_UCD.frame = CGRectMake(640, 348, 47, 47);
	/*
	if(firstTime == TRUE)
	{
		//btn_Plus.frame=CGRectMake(880, 5, 33, 30);
		firstTime = FALSE;
		btn_Event.frame=CGRectMake(13+20, 40, 110, height+1);
		btn_BusinessCard.frame=CGRectMake(13+20, height+41, 110, height+1);
		btn_Invitation.frame=CGRectMake(13+20, height*2+42, 110, height);
		btn_IDBadge.frame=CGRectMake(13+20, height*3+42, 110, height+2);
		btn_ContactInfo.frame=CGRectMake(13+20, height*4+43, 110, height+5);
		
		iv_SeperationLine.frame=CGRectMake(13+20, 40, 111, 710);
		iv_SeperationBorder.frame=CGRectMake(13+20, 40, 115, 710);    
		mainView.frame=CGRectMake(130+20, 40, 795, 665);
		btn_UDT.frame=CGRectMake(124+20, 967-y, w+1, 37);
		btn_UCD.frame=CGRectMake(w+124+21, 967-y, w+2, 37);
		eventView.frame=CGRectMake(125+20, 40, 795, 670);
		imageProcessingView.frame=CGRectMake(130+20, 40, 795, 665);
		PreviewShareView.frame=CGRectMake(130+20, 40, 795, 665);
		btn_Back.frame=CGRectMake(30+20, 5, 26, 30);
		shareKitView.frame = CGRectMake(20,670-50,1024, 58);
		businessView.frame=CGRectMake(125+20, 40, 795, 670);
		invitationView.frame=CGRectMake(125+20, 40, 795, 670);
		barcodeView.frame=CGRectMake(125+20, 40, 795, 670);
		courseinfoView.frame=CGRectMake(125+20, 40, 795, 670);
		idbadgeView.frame=CGRectMake(125+20, 40, 795, 670);
		lbl_TemplateTitle.frame = CGRectMake(-20,5,1024,30);//jayna151211
		ftbimage.frame = CGRectMake(-6, 615, 802, 56);


	}
	else {
		
		
		if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
		   appDel.ori == UIInterfaceOrientationLandscapeRight)
		{
			//btn_Event.frame=CGRectMake(13+20, 40, 110, height+1);
//			btn_BusinessCard.frame=CGRectMake(13+20, height+41, 110, height+1);
//			btn_Invitation.frame=CGRectMake(13+20, height*2+42, 110, height);
//			btn_IDBadge.frame=CGRectMake(13+20, height*3+42, 110, height+2);
//			btn_ContactInfo.frame=CGRectMake(13+20, height*4+43, 110, height+5);
//			
//			iv_SeperationLine.frame=CGRectMake(13+20, 40, 111, 710);
//			iv_SeperationBorder.frame=CGRectMake(13+20, 40, 115, 710);    
//			mainView.frame=CGRectMake(130+20, 40, 795, 665);
//			btn_UDT.frame=CGRectMake(124+20, 967-y, w, 37);
//			btn_UCD.frame=CGRectMake(w+124+20, 967-y, w+2, 37);
//			eventView.frame=CGRectMake(125+20, 40, 795, 670);
//			imageProcessingView.frame=CGRectMake(130+20, 40, 795, 665);
//			PreviewShareView.frame=CGRectMake(130+20, 40, 795, 665);
//			btn_Back.frame=CGRectMake(30+20, 5, 26, 30);
//			shareKitView.frame = CGRectMake(20,670-50,1024, 58);
//			businessView.frame=CGRectMake(125+20, 40, 795, 670);
//			invitationView.frame=CGRectMake(125+20, 40, 795, 670);
//			barcodeView.frame=CGRectMake(125+20, 40, 795, 670);
//			courseinfoView.frame=CGRectMake(125+20, 40, 795, 670);
//			idbadgeView.frame=CGRectMake(125+20, 40, 795, 670);
//			lbl_TemplateTitle.frame = CGRectMake(-20,5,1024,30);//jayna151211
//			ftbimage.frame = CGRectMake(-6, 615, 802, 56);


		}
		//if(oncePort == TRUE)
//		{
			
			btn_Plus.frame=CGRectMake(880, 5, 33, 30);
			btn_Event.frame=CGRectMake(13, 40, 110, height+1);
			btn_BusinessCard.frame=CGRectMake(13, height+41, 110, height+1);
			btn_Invitation.frame=CGRectMake(13, height*2+42, 110, height);
			btn_IDBadge.frame=CGRectMake(13, height*3+42, 110, height+2);
			btn_ContactInfo.frame=CGRectMake(13, height*4+43, 110, height+5);
			
			iv_SeperationLine.frame=CGRectMake(13, 40, 111, 710);
			iv_SeperationBorder.frame=CGRectMake(13, 40, 115, 710);
			mainView.frame=CGRectMake(130, 40, 795, 665);
			btn_UDT.frame=CGRectMake(124, 967-y, w, 37);
			btn_UCD.frame=CGRectMake(w+124, 967-y, w, 37);
			eventView.frame=CGRectMake(125, 40, 795, 670);
			imageProcessingView.frame=CGRectMake(130, 40, 795, 665);
			PreviewShareView.frame=CGRectMake(130, 40, 795, 665);
			btn_Back.frame=CGRectMake(30, 5, 26, 30);
			shareKitView.frame = CGRectMake(-7,670-50,1024, 58);
			
			businessView.frame=CGRectMake(125, 40, 795, 670);
			invitationView.frame=CGRectMake(125, 40, 795, 670);
			barcodeView.frame=CGRectMake(125, 40, 795, 670);
			courseinfoView.frame=CGRectMake(125, 40, 795, 670);
			idbadgeView.frame=CGRectMake(125, 40, 795, 670);
			lbl_TemplateTitle.frame = CGRectMake(-40,5,1024,30);//jayna151211
			ftbimage.frame = CGRectMake(-6, 615, 800, 56);
		//}
//		else {
//			btn_Plus.frame=CGRectMake(880+20, 5, 33, 30);
//			btn_Event.frame=CGRectMake(13+20, 40, 110, height+1);
//			btn_BusinessCard.frame=CGRectMake(13+20, height+41, 110, height+1);
//			btn_Invitation.frame=CGRectMake(13+20, height*2+42, 110, height);
//			btn_IDBadge.frame=CGRectMake(13+20, height*3+42, 110, height+2);
//			btn_ContactInfo.frame=CGRectMake(13+20, height*4+43, 110, height+5);
//			
//			iv_SeperationLine.frame=CGRectMake(13+20, 40, 111, 710);
//			iv_SeperationBorder.frame=CGRectMake(13+20, 40, 115, 710);    
//			mainView.frame=CGRectMake(130+20, 40, 795, 665);
//			btn_UDT.frame=CGRectMake(124+20, 967-y, w, 37);
//			btn_UCD.frame=CGRectMake(w+124+20, 967-y, w+2, 37);
//			eventView.frame=CGRectMake(125+20, 40, 795, 670);
//			imageProcessingView.frame=CGRectMake(130+20, 40, 795, 665);
//			PreviewShareView.frame=CGRectMake(130+20, 40, 795, 665);
//			btn_Back.frame=CGRectMake(30+20, 5, 26, 30);
//			shareKitView.frame = CGRectMake(20,670-50,1024, 58);
//			businessView.frame=CGRectMake(125+20, 40, 795, 670);
//			invitationView.frame=CGRectMake(125+20, 40, 795, 670);
//			barcodeView.frame=CGRectMake(125+20, 40, 795, 670);
//			courseinfoView.frame=CGRectMake(125+20, 40, 795, 670);
//			idbadgeView.frame=CGRectMake(125+20, 40, 795, 670);
//			lbl_TemplateTitle.frame = CGRectMake(-20,5,1024,30);//jayna151211
//			ftbimage.frame = CGRectMake(-6, 615, 802, 56);
//		}
		
	}
	
	*/
    
     
	btn_Plus.frame=CGRectMake(880, 5, 33, 30);
	btn_Event.frame=CGRectMake(13, 40, 110, height+1);
	btn_BusinessCard.frame=CGRectMake(13, height+41, 110, height+1);
	btn_Invitation.frame=CGRectMake(13, height*2+42, 110, height);
	btn_IDBadge.frame=CGRectMake(13, height*3+42, 110, height+2);
	btn_ContactInfo.frame=CGRectMake(13, height*4+43, 110, height+5);
	
	iv_SeperationLine.frame=CGRectMake(13, 40, 111, 710);
	iv_SeperationBorder.frame=CGRectMake(13, 40, 115, 710);
	mainView.frame=CGRectMake(130, 40, 795, 665);
	btn_UDT.frame=CGRectMake(124, 967-y, w, 37);
	btn_UCD.frame=CGRectMake(w+124, 967-y, w, 37);
	eventView.frame=CGRectMake(125, 40, 795, 670);
	imageProcessingView.frame=CGRectMake(130, 40, 795, 665);
	PreviewShareView.frame=CGRectMake(130, 40, 795, 665);
	btn_Back.frame=CGRectMake(30, 5, 26, 30);
	shareKitView.frame = CGRectMake(-7,670-50,1024, 58);
	
	businessView.frame=CGRectMake(125, 40, 795, 670);
	invitationView.frame=CGRectMake(125, 40, 795, 670);
	barcodeView.frame=CGRectMake(125, 40, 795, 670);
	courseinfoView.frame=CGRectMake(125, 40, 795, 670);
	idbadgeView.frame=CGRectMake(125, 40, 795, 670);
	lbl_TemplateTitle.frame = CGRectMake(-40,5,1024,30);//jayna151211
	ftbimage.frame = CGRectMake(-6, 615, 800, 56);
	
	
	//lbl_TemplateTitle.frame = CGRectMake(250,10,294,21);
	
	Topimage.image=[UIImage imageNamed:@"_0006_top-red-band910.png"];
	Topimage.frame=CGRectMake(0,0,1004,48);
	
	
	
	//imgtemplate.frame = CGRectMake(50, 500, 453, 425);
	//imgtemplate.frame = CGRectMake(250, 200, 453, 425);
	imgtemplate.frame = CGRectMake(148, 100,ivMainImage.frame.size.width+5,290);
	coverFloWView.frame=CGRectMake(0, 0, 795, 500);
	//vc.view.frame = CGRectMake(0, -50, 795, 500);
	libraryView.frame=CGRectMake(0, 0, 795, 500);
	ivLibrary.center = CGPointMake(397, 250);
	
	
	btnCreate.frame=CGRectMake(340, 580, 115, 57);
	
	
	
	
	
	
	[iv_SeperationLine setImage:[UIImage imageNamed:@"seperation-line-L.png"]];
	[iv_SeperationBorder setImage:[UIImage imageNamed:@"seperation-border-l.png"]];
	
	
	//For image processing view
	ivMainImage.frame=CGRectMake(150, 100, 495, 290);
	colorView.frame=CGRectMake(150, 100, 495, 290);
	btn_ColorPicker.frame=CGRectMake(650, 293, 47, 47);
	btn_OpenCamera.frame=CGRectMake(650, 343, 47, 47);
	iv_photoLibImg.frame = ivMainImage.frame;
	//    iv_photoLibImg.frame = CGRectMake(ivMainImage.frame.origin.x+495-90, ivMainImage.frame.origin.y+290-90, 70, 70);
	ivAlignment.frame=CGRectMake(25, 410, 299, 116);
	btn_Bottom.frame=CGRectMake(44, 462, 55, 36);
	btn_Top.frame=CGRectMake(112, 462, 55, 36);
	btn_Left.frame=CGRectMake(181, 462, 55, 36);
	btn_Right.frame=CGRectMake(250, 462, 55, 36);
	ivColor.frame=CGRectMake(334, 410, 167, 116);
	btn_White.frame=CGRectMake(353, 462, 55, 36);
	btn_Black.frame=CGRectMake(428, 462, 55, 36);
	ivTransparency.frame=CGRectMake(511, 410, 246, 116);
	slider.frame=CGRectMake(524, 465, 220, 23);
	btn_Create_ImageProcessing.frame=CGRectMake(340, 575, 115, 57);
	
	if (!coverFloWView.hidden) {
		[self addCoverFlow];
	}
   
   // [vc setFrame:CGRectMake(20, 0, 755, 700)];
    //vc.view.frame = coverFloWView.frame;//CGRectMake(20, 0, 755, 700);
	
	//for image processing
	if ([str_flagForAlignmentClick isEqualToString:@"Left"]) {
		//ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical.png"];
		if ([str_Flag_Gradient isEqualToString:@"Black"]) {
			ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical-White.png"];
		}
		else {
			ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical.png"];
		}
		ivGradient.frame = CGRectMake(155, 105, 260, 280);
		tv_EventView.frame = CGRectMake(165, 110, 240, 270);
		int x=60,y=140;
		lbl_EventTitleStatic.frame = CGRectMake(110+x, 200+x-y, 76, 21);
		lbl_EventTitle.frame = CGRectMake(186+x, 200+x-y, 165, 21);
		lbl_StartStatic.frame = CGRectMake(110+x, 230+x-y, 79, 21);
		lbl_Start.frame = CGRectMake(188+x, 230+x-y, 162, 21);
		lbl_EndStatic.frame = CGRectMake(110+x, 248+x-y, 74, 21);
		lbl_End.frame = CGRectMake(184+x, 248+x-y, 165, 21);
		lbl_NotesStatic.frame = CGRectMake(112+x, 278+x-y, 46, 21);
		//lbl_Notes.frame = CGRectMake(110+x, 300+x-y, 245, 21);
//		lbl_AddressStatic.frame = CGRectMake(110+x, 330+x-y, 66, 21);
//		lbl_Address.frame = CGRectMake(110+x, 353+x-y, 245, 100);
//		lbl_Address.numberOfLines=6;
		
		lbl_Notes.frame = CGRectMake(112+x, 281+x-y, 245, 63);
		CGSize maximumLabelSize = CGSizeMake(245,9999);
		CGSize expectedLabelSize = [lbl_Notes.text sizeWithFont:lbl_Notes.font constrainedToSize:maximumLabelSize lineBreakMode:lbl_Notes.lineBreakMode];
		CGRect newFrame = lbl_Notes.frame;
		newFrame.size.height = expectedLabelSize.height;
		lbl_Notes.frame = newFrame;
		lbl_Notes.numberOfLines=0; 
		lbl_AddressStatic.frame = CGRectMake(112+x, 345+x-y, 66, 21);
		lbl_Address.frame = CGRectMake(112+x, 358+x-y, 200, 120);
		CGSize maximumLabelSize2 = CGSizeMake(200,9999);
		CGSize expectedLabelSize2 = [lbl_Address.text sizeWithFont:lbl_Address.font constrainedToSize:maximumLabelSize2 lineBreakMode:lbl_Address.lineBreakMode];
		CGRect newFrame2 = lbl_Address.frame;
		newFrame2.size.height = expectedLabelSize2.height;
		lbl_Address.frame = newFrame2;
		lbl_Address.numberOfLines=0;
		
		if ([str_TM_SelectedItem isEqualToString:@"Invitation"]||[str_TM_SelectedItem isEqualToString:@"IDBadge"] )
		{
			
			barCodeImgView.frame = CGRectMake(480, 135, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(480, 135, 100, 100);////jayna1512116.18
			//jayna1512116.18
			imgInvitation.frame = CGRectMake(480, 135+100+10, 100, 100);
			
		}
		else {
			barCodeImgView.frame = CGRectMake(480, 180, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(480, 180, 100, 100);////jayna1512116.18
		}
	
		
		////  14/12/2011 start
		//BusinessView Lables 
		lbl_CompanyStatic.frame = CGRectMake(110+x, 200+x-y, 76, 21);
		lbl_Company.frame = CGRectMake(180+x, 200+x-y, 165, 21);
		lbl_JobTitleStatic.frame = CGRectMake(110+x, 223+x-y, 79, 21);
		lbl_JobTitle.frame = CGRectMake(175+x, 223+x-y, 162, 21);
		lbl_NameStatic.frame = CGRectMake(110+x, 248+x-y, 74, 21);
		lbl_Name.frame = CGRectMake(155+x, 248+x-y, 190, 21);
		lbl_EmailStatic.frame = CGRectMake(110+x, 275+x-y, 46, 21);
		lbl_Email.frame = CGRectMake(155+x, 275+x-y, 190, 21);
		lbl_PhoneStatic.frame = CGRectMake(110+x, 300+x-y, 245, 21);
		lbl_Phone.frame = CGRectMake(160+x, 300+x-y, 190, 21);
		lbl_AddressStatic_BusinessCard.frame = CGRectMake(110+x, 330+x-y, 66, 21);
		//lbl_Address_BusinessCard.frame = CGRectMake(110+x, 353+x-y, 237, 100);
//		lbl_Address_BusinessCard.numberOfLines=6;
		
		lbl_Address_BusinessCard.frame = CGRectMake(110+x, 333+x-y, 200, 120);
		CGSize maximumLabelSize123 = CGSizeMake(200,9999);
		CGSize expectedLabelSize123 = [lbl_Address_BusinessCard.text sizeWithFont:lbl_Address_BusinessCard.font constrainedToSize:maximumLabelSize123 lineBreakMode:lbl_Address_BusinessCard.lineBreakMode];
		CGRect newFrame123 = lbl_Address_BusinessCard.frame;
		newFrame123.size.height = expectedLabelSize123.height;
		lbl_Address_BusinessCard.frame = newFrame123;
		lbl_Address_BusinessCard.numberOfLines=0;
		////  14/12/2011 start
		
		/////15/12/2011 start
		//for course info
		int k=-65;
		lbl_CourseNameStatic.frame = CGRectMake(110+x, 200+x-y-k, 100, 21);
		lbl_CourseName.frame = CGRectMake(204+x, 200+x-y-k, 140, 21);
		lbl_CourseCodeStatic.frame = CGRectMake(110+x, 223+x-y-k, 100, 21);
		lbl_CourseCode.frame = CGRectMake(202+x, 223+x-y-k, 140, 21);
		lbl_ProfessorStatic.frame = CGRectMake(110+x, 248+x-y-k, 72, 21);
		lbl_Professor.frame = CGRectMake(181+x, 248+x-y-k, 140, 21);
		lbl_DateTimeStatic.frame = CGRectMake(110+x, 275+x-y-k, 100, 21);
		lbl_DateTime.frame = CGRectMake(212+x, 275+x-y-k, 140, 21);
		/////15/12/2011  end
		
		int zx=40;
		//for invitationview
		lbl_TitleStatic_Invitation.frame = CGRectMake(150+x-zx, 210+x-y-k, 76, 21);
		lbl_Title_Invitation.frame = CGRectMake(186+x-zx, 210+x-y-k, 230, 21);
		lbl_AddressStatic_Invitation.frame = CGRectMake(150+x-zx, 240+x-y-k, 76, 21);
		lbl_Address_Invitation.frame = CGRectMake(150+x-zx, 243+x-y-k, 180, 21);
		CGSize maximumLabelSize125 = CGSizeMake(180,9999);
		CGSize expectedLabelSize125 = [lbl_Address_Invitation.text sizeWithFont:lbl_Address_Invitation.font constrainedToSize:maximumLabelSize125 lineBreakMode:lbl_Address_Invitation.lineBreakMode];
		CGRect newFrame125 = lbl_Address_Invitation.frame;
		newFrame125.size.height = expectedLabelSize125.height;
		lbl_Address_Invitation.frame = newFrame125;
		lbl_Address_Invitation.numberOfLines=0;
		
		//for idbadge view
		lbl_CompanyStatic_IDBadge.frame = CGRectMake(150+x-zx, 210+x-y-k, 110, 21);
		lbl_Company_IDBadge.frame = CGRectMake(258+x-zx, 210+x-y-k, 135, 21);
		lbl_NameStatic_IDBadge.frame = CGRectMake(150+x-zx, 240+x-y-k, 76, 21);
		lbl_Name_IDBadge.frame = CGRectMake(195+x-zx, 240+x-y-k, 180, 21);
		lbl_JobTitleStatic_IDBadge.frame = CGRectMake(150+x-zx, 270+x-y-k, 100, 21);
		lbl_JobTitle_IDBadge.frame = CGRectMake(214+x-zx, 270+x-y-k, 170, 21);
	}
	else if ([str_flagForAlignmentClick isEqualToString:@"Right"]) {
		//ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical.png"];
		if ([str_Flag_Gradient isEqualToString:@"Black"]) {
			ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical-White.png"];
		}
		else {
			ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical.png"];
		}
		ivGradient.frame = CGRectMake(380, 105, 260, 280);
		tv_EventView.frame = CGRectMake(390, 110, 240, 270);
		int x=60,y=140,z=225;
		lbl_EventTitleStatic.frame = CGRectMake(110+x+z, 200+x-y, 76, 21);
		lbl_EventTitle.frame = CGRectMake(186+x+z, 200+x-y, 165, 21);
		lbl_StartStatic.frame = CGRectMake(110+x+z, 230+x-y, 79, 21);
		lbl_Start.frame = CGRectMake(188+x+z, 230+x-y, 162, 21);
		lbl_EndStatic.frame = CGRectMake(110+x+z, 248+x-y, 74, 21);
		lbl_End.frame = CGRectMake(184+x+z, 248+x-y, 165, 21);
		lbl_NotesStatic.frame = CGRectMake(112+x+z, 278+x-y, 46, 21);
		//lbl_Notes.frame = CGRectMake(110+x+z, 300+x-y, 245, 21);
//		lbl_AddressStatic.frame = CGRectMake(110+x+z, 330+x-y, 66, 21);
//		lbl_Address.frame = CGRectMake(110+x+z, 353+x-y, 245, 100);
//		lbl_Address.numberOfLines=6;
		
		lbl_Notes.frame = CGRectMake(112+x+z, 281+x-y, 245, 63);
		CGSize maximumLabelSize = CGSizeMake(245,9999);
		CGSize expectedLabelSize = [lbl_Notes.text sizeWithFont:lbl_Notes.font constrainedToSize:maximumLabelSize lineBreakMode:lbl_Notes.lineBreakMode];
		CGRect newFrame = lbl_Notes.frame;
		newFrame.size.height = expectedLabelSize.height;
		lbl_Notes.frame = newFrame;
		lbl_Notes.numberOfLines=0; 
		lbl_AddressStatic.frame = CGRectMake(112+x+z, 345+x-y, 66, 21);
		lbl_Address.frame = CGRectMake(112+x+z, 358+x-y, 200, 120);
		CGSize maximumLabelSize2 = CGSizeMake(200,9999);
		CGSize expectedLabelSize2 = [lbl_Address.text sizeWithFont:lbl_Address.font constrainedToSize:maximumLabelSize2 lineBreakMode:lbl_Address.lineBreakMode];
		CGRect newFrame2 = lbl_Address.frame;
		newFrame2.size.height = expectedLabelSize2.height;
		lbl_Address.frame = newFrame2;
		lbl_Address.numberOfLines=0;
		
		if ([str_TM_SelectedItem isEqualToString:@"Invitation"]||[str_TM_SelectedItem isEqualToString:@"IDBadge"] )
		{
			
			barCodeImgView.frame = CGRectMake(220, 135, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(220, 135, 100, 100);////jayna1512116.18
			//jayna1512116.18
			imgInvitation.frame = CGRectMake(220, 135+100+10, 100, 100);
			
		}
		else {
			barCodeImgView.frame = CGRectMake(220, 180, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(220, 180, 100, 100);////jayna1512116.18
		}
		
		
		////  14/12/2011 start
		//BusinessView Lables 
		lbl_CompanyStatic.frame = CGRectMake(110+x+z, 200+x-y, 76, 21);
		lbl_Company.frame = CGRectMake(180+x+z, 200+x-y, 165, 21);
		lbl_JobTitleStatic.frame = CGRectMake(110+x+z, 223+x-y, 79, 21);
		lbl_JobTitle.frame = CGRectMake(175+x+z, 223+x-y, 162, 21);
		lbl_NameStatic.frame = CGRectMake(110+x+z, 248+x-y, 74, 21);
		lbl_Name.frame = CGRectMake(155+x+z, 248+x-y, 190, 21);
		lbl_EmailStatic.frame = CGRectMake(110+x+z, 275+x-y, 46, 21);
		lbl_Email.frame = CGRectMake(155+x+z, 275+x-y, 190, 21);
		lbl_PhoneStatic.frame = CGRectMake(110+x+z, 300+x-y, 245, 21);
		lbl_Phone.frame = CGRectMake(160+x+z, 300+x-y, 190, 21);
		lbl_AddressStatic_BusinessCard.frame = CGRectMake(110+x+z, 330+x-y, 66, 21);
		//lbl_Address_BusinessCard.frame = CGRectMake(110+x+z, 353+x-y, 237, 100);
//		lbl_Address_BusinessCard.numberOfLines=6;
		lbl_Address_BusinessCard.frame = CGRectMake(110+x+z, 333+x-y, 200, 120);
		CGSize maximumLabelSize234 = CGSizeMake(200,9999);
		CGSize expectedLabelSize234 = [lbl_Address_BusinessCard.text sizeWithFont:lbl_Address_BusinessCard.font constrainedToSize:maximumLabelSize234 lineBreakMode:lbl_Address_BusinessCard.lineBreakMode];
		CGRect newFrame234 = lbl_Address_BusinessCard.frame;
		newFrame234.size.height = expectedLabelSize234.height;
		lbl_Address_BusinessCard.frame = newFrame234;
		lbl_Address_BusinessCard.numberOfLines=0;
		////  14/12/2011 start
		
		/////15/12/2011 start
		//for course info
		int k=-65;
		lbl_CourseNameStatic.frame = CGRectMake(110+x+z, 200+x-y-k, 100, 21);
		lbl_CourseName.frame = CGRectMake(204+x+z, 200+x-y-k, 140, 21);
		lbl_CourseCodeStatic.frame = CGRectMake(110+x+z, 223+x-y-k, 100, 21);
		lbl_CourseCode.frame = CGRectMake(202+x+z, 223+x-y-k, 140, 21);
		lbl_ProfessorStatic.frame = CGRectMake(110+x+z, 248+x-y-k, 72, 21);
		lbl_Professor.frame = CGRectMake(181+x+z, 248+x-y-k, 140, 21);
		lbl_DateTimeStatic.frame = CGRectMake(110+x+z, 275+x-y-k, 100, 21);
		lbl_DateTime.frame = CGRectMake(212+x+z, 275+x-y-k, 140, 21);
		/////15/12/2011  end
		
		//for invitationView
		int zx=40;
		//for invitationview
		lbl_TitleStatic_Invitation.frame = CGRectMake(150+x+z-zx, 210+x-y-k, 76, 21);
		lbl_Title_Invitation.frame = CGRectMake(186+x+z-zx, 210+x-y-k, 230, 21);
		lbl_AddressStatic_Invitation.frame = CGRectMake(150+x+z-zx, 240+x-y-k, 76, 21);
		lbl_Address_Invitation.frame = CGRectMake(150+x+z-zx, 243+x-y-k, 180, 21);
		
		CGSize maximumLabelSize125 = CGSizeMake(180,9999);
		CGSize expectedLabelSize125 = [lbl_Address_Invitation.text sizeWithFont:lbl_Address_Invitation.font constrainedToSize:maximumLabelSize125 lineBreakMode:lbl_Address_Invitation.lineBreakMode];
		CGRect newFrame125 = lbl_Address_Invitation.frame;
		newFrame125.size.height = expectedLabelSize125.height;
		lbl_Address_Invitation.frame = newFrame125;
		lbl_Address_Invitation.numberOfLines=0;
		
		
		//for idbadge view
		lbl_CompanyStatic_IDBadge.frame = CGRectMake(150+x+z-zx, 210+x-y-k, 110, 21);
		lbl_Company_IDBadge.frame = CGRectMake(258+x+z-zx, 210+x-y-k, 135, 21);
		lbl_NameStatic_IDBadge.frame = CGRectMake(150+x+z-zx, 240+x-y-k, 76, 21);
		lbl_Name_IDBadge.frame = CGRectMake(195+x+z-zx, 240+x-y-k, 180, 21);
		lbl_JobTitleStatic_IDBadge.frame = CGRectMake(150+x+z-zx, 270+x-y-k, 100, 21);
		lbl_JobTitle_IDBadge.frame = CGRectMake(214+x+z-zx, 270+x-y-k, 170, 21);
		//}
	}
	else if ([str_flagForAlignmentClick isEqualToString:@"Top"]) {
		//ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal.png"];
		if ([str_Flag_Gradient isEqualToString:@"Black"]) {
			ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal-White.png"];
		}
		else {
			ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal.png"];
		}
		int x=60,y=140;
		if ([str_TM_SelectedItem isEqualToString:@"Event"]||[str_TM_SelectedItem isEqualToString:@"BusinessCard"]) {
			
			ivGradient.frame = CGRectMake(155, 105, 485, 145);
			tv_EventView.frame = CGRectMake(165, 110, 465, 135);
			lbl_EventTitleStatic.frame = CGRectMake(110+x, 200+x-y, 76, 21);
			lbl_EventTitle.frame = CGRectMake(186+x, 200+x-y, 165, 21);
			lbl_StartStatic.frame = CGRectMake(110+x, 230+x-y, 79, 21);
			lbl_Start.frame = CGRectMake(188+x, 230+x-y, 162, 21);
			lbl_EndStatic.frame = CGRectMake(110+x, 248+x-y, 74, 21);
			lbl_End.frame = CGRectMake(184+x, 248+x-y, 165, 21);
			lbl_NotesStatic.frame = CGRectMake(112+x, 285+x-y, 46, 21);
			//lbl_Notes.frame = CGRectMake(110+x, 300+x-y, 245, 21);
//			lbl_AddressStatic.frame = CGRectMake(360+x, 200+x-y, 66, 21);
//			lbl_Address.frame = CGRectMake(360+x, 223+x-y, 200, 100);
//			lbl_Address.numberOfLines=6;
			
			lbl_Notes.frame = CGRectMake(112+x, 288+x-y, 450, 63);
			CGSize maximumLabelSize = CGSizeMake(450,9999);
			CGSize expectedLabelSize = [lbl_Notes.text sizeWithFont:lbl_Notes.font constrainedToSize:maximumLabelSize lineBreakMode:lbl_Notes.lineBreakMode];
			CGRect newFrame = lbl_Notes.frame;
			newFrame.size.height = expectedLabelSize.height;
			lbl_Notes.frame = newFrame;
			lbl_Notes.numberOfLines=0; 
			lbl_AddressStatic.frame = CGRectMake(360+x, 200+x-y, 66, 21);
			lbl_Address.frame = CGRectMake(360+x, 203+x-y, 200, 120);
			CGSize maximumLabelSize2 = CGSizeMake(200,9999);
			CGSize expectedLabelSize2 = [lbl_Address.text sizeWithFont:lbl_Address.font constrainedToSize:maximumLabelSize2 lineBreakMode:lbl_Address.lineBreakMode];
			CGRect newFrame2 = lbl_Address.frame;
			newFrame2.size.height = expectedLabelSize2.height;
			lbl_Address.frame = newFrame2;
			lbl_Address.numberOfLines=0;
			
			barCodeImgView.frame = CGRectMake(350, 270, 100, 100);//Jayna131211
			btn_Barcode_ImageProcessingView.frame = CGRectMake(350, 270, 100, 100);//Jayna131211
			
			////  14/12/2011 start
			//BusinessView Lables 
			lbl_CompanyStatic.frame = CGRectMake(110+x, 200+x-y, 76, 21);
			lbl_Company.frame = CGRectMake(180+x, 200+x-y, 165, 21);
			lbl_JobTitleStatic.frame = CGRectMake(110+x, 223+x-y, 79, 21);
			lbl_JobTitle.frame = CGRectMake(175+x, 223+x-y, 162, 21 );
			lbl_NameStatic.frame = CGRectMake(110+x, 248+x-y, 74, 21);
			lbl_Name.frame = CGRectMake(155+x, 248+x-y, 190, 21);
			lbl_EmailStatic.frame = CGRectMake(110+x, 275+x-y, 46, 21);
			lbl_Email.frame = CGRectMake(155+x, 275+x-y, 190, 21);
			lbl_PhoneStatic.frame = CGRectMake(110+x, 300+x-y, 245, 21);
			lbl_Phone.frame = CGRectMake(160+x, 300+x-y, 190, 21);
			lbl_AddressStatic_BusinessCard.frame = CGRectMake(360+x, 200+x-y, 66, 21);
			//lbl_Address_BusinessCard.frame = CGRectMake(360+x, 223+x-y, 200, 100);
//			lbl_Address_BusinessCard.numberOfLines=6;
			
			lbl_Address_BusinessCard.frame = CGRectMake(360+x, 203+x-y, 200, 120);
			CGSize maximumLabelSize24 = CGSizeMake(200,9999);
			CGSize expectedLabelSize24 = [lbl_Address_BusinessCard.text sizeWithFont:lbl_Address_BusinessCard.font constrainedToSize:maximumLabelSize24 lineBreakMode:lbl_Address_BusinessCard.lineBreakMode];
			CGRect newFrame24 = lbl_Address_BusinessCard.frame;
			newFrame24.size.height = expectedLabelSize24.height;
			lbl_Address_BusinessCard.frame = newFrame24;
			lbl_Address_BusinessCard.numberOfLines=0;
			////  14/12/2011 start
			
		}
		else if ([str_TM_SelectedItem isEqualToString:@"Invitation"]||[str_TM_SelectedItem isEqualToString:@"IDBadge"] ){
			ivGradient.frame = CGRectMake(155, 105, 485, 130);
			tv_EventView.frame = CGRectMake(165, 110, 465, 120);
			barCodeImgView.frame = CGRectMake(300, 60+y+x, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(300, 60+y+x, 100, 100);////jayna1512116.18
			//jayna1512116.18
			imgInvitation.frame = CGRectMake(300+100+10, 60+y+x, 100, 100);
			lbl_TitleStatic_Invitation.frame = CGRectMake(150+x, 210+x-y, 76, 21);
			lbl_Title_Invitation.frame = CGRectMake(186+x, 210+x-y, 230, 21);
			lbl_AddressStatic_Invitation.frame = CGRectMake(150+x, 240+x-y, 76, 21);
			lbl_Address_Invitation.frame = CGRectMake(150+x, 243+x-y, 270, 21);
			CGSize maximumLabelSize125 = CGSizeMake(270,9999);
			CGSize expectedLabelSize125 = [lbl_Address_Invitation.text sizeWithFont:lbl_Address_Invitation.font constrainedToSize:maximumLabelSize125 lineBreakMode:lbl_Address_Invitation.lineBreakMode];
			CGRect newFrame125 = lbl_Address_Invitation.frame;
			newFrame125.size.height = expectedLabelSize125.height;
			lbl_Address_Invitation.frame = newFrame125;
			lbl_Address_Invitation.numberOfLines=0;
			
			//for invitation view
			lbl_CompanyStatic_IDBadge.frame = CGRectMake(150+x, 210+x-y, 110, 21);
			lbl_Company_IDBadge.frame = CGRectMake(258+x, 210+x-y, 230, 21);
			lbl_NameStatic_IDBadge.frame = CGRectMake(150+x, 240+x-y, 76, 21);
			lbl_Name_IDBadge.frame = CGRectMake(195+x, 240+x-y, 270, 21);
			lbl_JobTitleStatic_IDBadge.frame = CGRectMake(150+x, 270+x-y, 100, 21);
			lbl_JobTitle_IDBadge.frame = CGRectMake(214+x, 270+x-y, 230, 21);
			
		}
		else{
			ivGradient.frame = CGRectMake(155, 105, 485, 130);
			tv_EventView.frame = CGRectMake(165, 110, 465, 120);
			barCodeImgView.frame = CGRectMake(350, 270, 100, 100);//Jayna131211
			btn_Barcode_ImageProcessingView.frame = CGRectMake(350, 270, 100, 100);//Jayna131211
			/////15/12/2011 start
			//for course info
			lbl_CourseNameStatic.frame = CGRectMake(110+x, 200+x-y, 100, 21);
			lbl_CourseName.frame = CGRectMake(204+x, 200+x-y, 250, 21);
			lbl_CourseCodeStatic.frame = CGRectMake(110+x, 223+x-y, 100, 21);
			lbl_CourseCode.frame = CGRectMake(202+x, 223+x-y, 250, 21);
			lbl_ProfessorStatic.frame = CGRectMake(110+x, 248+x-y, 72, 21);
			lbl_Professor.frame = CGRectMake(181+x, 248+x-y, 250, 21);
			lbl_DateTimeStatic.frame = CGRectMake(110+x, 275+x-y, 100, 21);
			lbl_DateTime.frame = CGRectMake(212+x, 275+x-y, 250, 21);
			/////15/12/2011  end
		}
	}
	else if ([str_flagForAlignmentClick isEqualToString:@"Bottom"]) {
		//ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal.png"];
		if ([str_Flag_Gradient isEqualToString:@"Black"]) {
			ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal-White.png"];
		}
		else {
			ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal.png"];
		}
		int x= 60;
		if ([str_TM_SelectedItem isEqualToString:@"Event"]||[str_TM_SelectedItem isEqualToString:@"BusinessCard"]) {
			ivGradient.frame = CGRectMake(155, 245, 485, 140);
			tv_EventView.frame = CGRectMake(165, 250, 465, 130);
			lbl_EventTitleStatic.frame = CGRectMake(110+x, 200+x, 76, 21);
			lbl_EventTitle.frame = CGRectMake(186+x, 200+x, 165, 21);
			lbl_StartStatic.frame = CGRectMake(110+x, 230+x, 79, 21);
			lbl_Start.frame = CGRectMake(188+x, 230+x, 162, 21);
			lbl_EndStatic.frame = CGRectMake(110+x, 248+x, 74, 21);
			lbl_End.frame = CGRectMake(184+x, 248+x, 165, 21);
			lbl_NotesStatic.frame = CGRectMake(112+x, 285+x, 46, 21);
			//lbl_Notes.frame = CGRectMake(110+x, 300+x, 245, 21);
//			lbl_AddressStatic.frame = CGRectMake(360+x, 200+x, 66, 21);
//			lbl_Address.frame = CGRectMake(360+x, 223+x, 200, 100);
//			lbl_Address.numberOfLines=6;
			
			lbl_Notes.frame = CGRectMake(112+x, 288+x, 450, 63);
			CGSize maximumLabelSize = CGSizeMake(450,9999);
			CGSize expectedLabelSize = [lbl_Notes.text sizeWithFont:lbl_Notes.font constrainedToSize:maximumLabelSize lineBreakMode:lbl_Notes.lineBreakMode];
			CGRect newFrame = lbl_Notes.frame;
			newFrame.size.height = expectedLabelSize.height;
			lbl_Notes.frame = newFrame;
			
			lbl_AddressStatic.frame = CGRectMake(360+x, 200+x, 66, 21);
			lbl_Address.frame = CGRectMake(360+x, 203+x, 200, 120);
			CGSize maximumLabelSize2 = CGSizeMake(200,9999);
			CGSize expectedLabelSize2 = [lbl_Address.text sizeWithFont:lbl_Address.font constrainedToSize:maximumLabelSize2 lineBreakMode:lbl_Address.lineBreakMode];
			CGRect newFrame2 = lbl_Address.frame;
			newFrame2.size.height = expectedLabelSize2.height;
			lbl_Address.frame = newFrame2;
			lbl_Address.numberOfLines=0;
			
			barCodeImgView.frame = CGRectMake(350, 120, 100, 100);//Jayna131211
			btn_Barcode_ImageProcessingView.frame = CGRectMake(350, 120, 100, 100);//Jayna131211
			
			////  14/12/2011 start
			//BusinessView Lables 
			lbl_CompanyStatic.frame = CGRectMake(110+x, 200+x, 76, 21);
			lbl_Company.frame = CGRectMake(180+x, 200+x, 165, 21);
			lbl_JobTitleStatic.frame = CGRectMake(110+x, 223+x, 79, 21);
			lbl_JobTitle.frame = CGRectMake(175+x, 223+x, 162, 21 );
			lbl_NameStatic.frame = CGRectMake(110+x, 248+x, 74, 21);
			lbl_Name.frame = CGRectMake(155+x, 248+x, 190, 21);
			lbl_EmailStatic.frame = CGRectMake(110+x, 275+x, 46, 21);
			lbl_Email.frame = CGRectMake(155+x, 275+x, 190, 21);
			lbl_PhoneStatic.frame = CGRectMake(110+x, 300+x, 245, 21);
			lbl_Phone.frame = CGRectMake(160+x, 300+x, 190, 21);
			lbl_AddressStatic_BusinessCard.frame = CGRectMake(360+x, 200+x, 66, 21);
			//lbl_Address_BusinessCard.frame = CGRectMake(360+x, 223+x, 200, 100);
//			lbl_Address_BusinessCard.numberOfLines=6;
			
			lbl_Address_BusinessCard.frame = CGRectMake(360+x, 203+x, 200, 120);
			CGSize maximumLabelSize26 = CGSizeMake(200,9999);
			CGSize expectedLabelSize26 = [lbl_Address_BusinessCard.text sizeWithFont:lbl_Address_BusinessCard.font constrainedToSize:maximumLabelSize26 lineBreakMode:lbl_Address_BusinessCard.lineBreakMode];
			CGRect newFrame26 = lbl_Address_BusinessCard.frame;
			newFrame26.size.height = expectedLabelSize26.height;
			lbl_Address_BusinessCard.frame = newFrame26;
			lbl_Address_BusinessCard.numberOfLines=0;
			////  14/12/2011 start
		}
		else if ([str_TM_SelectedItem isEqualToString:@"Invitation"]||[str_TM_SelectedItem isEqualToString:@"IDBadge"] ){
			ivGradient.frame = CGRectMake(155, 255, 485, 130);
			tv_EventView.frame = CGRectMake(165, 260, 465, 120);
			barCodeImgView.frame = CGRectMake(235+x, 60+x, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(235+x, 60+x, 100, 100);////jayna1512116.18
			//jayna1512116.18
			imgInvitation.frame = CGRectMake(235+100+10+x, 60+x, 100, 100);
			
			lbl_TitleStatic_Invitation.frame = CGRectMake(150+x, 210+x, 76, 21);
			lbl_Title_Invitation.frame = CGRectMake(186+x, 210+x, 230, 21);
			lbl_AddressStatic_Invitation.frame = CGRectMake(150+x, 240+x, 76, 21);
			lbl_Address_Invitation.frame = CGRectMake(150+x, 243+x, 270, 21);
			CGSize maximumLabelSize125 = CGSizeMake(270,9999);
			CGSize expectedLabelSize125 = [lbl_Address_Invitation.text sizeWithFont:lbl_Address_Invitation.font constrainedToSize:maximumLabelSize125 lineBreakMode:lbl_Address_Invitation.lineBreakMode];
			CGRect newFrame125 = lbl_Address_Invitation.frame;
			newFrame125.size.height = expectedLabelSize125.height;
			lbl_Address_Invitation.frame = newFrame125;
			lbl_Address_Invitation.numberOfLines=0;
			
			//for invitation view
			lbl_CompanyStatic_IDBadge.frame = CGRectMake(150+x, 210+x, 110, 21);
			lbl_Company_IDBadge.frame = CGRectMake(258+x, 210+x, 230, 21);
			lbl_NameStatic_IDBadge.frame = CGRectMake(150+x, 240+x, 76, 21);
			lbl_Name_IDBadge.frame = CGRectMake(195+x, 240+x, 270, 21);
			lbl_JobTitleStatic_IDBadge.frame = CGRectMake(150+x, 270+x, 100, 21);
			lbl_JobTitle_IDBadge.frame = CGRectMake(214+x, 270+x, 230, 21);
		}
		else {
			ivGradient.frame = CGRectMake(155, 255, 485, 130);
			tv_EventView.frame = CGRectMake(165, 260, 465, 120);
			barCodeImgView.frame = CGRectMake(350, 120, 100, 100);//Jayna131211
			btn_Barcode_ImageProcessingView.frame = CGRectMake(350, 120, 100, 100);//Jayna131211
			/////15/12/2011 start
			//for course info
			int p=10;
			lbl_CourseNameStatic.frame = CGRectMake(110+x, 200+x+p, 100, 21);
			lbl_CourseName.frame = CGRectMake(204+x, 200+x+p, 250, 21);
			lbl_CourseCodeStatic.frame = CGRectMake(110+x, 223+x+p, 100, 21);
			lbl_CourseCode.frame = CGRectMake(202+x, 223+x+p, 250, 21);
			lbl_ProfessorStatic.frame = CGRectMake(110+x, 248+x+p, 72, 21);
			lbl_Professor.frame = CGRectMake(181+x, 248+x+p, 250, 21);
			lbl_DateTimeStatic.frame = CGRectMake(110+x, 275+x+p, 100, 21);
			lbl_DateTime.frame = CGRectMake(212+x, 275+x+p, 250, 21);
			/////15/12/2011  end
		}
	}
	
	PreviewShareView.frame = CGRectMake(0,0,1024, 670);
	
	//imgBGShare.frame = CGRectMake(0,0,1024, 58);
	//imgtemplate.frame = CGRectMake((820-465)/2, (630-290)/2,465,290);
	if ([strFlag isEqualToString:@"UCD"])
	{
		imgtemplate.frame = CGRectMake(162, 105,467,290);//jayna16121114.44	
	}
	else {
		imgtemplate.frame = CGRectMake(148, 100,ivMainImage.frame.size.width+5,290);
	}
	
	shareKitView.frame = CGRectMake(-7,670-57,1024, 67);//jayna16121114.44
	imgBGShare.frame = CGRectMake(0,0,1024, 67);//jayna16121114.44
	
	ftbimage.image = [UIImage imageNamed:@"_0001_landscape.png"];
	
	
	//jayna16121114.44
	CGFloat x=170;
	btnFacebook.frame = CGRectMake(x+15,12,42,43);
	x+=43+100;
	btnTwitter.frame = CGRectMake(x,12,42,43);
	x+=43+100;
	btnEmail.frame = CGRectMake(x-8,12,42,43);
	x+=43+100;
	btnTrash.frame = CGRectMake(x-19,12,42,43);
	//btn_Plus.frame=CGRectMake(880, 5, 33, 30);
	//btn_Plus.frame=CGRectMake(lbl_TemplateTitle.frame.origin.x + lbl_TemplateTitle.frame.size.width , 5, 33, 30);

}
-(IBAction)onPlusClick
{
	txt_EventTitle.text=@"";
	txt_Address.text=@"";
	txt_Start.text=@"";
	txt_End.text=@"";
	txt_City.text=@"";
	txt_State.text=@"";
	txt_ZipCode.text=@"";
	txt_Country.text=@"";
	txt_CompanyName.text=@"";
	txt_Name.text=@"";
	txt_JobTitle.text=@"";
	txt_Email.text=@"";
	txt_Phone.text=@"";
	txt_Add.text=@"";
	txt_City_BusinessCard.text=@"";
	txt_State_BusinessCard.text=@"";
	txt_ZipCode_BusinessCard.text=@"";
	txt_Country_BusinessCard.text=@"";
	txt_Title_Invitation.text=@"";
	txt_Add_Invitation.text=@"";
	txt_City_Invitation.text=@"";
	txt_State_Invitation.text=@"";
	txt_ZipCode_Invitation.text=@"";
	txt_Country_Invitation.text=@"";
	PreviewShareView.hidden=TRUE;
	imageProcessingView.hidden=TRUE;
	btn_Plus.hidden=TRUE;
	[self addCoverFlow];
	[self onClickUDT:nil];
}
-(IBAction)onClickUDT:(id)sender
{
	btn_Plus.hidden=TRUE;
	[self addCoverFlow];
	strFlag = @"UDT";
	btnCreate.enabled=TRUE;
	[btnCreate setBackgroundImage:[UIImage imageNamed:@"choose.png"] forState:UIControlStateNormal];
	libraryView.hidden = YES;
	PreviewShareView.hidden = YES;
	libraryView.hidden=TRUE;
	coverFloWView.hidden=FALSE;
	
	eventView.hidden=TRUE;
	businessView.hidden=TRUE;
	invitationView.hidden=TRUE;
	idbadgeView.hidden=TRUE;
	courseinfoView.hidden=TRUE;
	btn_Back.hidden=TRUE;
	
	lbl_TemplateTitle.text = @"Use Designed Templates";
	[btn_UDT setBackgroundImage:[UIImage imageNamed:@"UDT_Black.png"] forState:UIControlStateNormal];
	[btn_UCD setBackgroundImage:[UIImage imageNamed:@"UCD_Red.png"] forState:UIControlStateNormal];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo
{
	printf("\n inside the picker control");
	if ([picker sourceType] == UIImagePickerControllerSourceTypeCamera){
		// save the image to the photo library
		UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
	}else
	{
		printf("\n in else of picker");
	}
	
    UIImageOrientation    originalOrientation = img.imageOrientation;
	
	[self rotateImage:img byOrientationFlag:originalOrientation];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
	{
		[self dismissPopover];
	}
	
}
#pragma mark colorSelection
ViewController	*obj_ViewController;
UIPopoverController *dateSelection;
-(void)bg_ChangeTempColor
{
 	if([appDel.bgTempColor isEqual:[UIColor clearColor]])
	{}
	else
		//ivMainImage.image = [self changeColor:ivMainImage.image _Uicolor:appDel.bgTempColor];
		[self ChangeViewColor:appDel.bgTempColor];
		////ivMainImage.image = [self changeColor:ivMainImage.image _Uicolor:[UIColor blackColor]];
		
}
-(IBAction)onColorPickerClick
{
	obj_ViewController=[[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:[NSBundle mainBundle]];
	UINavigationController* tempNav=[[UINavigationController alloc] initWithRootViewController:obj_ViewController];
	dateSelection=[[UIPopoverController alloc] initWithContentViewController:tempNav];
	
	//obj_DatePicker.delegate=self;
	obj_ViewController.Colordelegate = self;
	dateSelection.popoverContentSize = CGSizeMake(230, 150);
	[dateSelection presentPopoverFromRect:btn_ColorPicker.frame inView:imageProcessingView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
	[tempNav release];
}
-(IBAction)onOpenCameraClick
{
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
		imagePickerController = [[UIImagePickerController alloc] init];	
		imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		imagePickerController.delegate = self;
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
		{
			if(photoPop)
				[self dismissPopover];
			
			
			photoPop=[[UIPopoverController alloc] initWithContentViewController:imagePickerController];
			photoPop.delegate=self;
			//[photoPop presentPopoverFromBarButtonItem:b permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
			if (FlagForPhotoFromInvitation==TRUE) {
				//FlagForPhotoFromInvitation=FALSE;
				if([str_TM_SelectedItem isEqualToString:@"IDBadge"])
					[photoPop presentPopoverFromRect:CGRectMake(ivPhoto_IDBadge.frame.origin.x+70, ivPhoto_IDBadge.frame.origin.y+20, ivPhoto_IDBadge.frame.size.width, ivPhoto_IDBadge.frame.size.height) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
				else
					[photoPop presentPopoverFromRect:CGRectMake(ivPhoto_Invitation.frame.origin.x+70, ivPhoto_Invitation.frame.origin.y+20, ivPhoto_Invitation.frame.size.width, ivPhoto_Invitation.frame.size.height) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
			}
			else {
				[photoPop presentPopoverFromRect:btn_OpenCamera.frame inView:imageProcessingView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
			} 

			
		}
	}
}
-(IBAction)onOpenCameraClick_UCD
{
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
		imagePickerController = [[UIImagePickerController alloc] init];	
		imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		imagePickerController.delegate = self;
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
		{
			if(photoPop)
				[self dismissPopover];
			photoPop=[[UIPopoverController alloc] initWithContentViewController:imagePickerController];
			photoPop.delegate=self;
			[photoPop presentPopoverFromRect:btn_OpenCamera_UCD.frame inView:libraryView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
		}
	}
}

#pragma mark For imageProcessingView Clicks

//Jayna
-(IBAction)onCreateClick_ImageProcessing
{
	btn_Plus.hidden=FALSE;
	flagImgPrcsBack=TRUE;
	
	//imageProcessingView.hidden = TRUE;
	UIImage *newImage;
	CGRect  cropRect;
	if([imgtemplate retainCount] > 0)
	{
		[imgtemplate removeFromSuperview];
		[imgtemplate release];
		imgtemplate = nil;
	}
	imgtemplate = [[UIImageView alloc] initWithFrame:CGRectZero];
	imgtemplate.backgroundColor = [UIColor blueColor];
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		if ([strFlag isEqualToString:@"UCD"])
		{
			//newImage = [self captureScreenInRect:CGRectMake(90,160,465,290)];//jayna16121114.44
//			imgtemplate.frame = CGRectMake(90, 160,465,290);
//			cropRect = CGRectMake(90,160,465,290);//jayna16121114.44
		}
		else {
			newImage = [self captureScreenInRect:CGRectMake(ivMainImage.frame.origin.x+34,ivMainImage.frame.origin.y+40,494,290)];//jayna16121114.44
			imgtemplate.frame = CGRectMake(90, 37,ivMainImage.frame.size.width,290);
			cropRect = CGRectMake(ivMainImage.frame.origin.x+34,ivMainImage.frame.origin.y+40,494,290);//jayna16121114.44
		}
		PreviewShareView.frame = CGRectMake(0,0,800, 810);
		shareKitView.frame = CGRectMake(0,810-59,800, 67);//jayna16121114.44
		imgBGShare.frame = CGRectMake(0,0,800, 67);//jayna16121114.44
		//imgtemplate.frame = CGRectMake(100,350,466,466);
		
		//jayna16121114.44
		CGFloat x=100;
		btnFacebook.frame = CGRectMake(x+15,12,42,43);
		x+=43+100;
		btnTwitter.frame = CGRectMake(x,12,42,43);
		x+=43+100;
		btnEmail.frame = CGRectMake(x-8,12,42,43);
		x+=43+100;
		btnTrash.frame = CGRectMake(x-19,12,42,43);
		[imageProcessingView addSubview:PreviewShareView];
	}
	else {
		/*if(firstTime == FALSE)
			newImage = [self captureScreenInRect:CGRectMake(ivMainImage.frame.origin.x+150,ivMainImage.frame.origin.y+40,490,290)];//jayna16121114.44
		else
			newImage = [self captureScreenInRect:CGRectMake(ivMainImage.frame.origin.x+153,ivMainImage.frame.origin.y+40,490,290)];//jayna16121114.44
		*/
		//if(oncePort == TRUE){
			newImage = [self captureScreenInRect:CGRectMake(ivMainImage.frame.origin.x+128,ivMainImage.frame.origin.y+40,500,290)];//jayna16121114.44
			imgtemplate.frame = CGRectMake(148, 100,ivMainImage.frame.size.width+5,290);//jayna16121114.44	
			cropRect = CGRectMake(ivMainImage.frame.origin.x+128,ivMainImage.frame.origin.y+40,500,290);//jayna16121114.44
		//}
//		else {
//			newImage = [self captureScreenInRect:CGRectMake(ivMainImage.frame.origin.x+148,ivMainImage.frame.origin.y+40,500,290)];//jayna16121114.44
//			imgtemplate.frame = CGRectMake(148, 100,ivMainImage.frame.size.width+5,290);//jayna16121114.44	
//			cropRect = CGRectMake(ivMainImage.frame.origin.x+148,ivMainImage.frame.origin.y+40,500,290);//jayna16121114.44
//		}
		PreviewShareView.frame = CGRectMake(0,0,1024, 670);
		shareKitView.frame = CGRectMake(-7,670-57,1024, 67);//jayna16121114.44
		imgBGShare.frame = CGRectMake(0,0,1024, 67);//jayna16121114.44
		

		CGFloat x=170;
		btnFacebook.frame = CGRectMake(x+15,12,42,43);
		x+=43+100;
		btnTwitter.frame = CGRectMake(x,12,42,43);
		x+=43+100;
		btnEmail.frame = CGRectMake(x-8,12,42,43);
		x+=43+100;
		btnTrash.frame = CGRectMake(x-19,12,42,43);
		
		[imageProcessingView addSubview:PreviewShareView];
		
	}
	if ([strFlag isEqualToString:@"UCD"])
	{
		if(appDel.ori == UIInterfaceOrientationPortrait ||
		   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
		{
			//newImage = [self captureScreenInRect:CGRectMake(ivLibrary.frame.origin.x+36,ivLibrary.frame.origin.y+50,465,290)];//jayna16121114.44
//			cropRect = CGRectMake(ivLibrary.frame.origin.x+36,ivLibrary.frame.origin.y+50,465,290);//jayna16121114.44
//			imgtemplate.frame = CGRectMake(ivLibrary.frame.origin.x,ivLibrary.frame.origin.y,465,290);
			newImage = [self captureScreenInRect:CGRectMake(ivLibrary.frame.origin.x+30,ivLibrary.frame.origin.y+40,465,290)];//jayna16121114.44
			cropRect = CGRectMake(ivLibrary.frame.origin.x+30,ivLibrary.frame.origin.y+40,465,290);//jayna16121114.44
			imgtemplate.frame = CGRectMake(ivLibrary.frame.origin.x-3, ivLibrary.frame.origin.y,467,290);//jayna16121114.44
		}
		else {
			//if(oncePort == TRUE){
				newImage = [self captureScreenInRect:CGRectMake(ivLibrary.frame.origin.x+108+20,ivLibrary.frame.origin.y+40,467,290)];//jayna16121114.44
				cropRect = CGRectMake(ivLibrary.frame.origin.x+108+20,ivLibrary.frame.origin.y+40,467,290);//jayna16121114.44
				imgtemplate.frame = CGRectMake(162, 105,467,290);//jayna16121114.44	
			//}
//			else {
//				newImage = [self captureScreenInRect:CGRectMake(ivLibrary.frame.origin.x+128+20,ivLibrary.frame.origin.y+40,467,290)];//jayna16121114.44
//				cropRect = CGRectMake(ivLibrary.frame.origin.x+128+20,ivLibrary.frame.origin.y+40,467,290);//jayna16121114.44
//				imgtemplate.frame = CGRectMake(162, 105,467,290);//jayna16121114.44	
//			}
			
		}

			//newImage = [self captureScreenInRect:libraryView.frame];//jayna16121114.44
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString* path = [documentsDirectory stringByAppendingPathComponent: 
						  [NSString stringWithFormat:@"%@",@"Jayna.png"] ];
		NSData* data = UIImagePNGRepresentation(newImage);
		[data writeToFile:path atomically:YES];
		
	}
	
	/*******/
	
	CGImageRef imageRef = CGImageCreateWithImageInRect([newImage CGImage], cropRect);
	
	UIImage *image = [UIImage imageWithCGImage:imageRef]; 
	CGImageRelease(imageRef);
	/**********/
	PreviewShareView.hidden=FALSE;
	imgtemplate.contentMode = UIViewContentModeScaleToFill;
	imgtemplate.image = image;
	//imgtemplate.image = [UIImage imageNamed:@"CourseInfo-bg.png"];
	[PreviewShareView addSubview:imgtemplate];
	
	[self saveToLibSection:image];//jayna151211
	
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (alertView.tag==1000) {
		if (buttonIndex==1) {
			barCodeImgView.image=nil;
			if ([str_TM_SelectedItem isEqualToString:@"Event"] ) {
				ivBarcode.image=[UIImage imageNamed:@"ivBackground.png"];
			}
			if ([str_TM_SelectedItem isEqualToString:@"BusinessCard"] ) {
				ivBarcode_BusinessCard.image=[UIImage imageNamed:@"ivBackground.png"];
			}
			if ([str_TM_SelectedItem isEqualToString:@"Invitation"] ) {
				ivBarcode_Invitation.image=[UIImage imageNamed:@"ivBackground.png"];
			}
			if ([str_TM_SelectedItem isEqualToString:@"IDBadge"] ) {
				ivBarcode_IDBadge.image=[UIImage imageNamed:@"ivBackground.png"];
			}
			if ([str_TM_SelectedItem isEqualToString:@"CourseInfo"] ) {
				ivBarcode_CourseInfo.image=[UIImage imageNamed:@"ivBackground.png"];
			}
		}
	}
	if (buttonIndex==1) {
		barCodeImgView.image=nil;
		if ([str_TM_SelectedItem isEqualToString:@"Event"] ) {
			ivBarcode.image=[UIImage imageNamed:@"ivBackground.png"];
		}
		if ([str_TM_SelectedItem isEqualToString:@"BusinessCard"] ) {
			ivBarcode_BusinessCard.image=[UIImage imageNamed:@"ivBackground.png"];
		}
		if ([str_TM_SelectedItem isEqualToString:@"Invitation"] ) {
			ivBarcode_Invitation.image=[UIImage imageNamed:@"ivBackground.png"];
		}
		if ([str_TM_SelectedItem isEqualToString:@"IDBadge"] ) {
			ivBarcode_IDBadge.image=[UIImage imageNamed:@"ivBackground.png"];
		}
		if ([str_TM_SelectedItem isEqualToString:@"CourseInfo"] ) {
			ivBarcode_CourseInfo.image=[UIImage imageNamed:@"ivBackground.png"];
		}
	}
}
-(IBAction)onBarcodeClick_ImageProcessingView
{
	UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure, you want to delete QR Code?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
	[av show];
	[av release];
}
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
/*********/

#pragma mark Save in Library Section

-(NSString *)TimeandDate{
	
	//Date
	NSDate* date = [NSDate date];
	NSDateFormatter *Date1=[[[NSDateFormatter alloc] init] autorelease];
	[Date1 setDateFormat:@"E MM/dd/yy"];
	//[Date1 setDateFormat:@"MMMM dd, yyyy"];
	NSString *Date12=[Date1 stringFromDate:date];    
	NSLog(@"Date: %@", Date12);
	//Time
	NSDateFormatter *Time1=[[[NSDateFormatter alloc] init] autorelease];
	[Time1 setDateFormat:@"h:mm aaa"];
	NSString *Time12=[Time1 stringFromDate:date];    
	NSLog(@"Date: %@",Time12);
	NSString *createdDate = [NSString stringWithFormat:@"Created on %@",Date12];
	//Time12 = [Time12 stringByReplacingOccurrencesOfString:@"PM" withString:@"P.M."];
	//Time12 = [Time12 stringByReplacingOccurrencesOfString:@"AM" withString:@"A.M."];
	//[TimeLabel setText:Time12];
	return createdDate;
}

-(void)saveToLibSection:(UIImage *)img
{
	NSString *createdDate = [self TimeandDate];
	
	NSString *sql = [NSString stringWithFormat:@"select *from library"];
	NSMutableArray *array=[DAL ExecuteArraySet:sql];
	
	UIImage *newImage = img;
	
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MM-dd-yyyy-HH-mm-ss"];
	
	NSString * date = [dateFormatter stringFromDate:[NSDate date]];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString* path = [documentsDirectory stringByAppendingPathComponent: 
					  [NSString stringWithFormat:@"qr%@.png",date]];
	NSData* data = UIImagePNGRepresentation(newImage);
	[data writeToFile:path atomically:YES];
	if ([strFlag isEqualToString:@"UCD"])
	{
		[DAL insert_library_CreatedDate:createdDate 
								  Image:[NSString stringWithFormat:@"qr%@.png",date] 
							   Category:@"Event"
							Description:@""
						  starting_Date:@""
							Ending_Date:@""
								Address:@""
								  Links:@"NODATA" 
								  Email:@"NODATA" 
							  Locations:@"NODATA" 
								Message:@"NODATA" 
							 Department:@"NODATA" 
									Job:@"NODATA" 
								 Suffix:@"NODATA" 
							 MiddleName:@"NODATA" 
							   LastName:@"NODATA" 
							  FirstName:@"NODATA" 
								 Prefix:@"NODATA" 
								PhoneNo:@"NODATA" 
								Subject:@"NODATA" 
								  Notes:[NSString stringWithFormat:@"%@",tv_Notes.text]];
	}
	else {

	if ([str_TM_SelectedItem isEqualToString:@"Event"]) {
		
	NSString *address = [NSString stringWithFormat:@"%@",lbl_Address.text];
	[DAL insert_library_CreatedDate:createdDate 
							  Image:[NSString stringWithFormat:@"qr%@.png",date] 
						   Category:[NSString stringWithFormat:@"%@",str_TM_SelectedItem]
						Description:[NSString stringWithFormat:@"%@",lbl_EventTitle.text]
					  starting_Date:[NSString stringWithFormat:@"%@",lbl_Start.text]
						Ending_Date:[NSString stringWithFormat:@"%@",lbl_End.text]
							Address:[NSString stringWithFormat:@"%@",strAddressTOpassLibrary_Event]
							  Links:@"NODATA" 
							  Email:@"NODATA" 
						  Locations:@"NODATA" 
							Message:@"NODATA" 
						 Department:@"NODATA" 
								Job:@"NODATA" 
							 Suffix:@"NODATA" 
						 MiddleName:@"NODATA" 
						   LastName:@"NODATA" 
						  FirstName:@"NODATA" 
							 Prefix:@"NODATA" 
							PhoneNo:@"NODATA" 
							Subject:@"NODATA" 
							  Notes:[NSString stringWithFormat:@"%@",tv_Notes.text]];
	
	}
	if ([str_TM_SelectedItem isEqualToString:@"BusinessCard"])
	{
		[DAL insert_library_CreatedDate:createdDate 
								  Image:[NSString stringWithFormat:@"qr%@.png",date] 
							   Category:[NSString stringWithFormat:@"%@",str_TM_SelectedItem]
							Description:[NSString stringWithFormat:@"%@",lbl_Company.text]
						  starting_Date:@"NODATA"
							Ending_Date:@"NODATA"
								Address:[NSString stringWithFormat:@"%@",strAddressTOpassLibrary_BusinessCard]
								  Links:@"NODATA" 
								  Email:[NSString stringWithFormat:@"%@",lbl_Email.text]
							  Locations:[NSString stringWithFormat:@"%@",[lbl_CompanyStatic.text stringByReplacingOccurrencesOfString:@"Company:" withString:@"Company Name"]]
								Message:@"NODATA" 
							 Department:@"NODATA" 
									Job:[NSString stringWithFormat:@"%@",lbl_JobTitle.text]
								 Suffix:@"NODATA" 
							 MiddleName:@"NODATA" 
							   LastName:@"NODATA" 
							  FirstName:[NSString stringWithFormat:@"%@",lbl_Name.text]
								 Prefix:@"NODATA" 
								PhoneNo:[NSString stringWithFormat:@"%@",lbl_Phone.text]
								Subject:@"NODATA" 
								  Notes:@"NODATA" ];
	}
	if ([str_TM_SelectedItem isEqualToString:@"Invitation"] ) {
		[DAL insert_library_CreatedDate:createdDate 
								  Image:[NSString stringWithFormat:@"qr%@.png",date] 
							   Category:[NSString stringWithFormat:@"%@",str_TM_SelectedItem]
							Description:[NSString stringWithFormat:@"%@",lbl_Title_Invitation.text]
						  starting_Date:@"NODATA"
							Ending_Date:@"NODATA"
								Address:[NSString stringWithFormat:@"%@",strAddressTOpassLibrary_Invitaion]
								  Links:@"NODATA" 
								  Email:@"NODATA" 
							  Locations:[NSString stringWithFormat:@"%@",[lbl_TitleStatic_Invitation.text stringByReplacingOccurrencesOfString:@":" withString:@""]] 
								Message:@"NODATA" 
							 Department:@"NODATA" 
									Job:@"NODATA" 
								 Suffix:@"NODATA" 
							 MiddleName:@"NODATA" 
							   LastName:@"NODATA" 
							  FirstName:@"NODATA" 
								 Prefix:@"NODATA" 
								PhoneNo:@"NODATA" 
								Subject:@"NODATA" 
								  Notes:@"NODATA"];
	}
	if ([str_TM_SelectedItem isEqualToString:@"IDBadge"])
	{
		[DAL insert_library_CreatedDate:createdDate 
								  Image:[NSString stringWithFormat:@"qr%@.png",date] 
							   Category:[NSString stringWithFormat:@"%@",str_TM_SelectedItem]
							Description:[NSString stringWithFormat:@"%@",lbl_Company_IDBadge.text]
						  starting_Date:@"NODATA" 
							Ending_Date:@"NODATA" 
								Address:@"NODATA" 
								  Links:@"NODATA" 
								  Email:@"NODATA" 
							  Locations:[NSString stringWithFormat:@"%@",[lbl_CompanyStatic_IDBadge.text stringByReplacingOccurrencesOfString:@":" withString:@""]] 
								Message:@"NODATA" 
							 Department:@"NODATA" 
									Job:[NSString stringWithFormat:@"%@",lbl_JobTitle_IDBadge.text]
								 Suffix:@"NODATA" 
							 MiddleName:@"NODATA" 
							   LastName:@"NODATA" 
							  FirstName:[NSString stringWithFormat:@"%@",lbl_Name_IDBadge.text]
								 Prefix:@"NODATA" 
								PhoneNo:@"NODATA" 
								Subject:@"NODATA" 
								  Notes:@"NODATA" ];
	}
	if ([str_TM_SelectedItem isEqualToString:@"CourseInfo"] ) {
		[DAL insert_library_CreatedDate:createdDate 
								  Image:[NSString stringWithFormat:@"qr%@.png",date] 
							   Category:[NSString stringWithFormat:@"%@",str_TM_SelectedItem]
							Description:[NSString stringWithFormat:@"%@",lbl_CourseName.text]
						  starting_Date:@"NODATA" 
							Ending_Date:@"NODATA" 
								Address:@"NODATA" 
								  Links:[NSString stringWithFormat:@"%@",lbl_DateTime.text]
								  Email:@"NODATA" 
							  Locations:[NSString stringWithFormat:@"%@",[lbl_CourseNameStatic.text stringByReplacingOccurrencesOfString:@":" withString:@""]] 
								Message:[NSString stringWithFormat:@"%@",lbl_Professor.text]
							 Department:[NSString stringWithFormat:@"%@",lbl_CourseCode.text]
									Job:@"NODATA" 
								 Suffix:@"NODATA" 
							 MiddleName:@"NODATA" 
							   LastName:@"NODATA" 
							  FirstName:@"NODATA" 
								 Prefix:@"NODATA" 
								PhoneNo:@"NODATA" 
								Subject:@"NODATA" 
								  Notes:@"NODATA" ];
	}
	}
	//[DAL insert_library_CreatedDate:createdDate Image:[NSString stringWithFormat:@"qr%d.png",[array count]+1]  Category:@"NODATA" Description:@"NODATA" starting_Date:@"NODATA" Ending_Date:@"NODATA" Address:@"NODATA" Links:@"NODATA" Email:@"NODATA" Locations:@"NODATA"];
}

#pragma mark Trash Click jayna151211
-(IBAction)btnTrashClick:(id)sender
{
	if([imgtemplate retainCount] > 0)
	{
		NSString *sql = [NSString stringWithFormat:@"select Image from library where Image =(SELECT MAX(Image) from library)"];
		NSMutableArray *array=[DAL ExecuteArraySet:sql];
		
		NSString  *sql1 =[NSString stringWithFormat:@"delete from library where Image = '%@' ",[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"Image"]]];
		
		 [DAL ExecuteArraySet:sql1];
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString * pdfname = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"Image"]]];	
		[[NSFileManager defaultManager] removeItemAtPath:pdfname error:nil];
		
		[imgtemplate removeFromSuperview];
		[imgtemplate release];
		imgtemplate = nil;
		
		PreviewShareView.hidden = YES;
		imageProcessingView.hidden = YES;
		[self onClickUDT:nil];
	}
	
	else {
		UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please select the QRCode you want to share" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
	}
	
	
}
#pragma mark shareKitView
/*-(IBAction)buttonFacebooKClicked:(id)sender
{
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		//self.view.frame = CGRectMake(80, 0,  945, 1024);
		Topimage.frame = CGRectMake(0,0,768, 48);
		lbl_TemplateTitle.frame = CGRectMake(250,10,294,21);	
		
	}
	else {
		//self.view.frame =CGRectMake(79+22, 0, 1024-79-20, 1007);
		Topimage.frame = CGRectMake(0,0,1024, 48);
		lbl_TemplateTitle.frame = CGRectMake(350,10,294,21);
		
	}
	
	
	
	appDel = (KrenMarketingAppDelegate*)[[UIApplication sharedApplication]delegate];
	NSString *text=@"hello";
	SHKItem *item = [SHKItem image:imgtemplate.image];
	[NSClassFromString(@"SHKFacebook") performSelector:@selector(shareItem:) withObject:item];
	
}
-(IBAction) buttonTwitterClicked:(id)sender
{
	//
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		//self.view.frame = CGRectMake(80, 0,  945, 1024);
		Topimage.frame = CGRectMake(0,0,768, 48);
		lbl_TemplateTitle.frame = CGRectMake(250,10,294,21);	
		
	}
	else {
		//self.view.frame =CGRectMake(79+22, 0, 1024-79-20, 1007);
		Topimage.frame = CGRectMake(0,0,1024, 48);
		lbl_TemplateTitle.frame = CGRectMake(350,10,294,21);
		
	}
	
	
	
	appDel = (KrenMarketingAppDelegate*)[[UIApplication sharedApplication]delegate];
	
	NSString *text=@"hello";
	
	SHKItem *item = [SHKItem image:imgtemplate.image title:nil];
	//SHKItem *item = [SHKItem text:text];
	
	[NSClassFromString(@"SHKTwitter") performSelector:@selector(shareItem:) withObject:item];
	
	//[NSClassFromString(@"SHKTwitter") performSelector:@selector(shareItem:) withObject:item];
	
}*/
/*-(IBAction)emailbtn_click:(id)sender
{
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		//self.view.frame = CGRectMake(80, 0,  945, 1024);
		Topimage.frame = CGRectMake(0,0,768, 48);
		lbl_TemplateTitle.frame = CGRectMake(0,10,768,21);    
		
	}
	else {
		//self.view.frame =CGRectMake(79+22, 0, 1024-79-20, 1007);
		Topimage.frame = CGRectMake(0,0,1024, 48);
		lbl_TemplateTitle.frame = CGRectMake(-20,10,1024,21);
		
		oncePort = TRUE;//jayna151211
		[self setFrameOrientation_LandScap];//jayna151211
		
	}
	
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
	
	
}*/
#pragma mark shareKitView
#pragma mark shareKitView
-(IBAction)buttonFacebooKClicked:(id)sender
{
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		//self.view.frame = CGRectMake(80, 0,  945, 1024);
		Topimage.frame = CGRectMake(0,0,768, 48);
		//lbl_TemplateTitle.frame = CGRectMake(-37,5,768,30); 	
		
	}
	else {
		//self.view.frame =CGRectMake(79+22, 0, 1024-79-20, 1007);
		Topimage.frame = CGRectMake(0,0,1024, 48);
		//lbl_TemplateTitle.frame = CGRectMake(0,5,1024,30);
		
	}
	
	
	
	appDel = (KrenMarketingAppDelegate*)[[UIApplication sharedApplication]delegate];
	NSString *text=@"hello";
	SHKItem *item = [SHKItem image:imgtemplate.image];
	[NSClassFromString(@"SHKFacebook") performSelector:@selector(shareItem:) withObject:item];
	
}

-(IBAction) buttonTwitterClicked:(id)sender
{
	//
	appDel.fromTwitter = TRUE;
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		//self.view.frame = CGRectMake(80, 0,  945, 1024);
		Topimage.frame = CGRectMake(0,0,768, 48);
		//lbl_TemplateTitle.frame = CGRectMake(-37,5,768,30);    
		
	}
	else {
		
		//self.view.frame =CGRectMake(79+22, 0, 1024-79-20, 1007);
		Topimage.frame = CGRectMake(0,0,1024, 48);
		//lbl_TemplateTitle.frame = CGRectMake(0,5,1024,30);
		
	}
	
	
	
	appDel = (KrenMarketingAppDelegate*)[[UIApplication sharedApplication]delegate];
	
	NSString *text=@"hello";
	
	SHKItem *item = [SHKItem image:imgtemplate.image title:nil];
	//SHKItem *item = [SHKItem text:text];
	
	[NSClassFromString(@"SHKTwitter") performSelector:@selector(shareItem:) withObject:item];
	
}
																														 
-(IBAction)emailbtn_click:(id)sender
{
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		//self.view.frame = CGRectMake(80, 0,  945, 1024);
		Topimage.frame = CGRectMake(0,0,768, 48);
		//lbl_TemplateTitle.frame = CGRectMake(-37,5,768,30);    
		
	}
	else {
		//self.view.frame =CGRectMake(79+22, 0, 1024-79-20, 1007);
		Topimage.frame = CGRectMake(0,0,1024, 48);
		//lbl_TemplateTitle.frame = CGRectMake(0,5,1024,30);
		
		oncePort = TRUE;//jayna151211
		[self setFrameOrientation_LandScap];//jayna151211
		
	}
	
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
	
	
}
-(void)displayComposerSheet
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	NSData *imgData = UIImagePNGRepresentation(imgtemplate.image);
	[picker addAttachmentData:imgData mimeType:@"image/png" fileName:@"Result"];//[tmpBody release];
	
	
	picker.modalPresentationStyle =UIModalPresentationFormSheet;
	picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[appDel.viewController presentModalViewController:picker animated:YES];
    //[picker release];
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

#pragma mark Change imageColor
-(void)ChangeViewColor:(UIColor*)colorMy
{
	colorView.backgroundColor = colorMy;
}
- (UIImage *) changeColor: (UIImage *)image _Uicolor:(UIColor *)colorMy {
	
	
	
	CGColorRef color = [colorMy CGColor];
	//UIView *colorView;
	//colorView.backgroundColor = colorMy;
	
	/*const CGFloat *components = CGColorGetComponents(color);
	
	CGFloat red1 = components[0];
	CGFloat green1 = components[1];
	CGFloat blue1 = components[2];*/
	
	
	
	CGFloat red = 0;
	CGFloat green = 0;
	CGFloat blue =0;
	
	int numComponents = CGColorGetNumberOfComponents(color);
	if(numComponents == 4)
	{
		const CGFloat *components = CGColorGetComponents(color);
		
		red = components[0];
		green = components[1];
		blue = components[2];
	}
	else {
		red = 0;
		green = 0;
		blue = 0;
	}

	UIGraphicsBeginImageContext(image.size);
	
	CGRect contextRect;
	contextRect.origin.x = 0.0f;
	contextRect.origin.y = 0.0f;
	contextRect.size = [image size];
	// Retrieve source image and begin image context
	CGSize itemImageSize = [image size];
	CGPoint itemImagePosition;
	itemImagePosition.x = ceilf((contextRect.size.width - itemImageSize.width) / 2);
	itemImagePosition.y = ceilf((contextRect.size.height - itemImageSize.height) );
	UIGraphicsBeginImageContext(contextRect.size);
	CGContextRef c = UIGraphicsGetCurrentContext();
	// Setup shadow
	// Setup transparency layer and clip to mask
	CGContextBeginTransparencyLayer(c, NULL);
	CGContextScaleCTM(c, 1.0, -1.0);
	CGContextClipToMask(c, CGRectMake(itemImagePosition.x, -itemImagePosition.y, itemImageSize.width, -itemImageSize.height), [image CGImage]);
	/*switch (colorSelected) {
		case 0:
			CGContextSetRGBFillColor(c, 0, 0, 1, 1);
			break;
			
		default:
			//CGContextSetRGBFillColor(c, 1,1,1, 1);
			CGContextSetRGBFillColor(c, red, green, blue, 1);
			break;
	}*/
	CGContextSetRGBFillColor(c, red, green, blue, 1);
	contextRect.size.height = -contextRect.size.height;
	contextRect.size.height -= 15;
	// Fill and end the transparency layer
	CGContextFillRect(c, contextRect);
	CGContextEndTransparencyLayer(c);
	
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
														 NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString* path = [documentsDirectory stringByAppendingPathComponent: 
					  [NSString stringWithString: @"testShwetaJayna.png"] ];
	NSData* data = UIImagePNGRepresentation(img);
	[data writeToFile:path atomically:YES];
	
	
	UIGraphicsEndImageContext();
	return img;
}
#pragma mark Convenience Functions for Image Picking

- (UIImage*)rotateImage:(UIImage*)img byOrientationFlag:(UIImageOrientation)orient
{
	
	CGImageRef          imgRef = img.CGImage;
	CGFloat             width = CGImageGetWidth(imgRef);
	CGFloat             height = CGImageGetHeight(imgRef);
	CGAffineTransform   transform = CGAffineTransformIdentity;
	CGRect              bounds = CGRectMake(0, 0, width, height);
	CGSize              imageSize = bounds.size;
	CGFloat             boundHeight;
	
	switch(orient) {
			
		case UIImageOrientationUp: //EXIF = 1
			////NSLog(@"\n    Niketa Checking    123   1\n");
			transform = CGAffineTransformIdentity;
			break;
			
		case UIImageOrientationDown: //EXIF = 3
			////NSLog(@"\n    Niketa Checking    123   2\n");
			transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;
			
		case UIImageOrientationLeft: //EXIF = 6
			////NSLog(@"\n    Niketa Checking    123   3\n");
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		case UIImageOrientationRight: //EXIF = 8
			////NSLog(@"\n    Niketa Checking    123   4\n");
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			//transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		default:
            // image is not auto-rotated by the photo picker, so whatever the user
            // sees is what they expect to get. No modification necessary
			////NSLog(@"\n    Niketa Checking    123   5\n");		
            transform = CGAffineTransformIdentity;
            break;
			
	}
	
	UIGraphicsBeginImageContext(bounds.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// To Test
    if ((orient == UIImageOrientationDown) || (orient == UIImageOrientationRight) || (orient == UIImageOrientationUp)){
        // flip the coordinate space upside down
		CGContextScaleCTM(context, 1, -1);
		CGContextTranslateCTM(context, 0, -height);
    }
	
    CGContextConcatCTM(context, transform);
	//if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
	//	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(229, 300, width, height), imgRef);
	//else 
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
	
	//CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(229, 300, width, height), imgRef);
    imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
	//[imgView setHidden:TRUE];
	//globleImage=imageCopy;
	[ivLibrary setImage:imageCopy];
	btnCreate.enabled=TRUE;
	[btnCreate setBackgroundImage:[UIImage imageNamed:@"create.png"] forState:UIControlStateNormal];
	iv_photoLibImg.contentMode = UIViewContentModeScaleAspectFit;
	iv_photoLibImg.hidden=FALSE;
	[ivPhoto_Invitation setImage:imageCopy];
	[ivPhoto_IDBadge setImage:imageCopy];
	[iv_photoLibImg setImage:imageCopy];
	[imgInvitation setImage:imageCopy];//jayna1512116.18
	//imgView1.backgroundColor=[UIColor redColor];
	
	
    return imageCopy;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
//	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
//		[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications]; 
}


-(IBAction)onClickUCD:(id)sender
{
	btn_Plus.hidden=TRUE;
	[self didRotate:nil];
	strFlag = @"UCD";
	btnCreate.enabled=FALSE;
	ivLibrary.image = [UIImage imageNamed:@"Blank-bg.jpg"];
	[btnCreate setBackgroundImage:[UIImage imageNamed:@"create-deactive.png"] forState:UIControlStateNormal];
	libraryView.hidden=FALSE;
	coverFloWView.hidden=TRUE;
	
	eventView.hidden=TRUE;
	businessView.hidden=TRUE;
	invitationView.hidden=TRUE;
	idbadgeView.hidden=TRUE;
	courseinfoView.hidden=TRUE;
	btn_Back.hidden=TRUE;
	imageProcessingView.hidden=TRUE;
	PreviewShareView.hidden=TRUE;
	barcodeView.hidden=TRUE;
	/*if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
		imagePickerController = [[UIImagePickerController alloc] init];	
		imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		imagePickerController.delegate = self;
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
		{
			if(photoPop)
				[self dismissPopover];
			
			
			photoPop=[[UIPopoverController alloc] initWithContentViewController:imagePickerController];
			photoPop.delegate=self;
			//[photoPop presentPopoverFromBarButtonItem:b permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
			[photoPop presentPopoverFromRect:btn_UCD.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
		}
	}*/
	lbl_TemplateTitle.text = @"Upload a Completed Design";
	[btn_UDT setBackgroundImage:[UIImage imageNamed:@"UDT_Red.png"] forState:UIControlStateNormal];
	[btn_UCD setBackgroundImage:[UIImage imageNamed:@"UCD_Black.png"] forState:UIControlStateNormal];
}

-(IBAction)onEventClick
{
	appDel.mon=FALSE;
	appDel.tue=FALSE;
	appDel.wed=FALSE;
	appDel.thu=FALSE;
	appDel.fri=FALSE;
	appDel.sat=FALSE;
	appDel.sun=FALSE;
	appDel.strStartTime=@"";
	appDel.strEndTime=@"";
	btn_Plus.hidden=TRUE;
	FlagEvent=FALSE;
	if (FlagForCoverFlow==FALSE){}
	else{
		FlagForCoverFlow=FALSE;
		[self addCoverFlow];
	}
	lblNotes.hidden=FALSE;
	tv_Notes.text=@"";
	txt_EventTitle.text=@"";
	txt_Address.text=@"";
	txt_Start.text=@"";
	txt_End.text=@"";
	txt_City.text=@"";
	txt_State.text=@"";
	txt_ZipCode.text=@"";
	txt_Country.text=@"";
	ivBarcode.image=[UIImage imageNamed:@"ivBackground.png"];
	if ([strFlag isEqualToString:@"UDT"]) {
		coverFloWView.hidden=FALSE;
		libraryView.hidden=TRUE;
	}
	else {
		coverFloWView.hidden=TRUE;
		libraryView.hidden=FALSE;
	}
	if(!imageProcessingView.hidden)
	{
		imageProcessingView.hidden=TRUE;
		flagForBackClick=FALSE;
	}
	imageProcessingView.hidden=TRUE;
	PreviewShareView.hidden=TRUE;
	eventView.hidden=TRUE;
	businessView.hidden=TRUE;
	invitationView.hidden=TRUE;
	idbadgeView.hidden=TRUE;
	courseinfoView.hidden=TRUE;
	barcodeView.hidden=TRUE;
	//[self onBackClick];
	str_TM_SelectedItem = @"Event";
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		[btn_Event setBackgroundImage:[UIImage imageNamed:@"event-hover-p.png"] forState:UIControlStateNormal];
		[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard-p.png"] forState:UIControlStateNormal];
		[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation-p.png"] forState:UIControlStateNormal];
		[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge-p.png"] forState:UIControlStateNormal];
		[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo-p.png"] forState:UIControlStateNormal];
		
	}
	else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
			appDel.ori == UIInterfaceOrientationLandscapeRight)
	{
		[btn_Event setBackgroundImage:[UIImage imageNamed:@"event-hover.png"] forState:UIControlStateNormal];
		[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard.png"] forState:UIControlStateNormal];
		[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation.png"] forState:UIControlStateNormal];
		[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge.png"] forState:UIControlStateNormal];
		[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo.png"] forState:UIControlStateNormal];
	}
	
	//for image processing
		//for eventview start
	lbl_EventTitle.hidden=FALSE;
	lbl_EventTitleStatic.hidden=FALSE;
	lbl_Start.hidden=FALSE;
	lbl_StartStatic.hidden=FALSE;
	lbl_End.hidden=FALSE;
	lbl_EndStatic.hidden=FALSE;
	lbl_Notes.hidden=FALSE;
	lbl_NotesStatic.hidden=TRUE;
	lbl_Address.hidden=FALSE;
	//lbl_AddressStatic.hidden=FALSE;
		//for eventview end
	
	
	///////14/12/2011 start
	//for businessview
	lbl_Company.hidden=TRUE;
	lbl_CompanyStatic.hidden=TRUE;
	lbl_JobTitle.hidden=TRUE;
	lbl_JobTitleStatic.hidden=TRUE;
	lbl_Name.hidden=TRUE;
	lbl_NameStatic.hidden=TRUE;
	lbl_Email.hidden=TRUE;
	lbl_EmailStatic.hidden=TRUE;
	lbl_Phone.hidden=TRUE;
	lbl_PhoneStatic.hidden=TRUE;
	lbl_Address_BusinessCard.hidden=TRUE;
	lbl_AddressStatic_BusinessCard.hidden=TRUE;
	
	///////14/12/2011 start
	
	///15/12/2011 start
	// for course ifo view
	lbl_CourseName.hidden=TRUE;
	lbl_CourseNameStatic.hidden=TRUE;
	lbl_CourseCodeStatic.hidden=TRUE;
	lbl_CourseCode.hidden=TRUE;
	lbl_Professor.hidden=TRUE;
	lbl_ProfessorStatic.hidden=TRUE;
	lbl_DateTime.hidden=TRUE;
	lbl_DateTimeStatic.hidden=TRUE;
	
	lbl_Title_Invitation.hidden=TRUE;
	lbl_TitleStatic_Invitation.hidden=TRUE;
	lbl_Address_Invitation.hidden=TRUE;
	lbl_AddressStatic_Invitation.hidden=TRUE;
	
	// for idbadge view
	lbl_Company_IDBadge.hidden=TRUE;
	lbl_CompanyStatic_IDBadge.hidden=TRUE;
	lbl_NameStatic_IDBadge.hidden=TRUE;
	lbl_Name_IDBadge.hidden=TRUE;
	lbl_JobTitle_IDBadge.hidden=TRUE;
	lbl_JobTitleStatic_IDBadge.hidden=TRUE;
	
	//15/12/2011 end
}

-(IBAction)onBarcodeClick_Event
{
	UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"QR Code will be pulled from Library -" message:@"if you'd like to create a new code to add to the template, create QR code in Write section first." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[av show];
	barcodeView.hidden=FALSE;
	NSString *strQuery = @"SELECT *FROM library";
	array_catagory = [DAL ExecuteArraySet:strQuery];
	[array_catagory retain];
	arrImg = [[NSMutableArray alloc]init];
	//[arrImg addObject:[UIImage imageNamed:@"qr3.png"]];
//	[arrImg addObject:[UIImage imageNamed:@"qr1.png"]];
//	[arrImg addObject:[UIImage imageNamed:@"qr2.png"]];
//	[arrImg addObject:[UIImage imageNamed:@"qr2.png"]];
//	[arrImg addObject:[UIImage imageNamed:@"qr2.png"]];
//	[arrImg addObject:[UIImage imageNamed:@"qr2.png"]];
//	[arrImg addObject:[UIImage imageNamed:@"qr2.png"]];
//	[arrImg addObject:[UIImage imageNamed:@"qr2.png"]];
	
	
	
	
	//jayna141211
	for(int i=0;i<[array_catagory count];i++)
	{
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
		NSLog(@"paths : %@",paths);
		NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
		//NSLog(@"documentsDirectory : %@",documentsDirectory);    
		NSString *newPath = documentsDirectory;
		[[NSFileManager defaultManager] createDirectoryAtPath:newPath withIntermediateDirectories:NO attributes:nil error:nil];
		
		
		if (![[NSFileManager defaultManager] fileExistsAtPath:newPath])
		{
			[[NSFileManager defaultManager] createDirectoryAtPath:newPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
		}
		
		NSString * strImage = [newPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[[array_catagory objectAtIndex:i] objectForKey:@"Image"]]];    
		UIImage *image1 = [UIImage imageWithContentsOfFile:strImage];
		[arrImg addObject:image1];
	}
	[tbl_Barcode reloadData];
	/****************/
}
-(IBAction)onContinueClick
{
	FlagEvent=TRUE;
	//[self dismissdatePopOver];
	imgInvitation.hidden = TRUE;//jayna1512116.18
	
	//19/12/2011 deval start
	if (ivBarcode.image==[UIImage imageNamed:@"ivBackground.png"]) {
		barCodeImgView.image=nil;
		btn_Barcode_ImageProcessingView.hidden=TRUE;
		
	}
	else {
		barCodeImgView.image = ivBarcode.image;
		btn_Barcode_ImageProcessingView.hidden=FALSE;
	}
	////19/12/2011 deval end
	flagForBackClick=TRUE;
	imageProcessingView.hidden=FALSE;
	iv_photoLibImg.image=nil;
	[self didRotate:nil];
	ivMainImage.image=vc.img_ImageNameFromFlow;
	if (vc.selectedImageIndex==7) {
		btn_ColorPicker.hidden=FALSE;
		btn_OpenCamera.hidden=FALSE;
		iv_photoLibImg.hidden=FALSE;
		colorView.hidden=FALSE;
	}
	else {
		btn_ColorPicker.hidden=TRUE;
		btn_OpenCamera.hidden=TRUE;
		iv_photoLibImg.hidden=TRUE;
		colorView.hidden=TRUE;
	}

	lbl_EventTitle.text = txt_EventTitle.text;
	lbl_Start.text = txt_Start.text;
	lbl_End.text = txt_End.text;
	NSString *strNote = [NSString stringWithFormat:@"%@",tv_Notes.text] ;
	lbl_Notes.text =strNote;
	//NSString *strAddress = @"               ";
	NSString *strAddress = @"";
	strAddressTOpassLibrary_Event=@"";
	//NSString *strAddress = [NSString stringWithFormat:@"               %@",txt_Address.text] ;
	if (![txt_Address.text isEqualToString:@""]) {
		lbl_Address.hidden=FALSE;
		//lbl_AddressStatic.hidden=FALSE;
		strAddress = [strAddress stringByAppendingString:[NSString stringWithFormat:@"%@\n",txt_Address.text]];	
		strAddressTOpassLibrary_Event = [[strAddressTOpassLibrary_Event stringByAppendingString:[NSString stringWithFormat:@"%@",txt_Address.text]] retain];
	}
	if (![txt_City.text isEqualToString:@""]) {
		if ([strAddress isEqualToString:@""]) {
			strAddress = [strAddress stringByAppendingString:[NSString stringWithFormat:@"%@",txt_City.text]];	
			strAddressTOpassLibrary_Event = [[strAddressTOpassLibrary_Event stringByAppendingString:[NSString stringWithFormat:@"%@",txt_City.text]] retain];
		}
		else {
			strAddressTOpassLibrary_Event = [[strAddressTOpassLibrary_Event stringByAppendingString:[NSString stringWithFormat:@",%@",txt_City.text]] retain];
			strAddress = [strAddress stringByAppendingString:[NSString stringWithFormat:@"%@",txt_City.text]];	
		}
		lbl_Address.hidden=FALSE;
		//lbl_AddressStatic.hidden=FALSE;
	}
	if (![txt_State.text isEqualToString:@""]) {
		if ([strAddress isEqualToString:@""]) {
			strAddress = [strAddress stringByAppendingString:[NSString stringWithFormat:@"%@",txt_State.text]];	
			strAddressTOpassLibrary_Event = [[strAddressTOpassLibrary_Event stringByAppendingString:[NSString stringWithFormat:@"%@",txt_State.text]] retain];
		}
		else {
			if (![txt_City.text isEqualToString:@""]) {
				strAddressTOpassLibrary_Event = [[strAddressTOpassLibrary_Event stringByAppendingString:[NSString stringWithFormat:@",%@",txt_State.text]] retain];
				strAddress = [strAddress stringByAppendingString:[NSString stringWithFormat:@", %@ ",txt_State.text]];	
			}
			else {
				strAddressTOpassLibrary_Event = [[strAddressTOpassLibrary_Event stringByAppendingString:[NSString stringWithFormat:@",%@",txt_State.text]] retain];
				strAddress = [strAddress stringByAppendingString:[NSString stringWithFormat:@"%@ ",txt_State.text]];
			}

		}

		
		lbl_Address.hidden=FALSE;
		//lbl_AddressStatic.hidden=FALSE;
	}
    if (![txt_ZipCode.text isEqualToString:@""]) {
		if ([strAddress isEqualToString:@""]) {
			strAddressTOpassLibrary_Event = [[strAddressTOpassLibrary_Event stringByAppendingString:[NSString stringWithFormat:@"%@",txt_ZipCode.text]] retain];
			strAddress = [strAddress stringByAppendingString:[NSString stringWithFormat:@"%@",txt_ZipCode.text]];	
		}
		else {
			if (![txt_State.text isEqualToString:@""]) {
				strAddressTOpassLibrary_Event = [[strAddressTOpassLibrary_Event stringByAppendingString:[NSString stringWithFormat:@",%@",txt_ZipCode.text]] retain];
				strAddress = [strAddress stringByAppendingString:[NSString stringWithFormat:@"%@",txt_ZipCode.text]];
			}
			else if ([txt_State.text isEqualToString:@""]&&[txt_City.text isEqualToString:@""]) {
				strAddressTOpassLibrary_Event = [[strAddressTOpassLibrary_Event stringByAppendingString:[NSString stringWithFormat:@",%@",txt_ZipCode.text]] retain];
				strAddress = [strAddress stringByAppendingString:[NSString stringWithFormat:@"%@",txt_ZipCode.text]];
			}
			else {
				strAddressTOpassLibrary_Event = [[strAddressTOpassLibrary_Event stringByAppendingString:[NSString stringWithFormat:@",%@",txt_ZipCode.text]] retain];
				strAddress = [strAddress stringByAppendingString:[NSString stringWithFormat:@" %@",txt_ZipCode.text]];
			}
				
		}
		
		lbl_Address.hidden=FALSE;
		//lbl_AddressStatic.hidden=FALSE;
	}
	if (![txt_Country.text isEqualToString:@""]) {
		if ([strAddress isEqualToString:@""]) {
			strAddressTOpassLibrary_Event = [[strAddressTOpassLibrary_Event stringByAppendingString:[NSString stringWithFormat:@"%@",txt_Country.text]] retain];
			strAddress = [strAddress stringByAppendingString:[NSString stringWithFormat:@"%@",txt_Country.text]];	
		}
		else {
			strAddressTOpassLibrary_Event = [[strAddressTOpassLibrary_Event stringByAppendingString:[NSString stringWithFormat:@",%@",txt_Country.text]] retain];
			strAddress = [strAddress stringByAppendingString:[NSString stringWithFormat:@"\n%@",txt_Country.text]];	
		}
		
		lbl_Address.hidden=FALSE;
		//lbl_AddressStatic.hidden=FALSE;
	}
	lbl_Address.text = strAddress;
	//[self.view sendSubviewToBack:iv_photoLibImg];
	NSString *str_EventString;
	str_EventString = @"\n";
	BOOL flagForAddressAtribute;
	[self onAlignmentBottomClick];
	if (![txt_EventTitle.text isEqualToString:@""]&&![txt_Start.text isEqualToString:@""]&&![txt_End.text isEqualToString:@""]&&![tv_Notes.text isEqualToString:@""]&&![txt_Address.text isEqualToString:@""]) {
		str_EventString = [str_EventString stringByAppendingString:[NSString stringWithFormat:@"  %@ \n\n",lbl_EventTitle.text]];
		str_EventString = [str_EventString stringByAppendingString:[NSString stringWithFormat:@"  %@ %@ \n",lbl_StartStatic.text,lbl_Start.text]];
		str_EventString = [str_EventString stringByAppendingString:[NSString stringWithFormat:@"  %@ %@ \n",lbl_EndStatic.text,lbl_End.text]];
		lbl_NotesStatic.hidden=TRUE;
		lbl_Notes.hidden=FALSE;
		//str_EventString = [str_EventString stringByAppendingString:[NSString stringWithFormat:@" %@ %@ \n",lbl_NotesStatic.text,tv_Notes.text]];
		lbl_Address.hidden=FALSE;
		//lbl_AddressStatic.hidden=FALSE;
		lbl_EventTitle.hidden=TRUE;
		lbl_EventTitleStatic.hidden=TRUE;
		lbl_Start.hidden=TRUE;
		lbl_StartStatic.hidden=TRUE;
		lbl_End.hidden=TRUE;
		lbl_EndStatic.hidden=TRUE;
	//	lbl_Notes.hidden=TRUE;
	//	lbl_NotesStatic.hidden=TRUE;
		flagForAddressAtribute=TRUE;
	}
	else {
		flagForAddressAtribute=FALSE;
		//str_EventString=@"";
	if ([txt_EventTitle.text isEqualToString:@""]) {
		lbl_EventTitle.hidden=TRUE;
		lbl_EventTitleStatic.hidden=TRUE;
	} 
	else {
		//lbl_EventTitle.hidden=FALSE;
		//lbl_EventTitleStatic.hidden=FALSE;
		lbl_EventTitle.hidden=TRUE;
		lbl_EventTitleStatic.hidden=TRUE;
		
		str_EventString = [str_EventString stringByAppendingString:[NSString stringWithFormat:@"  %@\n\n",lbl_EventTitle.text]];
		
	}
	if ([txt_Start.text isEqualToString:@""]) {
		lbl_Start.hidden=TRUE;
		lbl_StartStatic.hidden=TRUE;
	}
	else {
		lbl_Start.hidden=TRUE;
		lbl_StartStatic.hidden=TRUE;
		str_EventString = [str_EventString stringByAppendingString:[NSString stringWithFormat:@"  %@ %@\n",lbl_StartStatic.text,lbl_Start.text]];
	}

	if ([txt_End.text isEqualToString:@""]) {
		lbl_End.hidden=TRUE;
		lbl_EndStatic.hidden=TRUE;
	}
	else {
		lbl_End.hidden=TRUE;
		lbl_EndStatic.hidden=TRUE;
		str_EventString = [str_EventString stringByAppendingString:[NSString stringWithFormat:@"  %@ %@\n",lbl_EndStatic.text,lbl_End.text]];
	}
	
	if ([tv_Notes.text isEqualToString:@""]) {
		lbl_Notes.hidden=TRUE;
		lbl_NotesStatic.hidden=TRUE;
	}
	else {
		lbl_NotesStatic.hidden=TRUE;
		lbl_Notes.hidden=FALSE;
		//str_EventString = [str_EventString stringByAppendingString:[NSString stringWithFormat:@"%@ %@\n",lbl_NotesStatic.text,tv_Notes.text]];
	}
	if ([txt_Address.text isEqualToString:@""]&&[txt_City.text isEqualToString:@""]&&[txt_State.text isEqualToString:@""]&&[txt_ZipCode.text isEqualToString:@""]&&[txt_Country.text isEqualToString:@""]) {
		lbl_Address.hidden=TRUE;
		lbl_AddressStatic.hidden=TRUE;
	}
	else {
		lbl_Address.hidden=FALSE;
		//lbl_AddressStatic.hidden=FALSE;
		//str_EventString =  [str_EventString stringByAppendingString:[NSString stringWithFormat:@"%@ %@,\n",lbl_AddressStatic.text,txt_Address.text]];
		
	}
/*	if ([txt_City.text isEqualToString:@""]) {
		
	}
	else {
		//str_EventString =  [str_EventString stringByAppendingString:[NSString stringWithFormat:@"%@,\n",txt_City.text]];	
	}
	if ([txt_State.text isEqualToString:@""]) {
			
	}
	else {
		//str_EventString =  [str_EventString stringByAppendingString:[NSString stringWithFormat:@"%@,\n",txt_State.text]];	
	}
	if ([txt_ZipCode.text isEqualToString:@""]) {
			
	}
	else {
		//str_EventString =  [str_EventString stringByAppendingString:[NSString stringWithFormat:@"%@,\n",txt_ZipCode.text]];	
	}
	if ([txt_Country.text isEqualToString:@""]) {
		
	}
	else {
		//str_EventString =  [str_EventString stringByAppendingString:[NSString stringWithFormat:@"%@\n",txt_Country.text]];	
	}*/
	}
	attrStr1 = [NSMutableAttributedString attributedStringWithString:str_EventString];
	[attrStr1 setFont:[UIFont fontWithName:@"Helvetica" size:13]];
	if ([str_Flag_Gradient isEqualToString:@"Black"])
		[attrStr1 setTextColor:[UIColor blackColor]];
	else
		[attrStr1 setTextColor:[UIColor whiteColor]];
	if (![txt_EventTitle.text isEqualToString:@""]) {
		[attrStr1 setTextBold:YES range:[str_EventString rangeOfString:[NSString stringWithFormat:@"%@",lbl_EventTitle.text]]];
		[attrStr1 setFont:[UIFont boldSystemFontOfSize:15] range:[str_EventString rangeOfString:[NSString stringWithFormat:@"%@",lbl_EventTitle.text]]];
		 
	}
	if (![txt_Start.text isEqualToString:@""]) {
		[attrStr1 setTextBold:YES range:[str_EventString rangeOfString:@"Starts Date:"]];
	}
	if (![txt_End.text isEqualToString:@""]) {
		[attrStr1 setTextBold:YES range:[str_EventString rangeOfString:@"Ends Date:"]];
	}
	//if (![tv_Notes.text isEqualToString:@""]) {
//		[attrStr1 setTextBold:YES range:[str_EventString rangeOfString:@"Notes:"]];
//	}
	//if (![txt_Address.text isEqualToString:@""]&&flagForAddressAtribute==FALSE) {
//		[attrStr1 setTextBold:YES range:[str_EventString rangeOfString:@"Address:"]];
//	}
	tv_EventView.attributedText=attrStr1;
	tv_EventView.backgroundColor = [UIColor clearColor]; 
	[txt_EventTitle resignFirstResponder];
	[txt_Address resignFirstResponder];
	[txt_City resignFirstResponder];
	[txt_State resignFirstResponder];
	[txt_ZipCode resignFirstResponder];
	[txt_Country resignFirstResponder];
	[tv_Notes resignFirstResponder];
	
	lbl_AddressStatic.hidden=TRUE;
}
-(IBAction)onBusinessCardClick
{
	//if(oncePort == TRUE)
//	{
		btn_Continue_BarcodeView.frame = CGRectMake(262, 640, 137, 52);
	//}
//	else {
//		btn_Continue_BarcodeView.frame = CGRectMake(330, 640, 137, 52);
//	}
	appDel.mon=FALSE;
	appDel.tue=FALSE;
	appDel.wed=FALSE;
	appDel.thu=FALSE;
	appDel.fri=FALSE;
	appDel.sat=FALSE;
	appDel.sun=FALSE;
	appDel.strStartTime=@"";
	appDel.strEndTime=@"";
	btn_Plus.hidden=TRUE;
	if (FlagForCoverFlow==FALSE){
    }
	else{
		FlagForCoverFlow=FALSE;
		[self addCoverFlow];
	}
	txt_CompanyName.text=@"";
	txt_Name.text=@"";
	txt_JobTitle.text=@"";
	txt_Email.text=@"";
	txt_Phone.text=@"";
	txt_Add.text=@"";
	txt_City_BusinessCard.text=@"";
	txt_State_BusinessCard.text=@"";
	txt_ZipCode_BusinessCard.text=@"";
	txt_Country_BusinessCard.text=@"";
	ivBarcode_BusinessCard.image=[UIImage imageNamed:@"ivBackground.png"];
	if ([strFlag isEqualToString:@"UDT"]) {
		coverFloWView.hidden=FALSE;
		libraryView.hidden=TRUE;
	}
	else {
		coverFloWView.hidden=TRUE;
		libraryView.hidden=FALSE;
	}
	if(!imageProcessingView.hidden)
	{
		imageProcessingView.hidden=TRUE;
		flagForBackClick=FALSE;
	}
	imageProcessingView.hidden=TRUE;
	PreviewShareView.hidden=TRUE;
	eventView.hidden=TRUE;
	businessView.hidden=TRUE;
	invitationView.hidden=TRUE;
	idbadgeView.hidden=TRUE;
	courseinfoView.hidden=TRUE;
	barcodeView.hidden=TRUE;
	//[self onBackClick];
	str_TM_SelectedItem = @"BusinessCard";
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		
		//btn_Continue_BarcodeView.frame = CGRectMake(330, 640, 137, 52);
		[btn_Event setBackgroundImage:[UIImage imageNamed:@"event-p.png"] forState:UIControlStateNormal];
		[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard-hover-p.png"] forState:UIControlStateNormal];
		[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation-p.png"] forState:UIControlStateNormal];
		[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge-p.png"] forState:UIControlStateNormal];
		[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo-p.png"] forState:UIControlStateNormal];
		
	}
	else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
			appDel.ori == UIInterfaceOrientationLandscapeRight)
	{
		btn_Continue_BarcodeView.frame = CGRectMake(330, 610, 137, 52);
		[btn_Event setBackgroundImage:[UIImage imageNamed:@"event.png"] forState:UIControlStateNormal];
		[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard-hover.png"] forState:UIControlStateNormal];
		[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation.png"] forState:UIControlStateNormal];
		[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge.png"] forState:UIControlStateNormal];
		[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo.png"] forState:UIControlStateNormal];
	}
	/// for image processing
	//for eventview start
	lbl_EventTitle.hidden=TRUE;
	lbl_EventTitleStatic.hidden=TRUE;
	lbl_Start.hidden=TRUE;
	lbl_StartStatic.hidden=TRUE;
	lbl_End.hidden=TRUE;
	lbl_EndStatic.hidden=TRUE;
	lbl_Notes.hidden=TRUE;
	lbl_NotesStatic.hidden=TRUE;
	lbl_Address.hidden=TRUE;
	lbl_AddressStatic.hidden=TRUE;
	//for eventview end
	
	///////14/12/2011 start
	//for businessview
	lbl_Company.hidden=FALSE;
	lbl_CompanyStatic.hidden=FALSE;
	lbl_JobTitle.hidden=FALSE;
	lbl_JobTitleStatic.hidden=FALSE;
	lbl_Name.hidden=FALSE;
	lbl_NameStatic.hidden=FALSE;
	lbl_Email.hidden=FALSE;
	lbl_EmailStatic.hidden=FALSE;
	lbl_Phone.hidden=FALSE;
	lbl_PhoneStatic.hidden=FALSE;
	lbl_Address_BusinessCard.hidden=FALSE;
	//lbl_AddressStatic_BusinessCard.hidden=FALSE;
	
	///////14/12/2011 start
	
	///15/12/2011 start
	// for course ifo view
	lbl_CourseName.hidden=TRUE;
	lbl_CourseNameStatic.hidden=TRUE;
	lbl_CourseCodeStatic.hidden=TRUE;
	lbl_CourseCode.hidden=TRUE;
	lbl_Professor.hidden=TRUE;
	lbl_ProfessorStatic.hidden=TRUE;
	lbl_DateTime.hidden=TRUE;
	lbl_DateTimeStatic.hidden=TRUE;
	
	
	lbl_Title_Invitation.hidden=TRUE;
	lbl_TitleStatic_Invitation.hidden=TRUE;
	lbl_Address_Invitation.hidden=TRUE;
	lbl_AddressStatic_Invitation.hidden=TRUE;
	
	
	// for idbadge view
	lbl_Company_IDBadge.hidden=TRUE;
	lbl_CompanyStatic_IDBadge.hidden=TRUE;
	lbl_NameStatic_IDBadge.hidden=TRUE;
	lbl_Name_IDBadge.hidden=TRUE;
	lbl_JobTitle_IDBadge.hidden=TRUE;
	lbl_JobTitleStatic_IDBadge.hidden=TRUE;
	//15/12/2011 end
}
-(IBAction)onContinueClick_BusinessCard
{
	BOOL next;
	if ([txt_Email.text isEqualToString:@""]) {
		next = TRUE;
	}
	if(![txt_Email.text isEqualToString:@""]){
		
		NSString *email = txt_Email.text; 
		if (! (([email rangeOfString:@"@"].location != NSNotFound) && ([email rangeOfString:@"."].location != NSNotFound)) ) { 
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning !" message:@"Please enter valid Email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
			next = FALSE;
		}
		else {
			next =TRUE;
		}

	}
	if (next==TRUE) {
	[txt_CompanyName resignFirstResponder];
	[txt_Name resignFirstResponder];
	[txt_JobTitle resignFirstResponder];
	[txt_Email resignFirstResponder];
	[txt_Phone resignFirstResponder];
	[txt_Add resignFirstResponder];
		[txt_City_BusinessCard resignFirstResponder];
		[txt_State_BusinessCard resignFirstResponder];
		[txt_ZipCode_BusinessCard resignFirstResponder];
		[txt_Country_BusinessCard resignFirstResponder];
		
	imgInvitation.hidden = TRUE;//jayna1512116.18
	//barCodeImgView.image = ivBarcode_BusinessCard.image;
		//19/12/2011 deval start
		if (ivBarcode_BusinessCard.image==[UIImage imageNamed:@"ivBackground.png"]) {
			barCodeImgView.image=nil;
			btn_Barcode_ImageProcessingView.hidden=TRUE;
		}
		else {
			barCodeImgView.image = ivBarcode_BusinessCard.image;
			btn_Barcode_ImageProcessingView.hidden=FALSE;
		}
		////19/12/2011 deval end
	flagForBackClick=TRUE;
	imageProcessingView.hidden=FALSE;
	
	iv_photoLibImg.image=nil;
	ivMainImage.image=vc.img_ImageNameFromFlow;
	if (vc.selectedImageIndex==7) {
		btn_ColorPicker.hidden=FALSE;
		btn_OpenCamera.hidden=FALSE;
		iv_photoLibImg.hidden=FALSE;
		colorView.hidden=FALSE;
	}
	else {
		btn_ColorPicker.hidden=TRUE;
		btn_OpenCamera.hidden=TRUE;
		iv_photoLibImg.hidden=TRUE;
		colorView.hidden=TRUE;
	}
	lbl_Company.text = txt_CompanyName.text;
	lbl_JobTitle.text = txt_JobTitle.text;
	lbl_Name.text = txt_Name.text;
	lbl_Email.text = txt_Email.text;
	lbl_Phone.text = txt_Phone.text;
	//NSString *strAddress_BusinessCard = @"                ";
	NSString *strAddress_BusinessCard = @"";
	strAddressTOpassLibrary_BusinessCard=@"";
	//NSString *strAddress_BusinessCard = [NSString stringWithFormat:@"                %@",txt_Add.text];
	if (![txt_Add.text isEqualToString:@""]) {
		lbl_Address_BusinessCard.hidden=FALSE;
		lbl_Address_BusinessCard.hidden=FALSE;
		strAddress_BusinessCard = [strAddress_BusinessCard stringByAppendingString:[NSString stringWithFormat:@"%@\n",txt_Add.text]];	
		strAddressTOpassLibrary_BusinessCard = [[strAddressTOpassLibrary_BusinessCard stringByAppendingString:[NSString stringWithFormat:@"%@",txt_Add.text]] retain];	
	}
	if (![txt_City_BusinessCard.text isEqualToString:@""]) {
		lbl_Address_BusinessCard.hidden=FALSE;
		lbl_Address_BusinessCard.hidden=FALSE;
		if ([strAddress_BusinessCard isEqualToString:@""]) {
			strAddress_BusinessCard = [strAddress_BusinessCard stringByAppendingString:[NSString stringWithFormat:@"%@",txt_City_BusinessCard.text]];	
			strAddressTOpassLibrary_BusinessCard = [[strAddressTOpassLibrary_BusinessCard stringByAppendingString:[NSString stringWithFormat:@"%@",txt_City_BusinessCard.text]] retain];	
		}
		else {
			strAddressTOpassLibrary_BusinessCard = [[strAddressTOpassLibrary_BusinessCard stringByAppendingString:[NSString stringWithFormat:@",%@",txt_City_BusinessCard.text]] retain];	
			strAddress_BusinessCard = [strAddress_BusinessCard stringByAppendingString:[NSString stringWithFormat:@"%@",txt_City_BusinessCard.text]];	
		}

		
	}
	if (![txt_State_BusinessCard.text isEqualToString:@""]) {
		lbl_Address_BusinessCard.hidden=FALSE;
		lbl_Address_BusinessCard.hidden=FALSE;
		if ([strAddress_BusinessCard isEqualToString:@""]) {
			strAddressTOpassLibrary_BusinessCard = [[strAddressTOpassLibrary_BusinessCard stringByAppendingString:[NSString stringWithFormat:@"%@",txt_State_BusinessCard.text]] retain];	
			strAddress_BusinessCard = [strAddress_BusinessCard stringByAppendingString:[NSString stringWithFormat:@"%@",txt_State_BusinessCard.text]];	
		}
		else {
			if (![txt_City_BusinessCard.text isEqualToString:@""]) {
				strAddressTOpassLibrary_BusinessCard = [[strAddressTOpassLibrary_BusinessCard stringByAppendingString:[NSString stringWithFormat:@",%@",txt_State_BusinessCard.text]] retain];	
				strAddress_BusinessCard = [strAddress_BusinessCard stringByAppendingString:[NSString stringWithFormat:@", %@ ",txt_State_BusinessCard.text]];	
			}
			else {
				strAddressTOpassLibrary_BusinessCard = [[strAddressTOpassLibrary_BusinessCard stringByAppendingString:[NSString stringWithFormat:@",%@",txt_State_BusinessCard.text]] retain];	
				strAddress_BusinessCard = [strAddress_BusinessCard stringByAppendingString:[NSString stringWithFormat:@"%@ " ,txt_State_BusinessCard.text]];
			}

		}
	   
	}
    if (![txt_ZipCode_BusinessCard.text isEqualToString:@""]) {
		lbl_Address_BusinessCard.hidden=FALSE;
		lbl_Address_BusinessCard.hidden=FALSE;
		if ([strAddress_BusinessCard isEqualToString:@""]) {
			strAddressTOpassLibrary_BusinessCard = [[strAddressTOpassLibrary_BusinessCard stringByAppendingString:[NSString stringWithFormat:@"%@",txt_ZipCode_BusinessCard.text]] retain];	
			strAddress_BusinessCard = [strAddress_BusinessCard stringByAppendingString:[NSString stringWithFormat:@"%@",txt_ZipCode_BusinessCard.text]];	
		}
		else {
			if (![txt_State_BusinessCard.text isEqualToString:@""]) {
				strAddress_BusinessCard = [strAddress_BusinessCard stringByAppendingString:[NSString stringWithFormat:@"%@",txt_ZipCode_BusinessCard.text]];	
				strAddressTOpassLibrary_BusinessCard = [[strAddressTOpassLibrary_BusinessCard stringByAppendingString:[NSString stringWithFormat:@",%@",txt_ZipCode_BusinessCard.text]] retain];	
			}
			else if ([txt_State_BusinessCard.text isEqualToString:@""]&&[txt_City_BusinessCard.text isEqualToString:@""]) {
				strAddress_BusinessCard = [strAddress_BusinessCard stringByAppendingString:[NSString stringWithFormat:@"%@",txt_ZipCode_BusinessCard.text]];	
				strAddressTOpassLibrary_BusinessCard = [[strAddressTOpassLibrary_BusinessCard stringByAppendingString:[NSString stringWithFormat:@",%@",txt_ZipCode_BusinessCard.text]] retain];	
			}
			else {
				strAddress_BusinessCard = [strAddress_BusinessCard stringByAppendingString:[NSString stringWithFormat:@" %@",txt_ZipCode_BusinessCard.text]];	
				strAddressTOpassLibrary_BusinessCard = [[strAddressTOpassLibrary_BusinessCard stringByAppendingString:[NSString stringWithFormat:@",%@",txt_ZipCode_BusinessCard.text]] retain];
			}

		}
	   
	}
	if (![txt_Country_BusinessCard.text isEqualToString:@""]) {
		lbl_Address_BusinessCard.hidden=FALSE;
		lbl_Address_BusinessCard.hidden=FALSE;
		if ([strAddress_BusinessCard isEqualToString:@""]) {
			strAddressTOpassLibrary_BusinessCard = [[strAddressTOpassLibrary_BusinessCard stringByAppendingString:[NSString stringWithFormat:@"%@",txt_Country_BusinessCard.text]] retain];	
			strAddress_BusinessCard = [strAddress_BusinessCard stringByAppendingString:[NSString stringWithFormat:@"%@",txt_Country_BusinessCard.text]];	
		}
		else {
			strAddressTOpassLibrary_BusinessCard = [[strAddressTOpassLibrary_BusinessCard stringByAppendingString:[NSString stringWithFormat:@",%@",txt_Country_BusinessCard.text]] retain];	
			strAddress_BusinessCard = [strAddress_BusinessCard stringByAppendingString:[NSString stringWithFormat:@"\n%@",txt_Country_BusinessCard.text]];	
		}
	   
	}
	lbl_Address_BusinessCard.text = strAddress_BusinessCard;
	
	NSString *str_EventString_Business;
	str_EventString_Business = @"\n";
	BOOL flagForAddressAtribute_Business;
	[self onAlignmentBottomClick];
	if (![txt_CompanyName.text isEqualToString:@""]&&![txt_Name.text isEqualToString:@""]&&![txt_JobTitle.text isEqualToString:@""]&&![txt_Email.text isEqualToString:@""]&&![txt_Phone.text isEqualToString:@""]&&![txt_Add.text isEqualToString:@""]) {
		str_EventString_Business = [str_EventString_Business stringByAppendingString:[NSString stringWithFormat:@" %@\n\n",lbl_Company.text]];
		str_EventString_Business = [str_EventString_Business stringByAppendingString:[NSString stringWithFormat:@" %@ \n",lbl_Name.text]];
		str_EventString_Business = [str_EventString_Business stringByAppendingString:[NSString stringWithFormat:@" %@ \n",lbl_JobTitle.text]];
		str_EventString_Business = [str_EventString_Business stringByAppendingString:[NSString stringWithFormat:@" %@ %@ \n",lbl_EmailStatic.text,lbl_Email.text]];
		str_EventString_Business = [str_EventString_Business stringByAppendingString:[NSString stringWithFormat:@" %@ %@ \n",lbl_PhoneStatic.text,lbl_Phone.text]];
		lbl_Company.hidden=TRUE;
		lbl_CompanyStatic.hidden=TRUE;
		lbl_Name.hidden=TRUE;
		lbl_NameStatic.hidden=TRUE;
		lbl_JobTitle.hidden=TRUE;
		lbl_JobTitleStatic.hidden=TRUE;
		lbl_Email.hidden=TRUE;
		lbl_EmailStatic.hidden=TRUE;
		lbl_Phone.hidden=TRUE;
		lbl_PhoneStatic.hidden=TRUE;
		lbl_Address_BusinessCard.hidden=FALSE;
		//lbl_AddressStatic_BusinessCard.hidden=FALSE;
		flagForAddressAtribute_Business=TRUE;
	}
	else {
		flagForAddressAtribute_Business=FALSE;
	if ([txt_CompanyName.text isEqualToString:@""]) {
		lbl_Company.hidden=TRUE;
		lbl_CompanyStatic.hidden=TRUE;
	}
	else {
		lbl_Company.hidden=TRUE;
		lbl_CompanyStatic.hidden=TRUE;
		str_EventString_Business = [str_EventString_Business stringByAppendingString:[NSString stringWithFormat:@" %@\n\n",lbl_Company.text]];
	}
	if ([txt_Name.text isEqualToString:@""]) {
		lbl_Name.hidden=TRUE;
		lbl_NameStatic.hidden=TRUE;
	}
	else {
		lbl_Name.hidden=TRUE;
		lbl_NameStatic.hidden=TRUE;
		str_EventString_Business = [str_EventString_Business stringByAppendingString:[NSString stringWithFormat:@" %@\n",lbl_Name.text]];
	}
	if ([txt_JobTitle.text isEqualToString:@""]) {
		lbl_JobTitle.hidden=TRUE;
		lbl_JobTitleStatic.hidden=TRUE;
	}
	else {
		lbl_JobTitle.hidden=TRUE;
		lbl_JobTitleStatic.hidden=TRUE;	
		str_EventString_Business = [str_EventString_Business stringByAppendingString:[NSString stringWithFormat:@" %@ \n",lbl_JobTitle.text]];
	}
	if ([txt_Email.text isEqualToString:@""]) {
		lbl_Email.hidden=TRUE;
		lbl_EmailStatic.hidden=TRUE;
	}
	else {
		lbl_Email.hidden=TRUE;
		lbl_EmailStatic.hidden=TRUE;
		str_EventString_Business = [str_EventString_Business stringByAppendingString:[NSString stringWithFormat:@" %@ %@ \n",lbl_EmailStatic.text,lbl_Email.text]];
	}
	if ([txt_Phone.text isEqualToString:@""]) {
		lbl_Phone.hidden=TRUE;
		lbl_PhoneStatic.hidden=TRUE;
	}
	else {
		lbl_Phone.hidden=TRUE;
		lbl_PhoneStatic.hidden=TRUE;
		str_EventString_Business = [str_EventString_Business stringByAppendingString:[NSString stringWithFormat:@" %@ %@ \n",lbl_PhoneStatic.text,lbl_Phone.text]];
	}
	if ([txt_Add.text isEqualToString:@""]&&[txt_City_BusinessCard.text isEqualToString:@""]&&[txt_State_BusinessCard.text isEqualToString:@""]&&[txt_ZipCode_BusinessCard.text isEqualToString:@""]&&[txt_Country_BusinessCard.text isEqualToString:@""]) {
		lbl_Address_BusinessCard.hidden=TRUE;
		lbl_AddressStatic_BusinessCard.hidden=TRUE;
	}
	else {
		lbl_Address_BusinessCard.hidden=FALSE;
		//lbl_AddressStatic_BusinessCard.hidden=FALSE;
		//str_EventString_Business = [str_EventString_Business stringByAppendingString:[NSString stringWithFormat:@"%@ %@ \n",lbl_AddressStatic_BusinessCard.text,txt_Add.text]];
	}		
	}	
	attrStr_Business = [NSMutableAttributedString attributedStringWithString:str_EventString_Business];
	[attrStr_Business setFont:[UIFont fontWithName:@"Helvetica" size:13]];
	if ([str_Flag_Gradient isEqualToString:@"Black"])
		[attrStr_Business setTextColor:[UIColor blackColor]];
	else
		[attrStr_Business setTextColor:[UIColor whiteColor]];
	if (![txt_CompanyName.text isEqualToString:@""]) {
		[attrStr_Business setTextBold:YES range:[str_EventString_Business rangeOfString:[NSString stringWithFormat:@"%@",lbl_Company.text]]];
		[attrStr_Business setFont:[UIFont boldSystemFontOfSize:15] range:[str_EventString_Business rangeOfString:[NSString stringWithFormat:@"%@",lbl_Company.text]]];
	}
	if (![txt_Name.text isEqualToString:@""]) {
		[attrStr_Business setTextBold:YES range:[str_EventString_Business rangeOfString:[NSString stringWithFormat:@"%@",lbl_Name.text]]];
        
        
        
        
        
        
		//[attrStr_Business setFont:[UIFont boldSystemFontOfSize:15] range:[str_EventString_Business rangeOfString:[NSString stringWithFormat:@"%@",lbl_Name.text]]];
	}
        if(![txt_Phone.text isEqualToString:@""])
        {
            [attrStr_Business setTextColor:[UIColor blueColor] range:[str_EventString_Business rangeOfString:txt_Phone.text]];
        }
        
        
        
        
        
        
        
	//if (![txt_JobTitle.text isEqualToString:@""]) {
//		[attrStr_Business setTextBold:YES range:[str_EventString_Business rangeOfString:@"Job Title:"]];
//	}
	//if (![txt_Email.text isEqualToString:@""]) {
//		[attrStr_Business setTextBold:YES range:[str_EventString_Business rangeOfString:@"Email:"]];
//	}
//	if (![txt_Phone.text isEqualToString:@""]) {
//		[attrStr_Business setTextBold:YES range:[str_EventString_Business rangeOfString:@"Phone:"]];
//	}
	//if (![txt_Add.text isEqualToString:@""]&&flagForAddressAtribute_Business==FALSE) {
//		[attrStr_Business setTextBold:YES range:[str_EventString_Business rangeOfString:@"Address:"]];
//	}
	tv_EventView.attributedText=attrStr_Business;
		tv_EventView.linkColor = [UIColor blueColor];
	}
	
}
-(IBAction)onInvitaitonClick
{
	
	//if(oncePort == TRUE)
//	{
//		ivBarcode_IDBadge.frame = CGRectMake(186, 200, 137, 137);
//		btn_Barcode_IDBadgeView.frame = CGRectMake(186, 200, 137, 137);
//		ivPhoto_IDBadge.frame = CGRectMake(331, 200, 137, 137);
//		btn_ivPhoto_IDBadge.frame = CGRectMake(331, 200, 137, 137);
//		ivBarcode_Invitation.frame = CGRectMake(186, 305, 138, 138);//230
//		btn_Barcode_InvitationView.frame = CGRectMake(186, 305, 138, 138);
//		ivPhoto_Invitation.frame =  CGRectMake(331, 305, 138, 138);//420
//		btn_Barcode_Invitation.frame =  CGRectMake(331, 305, 138, 138);
//	}
//	else {
//		ivBarcode_IDBadge.frame = CGRectMake(234, 200, 137, 137);
//		btn_Barcode_IDBadgeView.frame = CGRectMake(234, 200, 137, 137);
//		ivPhoto_IDBadge.frame = CGRectMake(421, 200, 137, 137);
//		btn_ivPhoto_IDBadge.frame = CGRectMake(421, 200, 137, 137);
//		
//		ivBarcode_Invitation.frame = CGRectMake(230, 305, 138, 138);
//		btn_Barcode_InvitationView.frame = CGRectMake(230, 305, 138, 138);
//		//btn_Barcode_Invitation.frame = CGRectMake(377, 305, 138, 138);
//		ivPhoto_Invitation.frame =  CGRectMake(420, 305, 138, 138);
//		btn_Barcode_Invitation.frame =  CGRectMake(420, 305, 138, 138);
//	}
	strAddressTOpassLibrary_Invitaion=@"";
	appDel.mon=FALSE;
	appDel.tue=FALSE;
	appDel.wed=FALSE;
	appDel.thu=FALSE;
	appDel.fri=FALSE;
	appDel.sat=FALSE;
	appDel.sun=FALSE;
	appDel.strStartTime=@"";
	appDel.strEndTime=@"";
	btn_Plus.hidden=TRUE;
	if (FlagForCoverFlow==FALSE){}
	else{
		FlagForCoverFlow=FALSE;
		[self addCoverFlow];
	}
	txt_Title_Invitation.text=@"";
	txt_Add_Invitation.text=@"";
	txt_City_Invitation.text=@"";
	txt_State_Invitation.text=@"";
	txt_ZipCode_Invitation.text=@"";
	txt_Country_Invitation.text=@"";
	
	FlagForPhotoFromInvitation=TRUE;
	imgInvitation.image=nil;
	ivPhoto_Invitation.image=[UIImage imageNamed:@"photoBachground.png"];
	ivBarcode_Invitation.image=[UIImage imageNamed:@"ivBackground.png"];
	if ([strFlag isEqualToString:@"UDT"]) {
		coverFloWView.hidden=FALSE;
		libraryView.hidden=TRUE;
	}
	else {
		coverFloWView.hidden=TRUE;
		libraryView.hidden=FALSE;
	}
	imageProcessingView.hidden=TRUE;
	PreviewShareView.hidden=TRUE;
	businessView.hidden=TRUE;
	eventView.hidden=TRUE;
	invitationView.hidden=TRUE;
	idbadgeView.hidden=TRUE;
	courseinfoView.hidden=TRUE;
	barcodeView.hidden=TRUE;
	//[self onBackClick];
	if(!imageProcessingView.hidden)
	{
		imageProcessingView.hidden=TRUE;
		flagForBackClick=FALSE;
	}
	str_TM_SelectedItem = @"Invitation";
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		
		
		[btn_Event setBackgroundImage:[UIImage imageNamed:@"event-p.png"] forState:UIControlStateNormal];
		[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard-p.png"] forState:UIControlStateNormal];
		[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation-hover-p.png"] forState:UIControlStateNormal];
		[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge-p.png"] forState:UIControlStateNormal];
		[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo-p.png"] forState:UIControlStateNormal];
		
	}
	else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
			appDel.ori == UIInterfaceOrientationLandscapeRight)
	{
				
		
		[btn_Event setBackgroundImage:[UIImage imageNamed:@"event.png"] forState:UIControlStateNormal];
		[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard.png"] forState:UIControlStateNormal];
		[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation-hover.png"] forState:UIControlStateNormal];
		[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge.png"] forState:UIControlStateNormal];
		[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo.png"] forState:UIControlStateNormal];
	}
	/// for image processing
	//for eventview start
	lbl_EventTitle.hidden=TRUE;
	lbl_EventTitleStatic.hidden=TRUE;
	lbl_Start.hidden=TRUE;
	lbl_StartStatic.hidden=TRUE;
	lbl_End.hidden=TRUE;
	lbl_EndStatic.hidden=TRUE;
	lbl_Notes.hidden=TRUE;
	lbl_NotesStatic.hidden=TRUE;
	lbl_Address.hidden=TRUE;
	lbl_AddressStatic.hidden=TRUE;
	//for eventview end
	
	///////14/12/2011 start
	//for businessview
	lbl_Company.hidden=TRUE;
	lbl_CompanyStatic.hidden=TRUE;
	lbl_JobTitle.hidden=TRUE;
	lbl_JobTitleStatic.hidden=TRUE;
	lbl_Name.hidden=TRUE;
	lbl_NameStatic.hidden=TRUE;
	lbl_Email.hidden=TRUE;
	lbl_EmailStatic.hidden=TRUE;
	lbl_Phone.hidden=TRUE;
	lbl_PhoneStatic.hidden=TRUE;
	lbl_Address_BusinessCard.hidden=TRUE;
	lbl_AddressStatic_BusinessCard.hidden=TRUE;
	
	///////14/12/2011 start
	
	///15/12/2011 start
	// for course ifo view
	lbl_CourseName.hidden=TRUE;
	lbl_CourseNameStatic.hidden=TRUE;
	lbl_CourseCodeStatic.hidden=TRUE;
	lbl_CourseCode.hidden=TRUE;
	lbl_Professor.hidden=TRUE;
	lbl_ProfessorStatic.hidden=TRUE;
	lbl_DateTime.hidden=TRUE;
	lbl_DateTimeStatic.hidden=TRUE;
	
	lbl_Title_Invitation.hidden=FALSE;
	lbl_TitleStatic_Invitation.hidden=FALSE;
	lbl_Address_Invitation.hidden=FALSE;
	lbl_AddressStatic_Invitation.hidden=FALSE;
	
	
	// for idbadge view
	lbl_Company_IDBadge.hidden=TRUE;
	lbl_CompanyStatic_IDBadge.hidden=TRUE;
	lbl_NameStatic_IDBadge.hidden=TRUE;
	lbl_Name_IDBadge.hidden=TRUE;
	lbl_JobTitle_IDBadge.hidden=TRUE;
	lbl_JobTitleStatic_IDBadge.hidden=TRUE;
	
	//15/12/2011 end
}
-(IBAction)onContinueClick_Invitation
{
	[txt_Title_Invitation resignFirstResponder];
	[txt_Add_Invitation resignFirstResponder];
	[txt_City_Invitation resignFirstResponder];
	[txt_State_Invitation resignFirstResponder];
	[txt_ZipCode_Invitation resignFirstResponder];
	[txt_Country_Invitation resignFirstResponder];
	
	imgInvitation.hidden = NO;//jayna1512116.18
	//barCodeImgView.image = ivBarcode_IDBadge.image;
	
	//19/12/2011 deval start
	
	if (imgInvitation.image==[UIImage imageNamed:@"photoBachground.png"])
		imgInvitation.image=nil;
	if (ivBarcode_Invitation.image==[UIImage imageNamed:@"ivBackground.png"]) {
		barCodeImgView.image=nil;
		btn_Barcode_ImageProcessingView.hidden=TRUE;
	}
	else {
		barCodeImgView.image = ivBarcode_Invitation.image;
		btn_Barcode_ImageProcessingView.hidden=FALSE;
	}
	////19/12/2011 deval end
	
	flagForBackClick=TRUE;
	imageProcessingView.hidden=FALSE;
	ivMainImage.image=vc.img_ImageNameFromFlow;
	
	iv_photoLibImg.image=nil;
	if (vc.selectedImageIndex==7) {
		btn_ColorPicker.hidden=FALSE;
		btn_OpenCamera.hidden=FALSE;
		iv_photoLibImg.hidden=FALSE;
		colorView.hidden=FALSE;
	}
	else {
		btn_ColorPicker.hidden=TRUE;
		btn_OpenCamera.hidden=TRUE;
		iv_photoLibImg.hidden=TRUE;
		colorView.hidden=TRUE;
	}
	lbl_Title_Invitation.text = txt_Title_Invitation.text;
	lbl_Address_Invitation.text = [NSString stringWithFormat:@"               %@",txt_Add_Invitation.text];
	NSString *str_EventString_Invitation;
	NSString *strTemp_Invitaion;
	strTemp_Invitaion = @"";
	str_EventString_Invitation = @"\n";
	[self onAlignmentBottomClick];
	
	if ([txt_Title_Invitation.text isEqualToString:@""]) {
		lbl_Title_Invitation.hidden=TRUE;
		lbl_TitleStatic_Invitation.hidden=TRUE;
	}
	else {
		lbl_Title_Invitation.hidden=TRUE;
		lbl_TitleStatic_Invitation.hidden=TRUE;	
		str_EventString_Invitation = [str_EventString_Invitation stringByAppendingString:[NSString stringWithFormat:@" %@ \n\n",lbl_Title_Invitation.text]];
	}
	if ([txt_Add_Invitation.text isEqualToString:@""]&&[txt_City_Invitation.text isEqualToString:@""]&&[txt_State_Invitation.text isEqualToString:@""]&&[txt_ZipCode_Invitation.text isEqualToString:@""]&&[txt_Country_Invitation.text isEqualToString:@""]) {
		lbl_Address_Invitation.hidden=TRUE;
		lbl_AddressStatic_Invitation.hidden=TRUE;
	}   
	else {
		lbl_Address_Invitation.hidden=TRUE;
		lbl_AddressStatic_Invitation.hidden=TRUE;
		strAddressTOpassLibrary_Invitaion=@"";
		strTemp_Invitaion=@"1";
		strAddressTOpassLibrary_Invitaion = [[strAddressTOpassLibrary_Invitaion stringByAppendingString:[NSString stringWithFormat:@"%@ %@ ",lbl_AddressStatic_Invitation.text,txt_Add_Invitation.text]] retain];
		str_EventString_Invitation = [str_EventString_Invitation stringByAppendingString:[NSString stringWithFormat:@" %@\n",txt_Add_Invitation.text]];
	}
	if (![txt_City_Invitation.text isEqualToString:@""]) {
		if ([strTemp_Invitaion isEqualToString:@""]) {
			strTemp_Invitaion=@"1";
			strAddressTOpassLibrary_Invitaion = [[strAddressTOpassLibrary_Invitaion stringByAppendingString:[NSString stringWithFormat:@"%@",txt_City_Invitation.text]] retain];
			str_EventString_Invitation =  [str_EventString_Invitation stringByAppendingString:[NSString stringWithFormat:@" %@",txt_City_Invitation.text]];
		}
		else {
			
			strAddressTOpassLibrary_Invitaion = [[strAddressTOpassLibrary_Invitaion stringByAppendingString:[NSString stringWithFormat:@",%@",txt_City_Invitation.text]] retain];
			str_EventString_Invitation =  [str_EventString_Invitation stringByAppendingString:[NSString stringWithFormat:@" %@",txt_City_Invitation.text]];
		}

		
	}
	if (![txt_State_Invitation.text isEqualToString:@""]) {
		if ([strTemp_Invitaion isEqualToString:@""]) {
			strTemp_Invitaion=@"1";
			strAddressTOpassLibrary_Invitaion = [[strAddressTOpassLibrary_Invitaion stringByAppendingString:[NSString stringWithFormat:@"%@",txt_State_Invitation.text]] retain];
			str_EventString_Invitation =  [str_EventString_Invitation stringByAppendingString:[NSString stringWithFormat:@" %@",txt_State_Invitation.text]];
		}
		else {
			if (![txt_City_Invitation.text isEqualToString:@""]) {
				strAddressTOpassLibrary_Invitaion = [[strAddressTOpassLibrary_Invitaion stringByAppendingString:[NSString stringWithFormat:@",%@",txt_State_Invitation.text]] retain];
				str_EventString_Invitation =  [str_EventString_Invitation stringByAppendingString:[NSString stringWithFormat:@", %@",txt_State_Invitation.text]];
			}
			else {
				strAddressTOpassLibrary_Invitaion = [[strAddressTOpassLibrary_Invitaion stringByAppendingString:[NSString stringWithFormat:@",%@",txt_State_Invitation.text]] retain];
				str_EventString_Invitation =  [str_EventString_Invitation stringByAppendingString:[NSString stringWithFormat:@" %@",txt_State_Invitation.text]];
			}

		}
		
	}
	if (![txt_ZipCode_Invitation.text isEqualToString:@""]) {
		if ([strTemp_Invitaion isEqualToString:@""]) {
			strTemp_Invitaion=@"1";
			strAddressTOpassLibrary_Invitaion = [[strAddressTOpassLibrary_Invitaion stringByAppendingString:[NSString stringWithFormat:@"%@",txt_ZipCode_Invitation.text]] retain];
			str_EventString_Invitation =  [str_EventString_Invitation stringByAppendingString:[NSString stringWithFormat:@" %@",txt_ZipCode_Invitation.text]];
		}
		else {
			//if (![txt_State_Invitation.text isEqualToString:@""]) {
//				strAddressTOpassLibrary_Invitaion = [[strAddressTOpassLibrary_Invitaion stringByAppendingString:[NSString stringWithFormat:@",%@",txt_ZipCode_Invitation.text]] retain];
//				str_EventString_Invitation =  [str_EventString_Invitation stringByAppendingString:[NSString stringWithFormat:@"%@",txt_ZipCode_Invitation.text]];
//			}
//			else if ([txt_State_Invitation.text isEqualToString:@""]&&[txt_City_Invitation.text isEqualToString:@""]) {
//				strAddressTOpassLibrary_Invitaion = [[strAddressTOpassLibrary_Invitaion stringByAppendingString:[NSString stringWithFormat:@",%@",txt_ZipCode_Invitation.text]] retain];
//				str_EventString_Invitation =  [str_EventString_Invitation stringByAppendingString:[NSString stringWithFormat:@"%@",txt_ZipCode_Invitation.text]];
//			}
//			else {
				strAddressTOpassLibrary_Invitaion = [[strAddressTOpassLibrary_Invitaion stringByAppendingString:[NSString stringWithFormat:@",%@",txt_ZipCode_Invitation.text]] retain];
				str_EventString_Invitation =  [str_EventString_Invitation stringByAppendingString:[NSString stringWithFormat:@" %@",txt_ZipCode_Invitation.text]];
			//}
			
		}
		
	}
	if (![txt_Country_Invitation.text isEqualToString:@""]) {
		if ([strTemp_Invitaion isEqualToString:@""]) {
			strTemp_Invitaion=@"1";
			strAddressTOpassLibrary_Invitaion = [[strAddressTOpassLibrary_Invitaion stringByAppendingString:[NSString stringWithFormat:@"%@",txt_Country_Invitation.text]] retain];
			str_EventString_Invitation =  [str_EventString_Invitation stringByAppendingString:[NSString stringWithFormat:@" %@",txt_Country_Invitation.text]];
		}
		else {
			
			strAddressTOpassLibrary_Invitaion = [[strAddressTOpassLibrary_Invitaion stringByAppendingString:[NSString stringWithFormat:@",%@",txt_Country_Invitation.text]] retain];
			str_EventString_Invitation =  [str_EventString_Invitation stringByAppendingString:[NSString stringWithFormat:@"\n %@",txt_Country_Invitation.text]];
		}
		
	}
	attrStr_Invitation = [NSMutableAttributedString attributedStringWithString:str_EventString_Invitation];
	
	[attrStr_Invitation setFont:[UIFont fontWithName:@"Helvetica" size:13]];
	if ([str_Flag_Gradient isEqualToString:@"Black"])
		[attrStr_Invitation setTextColor:[UIColor blackColor]];
	else
		[attrStr_Invitation setTextColor:[UIColor whiteColor]];
	if (![txt_Title_Invitation.text isEqualToString:@""]) {
		[attrStr_Invitation setTextBold:YES range:[str_EventString_Invitation rangeOfString:[NSString stringWithFormat:@"%@",lbl_Title_Invitation.text]]];
		[attrStr_Invitation setFont:[UIFont boldSystemFontOfSize:15] range:[str_EventString_Invitation rangeOfString:[NSString stringWithFormat:@"%@",lbl_Title_Invitation.text]]];
	}
	//if (![txt_Add_Invitation.text isEqualToString:@""]) {
//		[attrStr_Invitation setTextBold:YES range:[str_EventString_Invitation rangeOfString:@"Address:"]];
//	}
	
	tv_EventView.attributedText=attrStr_Invitation;
	tv_EventView.linkColor = [UIColor blackColor];
}
-(IBAction)onIDBadgeClick
{
	
	
	appDel.mon=FALSE;
	appDel.tue=FALSE;
	appDel.wed=FALSE;
	appDel.thu=FALSE;
	appDel.fri=FALSE;
	appDel.sat=FALSE;
	appDel.sun=FALSE;
	appDel.strStartTime=@"";
	appDel.strEndTime=@"";
	btn_Plus.hidden=TRUE;
	if (FlagForCoverFlow==FALSE){}
	else{
		FlagForCoverFlow=FALSE;
		[self addCoverFlow];
	}
	imgInvitation.image=nil;
	txt_Company_IDBadge.text=@"";
	txt_Name_IDBadge.text=@"";
	txt_JobTitle_IDBadge.text=@"";
	ivBarcode_IDBadge.image=[UIImage imageNamed:@"ivBackground.png"];
	ivPhoto_IDBadge.image=[UIImage imageNamed:@"photoBachground.png"];
	FlagForPhotoFromInvitation=TRUE;
	if ([strFlag isEqualToString:@"UDT"]) {
		coverFloWView.hidden=FALSE;
		libraryView.hidden=TRUE;
	}
	else {
		coverFloWView.hidden=TRUE;
		libraryView.hidden=FALSE;
	}
	imageProcessingView.hidden=TRUE;
	PreviewShareView.hidden=TRUE;
	businessView.hidden=TRUE;
	invitationView.hidden=TRUE;
	idbadgeView.hidden=TRUE;
	eventView.hidden=TRUE;
	courseinfoView.hidden=TRUE;
	barcodeView.hidden=TRUE;
	//[self onBackClick];
	if(!imageProcessingView.hidden)
	{
		imageProcessingView.hidden=TRUE;
		flagForBackClick=FALSE;
	}
	str_TM_SelectedItem = @"IDBadge";
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		[btn_Event setBackgroundImage:[UIImage imageNamed:@"event-p.png"] forState:UIControlStateNormal];
		[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard-p.png"] forState:UIControlStateNormal];
		[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation-p.png"] forState:UIControlStateNormal];
		[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge-hover-p.png"] forState:UIControlStateNormal];
		[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo-p.png"] forState:UIControlStateNormal];
	}
	else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
			appDel.ori == UIInterfaceOrientationLandscapeRight)
	{
		[btn_Event setBackgroundImage:[UIImage imageNamed:@"event.png"] forState:UIControlStateNormal];
		[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard.png"] forState:UIControlStateNormal];
		[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation.png"] forState:UIControlStateNormal];
		[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge-hover.png"] forState:UIControlStateNormal];
		[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"courseinfo.png"] forState:UIControlStateNormal];
	}
	/// for image processing
	//for eventview start
	lbl_EventTitle.hidden=TRUE;
	lbl_EventTitleStatic.hidden=TRUE;
	lbl_Start.hidden=TRUE;
	lbl_StartStatic.hidden=TRUE;
	lbl_End.hidden=TRUE;
	lbl_EndStatic.hidden=TRUE;
	lbl_Notes.hidden=TRUE;
	lbl_NotesStatic.hidden=TRUE;
	lbl_Address.hidden=TRUE;
	lbl_AddressStatic.hidden=TRUE;
	//for eventview end
	
	///////14/12/2011 start
	//for businessview
	lbl_Company.hidden=TRUE;
	lbl_CompanyStatic.hidden=TRUE;
	lbl_JobTitle.hidden=TRUE;
	lbl_JobTitleStatic.hidden=TRUE;
	lbl_Name.hidden=TRUE;
	lbl_NameStatic.hidden=TRUE;
	lbl_Email.hidden=TRUE;
	lbl_EmailStatic.hidden=TRUE;
	lbl_Phone.hidden=TRUE;
	lbl_PhoneStatic.hidden=TRUE;
	lbl_Address_BusinessCard.hidden=TRUE;
	lbl_AddressStatic_BusinessCard.hidden=TRUE;
	
	///////14/12/2011 start
	
	///15/12/2011 start
	// for course ifo view
	lbl_CourseName.hidden=TRUE;
	lbl_CourseNameStatic.hidden=TRUE;
	lbl_CourseCodeStatic.hidden=TRUE;
	lbl_CourseCode.hidden=TRUE;
	lbl_Professor.hidden=TRUE;
	lbl_ProfessorStatic.hidden=TRUE;
	lbl_DateTime.hidden=TRUE;
	lbl_DateTimeStatic.hidden=TRUE;
	
	lbl_Title_Invitation.hidden=TRUE;
	lbl_TitleStatic_Invitation.hidden=TRUE;
	lbl_Address_Invitation.hidden=TRUE;
	lbl_AddressStatic_Invitation.hidden=TRUE;
	
	
	// for idbadge view
	lbl_Company_IDBadge.hidden=FALSE;
	lbl_CompanyStatic_IDBadge.hidden=FALSE;
	lbl_NameStatic_IDBadge.hidden=FALSE;
	lbl_Name_IDBadge.hidden=FALSE;
	lbl_JobTitle_IDBadge.hidden=FALSE;
	lbl_JobTitleStatic_IDBadge.hidden=FALSE;
	
	//15/12/2011 end
}
-(IBAction)onContinueClick_IDBadge
{
	[txt_Company_IDBadge resignFirstResponder];
	[txt_Name_IDBadge resignFirstResponder];
	[txt_JobTitle_IDBadge resignFirstResponder];
	imgInvitation.hidden = NO;//jayna1512116.18
	//barCodeImgView.image = ivBarcode_IDBadge.image;
	//19/12/2011 deval start
	if (imgInvitation.image==[UIImage imageNamed:@"photoBachground.png"])
		imgInvitation.image=nil;
	if (ivBarcode_IDBadge.image==[UIImage imageNamed:@"ivBackground.png"]) {
		barCodeImgView.image=nil;
		btn_Barcode_ImageProcessingView.hidden=TRUE;
	}
	else {
		barCodeImgView.image = ivBarcode_IDBadge.image;
		btn_Barcode_ImageProcessingView.hidden=FALSE;
	}
	flagForBackClick=TRUE;
	imageProcessingView.hidden=FALSE;
	ivMainImage.image=vc.img_ImageNameFromFlow;
	iv_photoLibImg.image=nil;
	
	if (vc.selectedImageIndex==7) {
		btn_ColorPicker.hidden=FALSE;
		btn_OpenCamera.hidden=FALSE;
		iv_photoLibImg.hidden=FALSE;
		colorView.hidden=FALSE;
	}
	else {
		btn_ColorPicker.hidden=TRUE;
		btn_OpenCamera.hidden=TRUE;
		iv_photoLibImg.hidden=TRUE;
		colorView.hidden=TRUE;
	}
	lbl_Company_IDBadge.text = txt_Company_IDBadge.text;
	lbl_Name_IDBadge.text = txt_Name_IDBadge.text;
	lbl_JobTitle_IDBadge.text = txt_JobTitle_IDBadge.text;
	[self onAlignmentBottomClick];
	NSString *str_EventString_IDBadge;
	str_EventString_IDBadge = @"\n";
	
	if ([txt_Company_IDBadge.text isEqualToString:@"" ]) {
		lbl_CompanyStatic_IDBadge.hidden=TRUE;
	}
	else {
		lbl_CompanyStatic_IDBadge.hidden=TRUE;
		lbl_Company_IDBadge.hidden=TRUE;
		str_EventString_IDBadge = [str_EventString_IDBadge stringByAppendingString:[NSString stringWithFormat:@" %@ \n\n",lbl_Company_IDBadge.text]];
	}
	if ([txt_Name_IDBadge.text isEqualToString:@"" ]) {
		lbl_NameStatic_IDBadge.hidden=TRUE;
	}
	else {
		lbl_NameStatic_IDBadge.hidden=TRUE;
		lbl_Name_IDBadge.hidden=TRUE;
		str_EventString_IDBadge = [str_EventString_IDBadge stringByAppendingString:[NSString stringWithFormat:@" %@ \n\n",lbl_Name_IDBadge.text]];
	}
	if ([txt_JobTitle_IDBadge.text isEqualToString:@"" ]) {
		lbl_JobTitleStatic_IDBadge.hidden=TRUE;
	}
	else {
		lbl_JobTitleStatic_IDBadge.hidden=TRUE;
		lbl_JobTitle_IDBadge.hidden=TRUE;
		str_EventString_IDBadge = [str_EventString_IDBadge stringByAppendingString:[NSString stringWithFormat:@" %@ \n\n",lbl_JobTitle_IDBadge.text]];
	}
	attrStr_IDBadge = [NSMutableAttributedString attributedStringWithString:str_EventString_IDBadge];
	[attrStr_IDBadge setFont:[UIFont fontWithName:@"Helvetica" size:13]];
	if ([str_Flag_Gradient isEqualToString:@"Black"])
		[attrStr_IDBadge setTextColor:[UIColor blackColor]];
	else
		[attrStr_IDBadge setTextColor:[UIColor whiteColor]];
	if (![txt_Company_IDBadge.text isEqualToString:@"" ]) {
		//[attrStr_IDBadge setTextBold:YES range:[str_EventString_IDBadge rangeOfString:[NSString stringWithFormat:@"%@",lbl_Company_IDBadge.text]]];
		//[attrStr_IDBadge setFont:[UIFont boldSystemFontOfSize:15] range:[str_EventString_IDBadge rangeOfString:[NSString stringWithFormat:@"%@",lbl_Company_IDBadge.text]]];
	}
	if (![txt_Name_IDBadge.text isEqualToString:@"" ]) {
		[attrStr_IDBadge setTextBold:YES range:[str_EventString_IDBadge rangeOfString:[NSString stringWithFormat:@"%@",lbl_Name_IDBadge.text]]];
		//[attrStr_IDBadge setFont:[UIFont boldSystemFontOfSize:15] range:[str_EventString_IDBadge rangeOfString:[NSString stringWithFormat:@"%@",lbl_Name_IDBadge.text]]];
	}
	//if (![txt_JobTitle_IDBadge.text isEqualToString:@"" ]) {
//		[attrStr_IDBadge setTextBold:YES range:[str_EventString_IDBadge rangeOfString:[NSString stringWithFormat:@"%@",lbl_JobTitle_IDBadge.text]]];
//	}
	tv_EventView.attributedText=attrStr_IDBadge;
}
-(IBAction)onContactInfoClick
{
	appDel.mon=FALSE;
	appDel.tue=FALSE;
	appDel.wed=FALSE;
	appDel.thu=FALSE;
	appDel.fri=FALSE;
	appDel.sat=FALSE;
	appDel.sun=FALSE;
	appDel.strStartTime=@"";
	appDel.strEndTime=@"";
	btn_Plus.hidden=TRUE;
	if (FlagForCoverFlow==FALSE){}
	else{
		FlagForCoverFlow=FALSE;
		[self addCoverFlow];
	}
	txt_CourseName.text=@"";
	txt_CourseCode.text=@"";
	txt_Professor.text=@"";
	txt_DateTime.text=@"";
	ivBarcode_CourseInfo.image=[UIImage imageNamed:@"ivBackground.png"];
	if ([strFlag isEqualToString:@"UDT"]) {
		coverFloWView.hidden=FALSE;
		libraryView.hidden=TRUE;
	}
	else {
		coverFloWView.hidden=TRUE;
		libraryView.hidden=FALSE;
	}
	imageProcessingView.hidden=TRUE;
	PreviewShareView.hidden=TRUE;
	businessView.hidden=TRUE;
	invitationView.hidden=TRUE;
	idbadgeView.hidden=TRUE;
	eventView.hidden=TRUE;
	courseinfoView.hidden=TRUE;
	barcodeView.hidden=TRUE;
	//[self onBackClick];
	if(!imageProcessingView.hidden)
	{
		imageProcessingView.hidden=TRUE;
		flagForBackClick=FALSE;
	}
	str_TM_SelectedItem = @"CourseInfo";
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		[btn_Event setBackgroundImage:[UIImage imageNamed:@"event-p.png"] forState:UIControlStateNormal];
		[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard-p.png"] forState:UIControlStateNormal];
		[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation-p.png"] forState:UIControlStateNormal];
		[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge-p.png"] forState:UIControlStateNormal];
		[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"course-hover-p.png"] forState:UIControlStateNormal];
		
	}
	else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
			appDel.ori == UIInterfaceOrientationLandscapeRight)
	{
		[btn_Event setBackgroundImage:[UIImage imageNamed:@"event.png"] forState:UIControlStateNormal];
		[btn_BusinessCard setBackgroundImage:[UIImage imageNamed:@"businesscard.png"] forState:UIControlStateNormal];
		[btn_Invitation setBackgroundImage:[UIImage imageNamed:@"invitation.png"] forState:UIControlStateNormal];
		[btn_IDBadge setBackgroundImage:[UIImage imageNamed:@"idbadge.png"] forState:UIControlStateNormal];
		[btn_ContactInfo setBackgroundImage:[UIImage imageNamed:@"course-hover.png"] forState:UIControlStateNormal];
	}
	
	/// for image processing
	//for eventview start
	
	lbl_EventTitle.hidden=TRUE;
	lbl_EventTitleStatic.hidden=TRUE;
	lbl_Start.hidden=TRUE;
	lbl_StartStatic.hidden=TRUE;
	lbl_End.hidden=TRUE;
	lbl_EndStatic.hidden=TRUE;
	lbl_Notes.hidden=TRUE;
	lbl_NotesStatic.hidden=TRUE;
	lbl_Address.hidden=TRUE;
	lbl_AddressStatic.hidden=TRUE;
	//for eventview end
	
	///////14/12/2011 start
	//for businessview
	lbl_Company.hidden=TRUE;
	lbl_CompanyStatic.hidden=TRUE;
	lbl_JobTitle.hidden=TRUE;
	lbl_JobTitleStatic.hidden=TRUE;
	lbl_Name.hidden=TRUE;
	lbl_NameStatic.hidden=TRUE;
	lbl_Email.hidden=TRUE;
	lbl_EmailStatic.hidden=TRUE;
	lbl_Phone.hidden=TRUE;
	lbl_PhoneStatic.hidden=TRUE;
	lbl_Address_BusinessCard.hidden=TRUE;
	lbl_AddressStatic_BusinessCard.hidden=TRUE;
	
	///////14/12/2011 start
	
	///15/12/2011 start
	// for course ifo view
	lbl_CourseName.hidden=FALSE;
	lbl_CourseNameStatic.hidden=FALSE;
	lbl_CourseCodeStatic.hidden=FALSE;
	lbl_CourseCode.hidden=FALSE;
	lbl_Professor.hidden=FALSE;
	lbl_ProfessorStatic.hidden=FALSE;
	lbl_DateTime.hidden=FALSE;
	lbl_DateTimeStatic.hidden=FALSE;
	
	lbl_Title_Invitation.hidden=TRUE;
	lbl_TitleStatic_Invitation.hidden=TRUE;
	lbl_Address_Invitation.hidden=TRUE;
	lbl_AddressStatic_Invitation.hidden=TRUE;
	
	// for idbadge view
	lbl_Company_IDBadge.hidden=TRUE;
	lbl_CompanyStatic_IDBadge.hidden=TRUE;
	lbl_NameStatic_IDBadge.hidden=TRUE;
	lbl_Name_IDBadge.hidden=TRUE;
	lbl_JobTitle_IDBadge.hidden=TRUE;
	lbl_JobTitleStatic_IDBadge.hidden=TRUE;
	//15/12/2011 end
}
-(IBAction)onContinueClick_CourseInfo
{
	[txt_CourseName resignFirstResponder];
	[txt_CourseCode resignFirstResponder];
	[txt_Professor resignFirstResponder];
	//[txt_DateTime resignFirstResponder];
	imgInvitation.hidden = TRUE;//jayna1512116.18
	//barCodeImgView.image = ivBarcode_CourseInfo.image;
	//19/12/2011 deval start
	if (ivBarcode_CourseInfo.image==[UIImage imageNamed:@"ivBackground.png"]) {
		barCodeImgView.image=nil;
		btn_Barcode_ImageProcessingView.hidden=TRUE;
	}
	else {
		barCodeImgView.image = ivBarcode_CourseInfo.image;
		btn_Barcode_ImageProcessingView.hidden=FALSE;
	}
	
	flagForBackClick=TRUE;
	imageProcessingView.hidden=FALSE;
	ivMainImage.image=vc.img_ImageNameFromFlow;
	iv_photoLibImg.image=nil;
	
	if (vc.selectedImageIndex==7) {
		btn_ColorPicker.hidden=FALSE;
		btn_OpenCamera.hidden=FALSE;
		iv_photoLibImg.hidden=FALSE;
		colorView.hidden=FALSE;
	}
	else {
		btn_ColorPicker.hidden=TRUE;
		btn_OpenCamera.hidden=TRUE;
		iv_photoLibImg.hidden=TRUE;
		colorView.hidden=TRUE;
	}
	lbl_CourseName.text = txt_CourseName.text;
	lbl_CourseCode.text = txt_CourseCode.text;
	lbl_Professor.text = txt_Professor.text;
	lbl_DateTime.text = txt_DateTime.text;
	[self onAlignmentBottomClick];
	NSString *str_EventString_CourseInfo;
	str_EventString_CourseInfo = @"";
	
	if ([txt_CourseName.text isEqualToString:@""]) {
		lbl_CourseNameStatic.hidden=TRUE;
	}
	else {
		lbl_CourseNameStatic.hidden=TRUE;
		lbl_CourseName.hidden=TRUE;
		str_EventString_CourseInfo = [str_EventString_CourseInfo stringByAppendingString:[NSString stringWithFormat:@"%@ %@ \n\n",lbl_CourseNameStatic.text,lbl_CourseName.text]];
	}
	if ([txt_CourseCode.text isEqualToString:@""]) {
		lbl_CourseCodeStatic.hidden=TRUE;
	}
	else {
		lbl_CourseCodeStatic.hidden=TRUE;
		lbl_CourseCode.hidden=TRUE;
		str_EventString_CourseInfo = [str_EventString_CourseInfo stringByAppendingString:[NSString stringWithFormat:@"%@ %@ \n\n",lbl_CourseCodeStatic.text,lbl_CourseCode.text]];
	}
	if ([txt_Professor.text isEqualToString:@""]) {
		lbl_ProfessorStatic.hidden=TRUE;
	}
	else {
		lbl_ProfessorStatic.hidden=TRUE;
		lbl_Professor.hidden=TRUE;
		str_EventString_CourseInfo = [str_EventString_CourseInfo stringByAppendingString:[NSString stringWithFormat:@"%@ %@ \n\n",lbl_ProfessorStatic.text,lbl_Professor.text]];
	}
	if ([txt_DateTime.text isEqualToString:@""]) {
		lbl_DateTimeStatic.hidden=TRUE;
	}
	else {
		lbl_DateTimeStatic.hidden=TRUE;
		lbl_DateTime.hidden=TRUE;
		str_EventString_CourseInfo = [str_EventString_CourseInfo stringByAppendingString:[NSString stringWithFormat:@"%@ %@ ",lbl_DateTimeStatic.text,lbl_DateTime.text]];
	}
	attrStr_CourseInfo = [NSMutableAttributedString attributedStringWithString:str_EventString_CourseInfo];
	[attrStr_CourseInfo setFont:[UIFont fontWithName:@"Helvetica" size:13]];
	if ([str_Flag_Gradient isEqualToString:@"Black"])
		[attrStr_CourseInfo setTextColor:[UIColor blackColor]];
	else
		[attrStr_CourseInfo setTextColor:[UIColor whiteColor]];
	if (![txt_CourseName.text isEqualToString:@""]) {
		[attrStr_CourseInfo setTextBold:YES range:[str_EventString_CourseInfo rangeOfString:@"Course Name:"]];
	}
	if (![txt_CourseCode.text isEqualToString:@""]) {
		[attrStr_CourseInfo setTextBold:YES range:[str_EventString_CourseInfo rangeOfString:@"Course Code:"]];
	}
	if (![txt_Professor.text isEqualToString:@""]) {
		[attrStr_CourseInfo setTextBold:YES range:[str_EventString_CourseInfo rangeOfString:@"Professor:"]];
	}
	if (![txt_DateTime.text isEqualToString:@""]) {
		[attrStr_CourseInfo setTextBold:YES range:[str_EventString_CourseInfo rangeOfString:@"Day and Time:"]];
	}
	tv_EventView.attributedText = attrStr_CourseInfo;
	tv_EventView.linkColor = [UIColor blackColor];
}
# pragma mark For AlignmentButtons Clicks

-(IBAction)onAlignmentLeftClick
{
	str_flagForAlignmentClick=@"Left";
	//ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical.png"];
	if ([str_Flag_Gradient isEqualToString:@"Black"]) {
		ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical-White.png"];
	}
	else {
		ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical.png"];
	}
	if(appDel.ori == 0)
		appDel.ori = [[UIDevice currentDevice] orientation];
	
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		//if ([str_TM_SelectedItem isEqualToString:@"Event"]) {
		ivGradient.frame = CGRectMake(95, 42, 260, 280);
		tv_EventView.frame = CGRectMake(105, 47, 240, 270);
		int y=140;
		
		if ([str_TM_SelectedItem isEqualToString:@"Invitation"]||[str_TM_SelectedItem isEqualToString:@"IDBadge"] )
		{
			
			barCodeImgView.frame = CGRectMake(410, 75, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(410, 75, 100, 100);////jayna1512116.18
			//jayna1512116.18
			imgInvitation.frame = CGRectMake(410, 75+100+10, 100, 100);
			
		}
		else {
			barCodeImgView.frame = CGRectMake(420, 120, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(420, 120, 100, 100);////jayna1512116.18
		}
		
	// EventView Lables
		lbl_EventTitleStatic.frame = CGRectMake(110, 200-y, 76, 21);
		lbl_EventTitle.frame = CGRectMake(186, 200-y, 165, 21);
		lbl_StartStatic.frame = CGRectMake(110, 230-y, 79, 21);
		lbl_Start.frame = CGRectMake(188, 230-y, 162, 21);
		lbl_EndStatic.frame = CGRectMake(110, 248-y, 74, 21);
		lbl_End.frame = CGRectMake(184, 248-y, 165, 21);
		lbl_NotesStatic.frame = CGRectMake(112, 278-y, 46, 21);
		//lbl_Notes.frame = CGRectMake(110, 300-y, 245, 21);
//		lbl_AddressStatic.frame = CGRectMake(110, 330-y, 66, 21);
//		lbl_Address.frame = CGRectMake(110, 353-y, 245, 100);
//		lbl_Address.numberOfLines=6;
		
		lbl_Notes.frame = CGRectMake(112, 281-y, 245, 63);
		CGSize maximumLabelSize = CGSizeMake(245,9999);
		CGSize expectedLabelSize = [lbl_Notes.text sizeWithFont:lbl_Notes.font constrainedToSize:maximumLabelSize lineBreakMode:lbl_Notes.lineBreakMode];
		CGRect newFrame = lbl_Notes.frame;
		newFrame.size.height = expectedLabelSize.height;
		lbl_Notes.frame = newFrame;
		lbl_Notes.numberOfLines=0; 
		lbl_AddressStatic.frame = CGRectMake(112, 345-y, 66, 21);
		lbl_Address.frame = CGRectMake(112, 358-y, 200, 120);//348
		CGSize maximumLabelSize2 = CGSizeMake(200,9999);
		CGSize expectedLabelSize2 = [lbl_Address.text sizeWithFont:lbl_Address.font constrainedToSize:maximumLabelSize2 lineBreakMode:lbl_Address.lineBreakMode];
		CGRect newFrame2 = lbl_Address.frame;
		newFrame2.size.height = expectedLabelSize2.height;
		lbl_Address.frame = newFrame2;
		lbl_Address.numberOfLines=0;
		
		
		////  14/12/2011 start
		//BusinessView Lables 
		lbl_CompanyStatic.frame = CGRectMake(110, 200-y, 76, 21);
		lbl_Company.frame = CGRectMake(180, 200-y, 165, 21);
		lbl_JobTitleStatic.frame = CGRectMake(110, 223-y, 79, 21);
		lbl_JobTitle.frame = CGRectMake(175, 223-y, 162, 21);
		lbl_NameStatic.frame = CGRectMake(110, 248-y, 74, 21);
		lbl_Name.frame = CGRectMake(155, 248-y, 190, 21);
		lbl_EmailStatic.frame = CGRectMake(110, 275-y, 46, 21);
		lbl_Email.frame = CGRectMake(155, 275-y, 190, 21);
		lbl_PhoneStatic.frame = CGRectMake(110, 300-y, 245, 21);
		lbl_Phone.frame = CGRectMake(160, 300-y, 190, 21);
		lbl_AddressStatic_BusinessCard.frame = CGRectMake(110, 330-y, 66, 21);
		//lbl_Address_BusinessCard.frame = CGRectMake(110, 353-y, 237, 100);
//		lbl_Address_BusinessCard.numberOfLines=6;
		lbl_Address_BusinessCard.frame = CGRectMake(110, 333-y, 200, 120);
		CGSize maximumLabelSize12 = CGSizeMake(200,9999);
		CGSize expectedLabelSize12 = [lbl_Address_BusinessCard.text sizeWithFont:lbl_Address_BusinessCard.font constrainedToSize:maximumLabelSize12 lineBreakMode:lbl_Address_BusinessCard.lineBreakMode];
		CGRect newFrame12 = lbl_Address_BusinessCard.frame;
		newFrame12.size.height = expectedLabelSize12.height;
		lbl_Address_BusinessCard.frame = newFrame12;
		lbl_Address_BusinessCard.numberOfLines=0;
		////  14/12/2011 start
		
		/////15/12/2011 start
		//for course info
		int k=-65;
		lbl_CourseNameStatic.frame = CGRectMake(110, 200-y-k, 100, 21);
		lbl_CourseName.frame = CGRectMake(204, 200-y-k, 140, 21);
		lbl_CourseCodeStatic.frame = CGRectMake(110, 223-y-k, 100, 21);
		lbl_CourseCode.frame = CGRectMake(202, 223-y-k, 140, 21);
		lbl_ProfessorStatic.frame = CGRectMake(110, 248-y-k, 72, 21);
		lbl_Professor.frame = CGRectMake(181, 248-y-k, 140, 21);
		lbl_DateTimeStatic.frame = CGRectMake(110, 275-y-k, 100, 21);
		lbl_DateTime.frame = CGRectMake(212, 275-y-k, 140, 21);
		/////15/12/2011  end
		int zx=40;
		//for invitationview
		lbl_TitleStatic_Invitation.frame = CGRectMake(150-zx, 210-y-k, 76, 21);
		lbl_Title_Invitation.frame = CGRectMake(186-zx, 210-y-k, 230, 21);
		lbl_AddressStatic_Invitation.frame = CGRectMake(150-zx, 240-y-k, 76, 21);
		lbl_Address_Invitation.frame = CGRectMake(150-zx, 243-y-k, 180, 21);
		CGSize maximumLabelSize125 = CGSizeMake(180,9999);
		CGSize expectedLabelSize125 = [lbl_Address_Invitation.text sizeWithFont:lbl_Address_Invitation.font constrainedToSize:maximumLabelSize125 lineBreakMode:lbl_Address_Invitation.lineBreakMode];
		CGRect newFrame125 = lbl_Address_Invitation.frame;
		newFrame125.size.height = expectedLabelSize125.height;
		lbl_Address_Invitation.frame = newFrame125;
		lbl_Address_Invitation.numberOfLines=0;
		
		//for idbadge view
		lbl_CompanyStatic_IDBadge.frame = CGRectMake(150-zx, 210-y-k, 110, 21);
		lbl_Company_IDBadge.frame = CGRectMake(258-zx, 210-y-k, 135, 21);
		lbl_NameStatic_IDBadge.frame = CGRectMake(150-zx, 240-y-k, 76, 21);
		lbl_Name_IDBadge.frame = CGRectMake(195-zx, 240-y-k, 180, 21);
		lbl_JobTitleStatic_IDBadge.frame = CGRectMake(150-zx, 270-y-k, 100, 21);
		lbl_JobTitle_IDBadge.frame = CGRectMake(214-zx, 270-y-k, 170, 21);
		//}
	}
	else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
			appDel.ori == UIInterfaceOrientationLandscapeRight)
	{		
		//if ([str_TM_SelectedItem isEqualToString:@"Event"]) {
		ivGradient.frame = CGRectMake(155, 105, 260, 280);
		tv_EventView.frame = CGRectMake(165, 110, 240, 270);
		int x=60,y=140;
		
		if ([str_TM_SelectedItem isEqualToString:@"Invitation"]||[str_TM_SelectedItem isEqualToString:@"IDBadge"] )
		{
			
			barCodeImgView.frame = CGRectMake(480, 135, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(480, 135, 100, 100);////jayna1512116.18
			//jayna1512116.18
			imgInvitation.frame = CGRectMake(480, 135+100+10, 100, 100);
			
		}
		else {
			barCodeImgView.frame = CGRectMake(480, 180, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(480, 180, 100, 100);////jayna1512116.18
		}
		
		lbl_EventTitleStatic.frame = CGRectMake(110+x, 200+x-y, 76, 21);
		lbl_EventTitle.frame = CGRectMake(186+x, 200+x-y, 165, 21);
		lbl_StartStatic.frame = CGRectMake(110+x, 230+x-y, 79, 21);
		lbl_Start.frame = CGRectMake(188+x, 230+x-y, 162, 21);
		lbl_EndStatic.frame = CGRectMake(110+x, 248+x-y, 74, 21);
		lbl_End.frame = CGRectMake(184+x, 248+x-y, 165, 21);
		lbl_NotesStatic.frame = CGRectMake(112+x, 278+x-y, 46, 21);
		//lbl_Notes.frame = CGRectMake(110+x, 300+x-y, 245, 21);
//		lbl_AddressStatic.frame = CGRectMake(110+x, 330+x-y, 66, 21);
//		lbl_Address.frame = CGRectMake(110+x, 353+x-y, 245, 100);
//		lbl_Address.numberOfLines=6;
		
		
		lbl_Notes.frame = CGRectMake(112+x, 281+x-y, 245, 63);
		CGSize maximumLabelSize = CGSizeMake(245,9999);
		CGSize expectedLabelSize = [lbl_Notes.text sizeWithFont:lbl_Notes.font constrainedToSize:maximumLabelSize lineBreakMode:lbl_Notes.lineBreakMode];
		CGRect newFrame = lbl_Notes.frame;
		newFrame.size.height = expectedLabelSize.height;
		lbl_Notes.frame = newFrame;
		lbl_Notes.numberOfLines=0; 
		lbl_AddressStatic.frame = CGRectMake(112+x, 345+x-y, 66, 21);
		lbl_Address.frame = CGRectMake(112+x, 358+x-y, 200, 120);
		CGSize maximumLabelSize2 = CGSizeMake(200,9999);
		CGSize expectedLabelSize2 = [lbl_Address.text sizeWithFont:lbl_Address.font constrainedToSize:maximumLabelSize2 lineBreakMode:lbl_Address.lineBreakMode];
		CGRect newFrame2 = lbl_Address.frame;
		newFrame2.size.height = expectedLabelSize2.height;
		lbl_Address.frame = newFrame2;
		lbl_Address.numberOfLines=0;
		
		
		
		////  14/12/2011 start
		//BusinessView Lables 
		lbl_CompanyStatic.frame = CGRectMake(110+x, 200+x-y, 76, 21);
		lbl_Company.frame = CGRectMake(180+x, 200+x-y, 165, 21);
		lbl_JobTitleStatic.frame = CGRectMake(110+x, 223+x-y, 79, 21);
		lbl_JobTitle.frame = CGRectMake(175+x, 223+x-y, 162, 21);
		lbl_NameStatic.frame = CGRectMake(110+x, 248+x-y, 74, 21);
		lbl_Name.frame = CGRectMake(155+x, 248+x-y, 190, 21);
		lbl_EmailStatic.frame = CGRectMake(110+x, 275+x-y, 46, 21);
		lbl_Email.frame = CGRectMake(155+x, 275+x-y, 190, 21);
		lbl_PhoneStatic.frame = CGRectMake(110+x, 300+x-y, 245, 21);
		lbl_Phone.frame = CGRectMake(160+x, 300+x-y, 190, 21);
		lbl_AddressStatic_BusinessCard.frame = CGRectMake(110+x, 330+x-y, 66, 21);
		//lbl_Address_BusinessCard.frame = CGRectMake(110+x, 353+x-y, 237, 100);
//		lbl_Address_BusinessCard.numberOfLines=6;
		lbl_Address_BusinessCard.frame = CGRectMake(110+x, 333+x-y, 200, 120);
		CGSize maximumLabelSize123 = CGSizeMake(200,9999);
		CGSize expectedLabelSize123 = [lbl_Address_BusinessCard.text sizeWithFont:lbl_Address_BusinessCard.font constrainedToSize:maximumLabelSize123 lineBreakMode:lbl_Address_BusinessCard.lineBreakMode];
		CGRect newFrame123 = lbl_Address_BusinessCard.frame;
		newFrame123.size.height = expectedLabelSize123.height;
		lbl_Address_BusinessCard.frame = newFrame123;
		lbl_Address_BusinessCard.numberOfLines=0;
		////  14/12/2011 start
		
		/////15/12/2011 start
		//for course info
		int k=-65;
		lbl_CourseNameStatic.frame = CGRectMake(110+x, 200+x-y-k, 100, 21);
		lbl_CourseName.frame = CGRectMake(204+x, 200+x-y-k, 140, 21);
		lbl_CourseCodeStatic.frame = CGRectMake(110+x, 223+x-y-k, 100, 21);
		lbl_CourseCode.frame = CGRectMake(202+x, 223+x-y-k, 140, 21);
		lbl_ProfessorStatic.frame = CGRectMake(110+x, 248+x-y-k, 72, 21);
		lbl_Professor.frame = CGRectMake(181+x, 248+x-y-k, 140, 21);
		lbl_DateTimeStatic.frame = CGRectMake(110+x, 275+x-y-k, 100, 21);
		lbl_DateTime.frame = CGRectMake(212+x, 275+x-y-k, 140, 21);
		/////15/12/2011  end
		
		
		int zx=40;
		//for invitationview
		lbl_TitleStatic_Invitation.frame = CGRectMake(150+x-zx, 210+x-y-k, 76, 21);
		lbl_Title_Invitation.frame = CGRectMake(186+x-zx, 210+x-y-k, 230, 21);
		lbl_AddressStatic_Invitation.frame = CGRectMake(150+x-zx, 240+x-y-k, 76, 21);
		lbl_Address_Invitation.frame = CGRectMake(150+x-zx, 243+x-y-k, 180, 21);
		CGSize maximumLabelSize125 = CGSizeMake(180,9999);
		CGSize expectedLabelSize125 = [lbl_Address_Invitation.text sizeWithFont:lbl_Address_Invitation.font constrainedToSize:maximumLabelSize125 lineBreakMode:lbl_Address_Invitation.lineBreakMode];
		CGRect newFrame125 = lbl_Address_Invitation.frame;
		newFrame125.size.height = expectedLabelSize125.height;
		lbl_Address_Invitation.frame = newFrame125;
		lbl_Address_Invitation.numberOfLines=0;
		
		//for idbadge view
		lbl_CompanyStatic_IDBadge.frame = CGRectMake(150+x-zx, 210+x-y-k, 110, 21);
		lbl_Company_IDBadge.frame = CGRectMake(258+x-zx, 210+x-y-k, 135, 21);
		lbl_NameStatic_IDBadge.frame = CGRectMake(150+x-zx, 240+x-y-k, 76, 21);
		lbl_Name_IDBadge.frame = CGRectMake(195+x-zx, 240+x-y-k, 180, 21);
		lbl_JobTitleStatic_IDBadge.frame = CGRectMake(150+x-zx, 270+x-y-k, 100, 21);
		lbl_JobTitle_IDBadge.frame = CGRectMake(214+x-zx, 270+x-y-k, 170, 21);
		//}
		//}
	}
}
-(IBAction)onAlignmentRightClick
{
	str_flagForAlignmentClick=@"Right";
	//ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical.png"];
	if ([str_Flag_Gradient isEqualToString:@"Black"]) {
		ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical-White.png"];
	}
	else {
		ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical.png"];
	}
	if(appDel.ori == 0)
		appDel.ori = [[UIDevice currentDevice] orientation];
	
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		//if ([str_TM_SelectedItem isEqualToString:@"Event"]) {
		ivGradient.frame = CGRectMake(320, 42, 260, 280);
		tv_EventView.frame = CGRectMake(330, 47, 240, 270);
		int y=140,x=225;
		
		if ([str_TM_SelectedItem isEqualToString:@"Invitation"]||[str_TM_SelectedItem isEqualToString:@"IDBadge"] )
		{
			
			barCodeImgView.frame = CGRectMake(160, 75, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(160, 75, 100, 100);////jayna1512116.18
			//jayna1512116.18
			imgInvitation.frame = CGRectMake(160, 75+100+10, 100, 100);
			
		}
		else {
			barCodeImgView.frame = CGRectMake(150, 120, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(150, 120, 100, 100);////jayna1512116.18
		}
		lbl_EventTitleStatic.frame = CGRectMake(110+x, 200-y, 76, 21);
		lbl_EventTitle.frame = CGRectMake(186+x, 200-y, 165, 21);
		lbl_StartStatic.frame = CGRectMake(110+x, 230-y, 79, 21);
		lbl_Start.frame = CGRectMake(188+x, 230-y, 162, 21);
		lbl_EndStatic.frame = CGRectMake(110+x, 248-y, 74, 21);
		lbl_End.frame = CGRectMake(184+x, 248-y, 165, 21);
		lbl_NotesStatic.frame = CGRectMake(112+x, 278-y, 46, 21);
		//lbl_Notes.frame = CGRectMake(110+x, 300-y, 245, 21);
//		lbl_AddressStatic.frame = CGRectMake(110+x, 330-y, 66, 21);
//		lbl_Address.frame = CGRectMake(110+x, 353-y, 245, 100);
//		lbl_Address.numberOfLines=6;
		
		lbl_Notes.frame = CGRectMake(112+x, 281-y, 245, 63);
		CGSize maximumLabelSize = CGSizeMake(245,9999);
		CGSize expectedLabelSize = [lbl_Notes.text sizeWithFont:lbl_Notes.font constrainedToSize:maximumLabelSize lineBreakMode:lbl_Notes.lineBreakMode];
		CGRect newFrame = lbl_Notes.frame;
		newFrame.size.height = expectedLabelSize.height;
		lbl_Notes.frame = newFrame;
		lbl_Notes.numberOfLines=0; 
		lbl_AddressStatic.frame = CGRectMake(112+x, 345-y, 66, 21);
		lbl_Address.frame = CGRectMake(112+x, 358-y, 200, 120);
		CGSize maximumLabelSize2 = CGSizeMake(200,9999);
		CGSize expectedLabelSize2 = [lbl_Address.text sizeWithFont:lbl_Address.font constrainedToSize:maximumLabelSize2 lineBreakMode:lbl_Address.lineBreakMode];
		CGRect newFrame2 = lbl_Address.frame;
		newFrame2.size.height = expectedLabelSize2.height;
		lbl_Address.frame = newFrame2;
		lbl_Address.numberOfLines=0;
		
		//barCodeImgView.frame = CGRectMake(150, 120, 100, 100);//Jayna131211
		
		////  14/12/2011 start
		//BusinessView Lables 
		lbl_CompanyStatic.frame = CGRectMake(110+x, 200-y, 76, 21);
		lbl_Company.frame = CGRectMake(180+x, 200-y, 165, 21);
		lbl_JobTitleStatic.frame = CGRectMake(110+x, 223-y, 79, 21);
		lbl_JobTitle.frame = CGRectMake(175+x, 223-y, 162, 21);
		lbl_NameStatic.frame = CGRectMake(110+x, 248-y, 74, 21);
		lbl_Name.frame = CGRectMake(155+x, 248-y, 190, 21);
		lbl_EmailStatic.frame = CGRectMake(110+x, 275-y, 46, 21);
		lbl_Email.frame = CGRectMake(155+x, 275-y, 190, 21);
		lbl_PhoneStatic.frame = CGRectMake(110+x, 300-y, 245, 21);
		lbl_Phone.frame = CGRectMake(160+x, 300-y, 190, 21);
		lbl_AddressStatic_BusinessCard.frame = CGRectMake(110+x, 330-y, 66, 21);
		//lbl_Address_BusinessCard.frame = CGRectMake(110+x, 353-y, 237, 100);
//		lbl_Address_BusinessCard.numberOfLines=6;
		lbl_Address_BusinessCard.frame = CGRectMake(110+x, 333-y, 200, 120);
		CGSize maximumLabelSize23 = CGSizeMake(200,9999);
		CGSize expectedLabelSize23 = [lbl_Address_BusinessCard.text sizeWithFont:lbl_Address_BusinessCard.font constrainedToSize:maximumLabelSize23 lineBreakMode:lbl_Address_BusinessCard.lineBreakMode];
		CGRect newFrame23 = lbl_Address_BusinessCard.frame;
		newFrame23.size.height = expectedLabelSize23.height;
		lbl_Address_BusinessCard.frame = newFrame23;
		lbl_Address_BusinessCard.numberOfLines=0;
		////  14/12/2011 start
		
		/////15/12/2011 start
		//for course info
		int k=-65;
		lbl_CourseNameStatic.frame = CGRectMake(110+x, 200-y-k, 100, 21);
		lbl_CourseName.frame = CGRectMake(204+x, 200-y-k, 140, 21);
		lbl_CourseCodeStatic.frame = CGRectMake(110+x, 223-y-k, 100, 21);
		lbl_CourseCode.frame = CGRectMake(202+x, 223-y-k, 140, 21);
		lbl_ProfessorStatic.frame = CGRectMake(110+x, 248-y-k, 72, 21);
		lbl_Professor.frame = CGRectMake(181+x, 248-y-k, 140, 21);
		lbl_DateTimeStatic.frame = CGRectMake(110+x, 275-y-k, 100, 21);
		lbl_DateTime.frame = CGRectMake(212+x, 275-y-k, 140, 21);
		/////15/12/2011  end
		
		
		//for invitationView
		int zx=40;
		//for invitationview
		lbl_TitleStatic_Invitation.frame = CGRectMake(150+x-zx, 210-y-k, 76, 21);
		lbl_Title_Invitation.frame = CGRectMake(186+x-zx, 210-y-k, 230, 21);
		lbl_AddressStatic_Invitation.frame = CGRectMake(150+x-zx, 240-y-k, 76, 21);
		lbl_Address_Invitation.frame = CGRectMake(150+x-zx, 243-y-k, 180, 21);
		CGSize maximumLabelSize125 = CGSizeMake(180,9999);
		CGSize expectedLabelSize125 = [lbl_Address_Invitation.text sizeWithFont:lbl_Address_Invitation.font constrainedToSize:maximumLabelSize125 lineBreakMode:lbl_Address_Invitation.lineBreakMode];
		CGRect newFrame125 = lbl_Address_Invitation.frame;
		newFrame125.size.height = expectedLabelSize125.height;
		lbl_Address_Invitation.frame = newFrame125;
		lbl_Address_Invitation.numberOfLines=0;
		
		//for idbadge view
		lbl_CompanyStatic_IDBadge.frame = CGRectMake(150+x-zx, 210-y-k, 110, 21);
		lbl_Company_IDBadge.frame = CGRectMake(258+x-zx, 210-y-k, 135, 21);
		lbl_NameStatic_IDBadge.frame = CGRectMake(150+x-zx, 240-y-k, 76, 21);
		lbl_Name_IDBadge.frame = CGRectMake(195+x-zx, 240-y-k, 180, 21);
		lbl_JobTitleStatic_IDBadge.frame = CGRectMake(150+x-zx, 270-y-k, 100, 21);
		lbl_JobTitle_IDBadge.frame = CGRectMake(214+x-zx, 270-y-k, 170, 21);
		//}
		
		//}
	}
	else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
			appDel.ori == UIInterfaceOrientationLandscapeRight)
	{		
		//if ([str_TM_SelectedItem isEqualToString:@"Event"]) {
		ivGradient.frame = CGRectMake(380, 105, 260, 280);
		tv_EventView.frame = CGRectMake(390, 110, 240, 270);
		int x=60,y=140,z=225;
		if ([str_TM_SelectedItem isEqualToString:@"Invitation"]||[str_TM_SelectedItem isEqualToString:@"IDBadge"] )
		{
			
			barCodeImgView.frame = CGRectMake(220, 135, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(220, 135, 100, 100);////jayna1512116.18
			//jayna1512116.18
			imgInvitation.frame = CGRectMake(220, 135+100+10, 100, 100);
			
		}
		else {
			barCodeImgView.frame = CGRectMake(220, 180, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(220, 180, 100, 100);////jayna1512116.18
		}
		lbl_EventTitleStatic.frame = CGRectMake(110+x+z, 200+x-y, 76, 21);
		lbl_EventTitle.frame = CGRectMake(186+x+z, 200+x-y, 165, 21);
		lbl_StartStatic.frame = CGRectMake(110+x+z, 230+x-y, 79, 21);
		lbl_Start.frame = CGRectMake(188+x+z, 230+x-y, 162, 21);
		lbl_EndStatic.frame = CGRectMake(110+x+z, 248+x-y, 74, 21);
		lbl_End.frame = CGRectMake(184+x+z, 248+x-y, 165, 21);
		lbl_NotesStatic.frame = CGRectMake(112+x+z, 278+x-y, 46, 21);
		//lbl_Notes.frame = CGRectMake(110+x+z, 300+x-y, 245, 21);
//		lbl_AddressStatic.frame = CGRectMake(110+x+z, 330+x-y, 66, 21);
//		lbl_Address.frame = CGRectMake(110+x+z, 353+x-y, 245, 100);
//		lbl_Address.numberOfLines=6;
		
		lbl_Notes.frame = CGRectMake(112+x+z, 281+x-y, 245, 63);
		CGSize maximumLabelSize = CGSizeMake(245,9999);
		CGSize expectedLabelSize = [lbl_Notes.text sizeWithFont:lbl_Notes.font constrainedToSize:maximumLabelSize lineBreakMode:lbl_Notes.lineBreakMode];
		CGRect newFrame = lbl_Notes.frame;
		newFrame.size.height = expectedLabelSize.height;
		lbl_Notes.frame = newFrame;
		lbl_Notes.numberOfLines=0; 
		lbl_AddressStatic.frame = CGRectMake(112+x+z, 345+x-y, 66, 21);
		lbl_Address.frame = CGRectMake(112+x+z, 358+x-y, 200, 120);
		CGSize maximumLabelSize2 = CGSizeMake(200,9999);
		CGSize expectedLabelSize2 = [lbl_Address.text sizeWithFont:lbl_Address.font constrainedToSize:maximumLabelSize2 lineBreakMode:lbl_Address.lineBreakMode];
		CGRect newFrame2 = lbl_Address.frame;
		newFrame2.size.height = expectedLabelSize2.height;
		lbl_Address.frame = newFrame2;
		lbl_Address.numberOfLines=0;
		
		
		
		////  14/12/2011 start
		//BusinessView Lables 
		lbl_CompanyStatic.frame = CGRectMake(110+x+z, 200+x-y, 76, 21);
		lbl_Company.frame = CGRectMake(180+x+z, 200+x-y, 165, 21);
		lbl_JobTitleStatic.frame = CGRectMake(110+x+z, 223+x-y, 79, 21);
		lbl_JobTitle.frame = CGRectMake(175+x+z, 223+x-y, 162, 21);
		lbl_NameStatic.frame = CGRectMake(110+x+z, 248+x-y, 74, 21);
		lbl_Name.frame = CGRectMake(155+x+z, 248+x-y, 190, 21);
		lbl_EmailStatic.frame = CGRectMake(110+x+z, 275+x-y, 46, 21);
		lbl_Email.frame = CGRectMake(155+x+z, 275+x-y, 190, 21);
		lbl_PhoneStatic.frame = CGRectMake(110+x+z, 300+x-y, 245, 21);
		lbl_Phone.frame = CGRectMake(160+x+z, 300+x-y, 190, 21);
		lbl_AddressStatic_BusinessCard.frame = CGRectMake(110+x+z, 330+x-y, 66, 21);
		//lbl_Address_BusinessCard.frame = CGRectMake(110+x+z, 353+x-y, 237, 100);
//		lbl_Address_BusinessCard.numberOfLines=6;
		lbl_Address_BusinessCard.frame = CGRectMake(110+x+z, 333+x-y, 200, 120);
		CGSize maximumLabelSize234 = CGSizeMake(200,9999);
		CGSize expectedLabelSize234 = [lbl_Address_BusinessCard.text sizeWithFont:lbl_Address_BusinessCard.font constrainedToSize:maximumLabelSize234 lineBreakMode:lbl_Address_BusinessCard.lineBreakMode];
		CGRect newFrame234 = lbl_Address_BusinessCard.frame;
		newFrame234.size.height = expectedLabelSize234.height;
		lbl_Address_BusinessCard.frame = newFrame234;
		lbl_Address_BusinessCard.numberOfLines=0;
		////  14/12/2011 start
		
		/////15/12/2011 start
		//for course info
		int k=-65;
		lbl_CourseNameStatic.frame = CGRectMake(110+x+z, 200+x-y-k, 100, 21);
		lbl_CourseName.frame = CGRectMake(204+x+z, 200+x-y-k, 140, 21);
		lbl_CourseCodeStatic.frame = CGRectMake(110+x+z, 223+x-y-k, 100, 21);
		lbl_CourseCode.frame = CGRectMake(202+x+z, 223+x-y-k, 140, 21);
		lbl_ProfessorStatic.frame = CGRectMake(110+x+z, 248+x-y-k, 72, 21);
		lbl_Professor.frame = CGRectMake(181+x+z, 248+x-y-k, 140, 21);
		lbl_DateTimeStatic.frame = CGRectMake(110+x+z, 275+x-y-k, 100, 21);
		lbl_DateTime.frame = CGRectMake(215+x+z, 275+x-y-k, 140, 21);
		/////15/12/2011  end
		
		//for invitationView
		int zx=40;
		//for invitationview
		lbl_TitleStatic_Invitation.frame = CGRectMake(150+x+z-zx, 210+x-y-k, 76, 21);
		lbl_Title_Invitation.frame = CGRectMake(186+x+z-zx, 210+x-y-k, 230, 21);
		lbl_AddressStatic_Invitation.frame = CGRectMake(150+x+z-zx, 240+x-y-k, 76, 21);
		lbl_Address_Invitation.frame = CGRectMake(150+x+z-zx, 243+x-y-k, 180, 21);
		
		CGSize maximumLabelSize125 = CGSizeMake(180,9999);
		CGSize expectedLabelSize125 = [lbl_Address_Invitation.text sizeWithFont:lbl_Address_Invitation.font constrainedToSize:maximumLabelSize125 lineBreakMode:lbl_Address_Invitation.lineBreakMode];
		CGRect newFrame125 = lbl_Address_Invitation.frame;
		newFrame125.size.height = expectedLabelSize125.height;
		lbl_Address_Invitation.frame = newFrame125;
		lbl_Address_Invitation.numberOfLines=0;
		
		//for idbadge view
		lbl_CompanyStatic_IDBadge.frame = CGRectMake(150+x+z-zx, 210+x-y-k, 110, 21);
		lbl_Company_IDBadge.frame = CGRectMake(258+x+z-zx, 210+x-y-k, 135, 21);
		lbl_NameStatic_IDBadge.frame = CGRectMake(150+x+z-zx, 240+x-y-k, 76, 21);
		lbl_Name_IDBadge.frame = CGRectMake(195+x+z-zx, 240+x-y-k, 180, 21);
		lbl_JobTitleStatic_IDBadge.frame = CGRectMake(150+x+z-zx, 270+x-y-k, 100, 21);
		lbl_JobTitle_IDBadge.frame = CGRectMake(214+x+z-zx, 270+x-y-k, 170, 21);
		//}
	}
}
-(IBAction)onAlignmentTopClick
{
	str_flagForAlignmentClick=@"Top";
	//ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal.png"];
	if ([str_Flag_Gradient isEqualToString:@"Black"]) {
		ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal-White.png"];
	}
	else {
		ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal.png"];
	}
	if(appDel.ori == 0)
		appDel.ori = [[UIDevice currentDevice] orientation];
	
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		int y=140;
		if ([str_TM_SelectedItem isEqualToString:@"Event"]||[str_TM_SelectedItem isEqualToString:@"BusinessCard"]) {
			
			ivGradient.frame = CGRectMake(95, 42, 485, 145);
			tv_EventView.frame = CGRectMake(105, 47, 465, 135);
			lbl_EventTitleStatic.frame = CGRectMake(110, 200-y, 76, 21);
			lbl_EventTitle.frame = CGRectMake(186, 200-y, 165, 21);
			lbl_StartStatic.frame = CGRectMake(110, 230-y, 79, 21);
			lbl_Start.frame = CGRectMake(188, 230-y, 162, 21);
			lbl_EndStatic.frame = CGRectMake(110, 248-y, 74, 21);
			lbl_End.frame = CGRectMake(184, 248-y, 165, 21);
			lbl_NotesStatic.frame = CGRectMake(112, 285-y, 46, 21);
			//lbl_Notes.frame = CGRectMake(110, 300-y, 245, 21);
//			lbl_AddressStatic.frame = CGRectMake(360, 200-y, 66, 21);
//			lbl_Address.frame = CGRectMake(360, 223-y, 200, 100);
//			lbl_Address.numberOfLines=6;
			
			lbl_Notes.frame = CGRectMake(112, 288-y, 450, 63);
			CGSize maximumLabelSize = CGSizeMake(450,9999);
			CGSize expectedLabelSize = [lbl_Notes.text sizeWithFont:lbl_Notes.font constrainedToSize:maximumLabelSize lineBreakMode:lbl_Notes.lineBreakMode];
			CGRect newFrame = lbl_Notes.frame;
			newFrame.size.height = expectedLabelSize.height;
			lbl_Notes.frame = newFrame;
			lbl_Notes.numberOfLines=0; 
			lbl_AddressStatic.frame = CGRectMake(360, 200-y, 66, 21);
			lbl_Address.frame = CGRectMake(360, 203-y, 200, 120);
			CGSize maximumLabelSize2 = CGSizeMake(200,9999);
			CGSize expectedLabelSize2 = [lbl_Address.text sizeWithFont:lbl_Address.font constrainedToSize:maximumLabelSize2 lineBreakMode:lbl_Address.lineBreakMode];
			CGRect newFrame2 = lbl_Address.frame;
			newFrame2.size.height = expectedLabelSize2.height;
			lbl_Address.frame = newFrame2;
			lbl_Address.numberOfLines=0;
			
			barCodeImgView.frame = CGRectMake(290, 205, 100, 100);//Jayna131211
			btn_Barcode_ImageProcessingView.frame = CGRectMake(290, 205, 100, 100);//Jayna131211
			
			
			////  14/12/2011 start
			//BusinessView Lables 
			lbl_CompanyStatic.frame = CGRectMake(110, 200-y, 76, 21);
			lbl_Company.frame = CGRectMake(180, 200-y, 165, 21);
			lbl_JobTitleStatic.frame = CGRectMake(110, 223-y, 79, 21);
			lbl_JobTitle.frame = CGRectMake(175, 223-y, 162, 21);
			lbl_NameStatic.frame = CGRectMake(110, 248-y, 74, 21);
			lbl_Name.frame = CGRectMake(155, 248-y, 190, 21);
			lbl_EmailStatic.frame = CGRectMake(110, 275-y, 46, 21);
			lbl_Email.frame = CGRectMake(155, 275-y, 190, 21);
			lbl_PhoneStatic.frame = CGRectMake(110, 300-y, 245, 21);
			lbl_Phone.frame = CGRectMake(160, 300-y, 190, 21);
			lbl_AddressStatic_BusinessCard.frame = CGRectMake(360, 200-y, 66, 21);
			//lbl_Address_BusinessCard.frame = CGRectMake(360, 223-y, 200, 100);
//			lbl_Address_BusinessCard.numberOfLines=6;
			lbl_Address_BusinessCard.frame = CGRectMake(360, 203-y, 200, 120);
			CGSize maximumLabelSize2345 = CGSizeMake(200,9999);
			CGSize expectedLabelSize2345 = [lbl_Address_BusinessCard.text sizeWithFont:lbl_Address_BusinessCard.font constrainedToSize:maximumLabelSize2345 lineBreakMode:lbl_Address_BusinessCard.lineBreakMode];
			CGRect newFrame2345 = lbl_Address_BusinessCard.frame;
			newFrame2345.size.height = expectedLabelSize2345.height;
			lbl_Address_BusinessCard.frame = newFrame2345;
			lbl_Address_BusinessCard.numberOfLines=0;
			////  14/12/2011 start
			
		
		}
		else if ([str_TM_SelectedItem isEqualToString:@"Invitation"]||[str_TM_SelectedItem isEqualToString:@"IDBadge"] ){
			ivGradient.frame = CGRectMake(95, 42, 485, 130);
			tv_EventView.frame = CGRectMake(105, 47, 465, 120);
			barCodeImgView.frame = CGRectMake(235, 60+y, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(235, 60+y, 100, 100);////jayna1512116.18
			//jayna1512116.18
			imgInvitation.frame = CGRectMake(235+100+10, 60+y, 100, 100);
			
			lbl_TitleStatic_Invitation.frame = CGRectMake(150, 210-y, 76, 21);
			lbl_Title_Invitation.frame = CGRectMake(186, 210-y, 230, 21);
			lbl_AddressStatic_Invitation.frame = CGRectMake(150, 240-y, 76, 21);
			lbl_Address_Invitation.frame = CGRectMake(150, 243-y, 270, 21);
			CGSize maximumLabelSize125 = CGSizeMake(270,9999);
			CGSize expectedLabelSize125 = [lbl_Address_Invitation.text sizeWithFont:lbl_Address_Invitation.font constrainedToSize:maximumLabelSize125 lineBreakMode:lbl_Address_Invitation.lineBreakMode];
			CGRect newFrame125 = lbl_Address_Invitation.frame;
			newFrame125.size.height = expectedLabelSize125.height;
			lbl_Address_Invitation.frame = newFrame125;
			lbl_Address_Invitation.numberOfLines=0;
			
			//for idbadge view
			lbl_CompanyStatic_IDBadge.frame = CGRectMake(150, 210-y, 110, 21);
			lbl_Company_IDBadge.frame = CGRectMake(258, 210-y, 230, 21);
			lbl_NameStatic_IDBadge.frame = CGRectMake(150, 240-y, 76, 21);
			lbl_Name_IDBadge.frame = CGRectMake(195, 240-y, 270, 21);
			lbl_JobTitleStatic_IDBadge.frame = CGRectMake(150, 270-y, 100, 21);
			lbl_JobTitle_IDBadge.frame = CGRectMake(214, 270-y, 230, 21);
			
			
		}
		else {
			ivGradient.frame = CGRectMake(95, 42, 485, 130);
			tv_EventView.frame = CGRectMake(105, 47, 465, 120);
			barCodeImgView.frame = CGRectMake(290, 205, 100, 100);//Jayna131211
			btn_Barcode_ImageProcessingView.frame = CGRectMake(290, 205, 100, 100);//Jayna131211
			
			/////15/12/2011 start
			//for course info
			lbl_CourseNameStatic.frame = CGRectMake(110, 200-y, 100, 21);
			lbl_CourseName.frame = CGRectMake(204, 200-y, 250, 21);
			lbl_CourseCodeStatic.frame = CGRectMake(110, 223-y, 100, 21);
			lbl_CourseCode.frame = CGRectMake(202, 223-y, 250, 21);
			lbl_ProfessorStatic.frame = CGRectMake(110, 248-y, 72, 21);
			lbl_Professor.frame = CGRectMake(181, 248-y, 250, 21);
			lbl_DateTimeStatic.frame = CGRectMake(110, 275-y, 100, 21);
			lbl_DateTime.frame = CGRectMake(212, 275-y, 250, 21);
			/////15/12/2011  end
		}

	}
	else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
			appDel.ori == UIInterfaceOrientationLandscapeRight)
	{		
		int x=60,y=140;
		if ([str_TM_SelectedItem isEqualToString:@"Event"]||[str_TM_SelectedItem isEqualToString:@"BusinessCard"]) {
			ivGradient.frame = CGRectMake(155, 105, 485, 145);
			tv_EventView.frame = CGRectMake(165, 110, 465, 135);
			lbl_EventTitleStatic.frame = CGRectMake(110+x, 200+x-y, 76, 21);
			lbl_EventTitle.frame = CGRectMake(186+x, 200+x-y, 165, 21);
			lbl_StartStatic.frame = CGRectMake(110+x, 230+x-y, 79, 21);
			lbl_Start.frame = CGRectMake(188+x, 230+x-y, 162, 21);
			lbl_EndStatic.frame = CGRectMake(110+x, 248+x-y, 74, 21);
			lbl_End.frame = CGRectMake(184+x, 248+x-y, 165, 21);
			lbl_NotesStatic.frame = CGRectMake(112+x, 285+x-y, 46, 21);
			//lbl_Notes.frame = CGRectMake(110+x, 300+x-y, 245, 21);
//			lbl_AddressStatic.frame = CGRectMake(360+x, 200+x-y, 66, 21);
//			lbl_Address.frame = CGRectMake(360+x, 223+x-y, 200, 100);
//			lbl_Address.numberOfLines=6;
			
			lbl_Notes.frame = CGRectMake(112+x, 288+x-y, 450, 63);
			CGSize maximumLabelSize = CGSizeMake(450,9999);
			CGSize expectedLabelSize = [lbl_Notes.text sizeWithFont:lbl_Notes.font constrainedToSize:maximumLabelSize lineBreakMode:lbl_Notes.lineBreakMode];
			CGRect newFrame = lbl_Notes.frame;
			newFrame.size.height = expectedLabelSize.height;
			lbl_Notes.frame = newFrame;
			lbl_Notes.numberOfLines=0; 
			lbl_AddressStatic.frame = CGRectMake(360+x, 200+x-y, 66, 21);
			lbl_Address.frame = CGRectMake(360+x, 203+x-y, 200, 120);
			CGSize maximumLabelSize2 = CGSizeMake(200,9999);
			CGSize expectedLabelSize2 = [lbl_Address.text sizeWithFont:lbl_Address.font constrainedToSize:maximumLabelSize2 lineBreakMode:lbl_Address.lineBreakMode];
			CGRect newFrame2 = lbl_Address.frame;
			newFrame2.size.height = expectedLabelSize2.height;
			lbl_Address.frame = newFrame2;
			lbl_Address.numberOfLines=0;
			
			barCodeImgView.frame = CGRectMake(350, 270, 100, 100);//Jayna131211
			btn_Barcode_ImageProcessingView.frame = CGRectMake(350, 270, 100, 100);//Jayna131211
			
			////  14/12/2011 start
			//BusinessView Lables 
			lbl_CompanyStatic.frame = CGRectMake(110+x, 200+x-y, 76, 21);
			lbl_Company.frame = CGRectMake(180+x, 200+x-y, 165, 21);
			lbl_JobTitleStatic.frame = CGRectMake(110+x, 223+x-y, 79, 21);
			lbl_JobTitle.frame = CGRectMake(175+x, 223+x-y, 162, 21 );
			lbl_NameStatic.frame = CGRectMake(110+x, 248+x-y, 74, 21);
			lbl_Name.frame = CGRectMake(155+x, 248+x-y, 190, 21);
			lbl_EmailStatic.frame = CGRectMake(110+x, 275+x-y, 46, 21);
			lbl_Email.frame = CGRectMake(155+x, 275+x-y, 190, 21);
			lbl_PhoneStatic.frame = CGRectMake(110+x, 300+x-y, 245, 21);
			lbl_Phone.frame = CGRectMake(160+x, 300+x-y, 190, 21);
			lbl_AddressStatic_BusinessCard.frame = CGRectMake(360+x, 200+x-y, 66, 21);
			//lbl_Address_BusinessCard.frame = CGRectMake(360+x, 223+x-y, 200, 100);
//			lbl_Address_BusinessCard.numberOfLines=6;
			
			lbl_Address_BusinessCard.frame = CGRectMake(360+x, 203+x-y, 200, 120);
			CGSize maximumLabelSize24 = CGSizeMake(200,9999);
			CGSize expectedLabelSize24 = [lbl_Address_BusinessCard.text sizeWithFont:lbl_Address_BusinessCard.font constrainedToSize:maximumLabelSize24 lineBreakMode:lbl_Address_BusinessCard.lineBreakMode];
			CGRect newFrame24 = lbl_Address_BusinessCard.frame;
			newFrame24.size.height = expectedLabelSize24.height;
			lbl_Address_BusinessCard.frame = newFrame24;
			lbl_Address_BusinessCard.numberOfLines=0;
			////  14/12/2011 start
			
			
		}
		else if ([str_TM_SelectedItem isEqualToString:@"Invitation"]||[str_TM_SelectedItem isEqualToString:@"IDBadge"] ){
			ivGradient.frame = CGRectMake(155, 105, 485, 130);
			tv_EventView.frame = CGRectMake(165, 110, 465, 120);
			barCodeImgView.frame = CGRectMake(300, 60+y+x, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(300, 60+y+x, 100, 100);////jayna1512116.18
			//jayna1512116.18
			imgInvitation.frame = CGRectMake(300+100+10, 60+y+x, 100, 100);
			
			lbl_TitleStatic_Invitation.frame = CGRectMake(150+x, 210+x-y, 76, 21);
			lbl_Title_Invitation.frame = CGRectMake(186+x, 210+x-y, 230, 21);
			lbl_AddressStatic_Invitation.frame = CGRectMake(150+x, 240+x-y, 76, 21);
			lbl_Address_Invitation.frame = CGRectMake(150+x, 243+x-y, 270, 21);
			CGSize maximumLabelSize125 = CGSizeMake(270,9999);
			CGSize expectedLabelSize125 = [lbl_Address_Invitation.text sizeWithFont:lbl_Address_Invitation.font constrainedToSize:maximumLabelSize125 lineBreakMode:lbl_Address_Invitation.lineBreakMode];
			CGRect newFrame125 = lbl_Address_Invitation.frame;
			newFrame125.size.height = expectedLabelSize125.height;
			lbl_Address_Invitation.frame = newFrame125;
			lbl_Address_Invitation.numberOfLines=0;
			
			//for invitation view
			lbl_CompanyStatic_IDBadge.frame = CGRectMake(150+x, 210+x-y, 110, 21);
			lbl_Company_IDBadge.frame = CGRectMake(258+x, 210+x-y, 230, 21);
			lbl_NameStatic_IDBadge.frame = CGRectMake(150+x, 240+x-y, 76, 21);
			lbl_Name_IDBadge.frame = CGRectMake(195+x, 240+x-y, 270, 21);
			lbl_JobTitleStatic_IDBadge.frame = CGRectMake(150+x, 270+x-y, 100, 21);
			lbl_JobTitle_IDBadge.frame = CGRectMake(214+x, 270+x-y, 230, 21);
			
		}
		else{
			ivGradient.frame = CGRectMake(155, 105, 485, 130);
			tv_EventView.frame = CGRectMake(165, 110, 465, 120);
			barCodeImgView.frame = CGRectMake(350, 270, 100, 100);//Jayna131211
			btn_Barcode_ImageProcessingView.frame = CGRectMake(350, 270, 100, 100);//Jayna131211
			/////15/12/2011 start
			//for course info
			lbl_CourseNameStatic.frame = CGRectMake(110+x, 200+x-y, 100, 21);
			lbl_CourseName.frame = CGRectMake(204+x, 200+x-y, 250, 21);
			lbl_CourseCodeStatic.frame = CGRectMake(110+x, 223+x-y, 100, 21);
			lbl_CourseCode.frame = CGRectMake(202+x, 223+x-y, 250, 21);
			lbl_ProfessorStatic.frame = CGRectMake(110+x, 248+x-y, 72, 21);
			lbl_Professor.frame = CGRectMake(181+x, 248+x-y, 250, 21);
			lbl_DateTimeStatic.frame = CGRectMake(110+x, 275+x-y, 100, 21);
			lbl_DateTime.frame = CGRectMake(212+x, 275+x-y, 250, 21);
			/////15/12/2011  end
		}
	}
}
-(IBAction)onAlignmentBottomClick
{
	str_flagForAlignmentClick=@"Bottom";
	//ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal.png"];
	if ([str_Flag_Gradient isEqualToString:@"Black"]) {
		ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal-White.png"];
	}
	else {
		ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal.png"];
	}
	if(appDel.ori == 0)
		appDel.ori = [[UIDevice currentDevice] orientation];
	
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		if ([str_TM_SelectedItem isEqualToString:@"Event"]||[str_TM_SelectedItem isEqualToString:@"BusinessCard"]) {
			ivGradient.frame = CGRectMake(95, 182, 485, 140);
			tv_EventView.frame = CGRectMake(105, 187, 465, 130);
			lbl_EventTitleStatic.frame = CGRectMake(110, 200, 76, 21);
			lbl_EventTitle.frame = CGRectMake(186, 200, 165, 21);
			lbl_StartStatic.frame = CGRectMake(110, 230, 79, 21);
			lbl_Start.frame = CGRectMake(188, 230, 162, 21);
			lbl_EndStatic.frame = CGRectMake(110, 248, 74, 21);
			lbl_End.frame = CGRectMake(184, 248, 165, 21);
			lbl_NotesStatic.frame = CGRectMake(112, 285, 46, 21);
			
			lbl_Notes.frame = CGRectMake(112, 288, 450, 63);
			CGSize maximumLabelSize = CGSizeMake(450,9999);
			CGSize expectedLabelSize = [lbl_Notes.text sizeWithFont:lbl_Notes.font constrainedToSize:maximumLabelSize lineBreakMode:lbl_Notes.lineBreakMode];
			CGRect newFrame = lbl_Notes.frame;
			newFrame.size.height = expectedLabelSize.height;
			lbl_Notes.frame = newFrame;
			lbl_Notes.numberOfLines=0; 
			lbl_AddressStatic.frame = CGRectMake(360, 200, 66, 21);
			lbl_Address.frame = CGRectMake(360, 203, 200, 120);
			CGSize maximumLabelSize2 = CGSizeMake(200,9999);
			CGSize expectedLabelSize2 = [lbl_Address.text sizeWithFont:lbl_Address.font constrainedToSize:maximumLabelSize2 lineBreakMode:lbl_Address.lineBreakMode];
			CGRect newFrame2 = lbl_Address.frame;
			newFrame2.size.height = expectedLabelSize2.height;
			lbl_Address.frame = newFrame2;
			lbl_Address.numberOfLines=0;
			
			barCodeImgView.frame = CGRectMake(290, 60, 100, 100);//Jayna131211
			btn_Barcode_ImageProcessingView.frame = CGRectMake(290, 60, 100, 100);//Jayna131211
			
			////  14/12/2011 start
			//BusinessView Lables 
			lbl_CompanyStatic.frame = CGRectMake(110, 200, 76, 21);
			lbl_Company.frame = CGRectMake(180, 200, 165, 21);
			lbl_JobTitleStatic.frame = CGRectMake(110, 223, 79, 21);
			lbl_JobTitle.frame = CGRectMake(175, 223, 162, 21);
			lbl_NameStatic.frame = CGRectMake(110, 248, 74, 21);
			lbl_Name.frame = CGRectMake(155, 248, 190, 21);
			lbl_EmailStatic.frame = CGRectMake(110, 275, 46, 21);
			lbl_Email.frame = CGRectMake(155, 275, 190, 21);
			lbl_PhoneStatic.frame = CGRectMake(110, 300, 245, 21);
			lbl_Phone.frame = CGRectMake(160, 300, 190, 21);
			lbl_AddressStatic_BusinessCard.frame = CGRectMake(360, 200, 66, 21);
			//lbl_Address_BusinessCard.frame = CGRectMake(360, 223, 200, 100);
//			lbl_Address_BusinessCard.numberOfLines=6;
			lbl_Address_BusinessCard.frame = CGRectMake(360, 203, 200, 120);
			CGSize maximumLabelSize25 = CGSizeMake(200,9999);
			CGSize expectedLabelSize25 = [lbl_Address_BusinessCard.text sizeWithFont:lbl_Address_BusinessCard.font constrainedToSize:maximumLabelSize25 lineBreakMode:lbl_Address_BusinessCard.lineBreakMode];
			CGRect newFrame25 = lbl_Address_BusinessCard.frame;
			newFrame25.size.height = expectedLabelSize25.height;
			lbl_Address_BusinessCard.frame = newFrame25;
			lbl_Address_BusinessCard.numberOfLines=0;
			////  14/12/2011 start
				
		}
		else if ([str_TM_SelectedItem isEqualToString:@"Invitation"]||[str_TM_SelectedItem isEqualToString:@"IDBadge"] ){
			ivGradient.frame = CGRectMake(95, 187, 485, 130);
			tv_EventView.frame = CGRectMake(105, 192, 465, 120);
			barCodeImgView.frame = CGRectMake(235, 60, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(235, 60, 100, 100);////jayna1512116.18
			//jayna1512116.18
			imgInvitation.frame = CGRectMake(235+100+10, 60, 100, 100);
			
			lbl_TitleStatic_Invitation.frame = CGRectMake(150, 210, 76, 21);
			lbl_Title_Invitation.frame = CGRectMake(186, 210, 230, 21);
			lbl_AddressStatic_Invitation.frame = CGRectMake(150, 240, 76, 21);
			lbl_Address_Invitation.frame = CGRectMake(150, 243, 270, 21);
			CGSize maximumLabelSize125 = CGSizeMake(270,9999);
			CGSize expectedLabelSize125 = [lbl_Address_Invitation.text sizeWithFont:lbl_Address_Invitation.font constrainedToSize:maximumLabelSize125 lineBreakMode:lbl_Address_Invitation.lineBreakMode];
			CGRect newFrame125 = lbl_Address_Invitation.frame;
			newFrame125.size.height = expectedLabelSize125.height;
			lbl_Address_Invitation.frame = newFrame125;
			lbl_Address_Invitation.numberOfLines=0;
			
			//for invitation view
			lbl_CompanyStatic_IDBadge.frame = CGRectMake(150, 210, 110, 21);
			lbl_Company_IDBadge.frame = CGRectMake(258, 210, 230, 21);
			lbl_NameStatic_IDBadge.frame = CGRectMake(150, 240, 76, 21);
			lbl_Name_IDBadge.frame = CGRectMake(195, 240, 270, 21);
			lbl_JobTitleStatic_IDBadge.frame = CGRectMake(150, 270, 100, 21);
			lbl_JobTitle_IDBadge.frame = CGRectMake(214, 270, 230, 21);
		}

		else {
			ivGradient.frame = CGRectMake(95, 187, 485, 130);
			tv_EventView.frame = CGRectMake(105, 192, 465, 120);
			barCodeImgView.frame = CGRectMake(290, 60, 100, 100);//Jayna131211
			btn_Barcode_ImageProcessingView.frame = CGRectMake(290, 60, 100, 100);//Jayna131211
			/////15/12/2011 start
			//for course info
			lbl_CourseNameStatic.frame = CGRectMake(110, 200, 100, 21);
			lbl_CourseName.frame = CGRectMake(204, 200, 250, 21);
			lbl_CourseCodeStatic.frame = CGRectMake(110, 223, 100, 21);
			lbl_CourseCode.frame = CGRectMake(202, 223, 250, 21);
			lbl_ProfessorStatic.frame = CGRectMake(110, 248, 72, 21);
			lbl_Professor.frame = CGRectMake(181, 248, 250, 21);
			lbl_DateTimeStatic.frame = CGRectMake(110, 275, 100, 21);
			lbl_DateTime.frame = CGRectMake(212, 275, 250, 21);
			/////15/12/2011  end
		}

	}
	else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
			appDel.ori == UIInterfaceOrientationLandscapeRight)
	{		
		int x=60;
		if ([str_TM_SelectedItem isEqualToString:@"Event"]||[str_TM_SelectedItem isEqualToString:@"BusinessCard"]) {
			
			ivGradient.frame = CGRectMake(155, 245, 485, 140);
			tv_EventView.frame = CGRectMake(165, 250, 465, 130);
			lbl_EventTitleStatic.frame = CGRectMake(110+x, 200+x, 76, 21);
			lbl_EventTitle.frame = CGRectMake(186+x, 200+x, 165, 21);
			lbl_StartStatic.frame = CGRectMake(110+x, 230+x, 79, 21);
			lbl_Start.frame = CGRectMake(188+x, 230+x, 162, 21);
			lbl_EndStatic.frame = CGRectMake(110+x, 248+x, 74, 21);
			lbl_End.frame = CGRectMake(184+x, 248+x, 165, 21);
			lbl_NotesStatic.frame = CGRectMake(112+x, 285+x, 46, 21);
			//lbl_Notes.frame = CGRectMake(110+x, 300+x, 245, 21);
//			lbl_AddressStatic.frame = CGRectMake(360+x, 200+x, 66, 21);
//			lbl_Address.frame = CGRectMake(360+x, 223+x, 200, 100);
//			lbl_Address.numberOfLines=6;
			
			lbl_Notes.frame = CGRectMake(112+x, 288+x, 450, 63);
			CGSize maximumLabelSize = CGSizeMake(450,9999);
			CGSize expectedLabelSize = [lbl_Notes.text sizeWithFont:lbl_Notes.font constrainedToSize:maximumLabelSize lineBreakMode:lbl_Notes.lineBreakMode];
			CGRect newFrame = lbl_Notes.frame;
			newFrame.size.height = expectedLabelSize.height;
			lbl_Notes.frame = newFrame;
			
			lbl_AddressStatic.frame = CGRectMake(360+x, 200+x, 66, 21);
			lbl_Address.frame = CGRectMake(360+x, 203+x, 200, 120);
			CGSize maximumLabelSize2 = CGSizeMake(200,9999);
			CGSize expectedLabelSize2 = [lbl_Address.text sizeWithFont:lbl_Address.font constrainedToSize:maximumLabelSize2 lineBreakMode:lbl_Address.lineBreakMode];
			CGRect newFrame2 = lbl_Address.frame;
			newFrame2.size.height = expectedLabelSize2.height;
			lbl_Address.frame = newFrame2;
			lbl_Address.numberOfLines=0;
			
			barCodeImgView.frame = CGRectMake(350, 120, 100, 100);//Jayna131211
			btn_Barcode_ImageProcessingView.frame = CGRectMake(350, 120, 100, 100);//Jayna131211
			
			////  14/12/2011 start
			//BusinessView Lables 
			lbl_CompanyStatic.frame = CGRectMake(110+x, 200+x, 76, 21);
			lbl_Company.frame = CGRectMake(180+x, 200+x, 165, 21);
			lbl_JobTitleStatic.frame = CGRectMake(110+x, 223+x, 79, 21);
			lbl_JobTitle.frame = CGRectMake(175+x, 223+x, 162, 21 );
			lbl_NameStatic.frame = CGRectMake(110+x, 248+x, 74, 21);
			lbl_Name.frame = CGRectMake(155+x, 248+x, 190, 21);
			lbl_EmailStatic.frame = CGRectMake(110+x, 275+x, 46, 21);
			lbl_Email.frame = CGRectMake(155+x, 275+x, 190, 21);
			lbl_PhoneStatic.frame = CGRectMake(110+x, 300+x, 245, 21);
			lbl_Phone.frame = CGRectMake(160+x, 300+x, 190, 21);
			lbl_AddressStatic_BusinessCard.frame = CGRectMake(360+x, 200+x, 66, 21);
			//lbl_Address_BusinessCard.frame = CGRectMake(360+x, 223+x, 200, 100);
//			lbl_Address_BusinessCard.numberOfLines=6;
			
			lbl_Address_BusinessCard.frame = CGRectMake(360+x, 203+x, 200, 120);
			CGSize maximumLabelSize26 = CGSizeMake(200,9999);
			CGSize expectedLabelSize26 = [lbl_Address_BusinessCard.text sizeWithFont:lbl_Address_BusinessCard.font constrainedToSize:maximumLabelSize26 lineBreakMode:lbl_Address_BusinessCard.lineBreakMode];
			CGRect newFrame26 = lbl_Address_BusinessCard.frame;
			newFrame26.size.height = expectedLabelSize26.height;
			lbl_Address_BusinessCard.frame = newFrame26;
			lbl_Address_BusinessCard.numberOfLines=0;
			////  14/12/2011 start
			
			
		}
		else if ([str_TM_SelectedItem isEqualToString:@"Invitation"]||[str_TM_SelectedItem isEqualToString:@"IDBadge"] ){
			ivGradient.frame = CGRectMake(155, 255, 485, 130);
			tv_EventView.frame = CGRectMake(165, 260, 465, 120);
			barCodeImgView.frame = CGRectMake(235+x, 60+x, 100, 100);////jayna1512116.18
			btn_Barcode_ImageProcessingView.frame = CGRectMake(235+x, 60+x, 100, 100);////jayna1512116.18
			//jayna1512116.18
			imgInvitation.frame = CGRectMake(235+100+10+x, 60+x, 100, 100);
			
			lbl_TitleStatic_Invitation.frame = CGRectMake(150+x, 210+x, 76, 21);
			lbl_Title_Invitation.frame = CGRectMake(186+x, 210+x, 230, 21);
			lbl_AddressStatic_Invitation.frame = CGRectMake(150+x, 240+x, 76, 21);
			lbl_Address_Invitation.frame = CGRectMake(150+x, 243+x, 270, 21);
			CGSize maximumLabelSize125 = CGSizeMake(270,9999);
			CGSize expectedLabelSize125 = [lbl_Address_Invitation.text sizeWithFont:lbl_Address_Invitation.font constrainedToSize:maximumLabelSize125 lineBreakMode:lbl_Address_Invitation.lineBreakMode];
			CGRect newFrame125 = lbl_Address_Invitation.frame;
			newFrame125.size.height = expectedLabelSize125.height;
			lbl_Address_Invitation.frame = newFrame125;
			lbl_Address_Invitation.numberOfLines=0;
			
			//for invitation view
			lbl_CompanyStatic_IDBadge.frame = CGRectMake(150+x, 210+x, 110, 21);
			lbl_Company_IDBadge.frame = CGRectMake(258+x, 210+x, 230, 21);
			lbl_NameStatic_IDBadge.frame = CGRectMake(150+x, 240+x, 76, 21);
			lbl_Name_IDBadge.frame = CGRectMake(195+x, 240+x, 270, 21);
			lbl_JobTitleStatic_IDBadge.frame = CGRectMake(150+x, 270+x, 100, 21);
			lbl_JobTitle_IDBadge.frame = CGRectMake(214+x, 270+x, 230, 21);
		}
		else {
			ivGradient.frame = CGRectMake(155, 255, 485, 130);
			tv_EventView.frame = CGRectMake(165, 260, 465, 120);
			barCodeImgView.frame = CGRectMake(350, 120, 100, 100);//Jayna131211
			btn_Barcode_ImageProcessingView.frame = CGRectMake(350, 120, 100, 100);//Jayna131211
			/////15/12/2011 start
			//for course info
			int p=10;
			lbl_CourseNameStatic.frame = CGRectMake(110+x, 200+x+p, 100, 21);
			lbl_CourseName.frame = CGRectMake(204+x, 200+x+p, 250, 21);
			lbl_CourseCodeStatic.frame = CGRectMake(110+x, 223+x+p, 100, 21);
			lbl_CourseCode.frame = CGRectMake(202+x, 223+x+p, 250, 21);
			lbl_ProfessorStatic.frame = CGRectMake(110+x, 248+x+p, 72, 21);
			lbl_Professor.frame = CGRectMake(181+x, 248+x+p, 250, 21);
			lbl_DateTimeStatic.frame = CGRectMake(110+x, 275+x+p, 100, 21);
			lbl_DateTime.frame = CGRectMake(212+x, 275+x+p, 250, 21);
			/////15/12/2011  end
		}

	}
}
-(IBAction)onFontBlackClick
{
	if ([str_flagForAlignmentClick isEqualToString:@"Top"]||[str_flagForAlignmentClick isEqualToString:@"Bottom"]) {
		ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal-White.png"];
	}
	else {
		ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical-White.png"];
	}
	//[attrStr1 setTextColor:[UIColor blackColor]];
//	[attrStr_Business setTextColor:[UIColor blackColor]];
//	[attrStr_Invitation setTextColor:[UIColor blackColor]];
//	[attrStr_IDBadge setTextColor:[UIColor blackColor]];
//	[attrStr_CourseInfo setTextColor:[UIColor blackColor]];
	tv_EventView.textColor = [UIColor blackColor];
	str_Flag_Gradient = @"Black";
	lbl_EventTitle.textColor = [UIColor blackColor];
	lbl_EventTitleStatic.textColor = [UIColor blackColor];
	lbl_Start.textColor = [UIColor blackColor];
	lbl_StartStatic.textColor = [UIColor blackColor];
	lbl_End.textColor = [UIColor blackColor];
	lbl_EndStatic.textColor = [UIColor blackColor];
	lbl_Notes.textColor = [UIColor blackColor];
	lbl_NotesStatic.textColor = [UIColor blackColor];
	lbl_Address.textColor = [UIColor blackColor];
	lbl_AddressStatic.textColor = [UIColor blackColor];
	
	
	//For businessview
	lbl_CompanyStatic.textColor = [UIColor blackColor];
	lbl_Company.textColor = [UIColor blackColor];
	lbl_JobTitleStatic.textColor = [UIColor blackColor];
	lbl_JobTitle.textColor = [UIColor blackColor];
	lbl_NameStatic.textColor = [UIColor blackColor];
	lbl_Name.textColor = [UIColor blackColor];
	lbl_Email.textColor = [UIColor blackColor];
	lbl_EmailStatic.textColor = [UIColor blackColor];
	lbl_PhoneStatic.textColor = [UIColor blackColor];
	lbl_Phone.textColor = [UIColor blackColor];
	lbl_AddressStatic_BusinessCard.textColor = [UIColor blackColor];
	lbl_Address_BusinessCard.textColor = [UIColor blackColor];
	
	//For CourseInfo
	lbl_CourseNameStatic.textColor = [UIColor blackColor];
	lbl_CourseName.textColor = [UIColor blackColor];
	lbl_CourseCodeStatic.textColor = [UIColor blackColor];
	lbl_CourseCode.textColor = [UIColor blackColor];
	lbl_Professor.textColor = [UIColor blackColor];
	lbl_ProfessorStatic.textColor = [UIColor blackColor];
	lbl_DateTimeStatic.textColor = [UIColor blackColor];
	lbl_DateTime.textColor = [UIColor blackColor];
	
	//invitation view
	lbl_Title_Invitation.textColor = [UIColor blackColor];
	lbl_TitleStatic_Invitation.textColor = [UIColor blackColor];
	lbl_Address_Invitation.textColor = [UIColor blackColor];
	lbl_AddressStatic_Invitation.textColor = [UIColor blackColor];
	
	// for idbadge view
	lbl_Company_IDBadge.textColor = [UIColor blackColor];
	lbl_CompanyStatic_IDBadge.textColor = [UIColor blackColor];
	lbl_NameStatic_IDBadge.textColor = [UIColor blackColor];
	lbl_Name_IDBadge.textColor = [UIColor blackColor];
	lbl_JobTitle_IDBadge.textColor = [UIColor blackColor];
	lbl_JobTitleStatic_IDBadge.textColor = [UIColor blackColor];
	
}
-(IBAction)onFontWhiteClick
{
	
	if ([str_flagForAlignmentClick isEqualToString:@"Top"]||[str_flagForAlignmentClick isEqualToString:@"Bottom"]) {
		ivGradient.image = [UIImage imageNamed:@"Gradient-Horizontal.png"];
	}
	else {
		ivGradient.image = [UIImage imageNamed:@"Gradient-Vertical.png"];
	}
	str_Flag_Gradient = @"White";
	//[attrStr_Business setTextColor:[UIColor whiteColor]];
//	[attrStr_Invitation setTextColor:[UIColor whiteColor]];
//	[attrStr_IDBadge setTextColor:[UIColor whiteColor]];
//	[attrStr_CourseInfo setTextColor:[UIColor whiteColor]];
	tv_EventView.textColor = [UIColor whiteColor];
	lbl_EventTitle.textColor = [UIColor whiteColor];
	lbl_EventTitleStatic.textColor = [UIColor whiteColor];
	lbl_Start.textColor = [UIColor whiteColor];
	lbl_StartStatic.textColor = [UIColor whiteColor];
	lbl_End.textColor = [UIColor whiteColor];
	lbl_EndStatic.textColor = [UIColor whiteColor];
	lbl_Notes.textColor = [UIColor whiteColor];
	lbl_NotesStatic.textColor = [UIColor whiteColor];
	lbl_Address.textColor = [UIColor whiteColor];
	lbl_AddressStatic.textColor = [UIColor whiteColor];
	
	//for business view
	lbl_CompanyStatic.textColor = [UIColor whiteColor];
	lbl_Company.textColor = [UIColor whiteColor];
	lbl_JobTitleStatic.textColor = [UIColor whiteColor];
	lbl_JobTitle.textColor = [UIColor whiteColor];
	lbl_NameStatic.textColor = [UIColor whiteColor];
	lbl_Name.textColor = [UIColor whiteColor];
	lbl_Email.textColor = [UIColor whiteColor];
	lbl_EmailStatic.textColor = [UIColor whiteColor];
	lbl_PhoneStatic.textColor = [UIColor whiteColor];
	lbl_Phone.textColor = [UIColor whiteColor];
	lbl_AddressStatic_BusinessCard.textColor = [UIColor whiteColor];
	lbl_Address_BusinessCard.textColor = [UIColor whiteColor];
	
	//For CourseInfo Ciew
	lbl_CourseNameStatic.textColor = [UIColor whiteColor];
	lbl_CourseName.textColor = [UIColor whiteColor];
	lbl_CourseCodeStatic.textColor = [UIColor whiteColor];
	lbl_CourseCode.textColor = [UIColor whiteColor];
	lbl_Professor.textColor = [UIColor whiteColor];
	lbl_ProfessorStatic.textColor = [UIColor whiteColor];
	lbl_DateTimeStatic.textColor = [UIColor whiteColor];
	lbl_DateTime.textColor = [UIColor whiteColor];
	
	//invitation view
	lbl_Title_Invitation.textColor = [UIColor whiteColor];
	lbl_TitleStatic_Invitation.textColor = [UIColor whiteColor];
	lbl_Address_Invitation.textColor = [UIColor whiteColor];
	lbl_AddressStatic_Invitation.textColor = [UIColor whiteColor];
	
	// for idbadge view
	lbl_Company_IDBadge.textColor = [UIColor whiteColor];
	lbl_CompanyStatic_IDBadge.textColor = [UIColor whiteColor];
	lbl_NameStatic_IDBadge.textColor = [UIColor whiteColor];
	lbl_Name_IDBadge.textColor = [UIColor whiteColor];
	lbl_JobTitle_IDBadge.textColor = [UIColor whiteColor];
	lbl_JobTitleStatic_IDBadge.textColor = [UIColor whiteColor];
	
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
# pragma mark For DatePicker Open Clicks
DatePicker* obj_DatePicker;
-(IBAction)onBtnStartClick_Event
{
	[txt_EventTitle resignFirstResponder];
	[txt_Address resignFirstResponder];
	[tv_Notes resignFirstResponder];
	strFlagForTextfield = @"Start";
	//obj_DatePicker=[[DatePicker alloc] initWithNibName:@"DatePicker" bundle:[NSBundle mainBundle]];
//	obj_DatePicker.flag = strFlagForTextfield;
//	UINavigationController* tempNav=[[UINavigationController alloc] initWithRootViewController:obj_DatePicker];
//	dateSelection=[[UIPopoverController alloc] initWithContentViewController:tempNav];
//	
//	obj_DatePicker.delegate=self;
//	[dateSelection presentPopoverFromRect:CGRectMake(btnstart.frame.origin.x, btnstart.frame.origin.y+8, btnstart.frame.size.width, btnstart.frame.size.height) inView:eventView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
//	[tempNav release];
	if(dateSelection)
		[self dismissdatePopOver];
	//UIButton* b=(UIButton*)sender;
	StartEndDayController* objStartEndDayController=[[StartEndDayController alloc] initWithNibName:@"StartEndDayController" bundle:[NSBundle mainBundle]];
	objStartEndDayController.delegate=self;
	objStartEndDayController.isFrom=@"TM";
	objStartEndDayController.selectedDate=@"start";
	UINavigationController* tempNav=[[UINavigationController alloc] initWithRootViewController:objStartEndDayController];
	dateSelection=[[UIPopoverController alloc] initWithContentViewController:tempNav];
	[dateSelection presentPopoverFromRect:CGRectMake(btnstart.frame.origin.x, btnstart.frame.origin.y+8, btnstart.frame.size.width, btnstart.frame.size.height) inView:eventView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
	//if(appDel.ori == UIInterfaceOrientationPortrait || 
//	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
//		[dateSelection presentPopoverFromRect:CGRectMake(b.frame.origin.x-530, b.frame.origin.y, b.frame.size.width, b.frame.size.height) inView:EventView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
//	else
//		[dateSelection presentPopoverFromRect:CGRectMake(b.frame.origin.x-445, b.frame.origin.y, b.frame.size.width, b.frame.size.height) inView:EventView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
//	
	[tempNav release];
	[objStartEndDayController release];
}
-(IBAction)onBtnEndClick_Event
{
	[txt_EventTitle resignFirstResponder];
	[txt_Address resignFirstResponder];
	[tv_Notes resignFirstResponder];
	strFlagForTextfield = @"End";
	//obj_DatePicker=[[DatePicker alloc] initWithNibName:@"DatePicker" bundle:[NSBundle mainBundle]];
//	obj_DatePicker.flag = strFlagForTextfield;
//	UINavigationController* tempNav=[[UINavigationController alloc] initWithRootViewController:obj_DatePicker];
//	dateSelection=[[UIPopoverController alloc] initWithContentViewController:tempNav];
//	
//	obj_DatePicker.delegate=self;
//	[dateSelection presentPopoverFromRect:btnend.frame inView:eventView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
//	[tempNav release];
	
	if(dateSelection)
		[self dismissdatePopOver];
	//UIButton* b=(UIButton*)sender;
	StartEndDayController* objStartEndDayController=[[StartEndDayController alloc] initWithNibName:@"StartEndDayController" bundle:[NSBundle mainBundle]];
	objStartEndDayController.delegate=self;
	objStartEndDayController.selectedDate=@"end";
	objStartEndDayController.startDate=[NSDate date];
	objStartEndDayController.endDate=[NSDate date];
	UINavigationController* tempNav=[[UINavigationController alloc] initWithRootViewController:objStartEndDayController];
	dateSelection=[[UIPopoverController alloc] initWithContentViewController:tempNav];
	[dateSelection presentPopoverFromRect:btnend.frame inView:eventView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
	//if(appDel.ori == UIInterfaceOrientationPortrait || 
//	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
//		[dateSelection presentPopoverFromRect:CGRectMake(b.frame.origin.x-530, b.frame.origin.y, b.frame.size.width, b.frame.size.height) inView:EventView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
//	else
//		[dateSelection presentPopoverFromRect:CGRectMake(b.frame.origin.x-445, b.frame.origin.y, b.frame.size.width, b.frame.size.height) inView:EventView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
//	
	[tempNav release];
	[objStartEndDayController release];
}
-(IBAction)onBtnDateTimeClick_CourseInfo
{
	//appDel.str_date=@"";
	[txt_CourseName resignFirstResponder];
	[txt_CourseCode resignFirstResponder];
	[txt_Professor resignFirstResponder];
	strFlagForTextfield = @"DateTime";
	if (dateSelection) 
	{
		[self dismissdatePopOver];
	}
	obj_DatePickerCourseInfo=[[DatePickerCourseInfo alloc] initWithNibName:@"DatePickerCourseInfo" bundle:[NSBundle mainBundle]];
	UINavigationController* tempNav=[[UINavigationController alloc] initWithRootViewController:obj_DatePickerCourseInfo];
	dateSelection=[[UIPopoverController alloc] initWithContentViewController:tempNav];
	
	obj_DatePickerCourseInfo.delegateCourseInfo=self;
	[dateSelection presentPopoverFromRect:btn_DateTime.frame inView:courseinfoView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
	[tempNav release];
}

-(void) completeDateselection:(NSString*) sDate:(NSString*) eDate:(NSString*) allday
{
	if ([sDate length]>0 && [eDate length]>0) {
		
		NSDateFormatter* df=[[[NSDateFormatter alloc]init] autorelease];
		//if([allday isEqualToString:@"All Day"])
		//	[df setDateFormat:@"MM/dd/yy"];	
		txt_Start.text = sDate;
		txt_End.text = eDate;
		NSDateFormatter* df1=[[[NSDateFormatter alloc]init] autorelease];
		[df1 setDateFormat:@"E MM/dd/yy h:mm aaa"];
		NSDate *startdate = [df1 dateFromString:txt_Start.text];
		NSDate *enddate = [df1 dateFromString:eDate];
		if ([enddate compare:startdate] == NSOrderedAscending)
		{
			NSLog(@"NSOrderedAscending");
			UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"End date should be larger than start date" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
			[alert release];
			txt_End.text =@"";
			
		}
		else {
			NSLog(@"NSOrderedDescending");
			
			txt_End.text=eDate;
			[self dismissdatePopOver];
			[txt_Address becomeFirstResponder];
		}
	}
	else {
	if ([allday isEqualToString:@""]) {
		if ([strFlagForTextfield isEqualToString:@"Start"]) {
			
			txt_Start.text = sDate;
			
			[self onBtnEndClick_Event];
		}
		else {
			//txt_End.text = eDate;
			NSDateFormatter* df=[[[NSDateFormatter alloc]init] autorelease];
			[df setDateFormat:@"E MM/dd/yy h:mmaaa"];
			NSDate *startdate = [df dateFromString:txt_Start.text];
			NSDate *enddate = [df dateFromString:eDate];
			if ([enddate compare:startdate] == NSOrderedAscending)
			{
				NSLog(@"NSOrderedAscending");
				UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"End date should be larger than start date" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				[alert show];
				[alert release];
				txt_End.text =@"";
				
			}
			else {
				NSLog(@"NSOrderedDescending");
				txt_End.text=eDate;
				[self dismissdatePopOver];
				[txt_Address becomeFirstResponder];
			}
		}
	}
	else {
		[self dismissdatePopOver];
		[txt_Address becomeFirstResponder];
		NSDateFormatter* df=[[[NSDateFormatter alloc]init] autorelease];
		//if([allday isEqualToString:@"All Day"])
		//	[df setDateFormat:@"MM/dd/yy"];	
		txt_Start.text = sDate;
		txt_End.text = eDate;
	}
	}
	
}
# pragma mark PopOver dissmiss
- (void) dismissPopover
{
	if(photoPop)  
	{
		[photoPop dismissPopoverAnimated:YES];
		[photoPop release];
		photoPop=nil;
	}
}
-(void) dismissdatePopOver
{
	if (dateSelection) 
	{
		[dateSelection dismissPopoverAnimated:YES];
		[dateSelection release];
		dateSelection=nil;
	}
	if ([strFlagForTextfield isEqualToString:@"DateTime"]) {
		txt_DateTime.text=appDel.str_date ;
	}
	else if ([strFlagForTextfield isEqualToString:@"Start"]) {
		if (FlagEvent==FALSE){}
			//[self onBtnEndClick_Event];
		//txt_Start.text=appDel.str_date ;
	}
	else if ([strFlagForTextfield isEqualToString:@"End"]) {
		if (FlagEvent==FALSE){}
			//[txt_Address becomeFirstResponder];
		//txt_End.text=appDel.str_date ;
		
	}
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
	//if ([tv_Notes.text isEqualToString:@""]||tv_Notes.text==nil) {
//		lblNotes.hidden=FALSE;	
//	}
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	//if ([textView isEqual:tv_Notes]) {
//		
//		lblNotes.hidden=TRUE;
//	}
	return YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		return [array_catagory count];
	else {
		return [arrCategory_iPhone count];
	}

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
	if([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight)
	{
		return 69;
	}
	else 
	{
		return 69;
	}
	}
	else {
		return 72;
	}

	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
			
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		static NSString *CellIdentifier = @"CustomCell";
		LibraryCell *cell = (LibraryCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		cell.selectedBackgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"_0001_Layer-41.png"]]; 
		if (cell == nil) {
			NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LibraryCell" owner:self options:nil];
			for (id currentObject in topLevelObjects){
				if ([currentObject isKindOfClass:[UITableViewCell class]]){
					cell =  (LibraryCell *) currentObject;
					break;
				}
			}
		}
		
		UIImageView *img = [[[UIImageView alloc]init] autorelease];
		img.image = [UIImage imageNamed:@""];
		img.frame = CGRectMake(0, 0, 830, 69);
		[cell.contentView addSubview:img];
		
		UIImageView *imgqr = [[[UIImageView alloc]init] autorelease];
		imgqr.image = [arrImg objectAtIndex:indexPath.row];
		imgqr.frame = CGRectMake(25, 6, 57, 57);
		[cell.contentView addSubview:imgqr];
		
		UILabel *lbl = [[[UILabel alloc]initWithFrame:CGRectMake(100, 6, 200, 18)] autorelease];
		lbl.text = [[array_catagory objectAtIndex:indexPath.row] objectForKey:@"Category"];
		[lbl setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
		[cell.contentView addSubview:lbl];

		
		UILabel *lbl1 = [[[UILabel alloc]initWithFrame:CGRectMake(100, 20, 600, 30)] autorelease];
		lbl1.text = [[array_catagory objectAtIndex:indexPath.row] objectForKey:@"Description"];
		[lbl1 setFont:[UIFont fontWithName:@"Arial" size:14]];
		lbl1.backgroundColor = [UIColor clearColor];
		[cell.contentView addSubview:lbl1];
		
		
		if(selectedRow == indexPath.row)
		{
			img.image = [UIImage imageNamed:@"_0001_Layer-41-20.png"];
			lbl.backgroundColor = [UIColor clearColor];
			lbl1.backgroundColor = [UIColor clearColor];
			lbl.textColor = [UIColor whiteColor];
			lbl1.textColor = [UIColor whiteColor];
		}
		return cell;
	}
	else {
		static NSString *CellIdentifier = @"CustomCell";
		LibraryCell_Landscape *cell = (LibraryCell_Landscape *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LibraryCell-Landscape" owner:self options:nil];
			for (id currentObject in topLevelObjects){
				if ([currentObject isKindOfClass:[UITableViewCell class]]){
					cell =  (LibraryCell_Landscape *) currentObject;
					break;
				}
			}
		}
		
		UIImageView *img = [[UIImageView alloc]init];
		img.image = [UIImage imageNamed:@"_0000_seperation-lines-set1-copy-20.png"];
		img.frame = CGRectMake(0, 0, 320, 72);
		[cell.contentView addSubview:img];
		[img release];
		
		UIImageView *img1 = [[UIImageView alloc]init];
		img1.image = [UIImage imageNamed:[array_NormalImages objectAtIndex:indexPath.row]];
		img1.frame = CGRectMake(10, 8, 56, 56);
		[cell.contentView addSubview:img1];
		[img1 release];
		
		
		UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, 150, 50)];
		lbl1.text = [arrCategory_iPhone objectAtIndex:indexPath.row];
		lbl1.numberOfLines = 0;
		lbl1.lineBreakMode = UILineBreakModeWordWrap;
		[lbl1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
		[cell.contentView addSubview:lbl1];
		[lbl1 release];
		
		UIImageView *img_aero = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Arrow_WriteDark_iphone.png"]];
		img_aero.frame = CGRectMake(300, 30, 6, 11);
		[cell.contentView addSubview:img_aero];
		
		img.highlightedImage = [UIImage imageNamed:@"_0001_seperation-lines-set1-20.png"];
		img.image = [UIImage imageNamed:@"_0000_seperation-lines-set1-copy-20.png"];
		lbl1.highlightedTextColor = [UIColor whiteColor];
		img_aero.highlightedImage = [UIImage imageNamed:@"Arrow_WriteNormal_iphone.png"];
		img1.highlightedImage = [UIImage imageNamed:[array_SelectedImages objectAtIndex:indexPath.row]];
		
		
		
		return cell;
		
	}

}	
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	//changeColor = indexPath.row;
	
	selectedRow = indexPath.row;
	
	[selectedindexes addObject:[NSNumber numberWithInt:selectedRow]];
	
	[self setselectedFirstRow:indexPath];
	
	
	//[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
	
}	
-(void)setselectedFirstRow:(NSIndexPath *)indexpath
{
	/*UITableViewCell *cell = [tbl_Barcode cellForRowAtIndexPath:indexpath];
	UIImageView *imgBg = [[UIImageView alloc]init];
	UILabel *lblHeading = [[UILabel alloc]init];
	UILabel *lblHeading1 = [[UILabel alloc]init];*/
	

	
	
	
	
	
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			[tbl_Barcode reloadData];
			ivBarcode.image = [arrImg objectAtIndex:selectedRow];
			ivBarcode_BusinessCard.image = [arrImg objectAtIndex:selectedRow];
			ivBarcode_CourseInfo.image = [arrImg objectAtIndex:selectedRow];
			ivBarcode_Invitation.image = [arrImg objectAtIndex:selectedRow];
			ivBarcode_IDBadge.image = [arrImg objectAtIndex:selectedRow];
			barcodeView.hidden=TRUE;
		}
	else {
		[tbl_allCat reloadData];
		
		appDel.indexForTemplate = selectedRow;
		TemplateOptionchoiceController *templateOptionchoiceController = [[TemplateOptionchoiceController alloc]initWithNibName:@"TemplateOptionchoiceController" bundle:nil];
		[self.navigationController pushViewController:templateOptionchoiceController animated:YES];
		[templateOptionchoiceController release];
		 
	}

	
}

#pragma mark UITextField Methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	
	if ([textField isEqual:txt_Phone]) {
		if(txt_Phone.keyboardType== UIKeyboardTypeNumberPad)
		{
			NSCharacterSet *cs;
			NSString *filtered;
			cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
			filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
			return [string isEqualToString:filtered];
		}
	}
	
	else if ([textField isEqual:txt_ZipCode]||[textField isEqual:txt_ZipCode_BusinessCard]||[textField isEqual:txt_ZipCode_Invitation]) {
		if(txt_Phone.keyboardType== UIKeyboardTypeNumberPad)
		{
			NSCharacterSet *cs;
			NSString *filtered;
			cs = [[NSCharacterSet characterSetWithCharactersInString:ZIP] invertedSet];
			filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
			return [string isEqualToString:filtered];
		}
	}
	
	else if ([textField isEqual:txt_State]||[textField isEqual:txt_State_BusinessCard]||[textField isEqual:txt_State_Invitation]||[textField isEqual:txt_City]||[textField isEqual:txt_City_BusinessCard]||[textField isEqual:txt_City_Invitation]||[textField isEqual:txt_Country]||[textField isEqual:txt_Country_BusinessCard]||[textField isEqual:txt_Country_Invitation]) {
		NSCharacterSet *cs;
		NSString *filtered;
		cs = [[NSCharacterSet characterSetWithCharactersInString:CHAR] invertedSet];
		filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return [string isEqualToString:filtered];
	}
	else {
		return YES;
	}

	
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	if ([textField isEqual:txt_Email]) {
		if(![txt_Email.text isEqualToString:@""]){
			
			NSString *email = txt_Email.text; 
			if (! (([email rangeOfString:@"@"].location != NSNotFound) && ([email rangeOfString:@"."].location != NSNotFound)) ) { 
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning !" message:@"Please enter valid Email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
				[alert release];
			}
		}
	}
	[textField resignFirstResponder];
	return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	activetxt = textField;
	if ([textField isEqual:txt_DateTime]) {
		strFlagForTextfield = @"DateTime";
		
		if (dateSelection) 
		{
			[self dismissdatePopOver];
		}
		obj_DatePicker=[[DatePicker alloc] initWithNibName:@"DatePicker" bundle:[NSBundle mainBundle]];
		UINavigationController* tempNav=[[UINavigationController alloc] initWithRootViewController:obj_DatePicker];
		dateSelection=[[UIPopoverController alloc] initWithContentViewController:tempNav];
		
		obj_DatePicker.delegate=self;
		[dateSelection presentPopoverFromRect:btn_DateTime.frame inView:courseinfoView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
		[tempNav release];
		[txt_DateTime resignFirstResponder];
	}
	else if ([textField isEqual:txt_Start]){
		
		if (dateSelection) 
		{
			[self dismissdatePopOver];
		}
		strFlagForTextfield = @"Start";
		obj_DatePicker=[[DatePicker alloc] initWithNibName:@"DatePicker" bundle:[NSBundle mainBundle]];
		UINavigationController* tempNav=[[UINavigationController alloc] initWithRootViewController:obj_DatePicker];
		dateSelection=[[UIPopoverController alloc] initWithContentViewController:tempNav];
		
		obj_DatePicker.delegate=self;
		[dateSelection presentPopoverFromRect:btnstart.frame inView:eventView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
		[tempNav release];
		[txt_Start resignFirstResponder];
	}
	else if ([textField isEqual:txt_End]){
		
		if (dateSelection) 
		{
			[self dismissdatePopOver];
		}
		strFlagForTextfield = @"End";
		obj_DatePicker=[[DatePicker alloc] initWithNibName:@"DatePicker" bundle:[NSBundle mainBundle]];
		UINavigationController* tempNav=[[UINavigationController alloc] initWithRootViewController:obj_DatePicker];
		dateSelection=[[UIPopoverController alloc] initWithContentViewController:tempNav];
		
		obj_DatePicker.delegate=self;
		[dateSelection presentPopoverFromRect:btnend.frame inView:eventView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
		[tempNav release];
		[txt_End resignFirstResponder];
	}
	return YES;
	
}

- (void)textFieldDidBeginEditing:(UITextField *)textField          // became first responder
{
	//if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
//	   appDel.ori == UIInterfaceOrientationLandscapeRight)
//	{
//		if(oncePort == TRUE)
//		{
//			if ([textField isEqual:txt_ZipCode]) {
//				eventView.frame=CGRectMake(125, -40, 795, 670);
//			}
//			if ([textField isEqual:txt_Country]) {
//				eventView.frame=CGRectMake(125, -60, 795, 670);
//			}
//			if ([textField isEqual:tv_Notes]) {
//				eventView.frame=CGRectMake(125, -80, 795, 670);
//			}
//		}
//		else {
//			if ([textField isEqual:txt_ZipCode]) {
//				eventView.frame=CGRectMake(125+20, -40, 795, 670);
//			}
//			if ([textField isEqual:txt_Country]) {
//				eventView.frame=CGRectMake(125+20, -60, 795, 670);
//			}
//			if ([textField isEqual:tv_Notes]) {
//				eventView.frame=CGRectMake(125+20, -80, 795, 670);
//			}
//		}
//	}
	if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
	   appDel.ori == UIInterfaceOrientationLandscapeRight)
	{
		//if(oncePort == TRUE){
			if ([textField isEqual:txt_Country]) {
				eventView.frame=CGRectMake(125, -30, 795, 670);
			}
			if ([textField isEqual:tv_Notes]) {
				eventView.frame=CGRectMake(125, -40, 795, 670);
			}
			if ([textField isEqual:txt_City_BusinessCard]) {
				businessView.frame=CGRectMake(125, -40, 795, 670);
			}
			if ([textField isEqual:txt_State_BusinessCard]) {
				businessView.frame=CGRectMake(125, -60, 795, 670);
			}
			if ([textField isEqual:txt_ZipCode_BusinessCard]) {
				businessView.frame=CGRectMake(125, -80, 795, 670);
			}
			if ([textField isEqual:txt_Country_BusinessCard]) {
				businessView.frame=CGRectMake(125, -110, 795, 670);
			}
			
		//}
//		else {
//			if ([textField isEqual:txt_Country]) {
//				eventView.frame=CGRectMake(125+20, -30, 795, 670);
//			}
//			if ([textField isEqual:tv_Notes]) {
//				eventView.frame=CGRectMake(125+20, -40, 795, 670);
//			}
//			if ([textField isEqual:txt_City_BusinessCard]) {
//				businessView.frame= CGRectMake(125+20, -40, 795, 670);
//			}
//			if ([textField isEqual:txt_State_BusinessCard]) {
//				businessView.frame=CGRectMake(125+20, -60, 795, 670);
//			}
//			if ([textField isEqual:txt_ZipCode_BusinessCard]) {
//				businessView.frame=CGRectMake(125+20, -80, 795, 670);
//			}
//			if ([textField isEqual:txt_Country_BusinessCard]) {
//				businessView.frame=CGRectMake(125+20, -110, 795, 670);
//			}
//		}
	}
	if ([textField isEqual:tv_Notes]) {
		
		lblNotes.hidden=TRUE;
	}

	
}

- (void)textFieldDidEndEditing:(UITextField *)textField            // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
{
	if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
	   appDel.ori == UIInterfaceOrientationLandscapeRight)
	{
		//if(oncePort == TRUE){
			if ([textField isEqual:txt_Country]) {
				eventView.frame=CGRectMake(125, 40, 795, 670);
				[scrl_Event setContentOffset:CGPointMake(0, 0)];
			}
			if ([textField isEqual:tv_Notes]) {
				eventView.frame=CGRectMake(125, 40, 795, 670);
				[scrl_Event setContentOffset:CGPointMake(0, 0)];
			}
			if ([textField isEqual:txt_City_BusinessCard]) {
				businessView.frame=CGRectMake(125, 40, 795, 670);
				[scrl_BusinessCard setContentOffset:CGPointMake(0, 0)];
			}
			if ([textField isEqual:txt_State_BusinessCard]) {
				businessView.frame=CGRectMake(125, 40, 795, 670);
				[scrl_BusinessCard setContentOffset:CGPointMake(0, 0)];
			}
			if ([textField isEqual:txt_ZipCode_BusinessCard]) {
				businessView.frame=CGRectMake(125, 40, 795, 670);
				[scrl_BusinessCard setContentOffset:CGPointMake(0, 0)];
			}
			if ([textField isEqual:txt_Country_BusinessCard]) {
				businessView.frame=CGRectMake(125, 40, 795, 670);
				[scrl_BusinessCard setContentOffset:CGPointMake(0, 0)];
			}
		//}
//		else {
//			if ([textField isEqual:txt_Country]) {
//				eventView.frame=CGRectMake(125+20, 40, 795, 670);
//				[scrl_Event setContentOffset:CGPointMake(0, 0)];
//			}
//			if ([textField isEqual:tv_Notes]) {
//				eventView.frame=CGRectMake(125+20, 40, 795, 670);
//				[scrl_Event setContentOffset:CGPointMake(0, 0)];
//			}
//			if ([textField isEqual:txt_City_BusinessCard]) {
//				businessView.frame=CGRectMake(125+20, 40, 795, 670);
//				[scrl_BusinessCard setContentOffset:CGPointMake(0, 0)];
//			}
//			if ([textField isEqual:txt_State_BusinessCard]) {
//				businessView.frame=CGRectMake(125+20, 40, 795, 670);
//				[scrl_BusinessCard setContentOffset:CGPointMake(0, 0)];
//			}
//			if ([textField isEqual:txt_ZipCode_BusinessCard]) {
//				businessView.frame=CGRectMake(125+20, 40, 795, 670);
//				[scrl_BusinessCard setContentOffset:CGPointMake(0, 0)];
//			}
//			if ([textField isEqual:txt_Country_BusinessCard]) {
//				businessView.frame=CGRectMake(125+20, 40, 795, 670);
//				[scrl_BusinessCard setContentOffset:CGPointMake(0, 0)];
//			}
//		}
	}
	//if(oncePort == TRUE)
//	{
//		if ([textField isEqual:txt_ZipCode]) {
//			eventView.frame=CGRectMake(125, 40, 795, 670);
//		}
//		if ([textField isEqual:txt_Country]) {
//			eventView.frame=CGRectMake(125, 40, 795, 670);
//		}
//		if ([textField isEqual:tv_Notes]) {
//			eventView.frame=CGRectMake(125, 40, 795, 670);
//		}
//	}
//	else {
//		if ([textField isEqual:txt_ZipCode]) {
//			eventView.frame=CGRectMake(125+20, 40, 795, 670);
//		}
//		if ([textField isEqual:txt_Country]) {
//			eventView.frame=CGRectMake(125+20, 40, 795, 670);
//		}
//		if ([textField isEqual:tv_Notes]) {
//			eventView.frame=CGRectMake(125+20, 40, 795, 670);
//		}
//	}
	if ([tv_Notes.text isEqualToString:@""]||tv_Notes.text==nil) {
		lblNotes.hidden=FALSE;	
	}
	[tv_Notes resignFirstResponder];
}


- (BOOL)textFieldShouldClear:(UITextField *)textField               // called when clear button pressed. return NO to ignore (no notifications)
{}

-(void)tv_NotesBecomeFirst
{
	[tv_Notes becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	//For Event
	if([textField isEqual:txt_EventTitle])
	{
		[self onBtnStartClick_Event];
	//	[txt_Address becomeFirstResponder];
	}
	if ([textField isEqual:txt_Address]) {
		[txt_City becomeFirstResponder];
	}
	if ([textField isEqual:txt_City]) {
		[txt_State becomeFirstResponder];
	}
	if ([textField isEqual:txt_State]) {
		[txt_ZipCode becomeFirstResponder];
	}
	if ([textField isEqual:txt_ZipCode]) {
		[txt_Country becomeFirstResponder];
	}
	if([textField isEqual:txt_Country])
	{
		//[self performSelector:@selector(tv_NotesBecomeFirst) withObject:nil afterDelay:0.5];
		[tv_Notes becomeFirstResponder];
		//[tv_Notes becomeFirstResponder];
	}
	if ([textField isEqual:tv_Notes]) {
		[tv_Notes resignFirstResponder];
	}
	//For Business card
	if([textField isEqual:txt_CompanyName])
	{
		[txt_Name becomeFirstResponder];
	}
	if([textField isEqual:txt_Name])
	{
		[txt_JobTitle becomeFirstResponder];
	}
	if([textField isEqual:txt_JobTitle])
	{
		[txt_Email becomeFirstResponder];
	}
	if([textField isEqual:txt_Email])
	{
		[txt_Phone becomeFirstResponder];
	}
	if([textField isEqual:txt_Phone])
	{
		[txt_Add becomeFirstResponder];
	}
	if([textField isEqual:txt_Add])
	{
		[txt_City_BusinessCard becomeFirstResponder];
	}
	if([textField isEqual:txt_City_BusinessCard])
	{
		[txt_State_BusinessCard becomeFirstResponder];
	}
	if([textField isEqual:txt_State_BusinessCard])
	{
		[txt_ZipCode_BusinessCard becomeFirstResponder];
	}
	if([textField isEqual:txt_ZipCode_BusinessCard])
	{
		[txt_Country_BusinessCard becomeFirstResponder];
	}
	if([textField isEqual:txt_Country_BusinessCard])
	{
		[txt_Country_BusinessCard resignFirstResponder];
	}
	//For Invitation
	if([textField isEqual:txt_Title_Invitation])
	{
		[txt_Add_Invitation becomeFirstResponder];
	}
	if([textField isEqual:txt_Add_Invitation])
	{
		[txt_City_Invitation becomeFirstResponder];
	}
	if([textField isEqual:txt_City_Invitation])
	{
		[txt_State_Invitation becomeFirstResponder];
	}
	if([textField isEqual:txt_State_Invitation])
	{
		[txt_ZipCode_Invitation becomeFirstResponder];
	}
	if([textField isEqual:txt_ZipCode_Invitation])
	{
		[txt_Country_Invitation becomeFirstResponder];
	}
	if([textField isEqual:txt_Country_Invitation])
	{
		[txt_Country_Invitation resignFirstResponder];
	}
	//for IDBadge
	if([textField isEqual:txt_Company_IDBadge])
	{
		[txt_Name_IDBadge becomeFirstResponder];
	}
	if([textField isEqual:txt_Name_IDBadge])
	{
		[txt_JobTitle_IDBadge becomeFirstResponder];
	}
	if([textField isEqual:txt_JobTitle_IDBadge])
	{
		[txt_JobTitle_IDBadge resignFirstResponder];
	}
	
	//for Course Info
	if([textField isEqual:txt_CourseName])
	{
		[txt_CourseCode becomeFirstResponder];
	}
	if([textField isEqual:txt_CourseCode])
	{
		[txt_Professor becomeFirstResponder];
	}
	if([textField isEqual:txt_Professor])
	{
		//[txt_DateTime becomeFirstResponder];
		[self onBtnDateTimeClick_CourseInfo];
		[txt_Professor resignFirstResponder];
		//[self textFieldShouldBeginEditing:txt_DateTime];
	}
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
	activetxtview = textView;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
	[tv_Notes resignFirstResponder];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	NSLog(@"text===%@",text);
	NSLog(@"text===%d",text);
	
	if([text isEqualToString:@"\n"])
	{
		[tv_Notes resignFirstResponder];
	}
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
-(void)viewWillDisappear:(BOOL)animated
{
}
-(void)event3respond
{
}




- (void)dealloc {
    //[super dealloc];
	[eventView release];
	[businessView release];
	[invitationView release];
	[idbadgeView release];
	[courseinfoView release];
	[imageProcessingView release];
	[PreviewShareView release];
	[ivBarcode release];
	[iv_photoLibImg release];
	[ivMainImage release];
	[ivColor release];
	[ivTransparency release];
	[ivAlignment release];
	[obj_DatePicker release];
	[iv_SeperationLine release];
	[iv_SeperationBorder release];
	[ivCoverFlow release];
	[ivLibrary release];
	[ivBarcode_BusinessCard release];
	[ivBarcode_CourseInfo release];
	[barCodeImgView release];
	[ivGradient release];
	[imagePickerController release];
	[coverFloWView release];
	[libraryView release];
	[imgtemplate release];
	[imgBGShare release];
	[shareKitView release];
	[vc release];
	[lbl_CourseName release];
	[lbl_CourseNameStatic release];
	[lbl_CourseCode release];
	[lbl_CourseCodeStatic release];
	[lbl_Professor release];
	[lbl_ProfessorStatic release];
	[lbl_DateTime release];
	[lbl_DateTimeStatic release];
	[txt_CompanyName release];
	[txt_Name release];
	[txt_JobTitle release];
	[txt_Email release];
	[txt_Phone release];
	[txt_Add release];
	[txt_Title_Invitation release];
	[txt_Add_Invitation release];
	[txt_Company_IDBadge release];
	[txt_Name_IDBadge release];
	[txt_JobTitle_IDBadge release];
	[txt_CourseName release];
	[txt_CourseCode release];
	[txt_Professor release];
	[txt_DateTime release];
	NSLog(@"I am being deallocated");
    [super dealloc];
}


@end
