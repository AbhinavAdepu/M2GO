//
//  EmailDetailViewController.h
//  KrenMarketing
//
//  Created by Jayna Gandhi on 03/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EmailDetailViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate>
{
	IBOutlet UILabel *lblHeader;
	IBOutlet UIImageView *ImageQRCode;
	IBOutlet UIButton *BtnEncode;
	
	UILabel *dateLabel;
	UILabel *TimeLabel;
	NSMutableAttributedString *strattr;
	int height;
	NSString *sampleString;
	
	IBOutlet UITextField *txtFrom;
	IBOutlet UITextField *txtSubject;
	IBOutlet UITextView *txtMessage;
	IBOutlet UIScrollView *scrollTexts;
	IBOutlet UILabel *lblPlaceholder;
}
-(void)CheckValidation;
-(IBAction)GenerateQrCode;
-(IBAction)BackToRoot;
-(void)textFieldDidChange:(id)sender;
-(IBAction) QrGenerateCode:(id) sender;
-(BOOL) validateEmail: (NSString *) email ;

@end
