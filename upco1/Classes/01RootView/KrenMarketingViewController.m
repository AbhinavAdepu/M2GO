//
//  KrenMarketingViewController.m
//  KrenMarketing
//
//  Created by Silvertouch on 14/11/11.
//  Copyright 2011 SilverTouch Tech. Ltd. All rights reserved.
//

#import "KrenMarketingViewController.h"
#import "ZBarSymbol.h"
#import "AboutViewController.h" 
#import "DAL.h"
#import "CategorySelectViewController.h"

#define btnWidth_P 80
#define btnHeight_P 81
#define Gap_P 12
#define btnWidth_L 79
#define btnHeight_L 82 
#define Gap_L 12

@implementation KrenMarketingViewController

@synthesize dateLabel,TimeLabel,imagecamera;




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void)viewWillAppear:(BOOL)animated
{
	/*CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.transition.x"];
    CGFloat startValue = 0.0;
    CGFloat endValue = M_PI;
    rotateAnimation.fromValue = [NSNumber numberWithDouble:startValue];
    rotateAnimation.toValue = [NSNumber numberWithDouble:endValue];
    rotateAnimation.duration = 1.5;
    [self.view.layer addAnimation:rotateAnimation forKey:@"transition"];*/
	
}
- (void)viewDidLoad {
	
   [super viewDidLoad];	
	
	self.view.autoresizingMask = NO;
	linksdata=@"";
	imageQR.hidden=YES;
	imagebottombar.hidden=YES;
	BtnQRcodeText.hidden=YES;
	facebook.hidden=YES;
	twitter.hidden=YES;
	Mail.hidden=YES;
	Mail.enabled = NO;
	trash.hidden=YES;
	dateLabel.hidden=YES;
	TimeLabel.hidden=YES;
    flagmet=NO;
    flagtrav=NO;
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
   geni=[[generalcalculations alloc]init];
	
	MainmenuAppear = TRUE;
	
	ScrlTabButtn = [[UIScrollView alloc] initWithFrame:CGRectMake(60,400,200,40)];
	[self.view addSubview:ScrlTabButtn];
	
	ArrayView=[[NSMutableArray alloc]init];
	btnScan = [[UIButton alloc] init];
	btnQuiz = [[UIButton alloc] init];
	btnPrevious =[[UIButton alloc] init];
	btnTemplate =[[UIButton alloc] init];
	btnTwitter = [[UIButton alloc] init];
	btnWrite = [[UIButton alloc] init];
	btnLibrary = [[UIButton alloc] init];
	btnAbout =[[UIButton alloc] init];
	btnDashBoard=[[UIButton alloc] init];
	imageBtnBack=[[UIImageView alloc]init];
   
    //--*
    actionbut=[[UIButton alloc]init];
      [actionbut setEnabled:YES];
    flagphon=NO;
    flagcon=NO;
    flageven=NO;
	
	viewMainMenusButns = [[UIView alloc]init];
	
	UILabel *lblVersion = [[UILabel alloc]initWithFrame:CGRectMake(0,0,50,20)];
	lblVersion.text = @"";
	lblVersion.backgroundColor = [UIColor clearColor];
	lblVersion.textColor = [UIColor whiteColor];
	
	[viewMainMenusButns addSubview:imageBtnBack];
	//[self.view bringSubviewToFront:imageBtnBack];
	counter=0;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{	
		if(appDel.ori==UIInterfaceOrientationPortrait || appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
		{
			viewMainMenusButns.frame=CGRectMake(-45,0, 120, 1007);
			imageBtnBack.image=[UIImage imageNamed:@"_0014_bottombarCOLOR-copy.png"] ;
			imageBtnBack.frame=CGRectMake(0,0, 167, 1007);
			//Add Images
			
			[btnScan setImage:[UIImage imageNamed:@"Potrait__scan_Unselected.png"] forState:UIControlStateNormal];
			// add targets and actions
			[btnScan addTarget:self action:@selector(BtnScanClicked:) forControlEvents:UIControlEventTouchUpInside];
			// add to a view
			[viewMainMenusButns addSubview:btnScan];
			
			//Add Images
			[btnDashBoard setImage:[UIImage imageNamed:@"Potrait_Dashboard.png"] forState:UIControlStateNormal];
			// add targets and actions
			[btnDashBoard addTarget:self action:@selector(BtnDashBoardClicked:) forControlEvents:UIControlEventTouchUpInside];
			// add to a view
			[viewMainMenusButns addSubview:btnDashBoard];
			
			//Add Images
			[btnWrite setImage:[UIImage imageNamed:@"Potrait__Write-.png"] forState:UIControlStateNormal];
			// add targets and actions
			[btnWrite addTarget:self action:@selector(BtnWriteClicked:) forControlEvents:UIControlEventTouchUpInside];
			// add to a view
			[viewMainMenusButns addSubview:btnWrite];
			
			//Add Images
			[btnQuiz setImage:[UIImage imageNamed:@"Portrait__Quiz.png"] forState:UIControlStateNormal];
			// add targets and actions
			[btnQuiz addTarget:self action:@selector(BtnquizClicked:) forControlEvents:UIControlEventTouchUpInside];
			// add to a view
			[viewMainMenusButns addSubview:btnQuiz];
			
			//Add Images
			[btnTemplate setImage:[UIImage imageNamed:@"Portrait__Templates.png"] forState:UIControlStateNormal];
			// add targets and actions
			[btnTemplate addTarget:self action:@selector(BtnTemplateClicked:) forControlEvents:UIControlEventTouchUpInside];
			// add to a view
			[viewMainMenusButns addSubview:btnTemplate];
			
			//Add Images
			[btnTwitter setImage:[UIImage imageNamed:@"Portrait_Twitter-.png"] forState:UIControlStateNormal];		
			// add targets and actions
			[btnTwitter addTarget:self action:@selector(BtnTwitterClicked:) forControlEvents:UIControlEventTouchUpInside];
			// add to a view
			[viewMainMenusButns addSubview:btnTwitter];
			
			//Add Images
			[btnLibrary setImage:[UIImage imageNamed:@"Portrait__library.png"] forState:UIControlStateNormal];
			// add targets and actions
			[btnLibrary addTarget:self action:@selector(BtnLibraryClicked:) forControlEvents:UIControlEventTouchUpInside];
			// add to a view
			[viewMainMenusButns addSubview:btnLibrary];
			
			//Add Images
			[btnAbout setImage:[UIImage imageNamed:@"Portrait__about.png"] forState:UIControlStateNormal];
			// add targets and actions
			[btnAbout addTarget:self action:@selector(BtnAboutClicked:) forControlEvents:UIControlEventTouchUpInside];
			// add to a view
			[viewMainMenusButns addSubview:btnAbout];		  
			
		}
		else
		{
			viewMainMenusButns.frame=CGRectMake(-45,0, 120, 1007);
			imageBtnBack.image=[UIImage imageNamed:@"SideBar.png"] ;
			imageBtnBack.frame=CGRectMake(0,0, 167,789);
			imageQR.frame=CGRectMake(100, 89, 405, 290);

			//Add Images
			[btnScan setImage:[UIImage imageNamed:@"Scan_unSelected1.png"] forState:UIControlStateNormal];
			// add targets and actions
			[btnScan addTarget:self action:@selector(BtnScanClicked:) forControlEvents:UIControlEventTouchUpInside];
			// add to a view
			[viewMainMenusButns addSubview:btnScan];
			
			
			//Add Images
			[btnDashBoard setImage:[UIImage imageNamed:@"DashBoard_unSelected1.png"] forState:UIControlStateNormal];
			// add targets and actions
			[btnDashBoard addTarget:self action:@selector(BtnDashBoardClicked:) forControlEvents:UIControlEventTouchUpInside];
			// add to a view
			[viewMainMenusButns addSubview:btnDashBoard];
			
			//Add Images
			[btnWrite setImage:[UIImage imageNamed:@"Write_Unselected1.png"] forState:UIControlStateNormal];
			// add targets and actions
			[btnWrite addTarget:self action:@selector(BtnWriteClicked:) forControlEvents:UIControlEventTouchUpInside];
			// add to a view
			[viewMainMenusButns addSubview:btnWrite];
			
			//Add Images
			[btnQuiz setImage:[UIImage imageNamed:@"Quiz_Unselected1.png"] forState:UIControlStateNormal];
			// add targets and actions
			[btnQuiz addTarget:self action:@selector(BtnquizClicked:) forControlEvents:UIControlEventTouchUpInside];
			// add to a view
			[viewMainMenusButns addSubview:btnQuiz];
			
			//Add Images
			[btnTemplate setImage:[UIImage imageNamed:@"Templates_Unselected1.png"] forState:UIControlStateNormal];
			// add targets and actions
			[btnTemplate addTarget:self action:@selector(BtnTemplateClicked:) forControlEvents:UIControlEventTouchUpInside];
			// add to a view
			[viewMainMenusButns addSubview:btnTemplate];
			
			//Add Images
			[btnTwitter setImage:[UIImage imageNamed:@"Twitter_Unselected1.png"] forState:UIControlStateNormal];		
			// add targets and actions
			[btnTwitter addTarget:self action:@selector(BtnTwitterClicked:) forControlEvents:UIControlEventTouchUpInside];
			// add to a view
			[viewMainMenusButns addSubview:btnTwitter];
			
			//Add Images
			[btnLibrary setImage:[UIImage imageNamed:@"library_unselected1.png"] forState:UIControlStateNormal];
			// add targets and actions
			[btnLibrary addTarget:self action:@selector(BtnLibraryClicked:) forControlEvents:UIControlEventTouchUpInside];
			// add to a view
			[viewMainMenusButns addSubview:btnLibrary];
			
			//Add Images
			[btnAbout setImage:[UIImage imageNamed:@"about_unselected1.png"] forState:UIControlStateNormal];
			// add targets and actions
			[btnAbout addTarget:self action:@selector(BtnAboutClicked:) forControlEvents:UIControlEventTouchUpInside];
			// add to a view
			[viewMainMenusButns addSubview:btnAbout];		  
			
			
		}
		
		
		
		
		//[self.view addSubview:imageBtnBack];
		//[self.view sendSubviewToBack:imageBtnBack];
		
		[scanView addSubview:trash];
        [scanView addSubview:actionbut];
        [scanView addSubview:Scanstrshow];
        
        [scanView bringSubviewToFront:Scanstrshow];
        Scanstrshow.linkColor=[UIColor blueColor];
        Scanstrshow.hidden=YES;
        
        actionbut.titleLabel.text=@"action";
        [actionbut setImage:[UIImage imageNamed:@"WriteQR-Portrait_0005_Generate-QR-Code-BTNs.png"] forState:UIControlStateNormal];
        [actionbut addTarget:self action:@selector(actionbutmethod) forControlEvents:UIControlEventTouchUpInside];
        
        [actionbut setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        actionbut.hidden=YES;
        
		
		viewMainMenusButns.backgroundColor = [UIColor clearColor];
		[self.view addSubview:viewMainMenusButns];
		//[viewMainMenusButns addSubview:lblVersion];
		[self performSelector:@selector(addMenuwithAnimation) withObject:nil afterDelay:1.0];
		x=0;
		x_menuView = -50;
		T1 = [NSTimer scheduledTimerWithTimeInterval:0.009
										 target:self
									   selector:@selector(addMenuwithAnimation)
									   userInfo:nil
										repeats:YES];
		
		
		/*********View Animation***********/
		
		
		/*CATransition *animation = [CATransition animation];
		[animation setDuration:0.7];
		[animation setType:kCATransitionPush];
		[animation setSubtype:kCATransitionFromLeft];
		[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		
		[[viewMainMenusButns layer] addAnimation:animation forKey:@"SwitchToView1"];*/
		
		
		
			}
	else 
	{
		btnScan.frame = CGRectMake(0,5,83,78); // position in the parent view and set the size of the button
		[btnScan setBackgroundImage:[UIImage imageNamed:@"Scan_unSelected.png"] forState:UIControlStateNormal];
		// add targets and actions
		[btnScan addTarget:self action:@selector(BtnScanClicked:) forControlEvents:UIControlEventTouchUpInside];
		// add to a view
		[ScrlTabButtn addSubview:btnScan];
				
		btnDashBoard.frame = CGRectMake(50,5,83,78); // position in the parent view and set the size of the button
		[btnDashBoard setBackgroundImage:[UIImage imageNamed:@"dashBoard_unSelected.png"] forState:UIControlStateNormal];
		// add targets and actions
		[btnDashBoard addTarget:self action:@selector(BtnDashBoardClicked:) forControlEvents:UIControlEventTouchUpInside];
		// add to a view
		[ScrlTabButtn addSubview:btnDashBoard];		
		
		btnWrite.frame = CGRectMake(100,5,83, 78); // position in the parent view and set the size of the button
		[btnWrite setBackgroundImage:[UIImage imageNamed:@"Write_UnSelected.png"] forState:UIControlStateNormal];
		// add targets and actions
		[btnWrite addTarget:self action:@selector(BtnScanClicked:) forControlEvents:UIControlEventTouchUpInside];
		// add to a view
		[ScrlTabButtn addSubview:btnWrite];
		
		btnQuiz.frame = CGRectMake(150,5,83, 78); // position in the parent view and set the size of the button
		[btnQuiz setBackgroundImage:[UIImage imageNamed:@"Quiz_Selected.png"] forState:UIControlStateNormal];
		// add targets and actions
		[btnQuiz addTarget:self action:@selector(BtnquizClicked:) forControlEvents:UIControlEventTouchUpInside];
		// add to a view
		[ScrlTabButtn addSubview:btnQuiz];
		
		btnTemplate.frame = CGRectMake(200,5, 83, 78); // position in the parent view and set the size of the button
		[btnTemplate setBackgroundImage:[UIImage imageNamed:@"Templates_Selected.png"] forState:UIControlStateNormal];		
		// add targets and actions
		[btnTemplate addTarget:self action:@selector(BtnTemplateClicked:) forControlEvents:UIControlEventTouchUpInside];
		// add to a view
		[ScrlTabButtn addSubview:btnTemplate];
		
		btnTwitter.frame = CGRectMake(250,5, 50, 40); // position in the parent view and set the size of the button
		[btnTwitter setBackgroundImage:[UIImage imageNamed:@"Twitter_Selected.png"] forState:UIControlStateNormal];		
		// add targets and actions
		[btnTwitter addTarget:self action:@selector(BtnTwitterClicked:) forControlEvents:UIControlEventTouchUpInside];
		// add to a view
		[ScrlTabButtn addSubview:btnTwitter];
		
		btnLibrary.frame = CGRectMake(300,5, 50, 40); // position in the parent view and set the size of the button
		//Add Images
		[btnLibrary setBackgroundImage:[UIImage imageNamed:@"library_selected.png"] forState:UIControlStateNormal];		
		// add targets and actions
		[btnLibrary addTarget:self action:@selector(BtnLibraryClicked:) forControlEvents:UIControlEventTouchUpInside];
		// add to a view
		[ScrlTabButtn addSubview:btnLibrary];
		
		btnAbout.frame = CGRectMake(350,5, 50,40); // position in the parent view and set the size of the button
		//Add Images
		
		[btnAbout setBackgroundImage:[UIImage imageNamed:@"about_Selected.png"] forState:UIControlStateNormal];		
		// add targets and actions
		[btnAbout addTarget:self action:@selector(BtnAboutClicked:) forControlEvents:UIControlEventTouchUpInside];
		// add to a view
		[ScrlTabButtn addSubview:btnAbout];		  
	}
	[ScrlTabButtn setScrollEnabled:NO];
	ScrlTabButtn.contentSize=CGSizeMake(420,50);	
	appDel.ForBackGroundSupport=FALSE;
}
#pragma mark addMenuwithAnimation
-(void)addMenuwithAnimation
{
	fromAnimation = TRUE;
	x+=1;
	x_menuView+=1;
	if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		MainMenuView.frame = CGRectMake(x,-20,1024,768);
		viewMainMenusButns.frame=CGRectMake(x_menuView,0, 120, 1007);
	}
	else 
	{
		MainMenuView.frame = CGRectMake(x,-20,768,1024);
		viewMainMenusButns.frame=CGRectMake(x_menuView,0, 120, 1007);
	}
	if(x>=50)
	{
		viewMainMenusButns.frame=CGRectMake(0,0, 120, 1007);
		[T1 invalidate];
		T1= nil;
		//[self.view addSubview:viewMainMenusButns];
	}
}
#pragma mark URL IN BROWSER
 -(IBAction)btnScanURL:(id)sender
{
    NSRange newlineRange = [LabelQRCode.text rangeOfString:@"maps.google.co"];
    if(newlineRange.location != NSNotFound) 
    {
     // LabelQRCode.text = @"http://www.google.com/";
        
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[LabelQRCode.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
    NSRange newlineRange2 = [LabelQRCode.text rangeOfString:@"google.co"];
    if(newlineRange2.location != NSNotFound) 
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.google.com/"]];
    }
//    NSRange newlineRange1 = [LabelQRCode.text rangeOfString:@"facebook.com"];
//    if(newlineRange1.location != NSNotFound) {
//       // LabelQRCode.text = @" https://www.facebook.com/";
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/"]];
//    }
//   
    
    NSLog(@"Main Result = %@",LabelQRCode.text);
     
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[LabelQRCode.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
	
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}



#pragma mark removeViews
-(void)RemoveOlderView
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
	[trash removeFromSuperview];
	[btnScan setImage:[UIImage imageNamed:@"Scan_unSelected1.png"] forState:UIControlStateNormal];	
	[btnDashBoard setImage:[UIImage imageNamed:@"DashBoard_unSelected1.png"] forState:UIControlStateNormal];
	[btnWrite setImage:[UIImage imageNamed:@"Write_Unselected1.png"] forState:UIControlStateNormal];
	[btnQuiz setImage:[UIImage imageNamed:@"Quiz_Unselected1.png"] forState:UIControlStateNormal];
	[btnTemplate setImage:[UIImage imageNamed:@"Templates_Unselected1.png"] forState:UIControlStateNormal];
	[btnTwitter setImage:[UIImage imageNamed:@"Twitter_Unselected1.png"] forState:UIControlStateNormal];		
	[btnLibrary setImage:[UIImage imageNamed:@"library_unselected1.png"] forState:UIControlStateNormal];		
	[btnAbout setImage:[UIImage imageNamed:@"about_unselected1.png"] forState:UIControlStateNormal];		
	
	if(scanView)
	{
		imageQR.hidden = TRUE;
		imageQR.image = nil;
		
		appDel.img.hidden = TRUE;
		appDel.img.image = nil;
		dateLabel.hidden = TRUE;
          actionbut.hidden=YES;
		dateLabel.text = nil;
		TimeLabel.hidden = TRUE;
		TimeLabel.text = nil;
		LabelQRCode.hidden = TRUE;
        Scanstrshow.hidden=YES;
		LabelQRCode.text = nil;
		
		imagebottombar.hidden = YES;
		twitter.hidden = YES;
		facebook.hidden = YES;
		Mail.hidden = YES;
		Mail.enabled = NO;
		
		[scanView removeFromSuperview];
	}
	
	if([DashBoardViewController_obj retainCount] > 0)
	{
		[[NSNotificationCenter defaultCenter] removeObserver:DashBoardViewController_obj name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
		
		[DashBoardViewController_obj.view removeFromSuperview];
		[DashBoardViewController_obj release];
		DashBoardViewController_obj = nil;
	}
	if([QuizViewController_obj retainCount] > 0)
	{
		[[NSNotificationCenter defaultCenter] removeObserver:QuizViewController_obj name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
		[QuizViewController_obj.view removeFromSuperview];
		[QuizViewController_obj release];
		QuizViewController_obj = nil;
	}
	if([QRGenViewController_obj retainCount] > 0)
	{
		[[NSNotificationCenter defaultCenter] removeObserver:QRGenViewController_obj name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
		[QRGenViewController_obj.view removeFromSuperview];
		[QRGenViewController_obj release];
        QRGenViewController_obj = nil;
	}
	if([LibraryViewController retainCount] > 0)
	{
		[[NSNotificationCenter defaultCenter] removeObserver:LibraryViewController_obj name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
		[LibraryViewController_obj.view removeFromSuperview];
		[LibraryViewController_obj release];
		LibraryViewController_obj = nil;
	}
	if([TwitterViewController_obj retainCount] > 0)
	{
		[[NSNotificationCenter defaultCenter] removeObserver:TwitterViewController_obj name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
		[TwitterViewController_obj.view removeFromSuperview];
		[TwitterViewController_obj release];
        TwitterViewController_obj = nil;
	}
	if([AboutViewController_obj retainCount] > 0)
	{
		[[NSNotificationCenter defaultCenter] removeObserver:AboutViewController_obj name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
		[AboutViewController_obj.view removeFromSuperview];
		[AboutViewController_obj release];
		AboutViewController_obj = nil;
	}
	if([TemplateViewController_obj retainCount] > 0)
	{
		[[NSNotificationCenter defaultCenter] removeObserver:TemplateViewController_obj name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
		[TemplateViewController_obj.view removeFromSuperview];
		[TemplateViewController_obj release];
		TemplateViewController_obj = nil;
		
	}
	
	
}

/*-(void)RemoveOlderView
{
	[trash removeFromSuperview];
	[btnScan setImage:[UIImage imageNamed:@"Scan_unSelected.png"] forState:UIControlStateNormal];	
	[btnDashBoard setImage:[UIImage imageNamed:@"DashBoard_unSelected.png"] forState:UIControlStateNormal];
	[btnWrite setImage:[UIImage imageNamed:@"Write_Unselected.png"] forState:UIControlStateNormal];
	[btnQuiz setImage:[UIImage imageNamed:@"Quiz_Unselected.png"] forState:UIControlStateNormal];
	[btnTemplate setImage:[UIImage imageNamed:@"Templates_Unselected.png"] forState:UIControlStateNormal];
	[btnTwitter setImage:[UIImage imageNamed:@"Twitter_Unselected.png"] forState:UIControlStateNormal];		
	[btnLibrary setImage:[UIImage imageNamed:@"library_unselected.png"] forState:UIControlStateNormal];		
	[btnAbout setImage:[UIImage imageNamed:@"about_unselected.png"] forState:UIControlStateNormal];		

	if(scanView)
	{
		imageQR.hidden = TRUE;
		imageQR.image = nil;
		
		appDel.img.hidden = TRUE;
		appDel.img.image = nil;
		dateLabel.hidden = TRUE;
   actionbut.hidden=YES;
		dateLabel.text = nil;
		TimeLabel.hidden = TRUE;
		TimeLabel.text = nil;
		LabelQRCode.hidden = TRUE;
		LabelQRCode.text = nil;
		
		imagebottombar.hidden = YES;
		twitter.hidden = YES;
		facebook.hidden = YES;
		Mail.hidden = YES;
		Mail.enabled = NO;
		
		[scanView removeFromSuperview];
	}
	if([DashBoardViewController_obj retainCount] > 0)
	{
		[DashBoardViewController_obj.view removeFromSuperview];
		[DashBoardViewController_obj release];
		DashBoardViewController_obj = nil;
	}
	if([QuizViewController_obj retainCount] > 0)
	{
		[QuizViewController_obj.view removeFromSuperview];
		[QuizViewController_obj release];
		QuizViewController_obj = nil;
	}
	if([QRGenViewController_obj retainCount] > 0)
	{
		[QRGenViewController_obj.view removeFromSuperview];
		[QRGenViewController_obj release];
        QRGenViewController_obj = nil;
	}
	if([LibraryViewController retainCount] > 0)
	{
		[LibraryViewController_obj.view removeFromSuperview];
		[LibraryViewController_obj release];
		LibraryViewController_obj = nil;
	}
	if([TwitterViewController_obj retainCount] > 0)
	{
		[TwitterViewController_obj.view removeFromSuperview];
		[TwitterViewController_obj release];
        TwitterViewController_obj = nil;
	}
	if([AboutViewController_obj retainCount] > 0)
	{
		[AboutViewController_obj.view removeFromSuperview];
		[AboutViewController_obj release];
		AboutViewController_obj = nil;
	}
	
}*/


#pragma mark BtnClickEvent



-(IBAction)BtnScanClicked:(id)sender{
	appDel.ForBackGroundSupport=FALSE;
	[self btnQRCodePressed:nil];
	[self RemoveOlderView];
	
	LBlHeading.text = @"Scan";
	
	if(Photosel == TRUE)
		lblIntroImage.hidden = YES;
	else
		lblIntroImage.hidden = NO;
	flag = TRUE;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		if([QRScanViewController_obj retainCount] > 0)
		{
			
		}
		else {			
			if(appDel.ori==UIInterfaceOrientationPortrait || appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
			{	
				//Photosel=FALSE;
				//AlbumSel=FALSE;
				
				[btnPhotoAlbum setImage:[UIImage imageNamed:@"UN_PhotoAlbum.png"] forState:UIControlStateNormal];
				[btnCamera setImage:[UIImage imageNamed:@"UNSEL__Camera.png"] forState:UIControlStateNormal];
			
				
				imagebottombar.image=[UIImage imageNamed:@"WriteQR-Portrait_0007_top-red-band.png"];
				[btnScan setImage:[UIImage imageNamed:@"Scan_Selected.png"] forState:UIControlStateNormal];
				TopRed.image=[UIImage imageNamed:@"_0009_top-red-band.png"];

				//btnScan.frame = CGRectMake(18, Gap_P, btnWidth_P, btnHeight_P); // position in the parent view and set the size of the button
				
				scanView.frame = CGRectMake(btnWidth_P, 0, 1024-btnWidth_P-10, 1007);
			    btnCamera.frame=CGRectMake(34,(1007)-41,327,40);
			    btnPhotoAlbum.frame=CGRectMake(327+34, (1007)-41,327, 40);
				TopRed.frame=CGRectMake(0,0,768,48);
				
				if(flag == TRUE)
				{
					flag = FALSE;
					imageQR.frame=CGRectMake(100, 89, 405, 290);
				}
				else {
					imageQR.frame=CGRectMake(50, 89, 405, 290);
				}

				facebook.frame=CGRectMake(190, 1024-124,80,81);
				twitter.frame=CGRectMake(100+(90*2),1024-124, 80,81);
				Mail.frame=CGRectMake(100+(90*3),1024-124, 80,81);
				trash.frame=CGRectMake(100+(90*4),1024-124, 80,81);
			
				imagebottombar.frame=CGRectMake(0,1024-114,910, 64);
				btnBack.frame=CGRectMake(45,7,22,27);
				LBlHeading.frame=CGRectMake(320,4,200,30);
				dateLabel.frame=CGRectMake(510,86,292,25);
				TimeLabel.frame=CGRectMake(510,107,100,25);
			}
			
		
			else{
				//Photosel=FALSE;
				//AlbumSel=FALSE;
				
				imagebottombar.image=[UIImage imageNamed:@"WriteQR-Portrait_0007_top-red-band.png"];

				[btnPhotoAlbum setImage:[UIImage imageNamed:@"cmr (3).png"] forState:UIControlStateNormal];
				[btnCamera setImage:[UIImage imageNamed:@"camera_selected.png"] forState:UIControlStateNormal];
				TopRed.image=[UIImage imageNamed:@"_0006_top-red-band910.png"];

				//btnScan.frame = CGRectMake(18, Gap_L, btnWidth_L, btnHeight_L); // position in the parent view and set the size of the button
				[btnScan setImage:[UIImage imageNamed:@"Scan_Selected.png"] forState:UIControlStateNormal];
				btnBack.frame=CGRectMake(21,7,22,27);
				scanView.frame = CGRectMake(114, 0, 1024-btnWidth_L-20, 1007);
				btnCamera.frame=CGRectMake(0,768-57, 453, 37);
				btnPhotoAlbum.frame=CGRectMake(453,768-57, 457, 37);
				TopRed.frame=CGRectMake(0,0,1004,48);
				imageQR.frame=CGRectMake(50, 89, 405, 290);
				imagebottombar.frame=CGRectMake(0, 768-108,910, 64);
				
				facebook.frame=CGRectMake(269, 768-104, 42, 44);
				twitter.frame=CGRectMake(269+105, 768-104, 42, 44);
				Mail.frame=CGRectMake(269+(105*2), 768-104, 42, 44);
				trash.frame=CGRectMake(269+(105*3), 768-104, 42, 44);
				
				
				LBlHeading.frame=CGRectMake(410,2,250,30);
				dateLabel.frame=CGRectMake(464,86,292,25);
				TimeLabel.frame=CGRectMake(464,107,100,25);

			}
			
			[self.view addSubview:scanView];
			
			
						[self.view bringSubviewToFront:viewMainMenusButns];
 			
			}				
	   }else{         //IPHONE
		
	   }		

}
-(IBAction)BtnDashBoardClicked:(id)sender{
	appDel.ForBackGroundSupport=TRUE;
	[self btnQRCodePressed:nil];
	[self RemoveOlderView];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		if([DashBoardViewController_obj retainCount] > 0)
		{
			
		}
		else {
			DashBoardViewController_obj=[[DashBoardViewController alloc] initWithNibName:@"DashBoardViewController_ipad" bundle:nil];
			nav_Dash = [[UINavigationController alloc]initWithRootViewController:DashBoardViewController_obj];
			if(appDel.ori == UIInterfaceOrientationPortrait || appDel.ori == UIInterfaceOrientationPortraitUpsideDown){
				[btnDashBoard setImage:[UIImage imageNamed:@"dashBoard_Selected1.png"] forState:UIControlStateNormal];
				nav_Dash.view.frame = CGRectMake(btnWidth_P, 0, 768-btnWidth_P, 1024);
			}else{
				[btnDashBoard setImage:[UIImage imageNamed:@"dashBoard_Selected1.png"] forState:UIControlStateNormal];
				nav_Dash.view.frame = CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L, 1007);
			}//nav_Dash.navigationBar.tintColor = [UIColor redColor];
			nav_Dash.navigationBarHidden = TRUE;
			//nav_Dash.navigationController.navigationItem.title = @"DashBoard";
			[self.view addSubview:nav_Dash.view];
			[self.view bringSubviewToFront:viewMainMenusButns];
			
			//[self.view sendSubviewToBack:nav_Dash.view];

		}
		
		
	}else{//iphone
			}
	
}

-(IBAction)BtnWriteClicked:(id)sender{
	appDel.ForBackGroundSupport=FALSE;
	[self btnQRCodePressed:nil];
	[self RemoveOlderView];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		QRGenViewController_obj=[[QRGenViewController alloc] initWithNibName:@"QRGenViewController_ipad" bundle:nil];
		nav_Write = [[UINavigationController alloc]initWithRootViewController:QRGenViewController_obj];
		nav_Write.navigationBar.hidden=YES;
		if(appDel.ori == UIInterfaceOrientationPortrait || appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
		{
			[btnWrite setImage:[UIImage imageNamed:@"Write_Selected.png"] forState:UIControlStateNormal];
			nav_Write.view.frame = CGRectMake(btnWidth_P, 0, 768-btnWidth_P, 1024);
			
		}else
		{	[btnWrite setImage:[UIImage imageNamed:@"Write_Selected.png"] forState:UIControlStateNormal];
			nav_Write.view.frame = CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L, 1007);
		}
		
		[self.view addSubview:nav_Write.view];
		[self.view bringSubviewToFront:viewMainMenusButns];
		
	}else{    //IPHONE
	}
	
	
}
//Developer : Deval Chauhan
//Date : 03/12/2011
//Change for : Template module implementation.
//Status : Changes start
//To Revert : Remove Line between starting and ending comment	
-(IBAction)BtnTemplateClicked:(id)sender{
	appDel.ForBackGroundSupport=FALSE;
	[self btnQRCodePressed:nil];
	[self RemoveOlderView];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{	
		TemplateViewController_obj=[[TemplateViewController alloc] initWithNibName:@"TemplateViewController_ipad" bundle:nil];
		nav_Template = [[UINavigationController alloc]initWithRootViewController:TemplateViewController_obj];
		if(appDel.ori == UIInterfaceOrientationPortrait || appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
		{	[btnTemplate setImage:[UIImage imageNamed:@"Templates_Selected1.png"] forState:UIControlStateNormal];
			nav_Template.view.frame = CGRectMake(btnWidth_P, 0, 768-btnWidth_P, 1024);
		}else
		{	[btnTemplate setImage:[UIImage imageNamed:@"Templates_Selected1.png"] forState:UIControlStateNormal];
			nav_Template.view.frame = CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L, 1007);
		}
		nav_Template.navigationBarHidden = TRUE;
		[self.view addSubview:nav_Template.view];		
		[self.view bringSubviewToFront:viewMainMenusButns];
		
	}else{ //iphone
	}
}
//Developer : Deval Chauhan
//Date : 03/12/2011
//Change for : Template module implementation.
//Status : Changes end
-(IBAction)BtnTwitterClicked:(id)sender{
	appDel.ForBackGroundSupport=FALSE;
	[self btnQRCodePressed:nil];
	[self RemoveOlderView];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{	
		TwitterViewController_obj=[[TwitterViewController alloc] initWithNibName:@"TwitterViewController_ipad" bundle:nil];
		nav_Twitter = [[UINavigationController alloc]initWithRootViewController:TwitterViewController_obj];
		if(appDel.ori == UIInterfaceOrientationPortrait || appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
		{	[btnTwitter setImage:[UIImage imageNamed:@"Twitter_Selected.png"] forState:UIControlStateNormal];
			nav_Twitter.view.frame = CGRectMake(btnWidth_P, 0, 768-btnWidth_P, 1024);
		}else
		{	[btnTwitter setImage:[UIImage imageNamed:@"Twitter_Selected.png"] forState:UIControlStateNormal];

			nav_Twitter.view.frame = CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L, 1007);
		}
		
	/*	nav_Twitter.navigationBarHidden = TRUE;
		[self.view addSubview:nav_Twitter.view];
		[self.view sendSubviewToBack:nav_Twitter.view];
		*/
		nav_Twitter.navigationBarHidden = TRUE;
		[self.view addSubview:nav_Twitter.view];		
		[self.view bringSubviewToFront:viewMainMenusButns];		

	}else{    //IPHONE
	}
	
	
	
}
-(IBAction)BtnLibraryClicked:(id)sender{
	appDel.ForBackGroundSupport=FALSE;
	[self btnQRCodePressed:nil];
	[self RemoveOlderView];
	
	NSString *strQuery = @"SELECT *FROM library";
	appDel.array_catagory = [DAL ExecuteArraySet:strQuery];
	/*
	if([appDel.array_catagory count] == 0)
	{
		UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please select the QRCode you want to share" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
	}
	else 
	{
	 */
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
			LibraryViewController_obj=[[LibraryViewController alloc] initWithNibName:@"LibraryViewController_ipad" bundle:nil];
			nav_Lib = [[UINavigationController alloc]initWithRootViewController:LibraryViewController_obj];
			if(appDel.ori == UIInterfaceOrientationPortrait || appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
			{	[btnLibrary setImage:[UIImage imageNamed:@"library_selected1.png"] forState:UIControlStateNormal];
				
				nav_Lib.view.frame = CGRectMake(btnWidth_P, 0, 768-btnWidth_P, 1024);
			}else
			{	[btnLibrary setImage:[UIImage imageNamed:@"library_selected1.png"] forState:UIControlStateNormal];
				
				
				nav_Lib.view.frame = CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L, 1007);
			}//nav_Dash.navigationBar.tintColor = [UIColor redColor];
			nav_Lib.navigationBarHidden = TRUE;
			//nav_Dash.navigationController.navigationItem.title = @"DashBoard";

			[self.view addSubview:nav_Lib.view];		
			[self.view bringSubviewToFront:viewMainMenusButns];
			
		}
		
	
		
}
-(IBAction)BtnAboutClicked:(id)sender{
	appDel.ForBackGroundSupport=FALSE;
	[self btnQRCodePressed:nil];
		[self RemoveOlderView];

	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{	
		AboutViewController_obj=[[AboutViewController alloc] initWithNibName:@"AboutViewController_ipad" bundle:nil];
		nav_About = [[UINavigationController alloc]initWithRootViewController:AboutViewController_obj];
		if(appDel.ori == UIInterfaceOrientationPortrait || appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
		{	[btnAbout setImage:[UIImage imageNamed:@"about_selected.png"] forState:UIControlStateNormal];
			nav_About.view.frame = CGRectMake(btnWidth_P, 0, 768-btnWidth_P, 1024);
		}else
		{	[btnAbout setImage:[UIImage imageNamed:@"about_selected.png"] forState:UIControlStateNormal];
			nav_About.view.frame = CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L, 1007);

		}
		nav_About.navigationBarHidden = TRUE;
		[self.view addSubview:nav_About.view];		
		[self.view bringSubviewToFront:viewMainMenusButns];

		
	}else{ //iphone
	}
	
}
-(IBAction)BtnquizClicked:(id)sender{
	appDel.ForBackGroundSupport=FALSE;
	[self btnQRCodePressed:nil];
	[self RemoveOlderView];

	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		QuizViewController_obj=[[QuizViewController alloc] initWithNibName:@"QuizViewController_ipad" bundle:nil];
		nav_Quiz = [[UINavigationController alloc]initWithRootViewController:QuizViewController_obj];
		if(appDel.ori == UIInterfaceOrientationPortrait || appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
		{[btnQuiz setImage:[UIImage imageNamed:@"Quiz_Selected.png"] forState:UIControlStateNormal];
			nav_Quiz.view.frame = CGRectMake(btnWidth_P, 0, 768-btnWidth_P, 1024);
		}else{
			[btnQuiz setImage:[UIImage imageNamed:@"Quiz_Selected.png"] forState:UIControlStateNormal];
			nav_Quiz.view.frame = CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L, 1007);
		}
		nav_Quiz.navigationBarHidden = TRUE;
		[self.view addSubview:nav_Quiz.view];		
		[self.view bringSubviewToFront:viewMainMenusButns];

	}else{
	}	
}

-(IBAction)btnQRCodePressed:(id)sender
{
	MainmenuAppear = FALSE;
	[MainMenuView removeFromSuperview];
	//[self BtnScanClicked:nil];
}
/*-(void)selectcategory:(UIImage *)img
{
	//CategorySelectViewController  *cat= [[CategorySelectViewController alloc] initWithNibName:@"CategorySelectViewController" bundle:nil];	
	//	
	//	[self presentModalViewController:cat animated:TRUE];
	
	
	
	CategorySelectViewController *dwBookView = [[CategorySelectViewController alloc]initWithNibName:@"CategorySelectViewController" bundle:nil];
	dwBookView.img = img;
    dwBookView.modalPresentationStyle=UIModalPresentationFormSheet;
    [self presentModalViewController:dwBookView animated:NO];
    dwBookView.view.superview.autoresizingMask = 
    UIViewAutoresizingFlexibleTopMargin | 
    UIViewAutoresizingFlexibleBottomMargin;    
    dwBookView.view.superview.frame = CGRectMake(
                                                 dwBookView.view.superview.frame.origin.x,
                                                 dwBookView.view.superview.frame.origin.y,
                                                 300.0f,
                                                 300.0f
                                                 );
    //dwBookView.view.superview.center = self.view.center;
    
	dwBookView.view.superview.center = CGPointMake(440, 500);
	
    //	[self presentModalViewController:dwBookView animated:YES];
    //[self presentModalViewController:nav animated:YES];
    [dwBookView release];
	
	
}*/

-(void)selectcategory:(UIImage *)img
{
	
	CategorySelectViewController *dwBookView = [[CategorySelectViewController alloc]initWithNibName:@"CategorySelectViewController" bundle:nil];
	 dwBookView.img = img;
	 dwBookView.modalPresentationStyle=UIModalPresentationFormSheet;
	 [self presentModalViewController:dwBookView animated:NO];
	 dwBookView.view.superview.autoresizingMask = 
	 UIViewAutoresizingFlexibleTopMargin | 
	 UIViewAutoresizingFlexibleBottomMargin;    
	 dwBookView.view.superview.frame = CGRectMake(
	 dwBookView.view.superview.frame.origin.x,
	 dwBookView.view.superview.frame.origin.y,
	 00.0f,
	 00.0f
	 );
	 dwBookView.view.superview.center = CGPointMake(440, 500);
	 [dwBookView release];
	
	/*glbImage = img;
	
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Save QR Code to Library"
												   message:@"Do you want to save this QR Code to the Library?" 
												  delegate:self 
										 cancelButtonTitle:@"Save"
										 otherButtonTitles:@"Don't Save",nil];
	
	[alert show];
	[alert release];*/
	
}



#pragma mark Save n delete QRCode
-(IBAction)Trash_click:(id)sender
{
	//[scanView removeFromSuperview];
	LBlHeading.text = @"Scan";
	//NSString *sql = [NSString stringWithFormat:@"select *from library"];
//	NSMutableArray *array=[DAL ExecuteArraySet:sql];
//
//	
//	NSString  *sql1 =[NSString stringWithFormat:@"delete from library where Image = '%@' ",[NSString stringWithFormat:@"qr%d.png",[array count]]];
//	[DAL ExecuteArraySet:sql1];
//	
//	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString *documentsDirectory = [paths objectAtIndex:0];
//	NSString * pdfname = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"qr%d.png",[array count]]];	
//	[[NSFileManager defaultManager] removeItemAtPath:pdfname error:nil];
//
	
	NSString *sql = [NSString stringWithFormat:@"select Image from library where Image =(SELECT MAX(Image) from library)"];
    NSLog(@"sql:%@",sql);
	NSMutableArray *array=[DAL ExecuteArraySet:sql];
    NSLog(@"array %@",array);
    if([array count]!=0)
    {
	NSString  *sql1 =[NSString stringWithFormat:@"delete from library where Image = '%@' ",[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"Image"]]];
	
	[DAL ExecuteArraySet:sql1];
   
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString * pdfname = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"Image"]]];	
	[[NSFileManager defaultManager] removeItemAtPath:pdfname error:nil];
    }
	
	
	imageQR.hidden = TRUE;
	imageQR.image = nil;
	
	appDel.img.hidden = TRUE;
	appDel.img.image = nil;
	dateLabel.hidden = TRUE;
      actionbut.hidden=YES;
	dateLabel.text = nil;
	TimeLabel.hidden = TRUE;
	TimeLabel.text = nil;
	LabelQRCode.hidden = TRUE;
    Scanstrshow.hidden=YES;
	LabelQRCode.text = nil;
	
	imagebottombar.hidden = YES;
	twitter.hidden = YES;
	facebook.hidden = YES;
	Mail.hidden = YES;
	Mail.enabled = NO;
	[trash removeFromSuperview];
	
}
-(void)actionbutmethod
{
    NSLog(@"into action butr method");
    flagmet=YES;
    [self saveQrCode:imageQR.image];
    
}


