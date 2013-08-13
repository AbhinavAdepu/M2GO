//
//  ColorSelection_iPhone.m
//  KrenMarketing
//
//  Created by Jayna Gandhi on 13/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ColorSelection_iPhone.h"


@implementation ColorSelection_iPhone

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
- (void)viewDidLoad {
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
    [super viewDidLoad];
}


-(IBAction)btnCancelPressed:(id)sender
{
	appDel.bgTempColor = [UIColor clearColor];
	[self dismissModalViewControllerAnimated:YES];
}
-(IBAction)btnDonePressed:(id)sender
{
	if(appDel.bgTempColor == nil)
		appDel.bgTempColor = [UIColor clearColor];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"bg_ChangeTempColor" object:nil];
	[self dismissModalViewControllerAnimated:YES];
}
-(IBAction)btnColorPressed:(id)sender
{
	UIButton *tempbtn = (UIButton *)sender;
	tempbtn.selected = YES;
	appDel.bgTempColor = nil;
	if([tempbtn isEqual:whiteButton ])
	{
		appDel.bgTempColor = [UIColor colorWithRed:1.0000 green:1.0000 blue:1.0000 alpha:1];
		blackButton.selected = NO;
		orangeButton.selected = NO;
		lightblueButton.selected = NO;
		lightgreenButton.selected = NO;
		grayButton.selected = NO;
		redButton.selected = NO;
		darkblueButton.selected = NO;
		darkgreenButton.selected = NO;
		yellowButton.selected = NO;
	}
	if([tempbtn isEqual:blackButton ])
	{
		appDel.bgTempColor = [UIColor colorWithRed:0.0000 green:0.0000 blue:0.0000 alpha:1];
		whiteButton.selected = NO;
		orangeButton.selected = NO;
		lightblueButton.selected = NO;
		lightgreenButton.selected = NO;
		grayButton.selected = NO;
		redButton.selected = NO;
		darkblueButton.selected = NO;
		darkgreenButton.selected = NO;
		yellowButton.selected = NO;
	}
	if([tempbtn isEqual:orangeButton])
	{
		appDel.bgTempColor = [UIColor colorWithRed:0.9608 green:0.2902 blue:0.0000 alpha:1];
		whiteButton.selected = NO;
		blackButton.selected = NO;
		lightblueButton.selected = NO;
		lightgreenButton.selected = NO;
		grayButton.selected = NO;
		redButton.selected = NO;
		darkblueButton.selected = NO;
		darkgreenButton.selected = NO;
		yellowButton.selected = NO;
	}
	if([tempbtn isEqual:lightblueButton])
	{
		appDel.bgTempColor = [UIColor colorWithRed:0.3882 green:0.8000 blue:0.8745 alpha:1];
		orangeButton.selected = NO;
		whiteButton.selected = NO;
		blackButton.selected = NO;
		
		lightgreenButton.selected = NO;
		grayButton.selected = NO;
		redButton.selected = NO;
		darkblueButton.selected = NO;
		darkgreenButton.selected = NO;
		yellowButton.selected = NO;
	}
	if([tempbtn isEqual:lightgreenButton])
	{
		appDel.bgTempColor = [UIColor colorWithRed:0.2549 green:0.6275 blue:0.1804 alpha:1];
		orangeButton.selected = NO;
		whiteButton.selected = NO;
		blackButton.selected = NO;
		lightblueButton.selected = NO;
		
		grayButton.selected = NO;
		redButton.selected = NO;
		darkblueButton.selected = NO;
		darkgreenButton.selected = NO;
		yellowButton.selected = NO;
	
	}
	
	
	if([tempbtn isEqual:grayButton])
	{
		appDel.bgTempColor = [UIColor colorWithRed:0.6667 green:0.6667 blue:0.6667 alpha:1];
		orangeButton.selected = NO;
		whiteButton.selected = NO;
		blackButton.selected = NO;
		lightblueButton.selected = NO;
		lightgreenButton.selected = NO;
		
		redButton.selected = NO;
		darkblueButton.selected = NO;
		darkgreenButton.selected = NO;
		yellowButton.selected = NO;
	}
	if([tempbtn isEqual:redButton])
	{
		appDel.bgTempColor = [UIColor colorWithRed:0.7882 green:0.0000 blue:0.0000 alpha:1];
		orangeButton.selected = NO;
		whiteButton.selected = NO;
		blackButton.selected = NO;
		lightblueButton.selected = NO;
		lightgreenButton.selected = NO;
		grayButton.selected = NO;
		
		darkblueButton.selected = NO;
		darkgreenButton.selected = NO;
		yellowButton.selected = NO;
	}
	if([tempbtn isEqual:darkblueButton])
	{
		appDel.bgTempColor = [UIColor colorWithRed:0.0902 green:0.5451 blue:0.7490 alpha:1];
		orangeButton.selected = NO;
		whiteButton.selected = NO;
		blackButton.selected = NO;
		lightblueButton.selected = NO;
		lightgreenButton.selected = NO;
		grayButton.selected = NO;
		redButton.selected = NO;
		
		darkgreenButton.selected = NO;
		yellowButton.selected = NO;
	}
	if([tempbtn isEqual:darkgreenButton])
	{
		appDel.bgTempColor = [UIColor colorWithRed:0.2314 green:0.4588 blue:0.1529 alpha:1];
		orangeButton.selected = NO;
		whiteButton.selected = NO;
		blackButton.selected = NO;
		lightblueButton.selected = NO;
		lightgreenButton.selected = NO;
		grayButton.selected = NO;
		redButton.selected = NO;
		darkblueButton.selected = NO;
		
		yellowButton.selected = NO;
	}
	if([tempbtn isEqual:yellowButton])
	{
		appDel.bgTempColor = [UIColor colorWithRed:0.9961 green:0.7294 blue:0.0745 alpha:1];
		orangeButton.selected = NO;
		whiteButton.selected = NO;
		blackButton.selected = NO;
		lightblueButton.selected = NO;
		lightgreenButton.selected = NO;
		grayButton.selected = NO;
		redButton.selected = NO;
		darkblueButton.selected = NO;
		darkgreenButton.selected = NO;
		
	}
	

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
