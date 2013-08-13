//
//  MapLocationViewController.h
//  KrenMarketing
//
//  Created by Jayna Gandhi on 03/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"

@interface MapLocationViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{
	UILabel *dateLabel;
	UILabel *TimeLabel;
	NSMutableAttributedString *strattr;
	IBOutlet UIImageView *ImageQRCode;
	int height;
	IBOutlet UILabel *lblHeader;
	
	IBOutlet UITextField *txtStreet;
	IBOutlet UITextField *txtCity;
	IBOutlet UITextField *txtState;
	IBOutlet UITextField *txtZipCode;
	IBOutlet UITextField *txtCountry;
	
	IBOutlet UITextView *txtNotes;
	IBOutlet UILabel *lblPlaceholder;
	
	IBOutlet UIScrollView *scrollTexts;
	IBOutlet UIButton *BtnEncode;
	NSString *sampleString;
}
-(IBAction)GenerateQrCode;
-(IBAction)BackToRoot;
-(void)textFieldDidChange:(id)sender;

@end
