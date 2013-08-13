//
//  CategorySelectViewController.h
//  KrenMarketing
//
//  Created by Ankit Vyas on 15/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KrenMarketingAppDelegate.h"
#import "KrenMarketingViewController.h"

@interface CategorySelectViewController : UIViewController
{
	IBOutlet UITableView *tabledata;
	
	NSMutableArray *array;
	
	KrenMarketingAppDelegate *appDelegate;
	
	KrenMarketingViewController *kerin;
	UIImage *img;

}

@property (nonatomic,retain)UIImage *img;
@end