-(void)saveQrCode:(UIImage *)img
{
	
	
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];

	//NSString *sql = [NSString stringWithFormat:@"select *from library"];
//	NSMutableArray *array=[DAL ExecuteArraySet:sql];
	
	UIImage *newImage;
	
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MM-dd-yyyy-HH-mm-ss"];
	NSString * date = [dateFormatter stringFromDate:[NSDate date]];
	
	if(appDel.img.image)
		newImage = appDel.img.image;
	else
		newImage = GImage;
		
	newImage = img;

	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString* path = [documentsDirectory stringByAppendingPathComponent: 
						 [NSString stringWithFormat:@"qr%@.png",date]];
	NSData* data = UIImagePNGRepresentation(newImage);
	[data writeToFile:path atomically:YES];
	
	//NSString  *sql =[NSString stringWithFormat:@"Insert into library(CreatedDate, Image, Category,Description,starting_Date,Ending_Date,Address,Links,Email,Locations) Values('%@', '%@', '%@', '%@', '%@','%@','%@','%@','%@','%@')",appDel.QRScanDate,strImage,@"QRText",appDel.QRScanText,@"No Data",@"No Data",@"No Data",@"No Data",@"No Data",@"No Data"];
	//NSString  *sql2 =[NSString stringWithFormat:@"Insert into library(CreatedDate, Image, Category,Description,starting_Date,Ending_Date,Address,Links,Email,Locations) Values('%@', '%@', '%@', '%@', '%@','%@','%@','%@','%@','%@')",@"september",strImage,@"QRText",@"No Data",@"No Data",@"No Data",@"No Data",@"No Data",@"No Data",@"No Data"];
	
	//NSString *sql = [NSString stringWithFormat:@"Insert into library(Image,CreatedDate,Category,Description,starting_Date,Ending_Date,Address,Links,Email,Locations) Values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",@"september",@"1.png",@"QRText",@"Nothing",@"Nothing",@"Nothing",@"Nothing",@"Nothing",@"Nothing",@"Nothing"];
	
	//[WebPubDB insert_library_CreatedDate:@"september" Image:@"1.png" Category:@"Event" Description:@"Amrit" starting_Date:@"oct" Ending_Date:@"Nov" Address:@"Ahmedabad" Links:@"google" Email:@"google" Locations:@"Vadodara"];
	NSLog(@"%@",appDel.catString);
	
	
	if([appDel.catString isEqualToString:@"Event"])
		appDel.catString = @"Event";
	if([appDel.catString isEqualToString:@"Map Location"])
		appDel.catString = @"Map Location ";
	if([appDel.catString isEqualToString:@"Phone"])
		appDel.catString = @"Phone";
	if([appDel.catString isEqualToString:@"SMS"])
		appDel.catString = @"SMS";
	if([appDel.catString isEqualToString:@"Contact"])
		appDel.catString = @"Contact";
	if([appDel.catString isEqualToString:@"Text"])
		appDel.catString = @"Text";
	if([appDel.catString isEqualToString:@"Email"])
		appDel.catString = @"Email";
	appDel.QRScanText=[appDel.QRScanText stringByReplacingOccurrencesOfString:@"BEGIN:VCARD" withString:@""];
    appDel.QRScanText=[appDel.QRScanText stringByReplacingOccurrencesOfString:@"END:VCARD" withString:@""];
    
    
    appDel.QRScanText=[appDel.QRScanText stringByReplacingOccurrencesOfString:@"BEGIN:VCALENDAR" withString:@""];
    appDel.QRScanText=[appDel.QRScanText stringByReplacingOccurrencesOfString:@"END:VCALENDAR" withString:@""];
    appDel.QRScanText=[appDel.QRScanText stringByReplacingOccurrencesOfString:@"Start Date & Time" withString:@"Start Date & Time:"];
    appDel.QRScanText=[appDel.QRScanText stringByReplacingOccurrencesOfString:@"End Date & Time" withString:@"End Date & Time:"];
    appDel.QRScanText=[appDel.QRScanText stringByReplacingOccurrencesOfString:@"Start Date & Time::" withString:@"Start Date & Time:"];
    appDel.QRScanText=[appDel.QRScanText stringByReplacingOccurrencesOfString:@"End Date & Time::" withString:@"End Date & Time:"];
    
    NSString *tempstr=appDel.QRScanText;
    NSLog(@"inserting string::%@",tempstr);
    
    if([appDel.catString isEqualToString:@"Contact"] || [appDel.catString isEqualToString:@"Event"] || [appDel.catString isEqualToString:@"Phone"] )
    {
//	[DAL insert_library_CreatedDate:appDel.QRScanDate Image:[NSString stringWithFormat:@"qr%@.png",date]  Category:appDel.catString Description:appDel.QRScanText starting_Date:@"" Ending_Date:@"" Address:@"" Links:@"" Email:@"" Locations:@"" Message:@"" Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:@"" Notes:@""];
	NSDictionary *keyval;
    NSMutableArray *keysdata=[[NSMutableArray alloc]initWithCapacity:1];
    NSMutableArray *valuedata=[[NSMutableArray alloc]initWithCapacity:1];
        NSString *add_temp; 
         NSString *loc_temp; 
        NSString *redundantphoneno;
        redundantphoneno=@"";
        
    int rot=0;
        NSLog(@"tempstr:%@",tempstr);
    NSArray *words = [tempstr componentsSeparatedByString:@"\n"];
  //  NSLog(@"count:%d",[words count]);
    
    for(int i=0;i<[words count];i++)
    {
       // NSLog(@"str:%@",[words objectAtIndex:i]);
        if(![[words objectAtIndex:i] isEqualToString:@""])
        {
        NSArray *divwords=[[words objectAtIndex:i] componentsSeparatedByString:@":"];
            NSLog(@"%@",divwords);           
            if([divwords count]==2)
            {
            [keysdata addObject:[divwords objectAtIndex:0]];
            
                
                if([[divwords objectAtIndex:0] isEqualToString:@"Start Date & Time"] || [[divwords objectAtIndex:0] isEqualToString:@"End Date & Time"])
                {
                    
                    
                    if ([[divwords objectAtIndex:1] rangeOfString:@"/"].location != NSNotFound)
                    { 
                        [valuedata addObject:[divwords objectAtIndex:1]];
                    }
                    else {
                        NSLog(@"into els part of date");
                        NSString *rawdate=[divwords objectAtIndex:1];
                        rawdate=[rawdate stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                        [valuedata addObject:[self strdate:rawdate]];                    }
                    
                    
                    
                    
                }
                else {
                    [valuedata addObject:[divwords objectAtIndex:1]];
                }

            
           // keyval=[NSDictionary dictionaryWithObject:valuedata forKey:keysdata];
            }
         if([divwords count]==1)
            {
                [keysdata addObject:@"D"];
                [valuedata addObject:[divwords objectAtIndex:0]]; 
            }
            if([divwords count]==3)
            {
                if([[divwords objectAtIndex:0] isEqualToString:@"Start Date & Time"])
                {
                    [keysdata addObject:[divwords objectAtIndex:0]];
                    
                    
                    
                    
                    
                    if([[divwords objectAtIndex:1] length]>0 && [[divwords objectAtIndex:2] length]>0)
                    {
                        [valuedata addObject:[[divwords objectAtIndex:1] stringByAppendingFormat:@":%@",[divwords objectAtIndex:2]]]; 
                        
                    }
                    if([[divwords objectAtIndex:1] length]>0 && [[divwords objectAtIndex:2] length]<=0)
                    {
                        [valuedata addObject:[divwords objectAtIndex:1]];
                        
                    }
                    
                }
            }
            if([divwords count]==3)
            {
                if([[divwords objectAtIndex:0] isEqualToString:@"End Date & Time"])
                {
                    [keysdata addObject:[divwords objectAtIndex:0]];
                    
                    if([[divwords objectAtIndex:1] length]>0 && [[divwords objectAtIndex:2] length]>0)
                    {
                        [valuedata addObject:[[divwords objectAtIndex:1] stringByAppendingFormat:@":%@",[divwords objectAtIndex:2]]]; 
                        
                    }
                    if([[divwords objectAtIndex:1] length]>0 && [[divwords objectAtIndex:2] length]<=0)
                    {
                        [valuedata addObject:[divwords objectAtIndex:1]];
                        
                    }
                    
                }
            }
            

            
            
            
            rot++;
            divwords =nil;
        }
        
       
        
    }
    keyval=[NSDictionary dictionaryWithObjects:valuedata forKeys:keysdata];
NSLog(@"dictonaydata:%@",[keyval description]);
     
    
    
    
    //string1 = [string1 stringByAppendingString:string2]
        add_temp=@"";
        if([appDel.catString isEqualToString:@"Event"])
        {
            if([[keyval objectForKey:@"Street Address"] length]>0)
            {
                add_temp=[add_temp stringByAppendingFormat:@"%@ ",[keyval objectForKey:@"Street Address"]];
            }
            if([[keyval objectForKey:@"City"] length]>0)
            {
                add_temp=[add_temp stringByAppendingFormat:@"%@ ",[keyval objectForKey:@"City"]];      
            }
            if([[keyval objectForKey:@"State"] length]>0)
            {
                add_temp=[add_temp stringByAppendingFormat:@"%@ ",[keyval objectForKey:@"State"]];      
            }
            if([[keyval objectForKey:@"Zip Code"] length]>0)
            {
                add_temp=[add_temp stringByAppendingFormat:@"%@ ",[keyval objectForKey:@"Zip Code"]];      
            }
            if([[keyval objectForKey:@"Country"] length]>0)
            {
                add_temp=[add_temp stringByAppendingFormat:@"%@ ",[keyval objectForKey:@"Country"]];      
            }
            if([[keyval objectForKey:@"LOCATION"] length]>0)
            {
                add_temp=[add_temp stringByAppendingFormat:@"%@ ",[keyval objectForKey:@"LOCATION"]];      
            }

           
            
       // add_temp=[[[[[keyval objectForKey:@"Street Address"] stringByAppendingString:[keyval objectForKey:@"City"]] stringByAppendingString:[keyval objectForKey:@"State"]] stringByAppendingString:[keyval objectForKey:@"Zip Code"]] stringByAppendingString:[keyval objectForKey:@"Country"]] ;
            
            //add_temp=[add_temp stringByAppendingString:[keyval objectForKey:@"LOCATION"]];   
        }
        else {
        add_temp=@"";
        }
      
        
              
      //  loc_temp=(([[keyval objectForKey:@"CELL"] length]<=0)?(([[keyval objectForKey:@"VOICE"] length]<=0)?(([[keyval objectForKey:@"TEL"] length]==0)?[keyval objectForKey:@"PhoneNumber"]:[keyval objectForKey:@"TEL"]):([keyval objectForKey:@"VOICE"])):[keyval objectForKey:@"CELL"]);
    
    /*    if(loc_temp==NULL || loc_temp == @"")
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert!"
                                                           message:@"Details are missing! Contact can't be saved to Library!" 
                                                          delegate:self 
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles:nil];
            alert.tag=151;
            [alert show];
            [alert release];

        }pulgon,wartha(dist)
        else {
     */      NSString *temsavdes;
        if([appDel.catString isEqualToString:@"Event"])
        {
            temsavdes=[keyval objectForKey:@"Event"];
        }
        else {
            
            
            temsavdes=([[keyval objectForKey:@"FN"] length]>0)?([keyval objectForKey:@"FN"]):([[keyval objectForKey:@"N"] length]>0)?[keyval objectForKey:@"N"]:@"";
             //temsavdes=([[keyval objectForKey:@"N"] length]<=0)?([keyval objectForKey:@"Name"]):(([[keyval objectForKey:@"D"] length]<=0)?([keyval objectForKey:@"N"]):([[keyval objectForKey:@"N"] stringByAppendingFormat:@" %@",[keyval objectForKey:@"D"]]));
          /*  if([appDel.catString isEqualToString:@"Contact"])
            {
            
            if([[keyval objectForKey:@"FN"] length]<=0)
            {
            
            }else
            {
                temsavdes=[keyval objectForKey:@"FN"];
            }
            }*/
            
        }
       
        
        
        redundantphoneno=(([[keyval objectForKey:@"CELL"] length]<=0)?(([[keyval objectForKey:@"VOICE"] length]<=0)?(([[keyval objectForKey:@"TEL"] length]==0)?[keyval objectForKey:@"PhoneNumber"]:[keyval objectForKey:@"TEL"]):([keyval objectForKey:@"VOICE"])):[keyval objectForKey:@"CELL"]);
              
        if([appDel.catString isEqualToString:@"Phone"])
        {
            temsavdes=redundantphoneno;
        }
        
       temsavdes=[temsavdes stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
       
        if(!flagmet)
        {
        
        
    [DAL insert_library_CreatedDate:appDel.QRScanDate
                              Image:[NSString stringWithFormat:@"qr%@.png",date] 
                           Category:appDel.catString
                        Description:temsavdes 
                      starting_Date:[keyval objectForKey:@"Start Date & Time"]
                        Ending_Date:[keyval objectForKey:@"End Date & Time"]
                            Address:add_temp 
                              Links:@"" 
                              Email:[keyval objectForKey:@"Email"] 
                          Locations:@"" 
                            Message:[keyval objectForKey:@"Message"] 
                         Department:([[keyval objectForKey:@"ORG"] length]<=0)?[keyval objectForKey:@"Department"]:[keyval objectForKey:@"ORG"]
                                Job:([[keyval objectForKey:@"TITLE"] length]<=0)?[keyval objectForKey:@"JobTitle"]:[keyval objectForKey:@"TITLE"]
                             Suffix:[keyval objectForKey:@"Suffix"] 
                         MiddleName:[keyval objectForKey:@"Middle"] 
                           LastName:[keyval objectForKey:@"PhoneticLastName"]
                          FirstName:[keyval objectForKey:@"PhoneticFirstName"]
                             Prefix:[keyval objectForKey:@"Prefix"] 
                            PhoneNo:(([[keyval objectForKey:@"CELL"] length]<=0)?(([[keyval objectForKey:@"VOICE"] length]<=0)?(([[keyval objectForKey:@"TEL"] length]==0)?[keyval objectForKey:@"PhoneNumber"]:[keyval objectForKey:@"TEL"]):([keyval objectForKey:@"VOICE"])):[keyval objectForKey:@"CELL"])
                            Subject:@"" 
                              Notes:([[keyval objectForKey:@"Notes"] length]<=0)?[keyval objectForKey:@"DESCRIPTION"]:[keyval objectForKey:@"Notes"]
     ];	
      //  } 
            NSLog(@"saving to db");
        }
        else {
            NSLog(@"from clicked method");
            flagmet=NO;
            
            //forcntact and phone
            if([appDel.catString isEqualToString:@"Contact"])
            {
                if([appDel.catString isEqualToString:@"Contact"] && [temsavdes length]>0 && [redundantphoneno length]>0&& flagcon)
                {
                    flagcon=NO;
                    [actionbut setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
                    [actionbut setEnabled:NO];
                    NSLog(@"saving vontact to contact book");
                    NSLog(@"name:%@-Phon:%@",temsavdes,redundantphoneno);
                    
                    ABAddressBookRef addressBook = ABAddressBookCreate();
                    ABRecordRef person = ABPersonCreate();
                    ABRecordSetValue(person, kABPersonFirstNameProperty, temsavdes, nil);
                     ABMutableMultiValueRef phoneNumberMultiValue = ABMultiValueCreateMutable(kABPersonPhoneProperty);
                     ABMultiValueAddValueAndLabel(phoneNumberMultiValue, redundantphoneno, kABHomeLabel, nil);
                    ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumberMultiValue, nil);
                    ABAddressBookAddRecord(addressBook, person, nil);
                    ABAddressBookSave(addressBook, nil);
                    
                      CFRelease(person);
                     CFRelease(phoneNumberMultiValue);
                    
                    
                    UIAlertView *alertviewcon=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Contact Added successfully!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alertviewcon show];
                    [alertviewcon release];


                    
                }
                
                
                
                
            }
            
            if([appDel.catString isEqualToString:@"Phone"])
            {
 
            if([appDel.catString isEqualToString:@"Phone"] && [appDel.QRScanText length]>0 && flagphon && [temsavdes length]>0)
            {
                flagphon=NO;
                [actionbut setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
                [actionbut setEnabled:NO];
                NSLog(@"phone to contact book");
                ABAddressBookRef addressBook = ABAddressBookCreate();
                ABRecordRef person = ABPersonCreate();
                ABMutableMultiValueRef phoneNumberMultiValue = ABMultiValueCreateMutable(kABPersonPhoneProperty);
                ABMultiValueAddValueAndLabel(phoneNumberMultiValue,temsavdes, kABHomeLabel, nil);
                ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumberMultiValue, nil);
                ABAddressBookAddRecord(addressBook, person, nil);
                ABAddressBookSave(addressBook, nil);
                
                CFRelease(person);
                //  CFRelease(addressMultiValue);
                CFRelease(phoneNumberMultiValue);
                
                UIAlertView *alertviewcon=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Contact Added successfully!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alertviewcon show];
                [alertviewcon release];

                
                
                
                
            }
            }

            
            
            
        if([appDel.catString isEqualToString:@"Event"])
        {
            if([appDel.catString isEqualToString:@"Event"] && flageven && [temsavdes length] > 0 && [[keyval objectForKey:@"Start Date & Time"] length] > 0 && [[keyval objectForKey:@"End Date & Time"] length] > 0)
            {
                NSLog(@"%@,%@",[keyval objectForKey:@"Start Date & Time"],[keyval objectForKey:@"End Date & Time"]);
                
                flageven=NO;
                [actionbut setImage:[UIImage imageNamed:@"inactivecalender.png"] forState:UIControlStateNormal];
                [actionbut setEnabled:NO];
                NSLog(@"saving Event to calemder");
                EKEventStore *eventStore = [[EKEventStore alloc] init];
                
                EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                
                temsavdes=[temsavdes stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                event.title=temsavdes;
                
                               
                
                NSString *stdate=[keyval objectForKey:@"Start Date & Time"];
                
                stdate=[stdate substringFromIndex:4];
                
                NSString *endate=[keyval objectForKey:@"End Date & Time"] ;
                
                endate=[endate substringFromIndex:4];
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"M/d/y h:mm a";
                
                NSDate *date = [formatter dateFromString:stdate];
                
                NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
                formatter1.dateFormat = @"M/d/y h:mm a";
                
                NSDate *date1 = [formatter dateFromString:endate];
                event.startDate = date;
                event.endDate = date1;
                event.location=add_temp;
                event.notes=([[keyval objectForKey:@"Notes"] length]<=0)?[keyval objectForKey:@"DESCRIPTION"]:[keyval objectForKey:@"Notes"];
              
                [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                NSError *err;
                
                [eventStore saveEvent:event span:EKSpanThisEvent error:&err]; 
                if(!err)
                {
                    
                    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:event.title message:@"Event Added successfully!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alertview show];
                    [alertview release];
                    
                }
                else {
                    NSLog(@"error is %@",err);  
                }

                
                
               
            }
            else {
             /*   UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Alert!" 
                                                                  message:@"iCloud services are not enabled on this device, so Event can't be added!" 
                                                                 delegate:nil 
                                                        cancelButtonTitle:@"OK" 
                                                        otherButtonTitles:nil];
                
                [message show];
                [message release];*/
                [actionbut setImage:[UIImage imageNamed:@"inactivecalender.png"] forState:UIControlStateNormal];
                [actionbut setEnabled:NO];
            }
            
            
            
            
        }
            
            
        }
        
    }
    else {
        
        if(!flagmet)
        {
            if([appDel.catString isEqualToString:@"SMS"])
            {
                NSLog(@"into sms");
                NSString *tmpsms=appDel.QRScanText;
                NSLog(@"temsms-%@",tmpsms);
              tmpsms=  [tmpsms stringByReplacingOccurrencesOfString:@"From:" withString:@""];
                NSArray *words = [tmpsms componentsSeparatedByString:@":"];
                NSString *despho=@"";
                NSString *mess=@"";
                if([words count]==1)
                {
                    if([[words objectAtIndex:0] length]>0)
                        despho=[words objectAtIndex:0];
                }
              if([words count]==2)
              {
                  if([[words objectAtIndex:0] length]>0)
                      despho=[words objectAtIndex:0];
                  if([[words objectAtIndex:1] length]>0)
                      mess=[words objectAtIndex:1];
              }
                if([words count]>2)
                {
                    if([[words objectAtIndex:0] length]>0)
                        despho=[words objectAtIndex:0];
                
                    
                    NSLog(@"length >[words count]");
                    for(int i=1;i<[words count];i++)
                    {
                       mess= [mess stringByAppendingFormat:@"%@",[words objectAtIndex:i]];
                    }
                }
           
                NSLog(@"temp phon:%@",despho);

                NSLog(@"temp msg:%@",mess);
                [DAL insert_library_CreatedDate:appDel.QRScanDate Image:[NSString stringWithFormat:@"qr%@.png",date]  Category:appDel.catString Description:despho starting_Date:@"" Ending_Date:@"" Address:@"" Links:@"" Email:@"" Locations:@"" Message:mess Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:@"" Notes:@""];
                NSLog(@"saving sms to db");

                
            }
            else if([appDel.catString isEqualToString:@"Email"])
            {
            
                NSLog(@"into email");
                NSString *tmpemail=appDel.QRScanText;
                tmpemail=[tmpemail stringByReplacingOccurrencesOfString:@"?" withString:@";"];
                tmpemail=[tmpemail stringByReplacingOccurrencesOfString:@"&" withString:@";"];
                 tmpemail=[tmpemail stringByReplacingOccurrencesOfString:@"=" withString:@":"];
                 tmpemail=[tmpemail stringByReplacingOccurrencesOfString:@"\n" withString:@";"];
                 NSArray *words = [tmpemail componentsSeparatedByString:@";"];
                NSDictionary *keyval;
                NSMutableArray *keysdata=[[NSMutableArray alloc]initWithCapacity:1];
                NSMutableArray *valuedata=[[NSMutableArray alloc]initWithCapacity:1];
                
                
                for(int i=0;i<[words count];i++)
                {
                    if(![[words objectAtIndex:i] isEqualToString:@""])
                    {
                      NSArray *divwords=[[words objectAtIndex:i] componentsSeparatedByString:@":"]; 
                        
                        if([divwords count]==2)
                        {
                            
                            [keysdata addObject:[divwords objectAtIndex:0]];
                            
                            [valuedata addObject:[divwords objectAtIndex:1]];

                        }
                        
                    }
                    
                    
                }
                keyval=[NSDictionary dictionaryWithObjects:valuedata forKeys:keysdata];
                NSLog(@"%@",keyval);

                [DAL insert_library_CreatedDate:appDel.QRScanDate Image:[NSString stringWithFormat:@"qr%@.png",date]  Category:appDel.catString Description:[[keyval objectForKey:@"from"] length]>0?[keyval objectForKey:@"from"]:[[keyval objectForKey:@"From"] length]>0?[keyval objectForKey:@"From"]:[[keyval objectForKey:@"FROM"] length]>0?[keyval objectForKey:@"FROM"]:@"" starting_Date:@"" Ending_Date:@"" Address:@"" Links:@"" Email:@"" Locations:@"" Message:[[keyval objectForKey:@"body"] length]>0?[keyval objectForKey:@"body"]:[[keyval objectForKey:@"BODY"] length]>0?[keyval objectForKey:@"BODY"]:[[keyval objectForKey:@"Body"] length]>0?[keyval objectForKey:@"Body"]:@""  Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:[[keyval objectForKey:@"SUBJECT"] length]>0?[keyval objectForKey:@"SUBJECT"]:[[keyval objectForKey:@"SUB"] length]>0?[keyval objectForKey:@"SUB"]:[[keyval objectForKey:@"subject"] length]>0?[keyval objectForKey:@"subject"]:[[keyval objectForKey:@"sub"] length]>0?[keyval objectForKey:@"sub"]:@"" Notes:@""];
                NSLog(@"saving to db");
                
                
                
                
            
            }
            else if([appDel.catString isEqualToString:@"Map Location"] || [appDel.catString isEqualToString:@"Map Location "])
            {

                NSString *tmpDatastr;
                tmpDatastr=appDel.QRScanText;
                
                NSLog(@"into maplocation");
                
                NSLog(@"srr in map loc:%@",appDel.QRScanText);
                //  NSArray *words=[tmpDatastr componentsSeparatedByString:@"\n"];
                tmpDatastr=[tmpDatastr stringByReplacingOccurrencesOfString:@";" withString:@"\n"];
                tmpDatastr=[tmpDatastr stringByReplacingOccurrencesOfString:@"Map URL:" withString:@""];
                NSArray *words=[tmpDatastr componentsSeparatedByString:@"\n"];
                
                NSLog(@"%@",words);
                NSDictionary *keyval;
                NSMutableArray *keysdata=[[NSMutableArray alloc]initWithCapacity:1];
                NSMutableArray *valuedata=[[NSMutableArray alloc]initWithCapacity:1];
                
                for(int i=0;i<[words count];i++)
                {
                    if(![[words objectAtIndex:i] isEqualToString:@""])
                    {
                        NSArray *divwords=[[words objectAtIndex:i] componentsSeparatedByString:@":"]; 
                        
                        if([divwords count]==2)
                        {
                            
                            if([[divwords objectAtIndex:0] isEqualToString:@"http"])
                            {
                                [keysdata addObject:@"Map URL"];
                                [valuedata addObject:[NSString stringWithFormat:@"%@:%@",[divwords objectAtIndex:0],[divwords objectAtIndex:1]]];
                            }
                            else
                            {
                                [keysdata addObject:[divwords objectAtIndex:0]];
                                
                                [valuedata addObject:[divwords objectAtIndex:1]];
                                
                            }
                            
                            
                        }
                        
                    }
                    
                    
                }
                keyval=[NSDictionary dictionaryWithObjects:valuedata forKeys:keysdata];   
                
                 [DAL insert_library_CreatedDate:appDel.QRScanDate Image:[NSString stringWithFormat:@"qr%@.png",date]  Category:appDel.catString Description:([[keyval objectForKey:@"Map URL"] length]>0)?[keyval objectForKey:@"Map URL"]:@""  starting_Date:@"" Ending_Date:@"" Address:@"" Links:([[keyval objectForKey:@"Notes"] length]>0)?[keyval objectForKey:@"Notes"]:@""  Email:@"" Locations:@"" Message:@"" Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:@"" Notes:@""];
                
                
            }
            
            
            else {
                [DAL insert_library_CreatedDate:appDel.QRScanDate Image:[NSString stringWithFormat:@"qr%@.png",date]  Category:appDel.catString Description:appDel.QRScanText starting_Date:@"" Ending_Date:@"" Address:@"" Links:@"" Email:@"" Locations:@"" Message:@"" Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:@"" Notes:@""];
                NSLog(@"saving to db");

            }
           }
        else {
            NSLog(@"from clicked method");
            flagmet=NO;
                       
        }
    }
    
	//[DAL insert_library_CreatedDate:appDel.QRScanDate Image: [NSString stringWithFormat:@"qr%d.png",[array count]+1] Category:@"QREvents" Description:appDel.QRScanText starting_Date:@"NODATA" Ending_Date:@"NODATA" Address:@"NODATA" Links:@"NODATA" Email:@"NODATA" Locations:@"NODATA"];
	
	
	//NSString *sql = [NSString stringWithFormat:@"select *from library"];
	//NSMutableArray *array1=[DAL ExecuteArraySet:sql];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView tag] == 151)
    {
    }
}

#pragma mark TIME & DATE
-(void)TimeandDate{
	//Date
	NSDate* date = [NSDate date];
	NSDateFormatter *Date1=[[[NSDateFormatter alloc] init] autorelease];
//	[Date1 setDateFormat:@"yyyyMMdd"];
//	[Date1 setDateFormat:@"MMM dd, yyyy"];

	[Date1 setDateFormat:@"E MM/dd/yy"];
	
	
	NSString *Date12=[Date1 stringFromDate:date];	
	NSLog(@"Date: %@", Date12);
	//Time
	NSDateFormatter *Time1=[[[NSDateFormatter alloc] init] autorelease];
	//[Time1 setDateFormat:@"yyyyMMdd"];
	//[Time1 setDateFormat:@"HH:MM aaa"];
	[Time1 setDateFormat:@"h:MM aa"];
	NSString *Time12=[Time1 stringFromDate:date];
	//Time12 = [Time12 stringByReplacingOccurrencesOfString:@"PM" withString:@"P.M."];
	//Time12 = [Time12 stringByReplacingOccurrencesOfString:@"AM" withString:@"A.M."];
	
	
		NSLog(@"Date: %@",Time12);
	
	
	Date12 = [NSString stringWithFormat:@"Scanned on %@",Date12];
	//Date12 = @"Scanned on %@",Date12];
	//Time12 = [Time12 stringByAppendingFormat:@"%@ P.M.",Time12];
	
	[dateLabel setText:Date12];
	[TimeLabel setText:Time12];
	/*	
NSDate* date = [NSDate date];

//Create the dateformatter object

NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];

//Set the required date format

[formatter setDateFormat:@"yyyy-MM-dd HH:MM:SS"];

//Get the string date

NSString* str = [formatter stringFromDate:date];

//Display on the console

NSLog(@"%@",str);

//Set in the lable
*/
//[dateLabel setText:str];

}
#pragma mark orientation
- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) orient
                                 duration: (NSTimeInterval) duration
{
    // compensate for view rotation so camera preview is not rotated
    [readerView willRotateToInterfaceOrientation: orient
                                        duration: duration];
}
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
 	//jayna
	appDel.ori = interfaceOrientation;
	//AlbumSel = FALSE;
	[popReader dismissPopoverAnimated:NO];	
	


	if(interfaceOrientation == UIInterfaceOrientationPortrait ||
	   interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
	{
		[MainMenuView removeFromSuperview];
		if(MainmenuAppear == TRUE)
		{
			
			//MainMenuView.frame = CGRectMake(0,0,768,1024);
			if(fromAnimation==TRUE)
				MainMenuView.frame = CGRectMake(50,-20,768,1024);
			else
				MainMenuView.frame = CGRectMake(0,-20,768,1024);
			mainImageView.image = [UIImage imageNamed:@"Default.png"];
			mainImageView.frame = CGRectMake(0,0,768,1024);
			[self.view addSubview:MainMenuView];
			[self.view sendSubviewToBack:MainMenuView];			
			//[self btnQRCodePressed:nil];
		}
		
		//153,358,427,205
		lblIntroText.frame=CGRectMake(80,275,550,205);
		lblIntroImage.frame=CGRectMake(45,420,624,68);

		//lblIntroText.frame=CGRectMake(109,275,500,96);

		btnBack.frame=CGRectMake(45,7,22,27);
		imageBtnBack.image=[UIImage imageNamed:@"_0014_bottombarCOLOR-copy.png"] ;
		imagebottombar.image=[UIImage imageNamed:@"WriteQR-Portrait_0007_top-red-band.png"];
		TopRed.image= [UIImage imageNamed:@"_0009_top-red-band.png"];
		
		if (Photosel==TRUE) {
			[btnPhotoAlbum setImage:[UIImage imageNamed:@"UN_PhotoAlbum.png"] forState:UIControlStateNormal];
			[btnCamera setImage:[UIImage imageNamed:@"SEL_Camera.png"] forState:UIControlStateNormal];
			
		}else if (AlbumSel==TRUE) {
			[btnPhotoAlbum setImage:[UIImage imageNamed:@"SEL_PHOTOAlbum.png"] forState:UIControlStateNormal];
			[btnCamera setImage:[UIImage imageNamed:@"UNSEL__Camera.png"] forState:UIControlStateNormal];
			
		}else{
			[btnPhotoAlbum setImage:[UIImage imageNamed:@"UN_PhotoAlbum.png"] forState:UIControlStateNormal];
			[btnCamera setImage:[UIImage imageNamed:@"UNSEL__Camera.png"] forState:UIControlStateNormal];
			
		}
		
		
		imageQR.frame=CGRectMake(100, 89, 405, 290);
		LBlHeading.frame=CGRectMake(320,4,200,30);
		
		/*******/
		if([LabelQRCode.text length] > 0)
		{
			LabelQRCode.frame=CGRectMake(90, 383,580,60);
            Scanstrshow.frame=CGRectMake(90, 393,580,60);
			
			CGSize maximumLabelSize = CGSizeMake(580,9999);
			
			//CGSize expectedLabelSize = [LabelQRCode.text sizeWithFont:LabelQRCode.font constrainedToSize:maximumLabelSize lineBreakMode:LabelQRCode.lineBreakMode];
			CGSize expectedLabelSize = [LabelQRCode.text sizeWithFont:LabelQRCode.font constrainedToSize:maximumLabelSize];
			
			CGRect newFrame = LabelQRCode.frame;
			
			if(expectedLabelSize.height > 487)
				newFrame.size.height = 487;
			else if(expectedLabelSize.height <= 30)
				newFrame.size.height = 32;
			else
            {
				newFrame.size.height = expectedLabelSize.height+10;
              //  newFrame.size.height = 487;
            }
        
			
			LabelQRCode.frame = newFrame;
           Scanstrshow.frame=newFrame;
		}
		
		/*********/
		
		BtnQRcodeText.frame=CGRectMake(90, 360,350,60);
		//[BtnQRcodeText setTitle:@"Jayna" forState:UIControlStateNormal];
		BtnQRcodeText.backgroundColor = [UIColor clearColor];
		BtnQRcodeText.contentEdgeInsets = UIEdgeInsetsMake(0,-300,0,0);
		[LabelQRCode bringSubviewToFront:BtnQRcodeText];
        
		dateLabel.frame=CGRectMake(510,86,292,25);
		TimeLabel.frame=CGRectMake(510,107,100,25);		
		
		imageBtnBack.frame=CGRectMake(0,0,167, 1007);
		scanView.frame = CGRectMake(btnWidth_P, 0, 1024-btnWidth_P-10, 1007);
		nav_Dash.view.frame = CGRectMake(btnWidth_P, 0, 945, 1024);
		nav_Quiz.view.frame = CGRectMake(btnWidth_P, 0,  945, 1024);
		nav_Lib.view.frame = CGRectMake(btnWidth_P, 0,  945, 1024);
		nav_About.view.frame = CGRectMake(btnWidth_P, 0,  945, 1024);
		nav_Write.view.frame = CGRectMake(btnWidth_P, 0, 945, 1024);
		nav_Twitter.view.frame=CGRectMake(btnWidth_P, 0,  945, 1024);
		nav_Template.view.frame = CGRectMake(btnWidth_P, 0,  945, 1024);
	
		// Frame for Button in QRSCan
		btnCamera.frame=CGRectMake(34,(1007)-41,327,40);
		btnPhotoAlbum.frame=CGRectMake(327+34, (1007)-41,327, 40);

		TopRed.frame=CGRectMake(0,0,768,48);
		
		imagebottombar.frame=CGRectMake(0,1024-109,910, 64);

			
		facebook.frame=CGRectMake(190, 1024-124,80,81);
		twitter.frame=CGRectMake(100+(90*2),1024-124, 80,81);
		Mail.frame=CGRectMake(100+(90*3),1024-124, 80,81);
		trash.frame=CGRectMake(100+(90*4),1024-124, 80,81);
        
        CGSize titleSize = [LabelQRCode.text sizeWithFont:LabelQRCode.font constrainedToSize:CGSizeMake(580,9999) lineBreakMode: UILineBreakModeCharacterWrap];
        
        NSLog(@"ycord:%f",LabelQRCode.frame.origin.y);
        NSLog(@"titlesize:%f",titleSize.height);
        
        actionbut.frame=CGRectMake(LabelQRCode.frame.origin.x+10, LabelQRCode.frame.origin.y+titleSize.height+5, 130, 70);
        
        
      //  actionbut.frame=CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
        
		
		NSLog(@"frame==%f =%f",nav_QR.view.frame.size.width,nav_QR.view.frame.size.height);
	//	int y = Gap_P;
		btnScan.frame = CGRectMake(18, 12,81, btnHeight_P); // position in the parent view and set the size of the button
		
		//y += btnHeight_P+Gap_P;
		btnDashBoard.frame = CGRectMake(18, 135, btnWidth_P, btnHeight_P); // position in the parent view and set the size of the button
		
		//y += btnHeight_P+Gap_P;
		btnWrite.frame = CGRectMake(18, 268, btnWidth_P, btnHeight_P); // position in the parent view and set the size of the button
		
		//y += btnHeight_P+Gap_P;
		btnQuiz.frame = CGRectMake(18, 398, btnWidth_P, btnHeight_P); // position in the parent view and set the size of the button
		
		//y += btnHeight_P+Gap_P;
		btnTemplate.frame = CGRectMake(18,525, btnWidth_P, btnHeight_P); // position in the parent view and set the size of the button
		
		//y += btnHeight_P+Gap_P;
		btnTwitter.frame = CGRectMake(18,657, btnWidth_P, btnHeight_P); // position in the parent view and set the size of the button
		
		//y += btnHeight_P+Gap_P;
		btnLibrary.frame = CGRectMake(18,788, btnWidth_P, btnHeight_P); // position in the parent view and set the size of the button
		
		//y += btnHeight_P+Gap_P;
		btnAbout.frame = CGRectMake(18,913, btnWidth_P, btnHeight_P); // position in the parent view and set the size of the button
			
		///readerView.camera
		return YES;
	}
	else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation== UIInterfaceOrientationLandscapeRight)
	{ 
		
		
		if(appDel.fromTwitter == FALSE)
		{
			imagebottombar.image=[UIImage imageNamed:@"WriteQR-Portrait_0007_top-red-band.png"];
			[MainMenuView removeFromSuperview];
			if(MainmenuAppear == TRUE)
			{
				//MainMenuView.frame = CGRectMake(0,0,768,1024);
				if(fromAnimation==TRUE)
					MainMenuView.frame = CGRectMake(50,-20,1024,768);
				else
					MainMenuView.frame = CGRectMake(0,-20,1024,768);
				mainImageView.image = [UIImage imageNamed:@"Default-Landscape.png"];
				mainImageView.frame = CGRectMake(0,0,1024,768);
				[self.view addSubview:MainMenuView];
				[self.view sendSubviewToBack:MainMenuView];
				//[self btnQRCodePressed:nil];
			}
			
			if (Photosel==TRUE) {
				[btnPhotoAlbum setImage:[UIImage imageNamed:@"cmr (3).png"] forState:UIControlStateNormal];
				[btnCamera setImage:[UIImage imageNamed:@"cmr (1).png"] forState:UIControlStateNormal];
				
			}else if (AlbumSel==TRUE) {
				[btnPhotoAlbum setImage:[UIImage imageNamed:@"cmr (2).png"] forState:UIControlStateNormal];
				[btnCamera setImage:[UIImage imageNamed:@"camera_selected.png"] forState:UIControlStateNormal];		
				
			}else{
				[btnPhotoAlbum setImage:[UIImage imageNamed:@"cmr (3).png"] forState:UIControlStateNormal];
				[btnCamera setImage:[UIImage imageNamed:@"camera_selected.png"] forState:UIControlStateNormal];
				
			}
		}
			lblIntroText.frame=CGRectMake(190,200,540,96);
			lblIntroImage.frame=CGRectMake(140,320,624,68);
			TopRed.image=[UIImage imageNamed:@"_0006_top-red-band910.png"];
			
			btnBack.frame=CGRectMake(21,7,22,27);
			imageBtnBack.image=[UIImage imageNamed:@"SideBar.png"] ;
			imageBtnBack.frame=CGRectMake(0,0, 167,789);
			scanView.frame = CGRectMake(114, 0, 1024-btnWidth_L-20, 1007);
			
			//nav_Dash.view.frame = CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L-20, 1007);
			nav_Dash.view.frame = CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L, 1007);
		
			nav_Quiz.view.frame = CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L-20, 1007);
			nav_About.view.frame =CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L-20, 1007);
			
			//nav_Write.view.frame =CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L-20, 1007);
			nav_Write.view.frame = CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L, 1007);
			
			nav_Twitter.view.frame = CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L, 1007);
			//
			nav_Twitter.view.frame = CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L, 1007);
			
			nav_Lib.view.frame = CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L, 1007);
			//nav_Lib.view.frame = CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L-20, 1007);	
			
			nav_Template.view.frame = CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L, 1007);
			//nav_Template.view.frame =CGRectMake(btnWidth_L+22, 0, 1024-btnWidth_L-20, 1007);
			
			imageQR.frame=CGRectMake(40, 89, 405, 290);
			LBlHeading.frame=CGRectMake(430,2,250,30);
			dateLabel.frame=CGRectMake(464,86,292,25);
			TimeLabel.frame=CGRectMake(464,107,100,25);
			
			// Frame for Button in QRSCan
			//LabelQRCode.frame=CGRectMake(60, 214,600,60);
			
			/*******/
			if([LabelQRCode.text length] > 0)
			{
				LabelQRCode.frame=CGRectMake(30, 383,870,60);
                Scanstrshow.frame=CGRectMake(30, 393,870,60);
				
				CGSize maximumLabelSize = CGSizeMake(870,9999);
				
				//CGSize expectedLabelSize = [LabelQRCode.text sizeWithFont:LabelQRCode.font constrainedToSize:maximumLabelSize lineBreakMode:LabelQRCode.lineBreakMode];
				CGSize expectedLabelSize = [LabelQRCode.text sizeWithFont:LabelQRCode.font constrainedToSize:maximumLabelSize];
				
				CGRect newFrame = LabelQRCode.frame;
				if(expectedLabelSize.height > 220)
					newFrame.size.height = 220;
				else if(expectedLabelSize.height <= 30)
					newFrame.size.height = 32;
				else
					newFrame.size.height = expectedLabelSize.height+10;
				LabelQRCode.frame = newFrame;
               Scanstrshow.frame=newFrame;
                
              				
			}
			/*********/
			BtnQRcodeText.frame=CGRectMake(50, 360,350,60);
			//[BtnQRcodeText setTitle:@"Jayna" forState:UIControlStateNormal];
			BtnQRcodeText.backgroundColor = [UIColor clearColor];
			BtnQRcodeText.contentEdgeInsets = UIEdgeInsetsMake(0, -268, 0, 0);
			
			btnCamera.frame=CGRectMake(0,768-57, 453, 37);
			btnPhotoAlbum.frame=CGRectMake(453,768-57, 457, 37);
			
			imagebottombar.frame=CGRectMake(0, 768-108,910, 64);
			
			facebook.frame=CGRectMake(269, 768-104, 42, 44);
			twitter.frame=CGRectMake(269+105, 768-104, 42, 44);
			Mail.frame=CGRectMake(269+(105*2), 768-104, 42, 44);
			trash.frame=CGRectMake(269+(105*3), 768-104, 42, 44);
			
        
        CGSize titleSize = [LabelQRCode.text sizeWithFont:LabelQRCode.font constrainedToSize:CGSizeMake(580,9999) lineBreakMode: UILineBreakModeCharacterWrap];
        
               
        actionbut.frame=CGRectMake(LabelQRCode.frame.origin.x+10, LabelQRCode.frame.origin.y+LabelQRCode.frame.size.height, 130, 70);

        
		
			TopRed.frame=CGRectMake(0,0,1004,48);
			int y = Gap_L;
			btnScan.frame = CGRectMake(18, y, btnWidth_L, btnHeight_L); // position in the parent view and set the size of the button
			
			y += btnHeight_L+Gap_L;
			btnDashBoard.frame = CGRectMake(18, y, btnWidth_L, btnHeight_L); // position in the parent view and set the size of the button
			
			y += btnHeight_L+Gap_L;
			btnWrite.frame = CGRectMake(18, y, btnWidth_L, btnHeight_L); // position in the parent view and set the size of the button
			
			y += btnHeight_L+Gap_L;
			btnQuiz.frame = CGRectMake(18, y, btnWidth_L, btnHeight_L); // position in the parent view and set the size of the button
			
			y += btnHeight_L+Gap_L;
			btnTemplate.frame = CGRectMake(18, y, btnWidth_L, btnHeight_L); // position in the parent view and set the size of the button
			
			y += btnHeight_L+Gap_L;
			btnTwitter.frame = CGRectMake(18, y, btnWidth_L, btnHeight_L); // position in the parent view and set the size of the button
			
			y += btnHeight_L+Gap_L;
			btnLibrary.frame = CGRectMake(18, y, btnWidth_L, btnHeight_L); // position in the parent view and set the size of the button
			
			y += btnHeight_L+Gap_L;
			btnAbout.frame = CGRectMake(18, y, btnWidth_L, btnHeight_L); // position in the parent view and set the size of the button
			
			
			[facebook setEnabled:TRUE];
			
			
			return YES;
		}
	
}

