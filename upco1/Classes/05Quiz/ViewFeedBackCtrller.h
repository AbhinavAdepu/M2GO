//
//  ViewFeedBackCtrller.h
//  KrenMarketing
//
//  Created by Jayna Gandhi on 02/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewFeedBackCtrller : UIViewController {
	
	KrenMarketingAppDelegate *appDel;
	int gPage;
	IBOutlet UILabel *lblQNo;
	IBOutlet UILabel *lblQuestion;
	IBOutlet UILabel *lblanswer;
	IBOutlet UIImageView *signImgView;
	
	IBOutlet UIButton *btnEmail;
	
	IBOutlet UILabel *lblTopic,*lblPage,*lblLO,*lblStudyingneeds,*lblNeed,*lblCorrectAns;
	IBOutlet UILabel *lblheadTopic,*lblheadPage,*lblheadLO,*lblheadStudyingneeds,*lblheadNeed,*lblheadCorrectAns,*lblheadRationale;
	
	IBOutlet UILabel *lblRationale;
	
	IBOutlet UIView *feedbackViewBox;
	
	UILabel *lblrelation;
	
	CGFloat y_pos;
    int corans;

	IBOutlet UIImageView *feedbackimage,*feedbackHeader;
	
	

}

-(IBAction)emailbtn_click:(id)sender;

@end
