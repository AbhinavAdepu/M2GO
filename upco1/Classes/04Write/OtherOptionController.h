//
//  OtherOptionController.h
//  New_Task
//
//  Created by Paras Gandhi on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//deval hcuhadsfnadfnandf

#import <UIKit/UIKit.h>

@protocol OtherOptionDelegate <NSObject>

@optional
-(void) completeSelection:(NSMutableArray*) arr;

@end



@interface OtherOptionController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
	UITableView    *tblView;
	NSMutableArray *tblArr;
    
	//        NSMutableArray *secOneArr;
	//        NSMutableArray *secTwoArr;
	NSString *cellSelectedValue;
	id<OtherOptionDelegate> delegate;
	
	int selctedrow[10];
	int cnt;
	IBOutlet UINavigationBar *nvBar;
}
@property(nonatomic, retain)     id<OtherOptionDelegate> delegate;
@property(nonatomic, retain)  NSMutableArray *tblArr;
-(IBAction)DoneBtnClicked;
-(IBAction)CancelBtnClicked;
-(void) passObject :(id) obj;
@end