#pragma mark CameraOpen
-(IBAction) getPhoto_Album:(id) sender
{	
	

	if(imageQR.hidden == TRUE)
		lblIntroImage.hidden = NO;
	else {
		lblIntroImage.hidden = YES;
	}

	
	Photosel=FALSE;
	AlbumSel=TRUE;
	LBlHeading.text = @"Scan";
	readerView.hidden=YES;
	[self initReader: @"ZBarReaderController"];
	[self updateCropMask];
	
    picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	if(appDel.ori==UIInterfaceOrientationPortrait || appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		[btnPhotoAlbum setImage:[UIImage imageNamed:@"SEL_PHOTOAlbum.png"] forState:UIControlStateNormal];
		[btnCamera setImage:[UIImage imageNamed:@"UNSEL__Camera.png"] forState:UIControlStateNormal];
		
	}else{
		[btnPhotoAlbum setImage:[UIImage imageNamed:@"cmr (2).png"] forState:UIControlStateNormal];
		[btnCamera setImage:[UIImage imageNamed:@"camera_selected.png"] forState:UIControlStateNormal];		
	}
	if((UIButton *) sender == btnPhotoAlbum) {
		
		if([reader respondsToSelector: @selector(readerView)]) {
			reader.readerView.showsFPS = YES;
			if(zoom)
				reader.readerView.zoom = zoom;
			reader.supportedOrientationsMask = (reader.showsZBarControls)
            ? ZBarOrientationMaskAll
            : ZBarOrientationMask(UIInterfaceOrientationPortrait); // tmp disable
		}
		reader.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		if(reader.sourceType == UIImagePickerControllerSourceTypeCamera)
			reader.cameraOverlayView = (reader.showsZBarControls) ? nil : overlay;
		manualBtn.enabled = TARGET_IPHONE_SIMULATOR ||
        (reader.cameraMode == ZBarReaderControllerCameraModeDefault) ||
        [reader isKindOfClass: [ZBarReaderViewController class]];
		reader.showsHelpOnFail = NO;
	//	[self presentModalViewController:reader animated:YES];
		CGRect choosePhotoRect = CGRectMake(0,00,850,1024);
		popReader = [[UIPopoverController alloc]initWithContentViewController:reader];
		 [popReader presentPopoverFromRect:choosePhotoRect inView:btnPhotoAlbum permittedArrowDirections: UIPopoverArrowDirectionAny animated:YES];
	} else {
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	}
}
//-(IBAction) getPhoto:(id) sender {
//	
//	
//	[self initReader: @"ZBarReaderController"];
//	[self updateCropMask];
//	if(appDel.ori==UIInterfaceOrientationPortrait || appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
//	{
//		[btnPhotoAlbum setImage:[UIImage imageNamed:@"Potrait_Album_Unselected.png"] forState:UIControlStateNormal];
//		[btnCamera setImage:[UIImage imageNamed:@"Potrait__Camera.png"] forState:UIControlStateNormal];
//		
//	}else{
//		[btnPhotoAlbum setImage:[UIImage imageNamed:@"cmr (2).png"] forState:UIControlStateNormal];
//		[btnCamera setImage:[UIImage imageNamed:@"cmr.png"] forState:UIControlStateNormal];
//	}
//	
//	UIImagePickerController * picker = [[UIImagePickerController alloc] init];
//	picker.delegate = self;
//	
//	if((UIButton *) sender == btnCamera) {
//		
//		
//		
//		
//		if([reader respondsToSelector: @selector(readerView)]) {
//			reader.readerView.showsFPS = YES;
//			if(zoom)
//				reader.readerView.zoom = zoom;
//			reader.supportedOrientationsMask = (reader.showsZBarControls)
//            ? ZBarOrientationMaskAll
//            : ZBarOrientationMask(UIInterfaceOrientationPortrait); // tmp disable
//		}
//		//reader.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//		if(reader.sourceType == UIImagePickerControllerSourceTypeCamera)
//			reader.cameraOverlayView = (reader.showsZBarControls) ? nil : overlay;
//		manualBtn.enabled = TARGET_IPHONE_SIMULATOR ||
//        (reader.cameraMode == ZBarReaderControllerCameraModeDefault) ||
//        [reader isKindOfClass: [ZBarReaderViewController class]];
//		
//		[self presentModalViewController:reader animated:YES];
//		/*CGRect choosePhotoRect = CGRectMake(80,200,850,1024);
//		UIPopoverController *popReader = [[UIPopoverController alloc]initWithContentViewController:reader];
//		[popReader presentPopoverFromRect:choosePhotoRect inView:self.view permittedArrowDirections: UIPopoverArrowDirectionDown animated:YES];*/
//	} else {
//		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//	}
//	
//}

