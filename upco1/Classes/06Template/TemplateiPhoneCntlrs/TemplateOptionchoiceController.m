//
//  TemplateOptionchoiceController.m
//  KrenMarketing
//
//  Created by Ankit Vyas on 03/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TemplateOptionchoiceController.h"
#import "EventDesignedTempViewController.h"
#import "UCDviewcontroller_iPhone.h"


@implementation TemplateOptionchoiceController

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
-(IBAction)btnBackPressed:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
	//[self.parentViewController viewWillAppear:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	if(appDel.indexForTemplate == 0)
	{
		lblHeading.text = @"Event";
		
	}
	else if(appDel.indexForTemplate == 1)
	{
		lblHeading.text = @"Business Cards";
	}
	else if(appDel.indexForTemplate == 2)
	{
		lblHeading.text = @"Invitation";
	}
	else if(appDel.indexForTemplate == 3)
	{
		lblHeading.text = @"ID Badge";
	}
	else if(appDel.indexForTemplate == 4)
	{
		lblHeading.text = @"Course Info";
	}
	
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(IBAction)btnUCDPressed:(id)sender
{
	
	UCDviewcontroller_iPhone *uCDviewcontroller_iPhone = [[UCDviewcontroller_iPhone alloc]initWithNibName:@"UCDviewcontroller_iPhone" bundle:nil];
	uCDviewcontroller_iPhone.strFlag = @"UCD";
	[self.navigationController pushViewController:uCDviewcontroller_iPhone animated:YES];
}
-(IBAction)btnUDTPressed:(id)sender
{
		EventDesignedTempViewController *eventDesignedTempViewController = [[EventDesignedTempViewController alloc]initWithNibName:@"EventDesignedTempViewController" bundle:nil];
		
		if([sender tag] == 0)
			eventDesignedTempViewController.strHeader = @"Use Designed Templates";
		eventDesignedTempViewController.strFlag = @"UDT";
		[self.navigationController pushViewController:eventDesignedTempViewController animated:nil];
		[eventDesignedTempViewController release];
	

	
	
}

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
