//
//  CourseInfoViewController.h
//  KrenMarketing
//
//  Created by Ankit Vyas on 14/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KrenMarketingAppDelegate.h"
#import "DatePickerCourseInfo.h"

@interface CourseInfoViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate> 
{
	IBOutlet UILabel *lblHeader;
	IBOutlet UIImageView *ImageQRCode;
	IBOutlet UIButton *BtnContinue;
	IBOutlet UITextField *lblPlaceholder;
	
	IBOutlet UITextField *txtCourseName;
	IBOutlet UITextField *txtCourseCode;
	IBOutlet UITextField *txtProfessor;
	IBOutlet UIButton *btnDaynTime;
	
	IBOutlet UIScrollView *scrollTexts;
	
	KrenMarketingAppDelegate *appDelegate;
	UIImage *image_Card;
	IBOutlet UIButton *btnQRCode;
	DatePickerCourseInfo *obj_date;
	int btnIndex;
	KrenMarketingAppDelegate *appDel;
}
@property (nonatomic,retain)UIImage *image_Card;
@property (nonatomic,readwrite)int btnIndex;
-(IBAction)BtnContinueClicked;
-(IBAction)btnLibraryClicked;
-(IBAction)btnPhotoLibraryClicked;
-(void)textFieldDidChange:(id)sender;
-(IBAction)BackToRoot;
-(IBAction)btnHomePressed:(id)sender;
-(IBAction)btnDayTimeClicked;

@end