-(IBAction) getPhoto:(id) sender {
	
	

	lblIntroImage.hidden = YES;
	dateLabel.hidden=YES;
      actionbut.hidden=YES;
	TimeLabel.hidden=YES;
	imageQR.hidden=YES;
	LabelQRCode.hidden=YES;
    Scanstrshow.hidden=YES;
	Photosel=TRUE;
	AlbumSel=FALSE;
LBlHeading.text = @"Scan";
	[self initReader: @"ZBarReaderController"];
	[self updateCropMask];
	if(appDel.ori==UIInterfaceOrientationPortrait || appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
		{
			[btnPhotoAlbum setImage:[UIImage imageNamed:@"UN_PhotoAlbum.png"] forState:UIControlStateNormal];
			[btnCamera setImage:[UIImage imageNamed:@"SEL_Camera.png"] forState:UIControlStateNormal];
			
			}else{
				[btnPhotoAlbum setImage:[UIImage imageNamed:@"cmr (3).png"] forState:UIControlStateNormal];
				[btnCamera setImage:[UIImage imageNamed:@"cmr (1).png"] forState:UIControlStateNormal];
			}
	
	picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	
	if((UIButton *)
	   sender == btnCamera) {
		
		
		
		
		if([reader respondsToSelector: @selector(readerView)]) {
			reader.readerView.showsFPS = YES;
			if(zoom)
				reader.readerView.zoom = zoom;
			reader.supportedOrientationsMask = (reader.showsZBarControls)
			? ZBarOrientationMaskAll
			: ZBarOrientationMask(UIInterfaceOrientationPortrait); // tmp disable
			}
		//reader.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		if(reader.sourceType == UIImagePickerControllerSourceTypeCamera)
			reader.cameraOverlayView = (reader.showsZBarControls) ? nil : overlay;
		manualBtn.enabled = TARGET_IPHONE_SIMULATOR ||
		(reader.cameraMode == ZBarReaderControllerCameraModeDefault) ||
		[reader isKindOfClass: [ZBarReaderViewController class]];
		
		readerView.hidden=NO;
		readerView.userInteractionEnabled = NO;
		readerView.readerDelegate = self;
		[readerView start];
		//reader.cameraViewTransform 
		//[reader.readerView setScanCrop:(CGRect){ { 0, 0 }, { 0.43, 1 } }];
		//reader.readerView.frame=CGRectMake(200, 100, 300, 300);
		//[self.view addSubview:reader.readerView];
		//[self.view bringSubviewToFront:reader.view];
		//[self presentModalViewController:reader animated:YES];
		/*CGRect choosePhotoRect = CGRectMake(80,200,850,1024);
				UIPopoverController *popReader = [[UIPopoverController alloc]initWithContentViewController:reader];
				[popReader presentPopoverFromRect:choosePhotoRect inView:self.view permittedArrowDirections: UIPopoverArrowDirectionDown animated:YES];*/
		} else {
			picker.sourceType = UIImagePickerControllerSourceTypeCamera;
			}
	
}

- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
		
	if([GImage retainCount] > 0)
	{
		[GImage release];
		
	}
	if([GsymData retainCount] > 0)
	{
		[GsymData release];
		
	}
	//imgHighlight.hidden = YES;.
	//appDel.img.image = imageQR.image;
	GImage = [img retain];
	
	GsymData = [(ZBarSymbolSet *)syms retain];
	[self performSelector:@selector(showResult_ScannedImg) withObject:nil afterDelay:2.0];
}

