    //
//  CategorySelectViewController.m
//  KrenMarketing
//
//  Created by Ankit Vyas on 15/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CategorySelectViewController.h"


@implementation CategorySelectViewController
@synthesize img;
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Save QR Code to Library"
												   message:@"Do you want to save this QR Code to the Library?" 
												  delegate:self 
										 cancelButtonTitle:@"Save"
										 otherButtonTitles:@"Don't Save",nil];
	
	[alert show];
	[alert release];
	
    [super viewDidLoad];
	
	
	
	
	appDelegate = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	array = [[NSMutableArray alloc] initWithObjects:@"Event "
			 ,@"Map Location"
			 ,@"Phone "
			 ,@"SMS "
			 ,@"Contact "
			 ,@"URL"
			 ,@"Text "
			 ,@"Email "
			 ,@"Do not add to Library"
			 ,nil];
	
	kerin = [[KrenMarketingViewController alloc]init];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	

	
	
	if(buttonIndex == 1)
	{
	[self dismissModalViewControllerAnimated:TRUE];
	}
	else {
		[self dismissModalViewControllerAnimated:TRUE];
		[kerin saveQrCode:img];
		
	}
	
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{	
	return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	
	cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	appDelegate.catString = [array objectAtIndex:indexPath.row];
	
	if([appDelegate.catString isEqualToString:@"Do not add to Library"])
	{
		[self dismissModalViewControllerAnimated:TRUE];
	}
	else 
	{
		[self dismissModalViewControllerAnimated:TRUE];
		[kerin saveQrCode:img];
	}
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
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
