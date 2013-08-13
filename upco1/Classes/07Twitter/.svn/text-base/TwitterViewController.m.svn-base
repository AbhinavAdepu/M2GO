//
//  TwitterViewController.m
//  KrenMarketing
//
//  Created by Silvertouch on 17/11/11.
//  Copyright 2011 SilverTouch Tech. Ltd. All rights reserved.
//

#import "TwitterViewController.h"


@implementation TwitterViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	 [super viewDidLoad];
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	webView.backgroundColor = [UIColor clearColor];  
	NSString *urlAddress = @"http://twitter.com/@kerinmarketing";
	//NSString *urlAddress = @"http://www.google.com";
	webView.clipsToBounds = YES;
	webView.contentMode = UIViewContentModeScaleToFill;
	
	webView.scalesPageToFit = NO;
	
	webView.delegate=self;
	
	//NSString *urlAddress = @"https://mobile.twitter.com/session/new?return_to=%2Fsignup";
	NSURL *url = [NSURL URLWithString:urlAddress];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[webView loadRequest:requestObj];
	
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
	firstTime = TRUE;
	oncePort = FALSE;
	come = 0;

	ForContentWeb = [[UIView alloc]initWithFrame:CGRectZero];
	[ForContentWeb setBackgroundColor:[UIColor clearColor]];
	[self.view addSubview:ForContentWeb];
	[ForContentWeb addSubview:webView];
	
	
	/*if(appDel.ori == UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{		
		ForContentWeb.frame = CGRectMake(35, 40, 690, 965);
		webView.frame = CGRectMake(0, 0, 690, 965);
		TopRed.frame=CGRectMake(0,0,768,48);
		TopRed.image= [UIImage imageNamed:@"_0009_top-red-band.png"];
		lblHEading.frame=CGRectMake(11,-4,700,48);
	}
	else {
		ForContentWeb.frame = CGRectMake(35, 40, 910, 705);
		webView.frame = CGRectMake(0, 0, 910, 705);
		TopRed.frame=CGRectMake(0,0,1004,48);
		TopRed.image=[UIImage imageNamed:@"_0006_top-red-band910.png"];
		lblHEading.frame=CGRectMake(-7,-4,950,48);
		
	}
*/
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(didRotate:) 
												 name:UIApplicationDidChangeStatusBarOrientationNotification
											   object:nil];
	
	[self didRotate:nil];
	}
	else 
	{
		activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(145, 205, 21, 21)];
		activity.hidden = TRUE;
		activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
		[self.view addSubview:activity];
	}
   
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
	activity.hidden = FALSE;
	[activity startAnimating];
	//NSString *jsCommand = [NSString stringWithFormat:@"document.body.style.zoom = 0.8;"];
	//[webView stringByEvaluatingJavaScriptFromString:jsCommand];
	
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	activity.hidden = TRUE;
	[activity stopAnimating];
	//NSString *jsCommand = [NSString stringWithFormat:@"document.body.style.zoom = 0.8;"];
	//NSString *jsCommand = [NSString stringWithFormat:@"document.head.style.zoom = 0.8;"];
	//[webView stringByEvaluatingJavaScriptFromString:jsCommand];
}



- (void) didRotate:(NSNotification *)notification
{
	NSLog(@"Twitter Didrotate");
	[webView reload];
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

-(void)setFrameOrientation_Portrait
{
	oncePort = TRUE;
	firstTime = FALSE;
	TopRed.frame=CGRectMake(0,0,768,48);
	TopRed.image= [UIImage imageNamed:@"_0009_top-red-band.png"];
	lblHEading.frame=CGRectMake(11,-4,700,48);
	ForContentWeb.frame = CGRectMake(35, 40, 655, 500);
	webView.frame = CGRectMake(0, 0, 655, 1004);
	//webView.frame = CGRectMake(35, 40, 690, 965);
}
-(void)setFrameOrientation_LandScap
{
	come++;
	NSLog(@"Come==%d",come);
	TopRed.frame=CGRectMake(0,0,1004,48);
	TopRed.image=[UIImage imageNamed:@"_0006_top-red-band910.png"];
	lblHEading.frame=CGRectMake(-7,-4,950,48);
	
	
	//webView.frame= CGRectMake(17, 40, 910, 705);
	
	/*
	if(firstTime == TRUE)
	{
		firstTime = FALSE;
		ForContentWeb.frame = CGRectMake(35, 40, 910, 710);
		webView.frame = CGRectMake(0, 0, 910, 710);
	}
	else {
		
		if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
		   appDel.ori == UIInterfaceOrientationLandscapeRight)
		{
			ForContentWeb.frame = CGRectMake(35, 40, 910, 710);
			webView.frame = CGRectMake(0, 0, 910, 710);
		}
		if(oncePort == TRUE)
		{
		ForContentWeb.frame = CGRectMake(14, 40, 910, 710);
		webView.frame= CGRectMake(0, 0, 910, 710);
		}
		else {
			ForContentWeb.frame = CGRectMake(35, 40, 910, 710);
			webView.frame = CGRectMake(0, 0, 910, 710);
		}

	}
	
	*/
	ForContentWeb.frame = CGRectMake(14, 40, 910, 710);
	webView.frame= CGRectMake(0, 0, 910, 710);

}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
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