-(NSString *)strdate:(NSString *)str
{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd'T'HHmmss'Z"];
    NSDate *date=[dateFormat dateFromString:str];
    if(date != nil)
    {
    [dateFormat setDateFormat:@"EEE MM/dd/yy hh:mm a"];
    return [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:date]]; 
    }
    else {
         str=[str substringToIndex:8];
        NSLog(@"%@",str);
         [dateFormat setDateFormat:@"yyyyMMdd"];
        NSDate *date=[dateFormat dateFromString:str];
        [dateFormat setDateFormat:@"EEE MM/dd/yy hh:mm a"];
        NSLog(@"returnd string:%@",[dateFormat stringFromDate:date]);
        return [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:date]]; 
    }
}

-(void)showResult_ScannedImg
{
	Photosel = FALSE;//Jayna040212
	LBlHeading.text = @"Scan";
	imageQR.hidden=NO;
	imagebottombar.hidden=NO;
	BtnQRcodeText.hidden=NO;
	facebook.hidden=NO;
	twitter.hidden=NO;
	Mail.hidden=NO;
	Mail.enabled = YES;
	[scanView addSubview:trash];
	trash.hidden=NO;
	dateLabel.hidden=NO;
	TimeLabel.hidden=NO;
	
	LabelQRCode.hidden=NO;
    Scanstrshow.hidden=NO;
   
    actionbut.hidden=NO;
    [actionbut setEnabled:YES];
   // actionbut.frame=CGRectMake(400,200,100,50);

    [scanView bringSubviewToFront:imagebottombar];
    [scanView bringSubviewToFront:imagecamera];
     [scanView bringSubviewToFront:btnCamera];
    [scanView bringSubviewToFront:trash];
    [scanView bringSubviewToFront:Mail];
    [scanView bringSubviewToFront:facebook];
    [scanView bringSubviewToFront:twitter];
    
    //[scanView bringSubviewToFront:actionbut];
	
	//imgHighlight.hidden = NO;
	readerView.hidden=YES;
	NSString *redundantdata;
	[self TimeandDate];
	NSString *data;
    // do something useful with results
    for(ZBarSymbol *sym in GsymData) {
       // NSLog(@"data=======>%@", [sym.data substringToIndex:6]);
		LabelQRCode.text=sym.data;
        Scanstrshow.text=LabelQRCode.text;
        redundantdata=sym.data;
        LabelQRCode.textColor = [UIColor blackColor];
                
        data=sym.data;
        
        
        //URL
        if([data length]>=3)
		if([[data substringToIndex:3] isEqualToString:@"htt"] || 
		   [[data substringToIndex:3] isEqualToString:@"WWW"] ||
		   [[data substringToIndex:3] isEqualToString:@"www"] )
		{
			
            if([data rangeOfString:@"?"].location == NSNotFound)
            {
                LBlHeading.text = @"URL";
                   LabelQRCode.textColor = [UIColor blueColor];
                LabelQRCode.text=data;
                Scanstrshow.text=data;
            }
                else {
                LBlHeading.text = @"Map Location";
                   
                data=[@"" stringByAppendingFormat:@"Map URL:%@",data];
                    LabelQRCode.text=[geni dividestring:data :@"Map Location"];
                    Scanstrshow.text=LabelQRCode.text;
            }
            
            
            
		}
		
		
		//NSLog(@"final data:%@",data);
		//For Event
		data= [data stringByReplacingOccurrencesOfString:@"DTSTART:" withString:@"\nStart Date & Time:"];
		NSLog(@"final data of scanned image:%@",data);
        data= [data stringByReplacingOccurrencesOfString:@"DTEND:" withString:@"\nEnd Date & Time:"];
        
         data= [data stringByReplacingOccurrencesOfString:@"EndDate&Time:" withString:@"End Date & Time:"];
         data= [data stringByReplacingOccurrencesOfString:@"StartDate&Time:" withString:@"Start Date & Time:"];
		
		data= [data stringByReplacingOccurrencesOfString:@"SUMMARY:" withString:@"Event:"];
		data= [data stringByReplacingOccurrencesOfString:@"   " withString:@""];
        
		NSLog(@"final data:%@",data);
		data=[data stringByAppendingFormat:@"\n"];
        data= [data stringByReplacingOccurrencesOfString:@":;" withString:@":"];
		
		data= [data stringByReplacingOccurrencesOfString:@";" withString:@"\n"];
		NSLog(@"incomingdata:%@",sym.data);
       
        
        
       /* //location
        if([data length]>=8)
            if([[sym.data substringToIndex:8] isEqualToString:@"Map URL:"] )
            {
                
                data=[data stringByReplacingOccurrencesOfString:@"Map URL:" withString:@""];
             NSArray *words=[data componentsSeparatedByString:@"\n"];
                
                for(int i=1;i<[words count];i++)
                 if([[words objectAtIndex:i] length]>0)
                linksdata=[words objectAtIndex:i];
               linksdata= [linksdata stringByReplacingOccurrencesOfString:@"Notes:" withString:@""];
              redundantdata=  LabelQRCode.text=[words objectAtIndex:0];
                LabelQRCode.textColor = [UIColor blueColor];

                LBlHeading.text = @"Map Location";
            }
*/
        
        
        
        
        
        //event
        if ([data rangeOfString:@"Event:"].location == NSNotFound)
        { 
            
        }
        else {
            
         LBlHeading.text = @"Event";
        }
        
        
        
        
		if([sym.data length] >= 15)
		{
			if([[sym.data substringToIndex:15] isEqualToString:@"BEGIN:VCALENDAR"])
			{
				LBlHeading.text = @"Event";
                data= [data stringByReplacingOccurrencesOfString:@"BEGIN:VEVENT" withString:@""];
                data= [data stringByReplacingOccurrencesOfString:@"END:VEVENT" withString:@""];
                data= [data stringByReplacingOccurrencesOfString:@"BEGIN:VCALENDAR" withString:@""];
                data= [data stringByReplacingOccurrencesOfString:@"END:VCALENDAR" withString:@""];
             redundantdata=data;
                LabelQRCode.text=[geni dividestring:data :@"Event"];
                Scanstrshow.text=LabelQRCode.text;
			}
            if([[sym.data substringToIndex:12] isEqualToString:@"BEGIN:VEVENT"])
			{
				LBlHeading.text = @"Event";
                data= [data stringByReplacingOccurrencesOfString:@"BEGIN:VEVENT" withString:@""];
                data= [data stringByReplacingOccurrencesOfString:@"END:VEVENT" withString:@""];
                data= [data stringByReplacingOccurrencesOfString:@"BEGIN:VCALENDAR" withString:@""];
                data= [data stringByReplacingOccurrencesOfString:@"END:VCALENDAR" withString:@""];
             redundantdata=data;
                LabelQRCode.text=[geni dividestring:data :@"Event"];
                  Scanstrshow.text=LabelQRCode.text;
			}
			   
		}
		
        if([sym.data length] > 7)
            if([[data substringToIndex:7] isEqualToString:@"MECARD:"])
            {
               data=  [data stringByReplacingOccurrencesOfString:@"MECARD:" withString:@"BEGIN:VCARD"]; 
               
            }
        
        //contact
        if([data length] >= 10)
		{
			if([[data substringToIndex:11] isEqualToString:@"BEGIN:VCARD"])
			{
				LBlHeading.text = @"Contact";
                data= [data stringByReplacingOccurrencesOfString:@"BEGIN:VCARD" withString:@""];
                data= [data stringByReplacingOccurrencesOfString:@"END:VCARD" withString:@""];
                data= [data stringByReplacingOccurrencesOfString:@"," withString:@""];
             redundantdata=data;
                LabelQRCode.text= [geni dividestring:data :@"Contact"];
                Scanstrshow.text=LabelQRCode.text;
			}
		}

       
		
		//NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:data];
	//	stDate = [data substringWithRange:[data rangeOfString:@"Start Date & Time"]];
		
		/*[attrStr1 setTextBold:YES range:[data rangeOfString:@"Event:"]];
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"Start Date & Time:"]];
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"End Date & Time:"]];
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"Address:"]];
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"Notes:"]];*/
		
		
		if([sym.data length] > 6)
		//For SMS Data
			//For SMS Data
			if([[sym.data substringToIndex:6] isEqualToString:@"SMSTO:"]||[[sym.data substringToIndex:6] isEqualToString:@"smsto:"])
			{
				data= [sym.data stringByReplacingOccurrencesOfString:@"SMSTO:" withString:@"From:"];
                data=[data stringByReplacingOccurrencesOfString:@"smsto:" withString:@"From:"];
				NSArray* components = [data componentsSeparatedByString:@":"];
				NSString *strTempSMS=@"";
				for(int i=0;i<[components count];i++)
				{
					if(i==[components count]-1)
						strTempSMS = [strTempSMS stringByAppendingFormat:@":%@",[components objectAtIndex:i]];
					else {
						if(i==0)
							strTempSMS = [strTempSMS stringByAppendingFormat:@"%@:",[components objectAtIndex:i]];
						else
							strTempSMS = [strTempSMS stringByAppendingFormat:@"%@",[components objectAtIndex:i]];
						
					}
					
					
					
				}
               
                redundantdata=	data;
				LBlHeading.text = @"SMS";
                LabelQRCode.text=[geni dividestring:data :@"SMS"];
                Scanstrshow.text=LabelQRCode.text;
				
			}
		
		//For Mail
		if([sym.data length] > 10)
		if([[sym.data substringToIndex:10] isEqualToString:@"MATMSG:TO:"] || [[sym.data substringToIndex:7] isEqualToString:@"mailto:"])
		{
			data= [sym.data stringByReplacingOccurrencesOfString:@"MATMSG:TO:" withString:@"from: "];
            data = [data stringByReplacingOccurrencesOfString:@"mailto:" withString:@"from: "];
			data = [data stringByAppendingFormat:@"\n"];
			data = [data stringByReplacingOccurrencesOfString:@"SUBJECT:" withString:@"\nsubject: "];
            data = [data stringByReplacingOccurrencesOfString:@"Subject:" withString:@"\nsubject: "];
            data = [data stringByReplacingOccurrencesOfString:@"SUB:" withString:@"\nsubject: "];
			data = [data stringByAppendingFormat:@"\n"];
			data = [data stringByReplacingOccurrencesOfString:@"BODY:" withString:@"\nbody:"];
            data = [data stringByReplacingOccurrencesOfString:@"Body:" withString:@"\nbody:"];
				redundantdata=data;
            LabelQRCode.text=[geni dividestring:data :@"Email"];
            Scanstrshow.text=LabelQRCode.text;
			LBlHeading.text = @"Email";
            
		}
        if([sym.data length] > 7)
		if([[data substringToIndex:7] isEqualToString:@"MAILTO:"])
		{
			data= [data stringByReplacingOccurrencesOfString:@"MAILTO:" withString:@"From: "];
             LabelQRCode.text=[geni dividestring:data :@"Email"];
               Scanstrshow.text=LabelQRCode.text;
		redundantdata=data;
			LBlHeading.text = @"Email";
		}
		
		//For Tel NO
		if([sym.data length] > 6)
		if([[sym.data substringToIndex:6] isEqualToString:@"TEL NO"] ||
		   [[sym.data substringToIndex:4] isEqualToString:@"TEL:"] || [[sym.data substringToIndex:4] isEqualToString:@"tel:"])
		{
			 data= [sym.data stringByReplacingOccurrencesOfString:@"TEL NO" withString:@"PhoneNumber:"];
			 data= [sym.data stringByReplacingOccurrencesOfString:@"TEL:" withString:@"PhoneNumber:"];
             data= [sym.data stringByReplacingOccurrencesOfString:@"tel:" withString:@"PhoneNumber:"];
			//data= [sym.data stringByReplacingOccurrencesOfString:@"TEL NO|" withString:@""];
            redundantdata=data;
            LabelQRCode.text=[geni dividestring:data :@"Phone"];
            Scanstrshow.text=LabelQRCode.text;
			LBlHeading.text = @"Phone";
			 
			
		}
		
		

        //
         // Me card filteration
                     
		imageQR.image=GImage;
        break;
    }
	
	if([LBlHeading.text isEqualToString:@"Scan"])
		LBlHeading.text = @"Text";
    
    
	appDel.img.image = GImage;
    appDel.tempImageScan = imageQR.image;
	appDel.QRScanDate=dateLabel.text;
	appDel.QRScanText=redundantdata;
    NSLog(@"qrscantext:%@",redundantdata);
	appDel.QRScanTime=TimeLabel.text;
	appDel.catString = LBlHeading.text;
    
    if([LBlHeading.text isEqualToString:@"Event"])
    {
        Scanstrshow.linkColor=[UIColor blackColor];
    }
    
    if([LBlHeading.text isEqualToString:@"Map Location "] || [LBlHeading.text isEqualToString:@"Map Location"])
		appDel.QRScanText = redundantdata;
    
    // actionbut.frame=CGRectMake(30, 600, 150, 50);
    CGSize titleSize = [LabelQRCode.text sizeWithFont:LabelQRCode.font constrainedToSize:CGSizeMake(580,9999) lineBreakMode: UILineBreakModeCharacterWrap];
    
    NSLog(@"ycord:%f",LabelQRCode.frame.origin.y);
    NSLog(@"titlesize:%f",titleSize.height);
    
    
     actionbut.frame=CGRectMake(LabelQRCode.frame.origin.x+10, LabelQRCode.frame.origin.y+titleSize.height+5, 130, 70);
    
    if(LBlHeading.text==@"Phone" || LBlHeading.text==@"Contact"||LBlHeading.text==@"Event" )
    {
        //()*#
       //parsing string for the attributes and for the image
        NSLog(@"into check");
        NSDictionary *keyval;
        NSMutableArray *keysdata=[[NSMutableArray alloc]initWithCapacity:1];
        NSMutableArray *valuedata=[[NSMutableArray alloc]initWithCapacity:1];
  
        NSString *loc_temp; 
        NSString *redundantphoneno;
        NSString *tempstr1;
        redundantphoneno=@"";
        tempstr1=appDel.QRScanText;
        
        
        int rot=0;
        NSLog(@"tempstr:%@",tempstr1);
        NSArray *words = [tempstr1 componentsSeparatedByString:@"\n"];
        //  NSLog(@"count:%d",[words count]);
        
        for(int i=0;i<[words count];i++)
        {
            // NSLog(@"str:%@",[words objectAtIndex:i]);
            if(![[words objectAtIndex:i] isEqualToString:@""])
            {
                NSArray *divwords=[[words objectAtIndex:i] componentsSeparatedByString:@":"];
                NSLog(@"%@",divwords);
                                
                if([divwords count]==2)
                {
                    [keysdata addObject:[divwords objectAtIndex:0]];
                    
                    
                    if([[divwords objectAtIndex:0] isEqualToString:@"Start Date & Time"] || [[divwords objectAtIndex:0] isEqualToString:@"End Date & Time"])
                    {
                        NSLog(@"start/end date /time");
                        
                        if ([[divwords objectAtIndex:1] rangeOfString:@"/"].location != NSNotFound)
                        { 
                            [valuedata addObject:[divwords objectAtIndex:1]];
                        }
                        else {
                            NSLog(@"into els part of date");
                          /*  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                            [dateFormat setDateFormat:@"yyyyMMdd'T'HHmmss'Z"];
                            NSDate *date=[dateFormat dateFromString:[divwords objectAtIndex:1]];
                            [dateFormat setDateFormat:@"EEE MM/dd/yy hh:mm a"];
                            [valuedata addObject:[NSString stringWithFormat:@"%@", [dateFormat stringFromDate:date]]]; */
                            NSLog(@"%@",[divwords objectAtIndex:1]);
                            [valuedata addObject:[self strdate:[divwords objectAtIndex:1]]];
                        }
                        
                        
                        
                        
                    }
                    else {
                        [valuedata addObject:[divwords objectAtIndex:1]];
                    }
                }

                                
                if([divwords count]==1)
                {
                    [keysdata addObject:@"D"];
                    [valuedata addObject:[divwords objectAtIndex:0]]; 
                }
                
                if([divwords count]==3)
                {
                    if([[divwords objectAtIndex:0] isEqualToString:@"Start Date & Time"])
                    {
                        [keysdata addObject:[divwords objectAtIndex:0]];
                        
                        if([[divwords objectAtIndex:1] length]>0 && [[divwords objectAtIndex:2] length]>0)
                        {
                            [valuedata addObject:[[divwords objectAtIndex:1] stringByAppendingFormat:@":%@",[divwords objectAtIndex:2]]]; 
                            
                        }
                        if([[divwords objectAtIndex:1] length]>0 && [[divwords objectAtIndex:2] length]<=0)
                        {
                            [valuedata addObject:[divwords objectAtIndex:1]];
                            
                        }
                        
                    }
                }
                if([divwords count]==3)
                {
                    if([[divwords objectAtIndex:0] isEqualToString:@"End Date & Time"])
                    {
                        [keysdata addObject:[divwords objectAtIndex:0]];
                        
                        if([[divwords objectAtIndex:1] length]>0 && [[divwords objectAtIndex:2] length]>0)
                        {
                            [valuedata addObject:[[divwords objectAtIndex:1] stringByAppendingFormat:@":%@",[divwords objectAtIndex:2]]]; 
                            
                        }
                        if([[divwords objectAtIndex:1] length]>0 && [[divwords objectAtIndex:2] length]<=0)
                        {
                            [valuedata addObject:[divwords objectAtIndex:1]];
                            
                        }
                        
                    }
                }
                

                
                rot++;
                divwords =nil;
            }
            
            
            
        }
        keyval=[NSDictionary dictionaryWithObjects:valuedata forKeys:keysdata];
     
        
        
        
                
        
        loc_temp=(([[keyval objectForKey:@"CELL"] length]<=0)?(([[keyval objectForKey:@"VOICE"] length]<=0)?(([[keyval objectForKey:@"TEL"] length]==0)?[keyval objectForKey:@"PhoneNumber"]:[keyval objectForKey:@"TEL"]):([keyval objectForKey:@"VOICE"])):[keyval objectForKey:@"CELL"]);
        
         NSString *temsavdes;
        if([appDel.catString isEqualToString:@"Event"])
        {
            temsavdes=[keyval objectForKey:@"Event"];
        }
        else {
            if([[keyval objectForKey:@"FN"] length]<=0)
            {
                temsavdes=([[keyval objectForKey:@"N"] length]<=0)?([keyval objectForKey:@"Name"]):([keyval objectForKey:@"N"]);
            }else
            {
                temsavdes=[keyval objectForKey:@"FN"];
            }
            
            if([[keyval objectForKey:@" Name"] length]>0)
            {
                
                temsavdes=[keyval objectForKey:@" Name"];
            }

        }
        
        redundantphoneno=(([[keyval objectForKey:@"CELL"] length]<=0)?(([[keyval objectForKey:@"VOICE"] length]<=0)?(([[keyval objectForKey:@"TEL"] length]==0)?[keyval objectForKey:@"PhoneNumber"]:[keyval objectForKey:@"TEL"]):([keyval objectForKey:@"VOICE"])):[keyval objectForKey:@"CELL"]);
        
        NSLog(@"completed dividing");
        NSLog(@"%@#",LBlHeading.text);
        NSLog(@"#%@#%@#",temsavdes,redundantphoneno);

        
        if(LBlHeading.text==@"Contact")
        {
            if([redundantphoneno length] > 0 && [temsavdes length] > 0)
            {
                int addcon=1;
                
                //  NSString *newString=[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"];
                // NSString *newString1=[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"];
                ABAddressBookRef addressBook = ABAddressBookCreate();
                
                
                CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBook );
                CFIndex nPeople = ABAddressBookGetPersonCount( addressBook );
                
                
                for ( int i = 0; i < nPeople; i++ )
                {
                    ABRecordRef ref = CFArrayGetValueAtIndex( allPeople, i );
                    NSString *firstName = (NSString *)ABRecordCopyValue(ref, kABPersonFirstNameProperty);
                    
                    if([firstName isEqualToString:temsavdes])
                    {
                        addcon=0; 
                        
                    }
                    
                    
                }
                if(addcon)
                {
                    flagcon=YES;
                    [actionbut setImage:[UIImage imageNamed:@"activecontact.png"] forState:UIControlStateNormal];
                    [actionbut setEnabled:YES];
                    
                }
                else {
                    flagcon=NO;
                    [actionbut setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
                    [actionbut setEnabled:NO];
                }
                
            }
            else {
                flagcon=NO;
                [actionbut setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
                [actionbut setEnabled:NO];
            }

            
        }
        if(LBlHeading.text==@"Phone")
		{
			if([redundantphoneno length] > 0)
            {         
            
            ABAddressBookRef addressBook = ABAddressBookCreate();
            
            
            CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBook );
            CFIndex nPeople = ABAddressBookGetPersonCount( addressBook );
            
            int addpho1=1;
            NSString *searchString = nil;
            
            for ( int i = 0; i < nPeople; i++ )
            {
                ABRecordRef ref = CFArrayGetValueAtIndex( allPeople, i );
                ABMultiValueRef phonnumb = (ABMultiValueRef) ABRecordCopyValue(ref,kABPersonPhoneProperty);
                
                
                for (CFIndex i = 0; i < ABMultiValueGetCount(phonnumb); i++) 
                {
                    searchString = (NSString *)ABMultiValueCopyValueAtIndex(phonnumb, i);
                    if([searchString isEqualToString:redundantphoneno])
                        addpho1=0;
                    
                }
                
                
                
            }
            
            if(addpho1)
            {
                flagphon=YES;
                // actbutton.imageView.image=[UIImage imageNamed:@"activecontact.png"];
                [actionbut setImage:[UIImage imageNamed:@"activecontact.png"] forState: UIControlStateNormal];
                [actionbut setEnabled:YES];
            }
            else {
                flagphon=NO;
                //   actbutton.imageView.image=[UIImage imageNamed:@"inactivecontact.png"];
                [actionbut setImage:[UIImage imageNamed:@"inactivecontact.png"] forState: UIControlStateNormal];
                [actionbut setEnabled:NO];
            }
            
            }
            
		}

        NSLog(@"%@,%@,%@",temsavdes,[keyval objectForKey:@"Start Date & Time"],[keyval objectForKey:@"End Date & Time"]);
                
         if([LBlHeading.text isEqualToString:@"Event"])
         {
        if(LBlHeading.text==@"Event" && [temsavdes length] > 0 && [[keyval objectForKey:@"Start Date & Time"] length] > 0 && [[keyval objectForKey:@"End Date & Time"] length] > 0)
        {
            NSLog(@"into event part");
            flageven=YES;
            int seconds_in_year = 60*60*24*365;
            NSDate *dat1=[[NSDate alloc]init];
            EKEventStore *eventStore = [[EKEventStore alloc] init];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mma"];
            NSDate *start = [dat1 dateByAddingTimeInterval:-seconds_in_year];
            NSDate *finish = [dat1 dateByAddingTimeInterval:seconds_in_year];
            
            
            // use Dictionary for remove duplicates produced by events covered more one year segment
            NSMutableDictionary *eventsDict = [NSMutableDictionary dictionaryWithCapacity:1024];
            
            NSDate* currentStart = [NSDate dateWithTimeInterval:0 sinceDate:start];
            
            
            
            // enumerate events by one year segment because iOS do not support predicate longer than 4 year !
            while ([currentStart compare:finish] == NSOrderedAscending) {
                
                NSDate* currentFinish = [NSDate dateWithTimeInterval:seconds_in_year sinceDate:currentStart];
                
                if ([currentFinish compare:finish] == NSOrderedDescending) {
                    currentFinish = [NSDate dateWithTimeInterval:0 sinceDate:finish];
                }
                NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:currentStart endDate:currentFinish calendars:nil];
                [eventStore enumerateEventsMatchingPredicate:predicate
                                                  usingBlock:^(EKEvent *event, BOOL *stop) {
                                                      
                                                      if (event) {
                                                          
                                                          if(event.eventIdentifier != nil)
                                                              [eventsDict setObject:event forKey:event.eventIdentifier];
                                                          else {
                                                              NSLog(@"no event dictonary");
                                                              flageven=NO;
                                                          }
                                                      }
                                                      
                                                  }];       
                currentStart = [NSDate dateWithTimeInterval:(seconds_in_year + 1) sinceDate:currentStart];
                
            }
            
            NSArray *events = [eventsDict allKeys];
            
            
            for(int i=0;i<[events count];i++)
            {
                EKEvent *evn=[eventsDict objectForKey:[events objectAtIndex:i]];
              //  NSLog(@"title of event:%@",evn.title);
                if([evn.title length]!= 0)
                {
                    temsavdes=[temsavdes stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                    if([evn.title isEqualToString:temsavdes])
                    {
                        flageven=NO;
                    }
                }
                
            }
            NSLog(@"is events:"); 
            NSLog(flageven ? @"Yes" : @"No");

            
            
            if (flageven)
            {
                NSLog(@"calendar active");
                               flageven=YES;
                               [actionbut setImage:[UIImage imageNamed:@"calenderactive.png"] forState: UIControlStateNormal];
                [actionbut setEnabled:YES];
                
            }
            else {
                flageven=NO;
                [actionbut setImage:[UIImage imageNamed:@"inactivecalender.png"] forState: UIControlStateNormal];
                [actionbut setEnabled:NO];
            }
            
            
        }
      
        else {
            flageven=NO;
            [actionbut setImage:[UIImage imageNamed:@"inactivecalender.png"] forState: UIControlStateNormal];
            [actionbut setEnabled:NO];
        }

         }
        
        
        
        
        actionbut.hidden=NO;
    }
    else {
        actionbut.hidden=YES;
    }
    
    Scanstrshow.lineBreakMode=YES;
    
    
   // CGFloat height = 0;
//	CGSize maximumLabelSize1 = CGSizeMake(300,9999);
	///CGSize expectedLabelSize1 = [LabelQRCode.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
	//height = expectedLabelSize1.height;
    
    
	//
    Scanstrshow.frame = CGRectMake(Scanstrshow.frame.origin.x, Scanstrshow.frame.origin.y+10, Scanstrshow.frame.size.width, Scanstrshow.frame.size.height);
	
    [Scanstrshow sizeToFit];
   if( [LBlHeading.text isEqualToString:@"Event"])
   {
       [Scanstrshow setLinkColor:[UIColor blackColor]];
   }
    
    
    LabelQRCode.hidden=YES;
    Scanstrshow.hidden=NO;
    
	[self selectcategory:GImage];
	//data = nil;
	//[self saveQrCode];
	
}
#pragma mark imagePickerController

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[picker dismissModalViewControllerAnimated:YES];	
}
- (void)  imagePickerController: (UIImagePickerController*) picker
  didFinishPickingMediaWithInfo: (NSDictionary*) info
{
	if(appDel.ori==UIInterfaceOrientationPortrait || appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		[btnPhotoAlbum setImage:[UIImage imageNamed:@"PhotoAlbum_Icon_UnSelected.png"] forState:UIControlStateNormal];
		[btnCamera setImage:[UIImage imageNamed:@"UNSEL__Camera.png"] forState:UIControlStateNormal];

	}else{
		[btnPhotoAlbum setImage:[UIImage imageNamed:@"cmr (1).png"] forState:UIControlStateNormal];
		[btnCamera setImage:[UIImage imageNamed:@"cmr (2).png"] forState:UIControlStateNormal];
	}
	
	[popReader dismissPopoverAnimated:YES];
	NSLog(@"info===>%@",[info allKeys]);
    id <NSFastEnumeration> results =
	[info objectForKey: ZBarReaderControllerResults];
	ZBarSymbol *bestResult=[[[ZBarSymbol alloc]init] autorelease];
	ZBarSymbol *sym=[[[ZBarSymbol alloc]init] autorelease];
	
    UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
	
      if(image)
	  {
         imageQR.image = image;
		  image = nil;
		  
	  }
	
   // appDel.img = [info objectForKey: UIImagePickerControllerOriginalImage];
	appDel.img = imageQR;
    appDel.tempImageScan = imageQR.image;
	imageQR.hidden=NO;
	imagebottombar.hidden=NO;
	BtnQRcodeText.hidden=NO;
	facebook.hidden=NO;
	twitter.hidden=NO;
	Mail.hidden=NO;
	Mail.enabled = YES;
	[scanView addSubview:trash];
	trash.hidden=NO;
	dateLabel.hidden=NO;
      actionbut.hidden=NO;
	TimeLabel.hidden=NO;
    [self TimeandDate];// Current Time & Date
	int quality = 0;
    bestResult = nil;
    for(sym in results) {
        int q = sym.quality;
        if(quality < q) {
            quality = q;
            bestResult = sym;
        }
    }
    [self performSelector: @selector(presentResult:)
			   withObject: bestResult
			   afterDelay: .001];
    if(!continuous)
        [picker dismissModalViewControllerAnimated: YES];
}

