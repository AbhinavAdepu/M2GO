//
//  TwitterViewController.h
//  KrenMarketing
//
//  Created by Silvertouch on 17/11/11.
//  Copyright 2011 SilverTouch Tech. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TwitterViewController : UIViewController <UIWebViewDelegate>{
	IBOutlet UIWebView *webView;
	
	 IBOutlet UIImageView *TopRed;	
	IBOutlet UILabel *lblHEading;
	KrenMarketingAppDelegate *appDel;
	
	BOOL firstTime;
	BOOL oncePort;
	UIView *ForContentWeb;
	int come;
	
	UIActivityIndicatorView *activity;

}

-(void)setFrameOrientation_Portrait;
-(void)setFrameOrientation_LandScap;
- (void) didRotate:(NSNotification *)notification;

@end
