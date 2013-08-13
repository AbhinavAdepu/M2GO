//
//  EventDTDetail.h
//  KrenMarketing
//
//  Created by Ankit Vyas on 03/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EventDTDetail : UIViewController {
	
	IBOutlet UIScrollView *scr_EventView;
	IBOutlet UITextField *txt_ZipCode;
	IBOutlet UITextField *txt_State;
	IBOutlet UITextField *txt_City;
	IBOutlet UITextField *txt_Country;
	IBOutlet UITextField *txt_EventTitle;
	IBOutlet UITextField *txt_Address;
	IBOutlet UITextView *tv_Notes;
	IBOutlet UILabel *txt_Start;
	IBOutlet UILabel *txt_End;
	IBOutlet UILabel *lblPlaceholder;
	
	NSString *strFlagForTextfield;
	UIImage *image_Card;
	
	IBOutlet UIButton *btnQRCode;
	NSString *strFlag; 
	
	int btnIndex;
	KrenMarketingAppDelegate *appDel;

}
-(IBAction)btnStartDateClicked:(id)sender;
-(IBAction)btnEndDateClicked:(id)sender;
-(IBAction)btnContinueClicked:(id)sender;
-(IBAction)btnbackPressed:(id)sender;
-(IBAction)btnHomePressed:(id)sender;
-(IBAction)btnNavToLib:(id)sender;
@property (nonatomic,retain)UIImage *image_Card;
@property (nonatomic,retain)NSString *strFlag;
@property (nonatomic,readwrite)int btnIndex;
@end
