//
//  ViewFeedBack_iPhone.h
//  KrenMarketing
//
//  Created by Jayna Gandhi on 27/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"


@interface ViewFeedBack_iPhone : UIViewController {
	IBOutlet UIScrollView *scrEmailFeedBack_verti;
	KrenMarketingAppDelegate *appDel;
	int gPage;
	
	IBOutlet UILabel *lblQuestion;
	IBOutlet UILabel *lblQNo;
	IBOutlet UILabel *lblAnswer;
	IBOutlet UIImageView *imgoption;
	IBOutlet UIButton *btnEmail;
	
	IBOutlet UILabel *lblCorrectAns,*lblTopic,*lblPage,*lblLO,*lblRationale;
	IBOutlet UILabel *lblheadCorrectAns,*lblheadTopic,*lblheadPage,*lblheadLO,*lblheadRationale;
	
	IBOutlet UIView *feedbackViewBox;
	IBOutlet UIImageView *feedbackimage,*feedbackimageHeader;
	
	
	CGFloat y_pos;
	
	OHAttributedLabel *txtDisplay;
	NSArray *arr_queset;

	int height;
}

-(IBAction)emailbtn_click:(id)sender;

@end
