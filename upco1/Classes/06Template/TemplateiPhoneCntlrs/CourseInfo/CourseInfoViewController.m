//
//  CourseInfoViewController.m
//  KrenMarketing
//
//  Created by Ankit Vyas on 14/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseInfoViewController.h"

#import "LibraryViewController.h"
#import "ImageProcessingView_iPhone.h"

@implementation CourseInfoViewController
@synthesize image_Card,btnIndex;
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

-(void)viewWillAppear:(BOOL)animated
{
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	if(appDel.QRImageFromLib)
		[btnQRCode setBackgroundImage:appDel.QRImageFromLib forState:UIControlStateNormal];
	else {
		[btnQRCode setBackgroundImage:[UIImage imageNamed:@"ivBackground.png"] forState:UIControlStateNormal];
	}
	
	///// For Add Gestures /////////
	UILongPressGestureRecognizer *longpressGestureEvent = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandler:)];
    longpressGestureEvent.minimumPressDuration = 1;
    [longpressGestureEvent setDelegate:self];
	[btnQRCode addGestureRecognizer:longpressGestureEvent];
	[longpressGestureEvent release];
	
}
	
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	appDelegate = (KrenMarketingAppDelegate*)[[UIApplication sharedApplication]delegate];
	
	scrollTexts.contentSize = CGSizeMake(0, 500);
	
	appDelegate.strEndTime= @"";
	appDelegate.mon = FALSE;
	appDelegate.tue = FALSE;
	appDelegate.wed = FALSE;
	appDelegate.thu = FALSE;
	appDelegate.fri = FALSE;
	appDelegate.sat = FALSE;
	appDelegate.sun = FALSE;
}
-(IBAction)btnHomePressed:(id)sender
{
	[self.navigationController popToViewController:[[self.navigationController viewControllers]objectAtIndex:1] animated:YES];
}
/*-(IBAction)BtnContinueClicked
{
	ImageProcessingView_iPhone *imageProcessingView_iPhone = [[ImageProcessingView_iPhone alloc]initWithNibName:@"ImageProcessingView_iPhone" bundle:nil];
	if([txtCourseName.text length] > 0)
		imageProcessingView_iPhone.EventTitle =[NSString stringWithFormat:@"%@%@",@"Course Name: ",txtCourseName.text];
	else
		imageProcessingView_iPhone.EventTitle = @"";
	if([txtCourseCode.text length]>0)
		imageProcessingView_iPhone.StDate = [NSString stringWithFormat:@"%@%@",@"Course Code: ",txtCourseCode.text];
	else
		imageProcessingView_iPhone.StDate = @"";
	if([txtProfessor.text length]>0)
		imageProcessingView_iPhone.EnDate =[NSString stringWithFormat:@"%@%@",@"Professor: ",txtProfessor.text];
	else
		imageProcessingView_iPhone.EnDate = @"";
	if([lblPlaceholder.text length] > 0)
		imageProcessingView_iPhone.Notes = [NSString stringWithFormat:@"%@%@",@"Day and Time: ",lblPlaceholder.text];
	else
		imageProcessingView_iPhone.Notes = @"";
		
	imageProcessingView_iPhone.image_Card = image_Card;
	imageProcessingView_iPhone.btnIndex = btnIndex;
	
	[self.navigationController pushViewController:imageProcessingView_iPhone animated:YES];
	[imageProcessingView_iPhone release];
}*/
-(IBAction)BtnContinueClicked
{
	ImageProcessingView_iPhone *imageProcessingView_iPhone = [[ImageProcessingView_iPhone alloc]initWithNibName:@"ImageProcessingView_iPhone" bundle:nil];
    
    appDel.aphoneNo = nil;
    appDel.aNotes = nil;
    
	if([txtCourseName.text length] > 0)
		appDelegate.aEventTitle =[NSString stringWithFormat:@"%@%@",@"Course Name: ",txtCourseName.text];
	else
		appDelegate.aEventTitle = @"";
	if([txtCourseCode.text length]>0)
		appDelegate.aStDate = [NSString stringWithFormat:@"%@%@",@"Course Code: ",txtCourseCode.text];
	else
		appDelegate.aStDate = @"";
	if([txtProfessor.text length]>0)
		appDelegate.aEnDate =[NSString stringWithFormat:@"%@%@",@"Professor: ",txtProfessor.text];
	else
		appDelegate.aEnDate = @"";
	if([lblPlaceholder.text length] > 0)
		appDelegate.aNotes = [NSString stringWithFormat:@"%@%@",@"Day and Time: ",lblPlaceholder.text];
	else
		appDelegate.aNotes = @"";
	
	imageProcessingView_iPhone.image_Card = image_Card;
	imageProcessingView_iPhone.btnIndex = btnIndex;
	
	[self.navigationController pushViewController:imageProcessingView_iPhone animated:YES];
	[imageProcessingView_iPhone release];
}
-(IBAction)btnLibraryClicked
{
	LibraryViewController *obj_LibraryViewController = [[LibraryViewController alloc]initWithNibName:@"LibraryViewController" bundle:nil];
	obj_LibraryViewController.flagFromTemp = YES;
	[self presentModalViewController:obj_LibraryViewController animated:YES];
}
-(IBAction)btnPhotoLibraryClicked
{
	
}
-(void)textFieldDidChange:(id)sender
{
	UITextField *txt = (id)sender;
	
	if(txt.tag == 0)
	{
		if([txtCourseName.text length] > 0)
		{
			BtnContinue.enabled = TRUE;
		}
		else 
		{
			BtnContinue.enabled = FALSE;
		}
	}
	if(txt.tag == 1)
	{
		if([txtCourseCode.text length] > 0)
		{
			BtnContinue.enabled = TRUE;
		}
		else 
		{
			BtnContinue.enabled = FALSE;
		}
	}
	if(txt.tag == 2)
	{
		if([txtProfessor.text length] > 0)
		{
			BtnContinue.enabled = TRUE;
		}
		else 
		{
			BtnContinue.enabled = FALSE;
		}
	}
	if([txtCourseName.text length] > 0 || [txtCourseCode.text length] > 0 || [txtProfessor.text length] >0 )
	{
		BtnContinue.enabled = TRUE;
	}
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
	if([textField isEqual:txtCourseName])
	{
		[txtCourseCode becomeFirstResponder];
	}
	if([textField isEqual:txtCourseCode])
	{
		[txtProfessor becomeFirstResponder];
	}
	if([textField isEqual:txtProfessor])
	{
		
		[txtProfessor resignFirstResponder];
		[self btnDayTimeClicked];
	}
	
	
	return YES;
}

