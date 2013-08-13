//
//  DatePicker.m
//  KrenMarketing
//
//  Created by Deval Chauhan on 12/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DatePicker.h"

@implementation DatePicker
@synthesize delegate,str_date,flag;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (CGSize)contentSizeForViewInPopoverView {
	
    return CGSizeMake(320, 216);
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	UIBarButtonItem* done=[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneClicked:)];
	self.navigationItem.rightBarButtonItem=done;
	
	UIBarButtonItem* cancel=[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelClicked:)];
	self.navigationItem.leftBarButtonItem=cancel;
	picker.date = [NSDate date];
	//NSDateFormatter* df=[[[NSDateFormatter alloc]init] autorelease];
//	[df setDateFormat:@"EEE, MMM d HH:MM aaa"];
//	appDel.str_date = [df stringFromDate: [[NSDate date] copy]];
}
-(IBAction) dateChangeAction:(id) sender
{
	NSDateFormatter* df=[[[NSDateFormatter alloc]init] autorelease];
	[df setDateFormat:@"E MM/dd/yy h:mm aa"];
	appDel.str_date = [df stringFromDate: [picker date]];
	if([flag isEqualToString:@"End"])
	{
		appDel.end_str=[df stringFromDate: [picker date]];
		appDel.endDate = [[picker date] copy];
	}
	if ([flag isEqualToString:@"Start"]) {
		appDel.strDate= [picker date];
	}
}
-(void) doneClicked:(id) sender
{
	//compare date
		if([appDel.end_str length] > 0)
		{
			if ([appDel.endDate compare:appDel.strDate] == NSOrderedAscending)
			{
				NSLog(@"NSOrderedAscending");
				UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please select larger End date" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				[alert show];
				[alert release];
				
			}
			else {
				NSLog(@"NSOrderedDescending");
				[delegate dismissdatePopOver];
			}

	}
	else {
		
        
        
        
        
        
        
        
        
        
        
        
        
        

        
        
        [delegate dismissdatePopOver];
	}

	
}

-(void) cancelClicked:(id) sender
{
	appDel.str_date=@"";
	[delegate dismissdatePopOver];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