#pragma mark QRSCanner 
- (void) initReader: (NSString*) clsName
{
    [reader release];
    Class cls = [[NSBundle mainBundle]
				 classNamed: clsName];
    assert(cls);
    reader = [cls new];
    assert(reader);
    reader.readerDelegate = self;
	readerView.readerDelegate = self;
	
	[ZBarReaderView class];
	
#if 0
    // apply defaults for demo
    ZBarImageScanner *scanner = reader.scanner;
    continuous = NO;
    zoom = 1;
    reader.showsZBarControls = NO;
	reader.rotating = NO;
	reader.supportedOrientationsMask = 0;
	//reader.cameraViewTransform = 
    reader.scanCrop = CGRectMake(0, .35, 1, .3);
	
    [defaultSymbologies release];
    defaultSymbologies =
	[[NSSet alloc]
	 initWithObjects:
	 [NSNumber numberWithInteger: ZBAR_CODE128],
	 nil];
    [scanner setSymbology: 0
				   config: ZBAR_CFG_ENABLE
					   to: 0];
    for(NSNumber *sym in defaultSymbologies)
        [scanner setSymbology: sym.integerValue
					   config: ZBAR_CFG_ENABLE
						   to: 1];
	
    [scanner setSymbology: 0
				   config: ZBAR_CFG_X_DENSITY
					   to: (xDensity = 0)];
    [scanner setSymbology: 0
				   config: ZBAR_CFG_Y_DENSITY
					   to: (yDensity = 1)];
#endif
}

