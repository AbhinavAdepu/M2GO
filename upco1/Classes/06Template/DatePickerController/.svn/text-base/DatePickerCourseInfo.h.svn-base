//
//  DatePickerCourseInfo.h
//  KrenMarketing
//
//  Created by Deval Chauhan on 1/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KrenMarketingAppDelegate.h"
@protocol dateSelectionDelegateCoureInfo <NSObject>
@end
@interface DatePickerCourseInfo : UIViewController <UIPickerViewDelegate>{
	IBOutlet UITableView *tbl_Datepicker;
	id<dateSelectionDelegateCoureInfo> delegateCourseInfo;
	IBOutlet UIPickerView *picker;
	NSMutableArray *array_Hour,*array_Minute,*array_AmPm;
	BOOL flagStartEndTime;
	IBOutlet UILabel *lbl_StartTime,*lbl_EndTime;
	NSString *str_Hour,*str_Minute,*str_AmPm;
	BOOL mon,tue,wed,thu,fri,sat,sun;
	UIButton *btn_Mon,*btn_Tue,*btn_Wed,*btn_Thu,*btn_Fri,*btn_Sat,*btn_Sun;

	KrenMarketingAppDelegate *appDel;
	NSString *days;
	IBOutlet UINavigationBar *nvBar;
}
@property(nonatomic, retain) id<dateSelectionDelegateCoureInfo> delegateCourseInfo;

-(IBAction)DoneBtnClicked;
-(void) doneClicked:(id) sender;

@end