-(IBAction)BackToRoot
{
	[self.navigationController popViewControllerAnimated:TRUE];
}
-(IBAction)btnDayTimeClicked
{
	[txtCourseCode resignFirstResponder];
	[txtCourseName resignFirstResponder];
	[txtProfessor resignFirstResponder];
	
	appDelegate.strStartTime = @"";
	obj_date = [[DatePickerCourseInfo alloc] initWithNibName:@"DatePickerCourseInfo" bundle:nil];
	[self presentModalViewController:obj_date animated:TRUE];
	obj_date.delegateCourseInfo = self;
	[obj_date release];
}

#pragma mark longPressHandler
- (void)longPressHandler:(UILongPressGestureRecognizer *)gestureRecognizer {
	
	if(UIGestureRecognizerStateBegan == gestureRecognizer.state) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure, you want to delete QR Code?" delegate:self  cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok",nil];
		alert.tag = 1000;
		[alert show];
		[alert release];
    }
	
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex==1) 
	{
		[btnQRCode setBackgroundImage:[UIImage imageNamed:@"ivBackground.png"] forState:UIControlStateNormal];
		appDel.QRImageFromLib = nil;
	}
	
	
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void) dismissdatePopOver
{
	[txtCourseCode resignFirstResponder];
		[txtCourseName resignFirstResponder];
		[txtProfessor resignFirstResponder];
		
	appDelegate.strStartTime = @"";
	
	lblPlaceholder.text = appDelegate.str_date;
	[self dismissModalViewControllerAnimated:TRUE];
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
