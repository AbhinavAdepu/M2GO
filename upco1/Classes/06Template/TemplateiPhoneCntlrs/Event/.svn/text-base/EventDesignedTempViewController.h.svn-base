//
//  EventDesignedTempViewController.h
//  KrenMarketing
//
//  Created by Ankit Vyas on 03/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EventDesignedTempViewController : UIViewController {
	
	IBOutlet UILabel *lblHeading;
	NSString *strHeader;
	NSArray *coversOriginal,*covers;
	IBOutlet UIScrollView *scr_Templates;
	IBOutlet OMPageControl *pageController_TemplatesCards;
	BOOL pageControlIsChangingPage;
	
	KrenMarketingAppDelegate *appDel;
	UIImage *image_Card;
	int btnIndex;
	NSString *strFlag;

}
@property (nonatomic,retain)UIImage *image_Card;
@property (nonatomic,readwrite)int btnIndex;
@property (nonatomic,retain)NSString *strFlag;
-(IBAction)btnChoosePressed:(id)sender;
-(IBAction)changePage:(id)sender;
-(IBAction)btnBackPressed:(id)sender;
-(IBAction)btnHomePressed:(id)sender;

@property (nonatomic,retain)NSString *strHeader;
@end
