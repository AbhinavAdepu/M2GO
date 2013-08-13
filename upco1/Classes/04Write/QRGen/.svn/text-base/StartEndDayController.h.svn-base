//
//  StartEndDayController.h
//  test
//
//  Created by Paras Gandhi on 12/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol dateSelectionDelegate <NSObject>

//@interface dateSelectionDelegate(Private)<CLLocationManagerDelegate> 
//@end

@optional
-(void) completeDateselection:(NSString*) sDate:(NSString*) eDate:(NSString*) allday;
-(void)calledendclick;
-(void)event3respond;
@end


@interface StartEndDayController : UIViewController {
	
	IBOutlet UIDatePicker* picker;
	NSDate* startDate;
	NSDate* endDate;
	IBOutlet UITableView* tblView;
	id<dateSelectionDelegate> delegate;
	
	int selected;
	NSString* sdate;
	NSString* edate;
	NSString* allday;
	
	NSString* selectedDate;
	NSString *isFrom;
	BOOL flagDoneClick;
	
	
	//IPhone
	IBOutlet UINavigationBar *navHeaderBar;
	
	IBOutlet UIDatePicker *dtPickerView;
}
@property(nonatomic, retain) NSString* selectedDate;
@property(nonatomic, retain) id<dateSelectionDelegate> delegate;
@property(nonatomic, retain) NSDate* startDate;
@property(nonatomic, retain) NSDate* endDate;
@property(nonatomic, retain) NSString *isFrom;
-(IBAction) dateChangeAction:(id) sender;
-(IBAction)btnBackPressed:(id)sender;

-(void) doneClicked:(id) sender;
@end
