//
//  DashBoardViewController.m
//  KrenMarketing
//
//  Created by Silvertouch on 17/11/11.
//  Copyright 2011 SilverTouch Tech. Ltd. All rights reserved.
//

#import "DashBoardViewController.h"


@implementation DashBoardViewController

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
- (void)viewDidLoad 
{
	[super viewDidLoad];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{

	firstTime = TRUE;
	oncePort = FALSE;
	
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"didRotate" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(didRotate:) 
												 name:UIApplicationDidChangeStatusBarOrientationNotification
											   object:nil];
    
	
	btnArrays = [[[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"_0007_n-2.png"]
				 ,[UIImage imageNamed:@"_0008_n-10.png"]
				 ,[UIImage imageNamed:@"_0009_n-12.png"]
				 ,[UIImage imageNamed:@"_0000_n-14.png"]
				 ,[UIImage imageNamed:@"_0001_n-15.png"]
				 ,[UIImage imageNamed:@"_0002_n-16.png"]
				 ,[UIImage imageNamed:@"_0003_n-17.png"]
				 ,[UIImage imageNamed:@"_0004_n-18.png"]
				 ,[UIImage imageNamed:@"_0005_n-20.png"]
				 ,[UIImage imageNamed:@"_0006_n-21.png"]
				 ,nil]retain];
	
	
	mainImage = [[UIImageView alloc]init];
	mainImage.frame = CGRectMake(34, 0, 654, 1024);
	mainImage.image = [UIImage imageNamed:@"Red_Layer-1.png"];
	[self.view addSubview:mainImage];
	
	
	whiteLayer = [[UIImageView alloc]init];
	whiteLayer.frame = CGRectMake(0, 48, 768, 38);
	whiteLayer.image = [UIImage imageNamed:@"select-chalter-L-1.png"];
	[self.view addSubview:whiteLayer];
	[topImage sendSubviewToBack:whiteLayer];
	
	
	topImage = [[UIImageView alloc]init];
	topImage.frame = CGRectMake(0, 0, 768, 58);
	topImage.image = [UIImage imageNamed:@"_0009_top-red-band.png"];
	[self.view addSubview:topImage];
	
	
	topLable = [[UILabel alloc]init];
	topLable.text = @"Dashboards";
	topLable.textColor=[UIColor whiteColor];
	[topLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
	topLable.backgroundColor = [UIColor clearColor];
	topLable.frame = CGRectMake(290, 5, 200, 30);
	[self.view addSubview:topLable];
	
	circle = [[UIImageView alloc]init];
	circle.frame = CGRectMake(60, 290, 603, 473);
	circle.image = [UIImage imageNamed:@"speedometer.png"];
	[self.view addSubview:circle];
	
	aero = [[UIImageView alloc]init];
	aero.frame = CGRectMake(240, 450, 255, 146);
	//aero.image = [UIImage imageNamed:@"speedometer-copy.png"];
	[aero setContentMode:UIViewContentModeCenter];
	[self.view addSubview:aero];
	
		
	labelWhite = [[UILabel alloc]init];
	labelWhite.text = @"Select a Chapter";
	labelWhite.textColor=[UIColor blackColor];
	[labelWhite setFont:[UIFont fontWithName:@"Helvetica" size:20]];
	labelWhite.backgroundColor = [UIColor clearColor];
	labelWhite.frame = CGRectMake(290, 50, 200, 30);
	[self.view addSubview:labelWhite];
	
	
	///////Buttons////////
	
	
	btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[btn2 addTarget:self 
			 action:@selector(NumberTwoClicked:)
		  forControlEvents:UIControlEventTouchDown];
	btn2.tag = 0;
	//[btn2 setImage:[UIImage imageNamed:@"_0002_Normal-State.png"] forState:UIControlStateNormal];
	//[btnContinue setTitle:@"Show View" forState:UIControlStateNormal];
	btn2.frame = CGRectMake(80, 630, 100, 80);
	[self.view addSubview:btn2];
	
	
	btn10 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[btn10 addTarget:self 
			  action:@selector(NumberTwoClicked:)
   forControlEvents:UIControlEventTouchDown];
	btn10.tag = 1;
	//[btn2 setImage:[UIImage imageNamed:@"_0002_Normal-State.png"] forState:UIControlStateNormal];
	//[btnContinue setTitle:@"Show View" forState:UIControlStateNormal];
	btn10.frame = CGRectMake(50, 520, 100, 80);
	[self.view addSubview:btn10];
	
	
	btn12 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[btn12 addTarget:self 
			  action:@selector(NumberTwoClicked:)
	forControlEvents:UIControlEventTouchDown];
	btn12.tag = 2;
	//[btn2 setImage:[UIImage imageNamed:@"_0002_Normal-State.png"] forState:UIControlStateNormal];
	//[btnContinue setTitle:@"Show View" forState:UIControlStateNormal];
	btn12.frame = CGRectMake(80, 420, 100, 80);
	[self.view addSubview:btn12];
	
	
	btn14 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[btn14 addTarget:self 
			  action:@selector(NumberTwoClicked:)
	forControlEvents:UIControlEventTouchDown];
	btn14.tag = 3;
	//[btn2 setImage:[UIImage imageNamed:@"_0002_Normal-State.png"] forState:UIControlStateNormal];
	//[btnContinue setTitle:@"Show View" forState:UIControlStateNormal];
	btn14.frame = CGRectMake(150, 330, 100, 80);
	[self.view addSubview:btn14];
	
	
	btn15 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[btn15 addTarget:self 
			  action:@selector(NumberTwoClicked:)
	forControlEvents:UIControlEventTouchDown];
	btn15.tag = 4;
	//[btn2 setImage:[UIImage imageNamed:@"_0002_Normal-State.png"] forState:UIControlStateNormal];
	//[btnContinue setTitle:@"Show View" forState:UIControlStateNormal];
	btn15.frame = CGRectMake(250, 300, 100, 80);
	[self.view addSubview:btn15];
	
	
	btn16 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[btn16 addTarget:self 
			  action:@selector(NumberTwoClicked:)
	forControlEvents:UIControlEventTouchDown];
	btn16.tag = 5;
	//[btn2 setImage:[UIImage imageNamed:@"_0002_Normal-State.png"] forState:UIControlStateNormal];
	//[btnContinue setTitle:@"Show View" forState:UIControlStateNormal];
	btn16.frame = CGRectMake(370, 290, 100, 80);
	[self.view addSubview:btn16];
	
	
	btn17 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[btn17 addTarget:self 
			  action:@selector(NumberTwoClicked:)
	forControlEvents:UIControlEventTouchDown];
	btn17.tag = 6;
	btn17.frame = CGRectMake(470, 330, 100, 80);
	[self.view addSubview:btn17];
	
	
	btn18 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[btn18 addTarget:self 
			  action:@selector(NumberTwoClicked:)
	forControlEvents:UIControlEventTouchUpInside];
	btn18.tag = 7;
	//[btn2 setImage:[UIImage imageNamed:@"_0002_Normal-State.png"] forState:UIControlStateNormal];
	//[btnContinue setTitle:@"Show View" forState:UIControlStateNormal];
	btn18.frame = CGRectMake(530, 420, 100, 80);
	[self.view addSubview:btn18];
	
	
	btn20 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[btn20 addTarget:self 
			  action:@selector(NumberTwoClicked:)
	forControlEvents:UIControlEventTouchUpInside];
	btn20.tag = 8;
	//[btn2 setImage:[UIImage imageNamed:@"_0002_Normal-State.png"] forState:UIControlStateNormal];
	//[btnContinue setTitle:@"Show View" forState:UIControlStateNormal];
	btn20.frame = CGRectMake(570, 520, 100, 80);
	[self.view addSubview:btn20];
	
	
	btn21 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[btn21 addTarget:self 
			  action:@selector(NumberTwoClicked:)
	forControlEvents:UIControlEventTouchUpInside];
	btn21.tag = 9;
	//[btn2 setImage:[UIImage imageNamed:@"_0002_Normal-State.png"] forState:UIControlStateNormal];
	//[btnContinue setTitle:@"Show View" forState:UIControlStateNormal];
	btn21.frame = CGRectMake(550, 630, 100, 80);
	[self.view addSubview:btn21];
	
	if (appDel.dashboadviewflag==FALSE) 
	{
		dashBoardView = [[UIView alloc] init];
		dashBoardView.frame = self.view.frame;
		
		
		mainViewImage = [[UIImageView alloc]init];
		mainViewImage.frame = CGRectMake(34, 0, 654, 1024);
		mainViewImage.image = [UIImage imageNamed:@"Red_Layer-1.png"];
		[dashBoardView addSubview:mainViewImage];
		
		
		topViewImage = [[UIImageView alloc]init];
		topViewImage.frame = CGRectMake(0, 0, 768, 48);
		topViewImage.image = [UIImage imageNamed:@"_0009_top-red-band.png"];
		[dashBoardView addSubview:topViewImage];
		
		
		topViewLable = [[UILabel alloc]init];
		topViewLable.text = @"Dashboards";
		topViewLable.textColor=[UIColor whiteColor];
		[topViewLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
		topViewLable.backgroundColor = [UIColor clearColor];
		topViewLable.frame = CGRectMake(290, 5, 200, 30);
		[dashBoardView addSubview:topViewLable];
		
		MSGView = [[UIImageView alloc]init];
		MSGView.frame = CGRectMake(153,358,427,205);
		MSGView.image = [UIImage imageNamed:@"_0003_These-activities-give-you-the-opportunity-to-practice-the-math-.png"];
		[dashBoardView addSubview:MSGView];
		
		
		btnContinue = [UIButton buttonWithType:UIButtonTypeCustom];
		[btnContinue addTarget:self 
						action:@selector(HideMainView)
			  forControlEvents:UIControlEventTouchDown];
		[btnContinue setImage:[UIImage imageNamed:@"_0002_Normal-State.png"] forState:UIControlStateNormal];
		//[btnContinue setTitle:@"Show View" forState:UIControlStateNormal];
		btnContinue.frame = CGRectMake(280, 610, 137, 52);
		[dashBoardView addSubview:btnContinue];
		
		[self.view addSubview:dashBoardView];
	}
	
	//tagme =2;
	[self didRotate:nil];
	}
	else 
	{
		tagme = 0;
		
		btnArrays1 = [[[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"2_aero.png"]
					  ,[UIImage imageNamed:@"10.png"]
					  ,[UIImage imageNamed:@"12.png"]
					  ,[UIImage imageNamed:@"14.png"]
					  ,[UIImage imageNamed:@"15_Amrit.png"]
					  ,[UIImage imageNamed:@"16_Amrit.png"]
					  ,[UIImage imageNamed:@"17.png"]
					  ,[UIImage imageNamed:@"18.png"]
					  ,[UIImage imageNamed:@"20.png"]
					  ,[UIImage imageNamed:@"21.png"]
					  ,nil]retain];

		
		aero = [[UIImageView alloc]init];
		[aero setContentMode:UIViewContentModeScaleToFill];
		aero.frame = CGRectMake(29, 130, 259.5, 239);
		
		aero.image = [UIImage imageNamed:@"2_aero.png"];
		[self.view addSubview:aero];
		[self.view bringSubviewToFront:aero];
		aero.hidden = TRUE;
	}
		
}

-(IBAction)openSafari:(id)sender
{
	tagme = [sender tag];
	aero.image =[btnArrays1 objectAtIndex:tagme];
	
	aero.frame = CGRectMake(29, 130, 259.5, 239);
	
	[self performSelector:@selector(startTimer) withObject:nil afterDelay:0.5];
}

-(IBAction)btnCountPressed:(id)sender
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.google.com"]];

}

