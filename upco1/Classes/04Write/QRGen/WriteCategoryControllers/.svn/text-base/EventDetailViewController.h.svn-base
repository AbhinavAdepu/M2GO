//
//  EventDetailViewController.h
//  KrenMarketing
//
//  Created by amrit on 04/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartEndDayController.h"

@interface EventDetailViewController : UIViewController <UITextFieldDelegate,UIScrollViewDelegate,dateSelectedDelegate,UITextViewDelegate>
{	
	IBOutlet UILabel *lblHeader;
	IBOutlet UIImageView *ImageQRCode;
	IBOutlet UIButton *BtnEncode;
	
	UILabel *dateLabel;
	UILabel *TimeLabel;
	NSMutableAttributedString *strattr;
	int height;
	NSString *sampleString;
	
	IBOutlet UITextField *txtEventTitle;
	IBOutlet UITextField *txtStreet;
	IBOutlet UITextField *txtCity;
	IBOutlet UITextField *txtState;
	IBOutlet UITextField *txtZipCode;
	IBOutlet UITextField *txtCountry;
	
	IBOutlet UITextView *txtNotes;
	IBOutlet UILabel *lblPlaceholder;
	
	IBOutlet UIScrollView *scrollTexts;
	IBOutlet UIButton *btnStartDate;
	IBOutlet UIButton *btnEndDate;
	
	IBOutlet UILabel *LblDate1;
	IBOutlet UILabel *LblDate2;
	NSString *strFlagForTextfield;
}

-(IBAction)startDateClicked;
-(IBAction)endDateClicked;

-(IBAction)GenerateQrCode;
-(IBAction)BackToRoot;
-(void)textFieldDidChange:(id)sender;

@end