- (void) updateCropMask
{
    CGRect r = reader.scanCrop;
    r.origin.x *= 426;
    r.origin.y *= 320;
    r.size.width *= 426;
    r.size.height *= 320;
    UIView *mask = [masks objectAtIndex: 0];
    mask.frame = CGRectMake(0, -426, 320, r.origin.x);
    mask = [masks objectAtIndex: 1];
    mask.frame = CGRectMake(0, r.origin.x - 426, r.origin.y, r.size.width);
	
    r.origin.y += r.size.height;
    mask = [masks objectAtIndex: 2];
    mask.frame = CGRectMake(r.origin.y, r.origin.x - 426,
                            320 - r.origin.y, r.size.width);
	
    r.origin.x += r.size.width;
    mask = [masks objectAtIndex: 3];
    mask.frame = CGRectMake(0, r.origin.x - 426, 320, 426 - r.origin.x);
	[mask release];
}

- (void) presentResult: (ZBarSymbol*) sym
{
	
	lblIntroImage.hidden = YES;
	
	LBlHeading.text = @"Scan";
    found = sym || imageQR.image;
    NSString *typeName = @"NONE";
    NSString *data = @"";
    if(sym) {
        typeName = sym.typeName;
        data = sym.data;
    }
    typeLabel.text = typeName;
    dataLabel.text = data;
	
    if(continuous) {
        typeOvl.text = typeName;
        dataOvl.text = data;
    }
	
    NSLog(@"imagePickerController:didFinishPickingMediaWithInfo:\n");
    NSLog(@"    type=%@ data=%@\n", typeName, data);

    CGSize size = [data sizeWithFont: [UIFont systemFontOfSize: 17]
				   constrainedToSize: CGSizeMake(288, 2000)
					   lineBreakMode: UILineBreakModeCharacterWrap];
    dataHeight = size.height + 26;
    if(dataHeight > 2000)
        dataHeight = 2000;
	LabelQRCode.textColor = [UIColor blackColor];

	//LabelQRCode.text=sym.data;
    
    //maplocation and url
     if([data length] >= 3
        )
	if([[data substringToIndex:3] isEqualToString:@"htt"] || 
	   [[data substringToIndex:3] isEqualToString:@"WWW"] ||
	   [[data substringToIndex:3] isEqualToString:@"www"] )
	{
		if([data rangeOfString:@"?"].location == NSNotFound)
        {
            LBlHeading.text = @"URL";
            LabelQRCode.textColor = [UIColor blueColor];
            LabelQRCode.text=data;
            appDel.QRScanText=data;
        }
        else {
            LBlHeading.text = @"Map Location";
            data=[@"" stringByAppendingFormat:@"Map URL:%@",data];
             appDel.QRScanText=data;
            LabelQRCode.text=[geni dividestring:data :@"Map Location"];
        }
      
	}

	
	
	//For Event
     if([data length] >= 15)
	if([[data substringToIndex:15] isEqualToString:@"BEGIN:VCALENDAR"])
	{
		LBlHeading.text = @"Event";
	}
	data= [data stringByReplacingOccurrencesOfString:@"DTSTART:" withString:@"\nStart Date & Time:"];
    NSLog(@"final data:%@",data);
    data= [data stringByReplacingOccurrencesOfString:@"DTEND:" withString:@"\nEnd Date & Time:"];
    data= [data stringByReplacingOccurrencesOfString:@"SUMMARY:" withString:@"Event:"];
    data= [data stringByReplacingOccurrencesOfString:@"   " withString:@""];
    	data=[data stringByAppendingFormat:@"\n"];
    data= [data stringByReplacingOccurrencesOfString:@";" withString:@"\n"];
    
    if ([data rangeOfString:@"Event:"].location == NSNotFound)
    { 
        
    }
    else {
        
        LBlHeading.text = @"Event";
    }
    
    if([data length] >= 12)
    {
        if([[data substringToIndex:12] isEqualToString:@"BEGIN:VEVENT"])
        {
            LBlHeading.text = @"Event";
        }       
        
    }
    if([LBlHeading.text isEqualToString:@"Event"])
    {
    data= [data stringByReplacingOccurrencesOfString:@"BEGIN:VEVENT" withString:@""];
	data= [data stringByReplacingOccurrencesOfString:@"END:VEVENT" withString:@""];
    data= [data stringByReplacingOccurrencesOfString:@"BEGIN:VCALENDAR" withString:@""];
	data= [data stringByReplacingOccurrencesOfString:@"END:VCALENDAR" withString:@""];
    LabelQRCode.text=[geni dividestring:data :@"Event"];
        appDel.QRScanText=data;
    }
    
    
     //mecard an vcard
    if([data length] > 7)
        if([[data substringToIndex:7] isEqualToString:@"MECARD:"])
        {
            data=  [data stringByReplacingOccurrencesOfString:@"MECARD:" withString:@"BEGIN:VCARD"]; 
            
        }
    
    if([data length] >= 11)
    {
        if([[data substringToIndex:11] isEqualToString:@"BEGIN:VCARD"])
        {
            LBlHeading.text = @"Contact";
        }
    }
    if([LBlHeading.text isEqualToString:@"Contact"])
    {
    data= [data stringByReplacingOccurrencesOfString:@"BEGIN:VCARD" withString:@""];
    data= [data stringByReplacingOccurrencesOfString:@"END:VCARD" withString:@""];
   
    LabelQRCode.text=[geni dividestring:data :@"Contact"];
        appDel.QRScanText=data;
    }
	
		
    
	//For SMS Data
	if([data length] > 6)
		
		//For SMS Data
		if([[data substringToIndex:6] isEqualToString:@"SMSTO:"] || [[data substringToIndex:6] isEqualToString:@"smsto:"])
		{
			data= [
                   data stringByReplacingOccurrencesOfString:@"SMSTO:" withString:@"From:"];
			NSArray* components = [data componentsSeparatedByString:@":"];
			NSString *strTempSMS=@"";
			for(int i=0;i<[components count];i++)
			{
				if(i==[components count]-1)
					strTempSMS = [strTempSMS stringByAppendingFormat:@":%@",[components objectAtIndex:i]];
				else {
					if(i==0)
						strTempSMS = [strTempSMS stringByAppendingFormat:@"%@:",[components objectAtIndex:i]];
					else
						strTempSMS = [strTempSMS stringByAppendingFormat:@"%@",[components objectAtIndex:i]];
					
				}

				
				
			}
			appDel.QRScanText=data;
            LabelQRCode.text=[geni dividestring:data :@"SMS"];
			LBlHeading.text = @"SMS";
            
		}

	
	
	//For Mail

    
    
    
    //For Mail
    if([data length] > 10)
		if([[data substringToIndex:10] isEqualToString:@"MATMSG:TO:"] || [[data substringToIndex:7] isEqualToString:@"mailto:"] || [[data substringToIndex:7] isEqualToString:@"MAILTO:"])
		{
			data= [data stringByReplacingOccurrencesOfString:@"MATMSG:TO:" withString:@"from:"];
            data= [data stringByReplacingOccurrencesOfString:@"mailto:" withString:@"from:"];
            data= [data stringByReplacingOccurrencesOfString:@"MAILTO:" withString:@"from:"];
			data = [data stringByAppendingFormat:@"\n"];
			data = [data stringByReplacingOccurrencesOfString:@"SUBJECT:" withString:@"\nsubject:"];
            data = [data stringByReplacingOccurrencesOfString:@"Subject:" withString:@"\nsubject:"];
            data = [data stringByReplacingOccurrencesOfString:@"SUB:" withString:@"\nsubject: "];
			data = [data stringByAppendingFormat:@"\n"];
			data = [data stringByReplacingOccurrencesOfString:@"BODY:" withString:@"\nbody:"];
            data = [data stringByReplacingOccurrencesOfString:@"Body:" withString:@"\nbody:"];
            appDel.QRScanText=data;
			LBlHeading.text = @"Email";
            LabelQRCode.text=[geni dividestring:data :@"Email"];
		}
	
	
    //For Tel NO
    if([data length] > 6)
		if([[data substringToIndex:6] isEqualToString:@"TEL NO"] ||
		   [[data substringToIndex:4] isEqualToString:@"TEL:"] || [[data substringToIndex:4] isEqualToString:@"tel:"])
		{
            data= [data stringByReplacingOccurrencesOfString:@"TEL NO" withString:@"PhoneNumber:"];
            data= [data stringByReplacingOccurrencesOfString:@"TEL:" withString:@"PhoneNumber:"];
            data= [data stringByReplacingOccurrencesOfString:@"tel:" withString:@"PhoneNumber:"];
			//data= [sym.data stringByReplacingOccurrencesOfString:@"TEL NO|" withString:@""];
		appDel.QRScanText=data;
            NSLog(@"going string from picker:%@",data);
             LabelQRCode.text=[geni dividestring:data :@"Phone"];
			LBlHeading.text = @"Phone";
            
			
		}

    

    
    
    NSDictionary *keyval;
    NSMutableArray *keysdata=[[NSMutableArray alloc]initWithCapacity:1];
    NSMutableArray *valuedata=[[NSMutableArray alloc]initWithCapacity:1];
    NSString *add_temp; 
    NSString *loc_temp; 
    NSString *redundantphoneno;
    redundantphoneno=@"";
    
    int rot=0;
    NSLog(@"tempstr:%@",data);
    NSArray *words = [data componentsSeparatedByString:@"\n"];
    //  NSLog(@"count:%d",[words count]);
    
    for(int i=0;i<[words count];i++)
    {
        // NSLog(@"str:%@",[words objectAtIndex:i]);
        if(![[words objectAtIndex:i] isEqualToString:@""])
        {
            NSArray *divwords=[[words objectAtIndex:i] componentsSeparatedByString:@":"];
            NSLog(@"%@",divwords);
                       
            if([divwords count]==2)
            {
                [keysdata addObject:[divwords objectAtIndex:0]];
                
                
                if([[divwords objectAtIndex:0] isEqualToString:@"Start Date & Time"] || [[divwords objectAtIndex:0] isEqualToString:@"End Date & Time"])
                {
                    NSLog(@"start/end date /time");
                    
                    if ([[divwords objectAtIndex:1] rangeOfString:@"/"].location != NSNotFound)
                    { 
                        [valuedata addObject:[divwords objectAtIndex:1]];
                    }
                    else {
                        NSLog(@"into els part of date");
                       /* NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                        NSLog(@"inp:#%@#",[divwords objectAtIndex:1]);
                        [dateFormat setDateFormat:@"yyyyMMdd'T'HHmmss'Z"];
                        NSDate *date=[dateFormat dateFromString:[divwords objectAtIndex:1]];
                        [dateFormat setDateFormat:@"EEE MM/dd/yy hh:mm a"];
                        NSLog(@"date:%@",[dateFormat stringFromDate:date]);
                        [valuedata addObject:[NSString stringWithFormat:@"%@", [dateFormat stringFromDate:date]]]; */
                        NSLog(@"%@",[divwords objectAtIndex:1]);
                        NSString *rawdate=[divwords objectAtIndex:1];
                        
                       // [foo stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                        rawdate=[rawdate stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                        [valuedata addObject:[self strdate:rawdate]];
                        
                    }
                    
                    
                    
                    
                }
                else {
                    [valuedata addObject:[divwords objectAtIndex:1]];
                }
                
               
            }
            if([divwords count]==1)
            {
                [keysdata addObject:@"D"];
                [valuedata addObject:[divwords objectAtIndex:0]]; 
            }
            
            
            if([divwords count]==3)
            {
                if([[divwords objectAtIndex:0] isEqualToString:@"Start Date & Time"])
                {
                    [keysdata addObject:[divwords objectAtIndex:0]];
                    
                    if([[divwords objectAtIndex:1] length]>0 && [[divwords objectAtIndex:2] length]>0)
                    {
                        [valuedata addObject:[[divwords objectAtIndex:1] stringByAppendingFormat:@":%@",[divwords objectAtIndex:2]]]; 
                        
                    }
                    if([[divwords objectAtIndex:1] length]>0 && [[divwords objectAtIndex:2] length]<=0)
                    {
                        [valuedata addObject:[divwords objectAtIndex:1]];
                        
                    }
                    
                }
            }
            if([divwords count]==3)
            {
                if([[divwords objectAtIndex:0] isEqualToString:@"End Date & Time"])
                {
                    [keysdata addObject:[divwords objectAtIndex:0]];
                    
                    if([[divwords objectAtIndex:1] length]>0 && [[divwords objectAtIndex:2] length]>0)
                    {
                        [valuedata addObject:[[divwords objectAtIndex:1] stringByAppendingFormat:@":%@",[divwords objectAtIndex:2]]]; 
                        
                    }
                    if([[divwords objectAtIndex:1] length]>0 && [[divwords objectAtIndex:2] length]<=0)
                    {
                        [valuedata addObject:[divwords objectAtIndex:1]];
                        
                    }
                    
                }
            }
            

            
            rot++;
            divwords =nil;
        }
        
        
        
    }
    keyval=[NSDictionary dictionaryWithObjects:valuedata forKeys:keysdata];
NSLog(@"dictonaydata:%@",[keyval description]);
    
    
    
    
    //string1 = [string1 stringByAppendingString:string2]
    add_temp=@"";
    if([appDel.catString isEqualToString:@"Event"])
    {
        if([[keyval objectForKey:@"Street Address"] length]>0)
        {
            add_temp=[add_temp stringByAppendingFormat:@"%@ ",[keyval objectForKey:@"Street Address"]];
        }
        if([[keyval objectForKey:@"City"] length]>0)
        {
            add_temp=[add_temp stringByAppendingFormat:@"%@ ",[keyval objectForKey:@"City"]];      
        }
        if([[keyval objectForKey:@"State"] length]>0)
        {
            add_temp=[add_temp stringByAppendingFormat:@"%@ ",[keyval objectForKey:@"State"]];      
        }
        if([[keyval objectForKey:@"Zip Code"] length]>0)
        {
            add_temp=[add_temp stringByAppendingFormat:@"%@ ",[keyval objectForKey:@"Zip Code"]];      
        }
        if([[keyval objectForKey:@"Country"] length]>0)
        {
            add_temp=[add_temp stringByAppendingFormat:@"%@ ",[keyval objectForKey:@"Country"]];      
        }
        if([[keyval objectForKey:@"LOCATION"] length]>0)
        {
            add_temp=[add_temp stringByAppendingFormat:@"%@ ",[keyval objectForKey:@"LOCATION"]];      
        }
        
        
        
        // add_temp=[[[[[keyval objectForKey:@"Street Address"] stringByAppendingString:[keyval objectForKey:@"City"]] stringByAppendingString:[keyval objectForKey:@"State"]] stringByAppendingString:[keyval objectForKey:@"Zip Code"]] stringByAppendingString:[keyval objectForKey:@"Country"]] ;
        
        //add_temp=[add_temp stringByAppendingString:[keyval objectForKey:@"LOCATION"]];   
    }
    else {
        add_temp=@"";
    }
    
    
    
    loc_temp=(([[keyval objectForKey:@"CELL"] length]<=0)?(([[keyval objectForKey:@"VOICE"] length]<=0)?(([[keyval objectForKey:@"TEL"] length]==0)?[keyval objectForKey:@"PhoneNumber"]:[keyval objectForKey:@"TEL"]):([keyval objectForKey:@"VOICE"])):[keyval objectForKey:@"CELL"]);
    
    /*    if(loc_temp==NULL || loc_temp == @"")
     {
     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert!"
     message:@"Details are missing! Contact can't be saved to Library!" 
     delegate:self 
     cancelButtonTitle:@"Ok"
     otherButtonTitles:nil];
     alert.tag=151;
     [alert show];
     [alert release];
     
     }
     else {
     */      NSString *temsavdes;
    if([appDel.catString isEqualToString:@"Event"])
    {
        temsavdes=[keyval objectForKey:@"Event"];
    }
    else {
        // temsavdes=([[keyval objectForKey:@"N"] length]<=0)?([keyval objectForKey:@"Name"]):(([[keyval objectForKey:@"D"] length]<=0)?([keyval objectForKey:@"N"]):([[keyval objectForKey:@"N"] stringByAppendingFormat:@" %@",[keyval objectForKey:@"D"]]));
        
        if([[keyval objectForKey:@"FN"] length]<=0)
        {
            temsavdes=([[keyval objectForKey:@"N"] length]<=0)?([keyval objectForKey:@"Name"]):([keyval objectForKey:@"N"]);
        }else
        {
            temsavdes=[keyval objectForKey:@"FN"];
        }
        
    }
    
    redundantphoneno=(([[keyval objectForKey:@"CELL"] length]<=0)?(([[keyval objectForKey:@"VOICE"] length]<=0)?(([[keyval objectForKey:@"TEL"] length]==0)?[keyval objectForKey:@"PhoneNumber"]:[keyval objectForKey:@"TEL"]):([keyval objectForKey:@"VOICE"])):[keyval objectForKey:@"CELL"]);
    

    
    
    
    
    
	
    NSString *compstr=LBlHeading.text;
    NSLog(@"comparing str:%@",compstr);
    if([compstr isEqualToString:@"Contact"] || [compstr isEqualToString:@"Phone"] )
    {
       // flagcon=YES;
       // flagphon=YES;
       // [actionbut setImage:[UIImage imageNamed:@"activecontact.png"] forState:UIControlStateNormal];
        
        
        
        if(LBlHeading.text==@"Contact")
        {
            if([redundantphoneno length] > 0 && [temsavdes length] > 0)
            {
                int addcon=1;
                
                //  NSString *newString=[[array_catagory objectAtIndex:changeColor] objectForKey:@"Description"];
                // NSString *newString1=[[array_catagory objectAtIndex:changeColor] objectForKey:@"PhoneNo"];
                ABAddressBookRef addressBook = ABAddressBookCreate();
                
                
                CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBook );
                CFIndex nPeople = ABAddressBookGetPersonCount( addressBook );
                
                
                for ( int i = 0; i < nPeople; i++ )
                {
                    ABRecordRef ref = CFArrayGetValueAtIndex( allPeople, i );
                    NSString *firstName = (NSString *)ABRecordCopyValue(ref, kABPersonFirstNameProperty);
                    if([firstName isEqualToString:temsavdes])
                    {
                        addcon=0; 
                        
                    }
                    
                    
                }
                if(addcon)
                {
                    flagcon=YES;
                    [actionbut setImage:[UIImage imageNamed:@"activecontact.png"] forState:UIControlStateNormal];
                    [actionbut setEnabled:YES];
                    
                }
                else {
                    flagcon=NO;
                    [actionbut setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
                    [actionbut setEnabled:NO];
                }
                
            }
            else {
                flagcon=NO;
                [actionbut setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
                [actionbut setEnabled:NO];
            }
            
            
        }
        if(LBlHeading.text==@"Phone")
		{
			if([redundantphoneno length] > 0)
            {   
                
                
                NSLog(@"comparing string from phone #%@#",redundantphoneno);
                
                ABAddressBookRef addressBook = ABAddressBookCreate();
                
                
                CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBook );
                CFIndex nPeople = ABAddressBookGetPersonCount( addressBook );
                
                int addpho1=1;
                NSString *searchString = nil;
                
                for ( int i = 0; i < nPeople; i++ )
                {
                    ABRecordRef ref = CFArrayGetValueAtIndex( allPeople, i );
                    ABMultiValueRef phonnumb = (ABMultiValueRef) ABRecordCopyValue(ref,kABPersonPhoneProperty);
                    
                    
                    for (CFIndex i = 0; i < ABMultiValueGetCount(phonnumb); i++) 
                    {
                        searchString = (NSString *)ABMultiValueCopyValueAtIndex(phonnumb, i);
                        if([searchString isEqualToString:redundantphoneno])
                            addpho1=0;
                        
                    }
                    
                    
                    
                }
                
                if(addpho1)
                {
                    flagphon=YES;
                    // actbutton.imageView.image=[UIImage imageNamed:@"activecontact.png"];
                    [actionbut setImage:[UIImage imageNamed:@"activecontact.png"] forState: UIControlStateNormal];
                    [actionbut setEnabled:YES];
                }
                else {
                    flagphon=NO;
                    //   actbutton.imageView.image=[UIImage imageNamed:@"inactivecontact.png"];
                    [actionbut setImage:[UIImage imageNamed:@"inactivecontact.png"] forState: UIControlStateNormal];
                    [actionbut setEnabled:NO];
                }
                
            }
            else {
                flagphon=NO;
                //   actbutton.imageView.image=[UIImage imageNamed:@"inactivecontact.png"];
                [actionbut setImage:[UIImage imageNamed:@"inactivecontact.png"] forState: UIControlStateNormal];
                [actionbut setEnabled:NO];
            }

            
		}
        
        
        
        
        
        
        
    }
    
    
    else if([compstr isEqualToString:@"Event"]){
        NSLog(@"%@,%@",[keyval objectForKey:@"Start Date & Time"],[keyval objectForKey:@"End Date & Time"]);
        flageven=YES;
        int seconds_in_year = 60*60*24*365;
        NSDate *dat1=[[NSDate alloc]init];
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mma"];
        NSDate *start = [dat1 dateByAddingTimeInterval:-seconds_in_year];
        NSDate *finish = [dat1 dateByAddingTimeInterval:seconds_in_year];
        
        
        // use Dictionary for remove duplicates produced by events covered more one year segment
        NSMutableDictionary *eventsDict = [NSMutableDictionary dictionaryWithCapacity:1024];
        
        NSDate* currentStart = [NSDate dateWithTimeInterval:0 sinceDate:start];
        
        
        
        // enumerate events by one year segment because iOS do not support predicate longer than 4 year !
        while ([currentStart compare:finish] == NSOrderedAscending) {
            
            NSDate* currentFinish = [NSDate dateWithTimeInterval:seconds_in_year sinceDate:currentStart];
            
            if ([currentFinish compare:finish] == NSOrderedDescending) {
                currentFinish = [NSDate dateWithTimeInterval:0 sinceDate:finish];
            }
            NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:currentStart endDate:currentFinish calendars:nil];
            [eventStore enumerateEventsMatchingPredicate:predicate
                                              usingBlock:^(EKEvent *event, BOOL *stop) {
                                                  
                                                  if (event) {
                                                      
                                                      if(event.eventIdentifier != nil)
                                                          [eventsDict setObject:event forKey:event.eventIdentifier];
                                                      else {
                                                          NSLog(@"no event dictonary");
                                                          flageven=NO;
                                                      }
                                                  }
                                                  
                                              }];       
            currentStart = [NSDate dateWithTimeInterval:(seconds_in_year + 1) sinceDate:currentStart];
            
        }
        
        NSArray *events = [eventsDict allKeys];
        
        
        for(int i=0;i<[events count];i++)
        {
            EKEvent *evn=[eventsDict objectForKey:[events objectAtIndex:i]];
           // NSLog(@"title of event:%@",evn.title);
            if([evn.title length]!= 0)
            {
                temsavdes=[temsavdes stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                if([evn.title isEqualToString:temsavdes])
                {
                    flageven=NO;
                }
            }
            
        }
        NSLog(@"is events:"); 
        NSLog(flageven ? @"Yes" : @"No");
        
        
        
        
        
        //SYSTEM_VERSION_LESS_THAN(@"5.0")
        
        if (flageven)
        {
            flageven=YES;
            [actionbut setImage:[UIImage imageNamed:@"calenderactive.png"] forState:UIControlStateNormal];
            [actionbut setEnabled:YES];
        }
        else {
            flageven=NO;
            [actionbut setImage:[UIImage imageNamed:@"inactivecalender.png"] forState:UIControlStateNormal];
            [actionbut setEnabled:NO];
            
        }
    } 
    else {
        flageven=NO;
        flagcon=NO;
        flageven=NO;
        actionbut.hidden=YES;
    }
    

    
    
	if([LBlHeading.text isEqualToString:@"Scan"])
		LBlHeading.text = @"Text";
	
     Scanstrshow.text=LabelQRCode.text;
    
    Scanstrshow.lineBreakMode=YES;
    
    
  /*  CGFloat height = 0;
	CGSize maximumLabelSize1 = CGSizeMake(300,9999);
	CGSize expectedLabelSize1 = [LabelQRCode.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
	height = expectedLabelSize1.height;
    
    
	Scanstrshow.frame = CGRectMake(Scanstrshow.frame.origin.x, Scanstrshow.frame.origin.y, 300, height+50);*/
	
    [Scanstrshow sizeToFit];

    
    
    
    
	LabelQRCode.hidden = YES;
   
    Scanstrshow.hidden=NO;
    
	
	appDel.QRScanDate=dateLabel.text;
	//appDel.QRScanText=LabelQRCode.text=data;
	appDel.QRScanTime=TimeLabel.text;
	appDel.img.image = imageQR.image;
	
	appDel.catString = LBlHeading.text;
	[self selectcategory:imageQR.image];
        
    
	
	if(appDel.ori==UIInterfaceOrientationPortrait || appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		
		[btnPhotoAlbum setImage:[UIImage imageNamed:@"SEL_PHOTOAlbum.png"] forState:UIControlStateNormal];
		
	}
	
	
	else{
		
		[btnPhotoAlbum setImage:[UIImage imageNamed:@"cmr (2).png"] forState:UIControlStateNormal];
		
		
	}
	/*UILabel *lbltemp = [[UILabel alloc]initWithFrame:CGRectMake(40, 214,800,60)];
	lbltemp.backgroundColor = [UIColor redColor];
	[self.view addSubview:lbltemp];
	[self.view bringSubviewToFront:LabelQRCode];*/
	//[self saveQrCode];
    
    //LabelQRCode
    // setup some frames
    
    //UITextField* text = [[UITextField alloc] initWithFrame:CGRectMake(40, 214,800,60)];
        
   // [self.view addSubview:text];
	
	[typeLabel release];
	[dataLabel release];
	
}

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
	
	
	[btnScan release];
	[btnDashBoard release];
	[btnWrite release];
	[btnTemplate release];
	[btnTwitter release];
	[btnLibrary release];
	[btnAbout release];
	[btnQuiz release];
	[btnNext release];
	[btnPrevious release];	
	[ScrlTabButtn release];
}

@end