#pragma mark set Orientation
-(void)setFrameOrientation_Portrait
{
	oncePort = TRUE;
	firstTime = FALSE;
	
	mainImage.frame = CGRectMake(34, 0, 654, 1024);
	mainImage.image = [UIImage imageNamed:@"Red_Layer-1.png"];
	
	topImage.image = [UIImage imageNamed:@"Title-dashboards-P.png"];
	topImage.frame = CGRectMake(34, 0, 654, 48);
	labelWhite.hidden = TRUE;
	//labelWhite.frame = CGRectMake(290, 40, 200, 30);
	whiteLayer.hidden = FALSE;
	whiteLayer.image = [UIImage imageNamed:@"select-chapter-654.png"];
	whiteLayer.frame = CGRectMake(34, 38, 654, 38);
	topLable.hidden = TRUE;
	topLable.frame = CGRectMake(290, 5, 200, 30);
	
	circle.frame = CGRectMake(60, 290, 603, 473);
	
	aero.frame = CGRectMake(240, 450, 255, 146);
	aero.image =[btnArrays objectAtIndex:tagme];
	
	
	
	//aero.frame = CGRectMake(150, 475, 255, 146);
	
	//tagme =1 ;
//	
//	if(tagme == 0)
//	{
//		aero.frame = CGRectMake(140, 540, 255, 146);
//	}
//	
//	if(tagme == 1)
//	{
//		aero.frame = CGRectMake(130, 510, 255, 146);
//	}
//	if(tagme == 2)
//	{
//		aero.frame = CGRectMake(150, 475, 255, 146);
//	}
//	if(tagme == 3)
//	{
//		aero.frame = CGRectMake(180, 430, 255, 146);
//	}
//	if(tagme == 4)
//	{
//		aero.frame = CGRectMake(222, 410, 255, 146);
//	}
//	if(tagme == 5)
//	{
//		aero.frame = CGRectMake(250, 410, 255, 146);
//	}
//	if(tagme == 6)
//	{
//		aero.frame = CGRectMake(295, 430, 255, 146);
//	}
//	if(tagme == 7)
//	{
//		aero.frame = CGRectMake(320, 470, 255, 146);
//	}
//	if(tagme == 8)
//	{
//		aero.frame = CGRectMake(330, 510, 255, 146);
//	}
//	if(tagme == 9)
//	{
//		aero.frame = CGRectMake(325, 540, 255, 146);
//	}
	
	//buttons//
	
	btn2.frame = CGRectMake(80, 630, 100, 80);
	btn10.frame = CGRectMake(50, 520, 100, 80);
	btn12.frame = CGRectMake(80, 420, 100, 80);
	btn14.frame = CGRectMake(150, 330, 100, 80);
	btn15.frame = CGRectMake(250, 300, 100, 80);
	btn16.frame = CGRectMake(370, 290, 100, 80);
	btn17.frame = CGRectMake(470, 330, 100, 80);
	btn18.frame = CGRectMake(530, 420, 100, 80);
	btn20.frame = CGRectMake(570, 520, 100, 80);
	btn21.frame = CGRectMake(550, 630, 100, 80);
	
	
	dashBoardView.frame = self.view.frame;
	topViewImage.image = [UIImage imageNamed:@"Title-dashboards-P.png"];
	
	topViewImage.frame = CGRectMake(34, 0, 654,48);
	topViewLable.hidden = TRUE;
	topViewLable.frame = CGRectMake(290, 5, 200, 30);
	
	MSGView.image = [UIImage imageNamed:@"_0003_These-activities-give-you-the-opportunity-to-practice-the-math-.png"];
	MSGView.frame = CGRectMake(153,358,427,205);
	mainViewImage.frame = CGRectMake(34, 0, 654, 1024);
	mainViewImage.image = [UIImage imageNamed:@"Red_Layer-1.png"];
	[btnContinue setImage:[UIImage imageNamed:@"_0002_Normal-State.png"] forState:UIControlStateNormal];
	btnContinue.frame = CGRectMake(280, 610, 137, 52);
	
}
-(void)setFrameOrientation_LandScap
{
	
	mainImage.frame = CGRectMake(13, 38, 1024, 768);
	mainImage.image = [UIImage imageNamed:@"red-bg.png"];
	topImage.image = [UIImage imageNamed:@"Title-dashboards-L.png"];
	topImage.frame = CGRectMake(13, 0, 910, 48);
	labelWhite.hidden = TRUE;
	labelWhite.frame = CGRectMake(391, 40, 200, 30);
	whiteLayer.hidden = FALSE;
	whiteLayer.image = [UIImage imageNamed:@"select-chalter-L.png"];
	whiteLayer.frame = CGRectMake(13, 38, 910, 38);
	topLable.hidden = TRUE;
	topLable.frame = CGRectMake(390, 2, 250, 30);
	
	circle.frame = CGRectMake(170, 177, 603, 473);
	
	aero.image =[btnArrays objectAtIndex:tagme];
	aero.frame = CGRectMake(345, 335, 255, 146);

	
	
	//if(tagme == 0)
//	{
//		aero.frame = CGRectMake(245, 425, 255, 146);
//	}
//	if(tagme == 1)
//	{
//		aero.frame = CGRectMake(240, 400, 255, 146);
//	}
//	if(tagme == 2)
//	{
//		aero.frame = CGRectMake(255, 355, 255, 146);
//	}
//	if(tagme == 3)
//	{
//		aero.frame = CGRectMake(280, 315, 255, 146);
//	}
//	if(tagme == 4)
//	{
//		aero.frame = CGRectMake(330, 295, 255, 146);
//	}
//	if(tagme == 5)
//	{
//		aero.frame = CGRectMake(360, 295, 255, 146);
//	}
//	if(tagme == 6)
//	{
//		aero.frame = CGRectMake(405, 320, 255, 146);
//	}
//	if(tagme == 7)
//	{
//		aero.frame = CGRectMake(430, 360, 255, 146);
//	}
//	if(tagme == 8)
//	{
//		aero.frame = CGRectMake(440, 400, 255, 146);
//	}
//	if(tagme == 9)
//	{
//		aero.frame = CGRectMake(440, 430, 255, 146);
//	}
	
	//buttons //
	
	
	btn2.frame = CGRectMake(180, 510, 100, 80);
	btn10.frame = CGRectMake(150, 400, 100, 80);
	btn12.frame = CGRectMake(180, 300, 100, 80);
	btn14.frame = CGRectMake(250, 210, 100, 80);
	btn15.frame = CGRectMake(350, 180, 100, 80);
	btn16.frame = CGRectMake(470, 170, 100, 80);
	btn17.frame = CGRectMake(570, 210, 100, 80);
	btn18.frame = CGRectMake(630, 300, 100, 80);
	btn20.frame = CGRectMake(670, 400, 100, 80);
	btn21.frame = CGRectMake(650, 510, 100, 80);
	
	
	
	dashBoardView.frame = self.view.frame;
	topViewImage.image = [UIImage imageNamed:@"Title-dashboards-L.png"];
	topViewImage.frame = CGRectMake(13, 0, 910, 48);
	topViewLable.hidden = TRUE;
	topViewLable.frame = CGRectMake(390, 2, 250, 30);
	MSGView.image = [UIImage imageNamed:@"MSG.png"];
	//MSGView.frame = CGRectMake(150,281,644,138);
	mainViewImage.frame = CGRectMake(13, 38, 1024, 768);
	mainViewImage.image = [UIImage imageNamed:@"red-bg.png"];
	[btnContinue setImage:[UIImage imageNamed:@"Normal-State.png"] forState:UIControlStateNormal];
	btnContinue.frame = CGRectMake(400, 446, 137, 52);
	
	/*
	if(firstTime == TRUE)
	{
		MSGView.frame = CGRectMake(170,281,644,138);
	}
	else {
		
		if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
		   appDel.ori == UIInterfaceOrientationLandscapeRight)
		{
			MSGView.frame = CGRectMake(170,281,644,138);
		}
		if(oncePort == TRUE)
		{
			MSGView.frame = CGRectMake(150,281,644,138);
		}
		else {
			MSGView.frame = CGRectMake(170,281,644,138);
		}
		
	}
	*/
	MSGView.frame = CGRectMake(150,281,644,138);
	
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
	
	if(appDel.ori == 0)
		appDel.ori = [[UIDevice currentDevice] orientation];
	
	//UIInterfaceOrientation ori = [[UIDevice currentDevice] orientation];
	if(appDel.ori == UIInterfaceOrientationPortrait || appDel.ori == UIInterfaceOrientationPortraitUpsideDown )
	{
		
		[self setFrameOrientation_Portrait];
	}
	else if(appDel.ori == UIInterfaceOrientationLandscapeLeft || appDel.ori == UIInterfaceOrientationLandscapeRight)
	{
		
		[self setFrameOrientation_LandScap];
	}
	
}


