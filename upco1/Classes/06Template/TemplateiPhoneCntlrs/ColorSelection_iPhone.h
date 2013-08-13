//
//  ColorSelection_iPhone.h
//  KrenMarketing
//
//  Created by Jayna Gandhi on 13/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ColorSelection_iPhone : UIViewController {
	
	KrenMarketingAppDelegate *appDel;
	
	IBOutlet UIButton *whiteButton;
	IBOutlet UIButton *blackButton;
	IBOutlet UIButton *orangeButton;
	IBOutlet UIButton *redButton;
	IBOutlet UIButton *lightblueButton;
	IBOutlet UIButton *lightgreenButton;
	IBOutlet UIButton *grayButton;
	IBOutlet UIButton *darkblueButton;
	IBOutlet UIButton *darkgreenButton;
	IBOutlet UIButton *yellowButton;
	
	

}

-(IBAction)btnCancelPressed:(id)sender;
-(IBAction)btnDonePressed:(id)sender;
-(IBAction)btnColorPressed:(id)sender;
@end
