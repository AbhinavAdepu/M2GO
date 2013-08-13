//
//  TemplateOptionchoiceController.h
//  KrenMarketing
//
//  Created by Ankit Vyas on 03/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TemplateOptionchoiceController : UIViewController {
	IBOutlet UIButton *btnUDT;
	IBOutlet UIButton *btnUCD;
	KrenMarketingAppDelegate *appDel;
	IBOutlet UILabel *lblHeading;

}

-(IBAction)btnBackPressed:(id)sender;
-(IBAction)btnUDTPressed:(id)sender;
-(IBAction)btnUCDPressed:(id)sender;
@end