-(IBAction)NumberTwoClicked:(id)sender
{
	tagme = [sender tag];
	aero.image =[btnArrays objectAtIndex:tagme];
	
	
	if([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight)
	{
		aero.frame = CGRectMake(345, 335, 255, 146);
	}
	
	else 
	{
		aero.frame = CGRectMake(240, 450, 255, 146);
	}
	
	[self performSelector:@selector(startTimer) withObject:nil afterDelay:0.5];
		
		
}

-(void)startTimer
{
	if(tagme == 0)
	{
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://ezto-media.mhecloud.mcgraw-hill.com/Media/Connect_Production/bne/mktg/kerin11/Market_Share/index.html"]];
		
	}
	else if(tagme== 1)
	{
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://ezto-media.mhecloud.mcgraw-hill.com/Media/Connect_Production/bne/mktg/kerin11/Product_Performance/index.html"]];
	}
	else if(tagme == 2)
	{
		
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://ezto-media.mhecloud.mcgraw-hill.com/Media/Connect_Production/bne/mktg/kerin11/Capacity_Mgmt/index.html"]];
	}
	else if(tagme== 3)
	{
		
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://ezto-media.mhecloud.mcgraw-hill.com/Media/Connect_Production/bne/mktg/kerin11/Retail_Pricing/index.html"]];
	}
	else if(tagme == 4)
	{
		
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://ezto-media.mhecloud.mcgraw-hill.com/Media/Connect_Production/bne/mktg/kerin11/Channel_Sales/index.html"]];
	}
	else if(tagme == 5)
	{
		
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://ezto-media.mhecloud.mcgraw-hill.com/Media/Connect_Production/bne/mktg/kerin11/Sales_Growth/index.html"]];
	}
	else if(tagme== 6)
	{
		
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://ezto-media.mhecloud.mcgraw-hill.com/Media/Connect_Production/bne/mktg/kerin11/IMC/index.html"]];
	}
	else if(tagme== 7)
	{
		
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://ezto-media.mhecloud.mcgraw-hill.com/Media/Connect_Production/bne/mktg/kerin11/Advertising/index.html"]];
	}
	else if(tagme == 8)
	{
		
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://ezto-media.mhecloud.mcgraw-hill.com/Media/Connect_Production/bne/mktg/kerin11/Sales_Mgmt/index.html"]];
	}
	else if(tagme == 9)
	{
		
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://ezto-media.mhecloud.mcgraw-hill.com/Media/Connect_Production/bne/mktg/kerin11/Site_Stickiness/index.html"]];
	}
	
}

-(void)HideMainView
{
	appDel.dashboadviewflag=TRUE;
	dashBoardView.hidden = TRUE;
}
-(IBAction)dashboard_view
{
	iphone_DashboardView.hidden = TRUE;
	aero.hidden = FALSE;
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}
/////
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	
	[btn2 release];
	[btn10 release];
	[btn12 release];
	[btn14 release];
	[btn15 release];
	[btn16 release];
	[btn17 release];
	[btn18 release];
	[btn20 release];
	[btn21 release];
	
	[topImage release];
	[mainImage release];
	[MainMsg release];
	[topLable release];
	[circle release];
	[aero release];
	[whiteLayer release];
	[labelWhite release];
	
	
	[dashBoardView release];
	[topViewImage release];
	[mainViewImage release];
	[MSGView release];
	[topViewLable release];
	[btnContinue release];
	
	[btnArrays release];
}


@end
