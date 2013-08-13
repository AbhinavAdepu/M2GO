//
//  DatePicker.h
//  KrenMarketing
//
//  Created by Deval Chauhan on 12/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KrenMarketingAppDelegate.h"
@protocol dateSelectionDelegate <NSObject>
@end
@interface DatePicker : UIViewController {
	IBOutlet UIDatePicker *picker;
	id<dateSelectionDelegate> delegate;
	NSString *str_date;
	KrenMarketingAppDelegate *appDel;
	NSString *flag;
	
	
}
@property(nonatomic, retain) id<dateSelectionDelegate> delegate;
@property(nonatomic, retain) NSString *str_date;
@property(nonatomic, retain) NSString *flag;
-(IBAction) dateChangeAction:(id) sender;
@end
