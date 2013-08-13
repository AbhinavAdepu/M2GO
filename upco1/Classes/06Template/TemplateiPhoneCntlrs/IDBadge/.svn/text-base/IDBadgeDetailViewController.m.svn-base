//
//  IDBadgeDetailViewController.m
//  KrenMarketing
//
//  Created by Ankit Vyas on 14/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "IDBadgeDetailViewController.h"
#import "LibraryViewController.h"
#import "ImageProcessingView_iPhone.h"

@implementation IDBadgeDetailViewController
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
}

-(IBAction)BackToRoot
{
	[self.navigationController popViewControllerAnimated:TRUE];
}


-(IBAction)btnHomePressed:(id)sender
{
	[self.navigationController popToViewController:[[self.navigationController viewControllers]objectAtIndex:1] animated:YES];
}

-(IBAction)BtnContinueClicked
{
	ImageProcessingView_iPhone *imageProcessingView_iPhone = [[ImageProcessingView_iPhone alloc]initWithNibName:@"ImageProcessingView_iPhone" bundle:nil];
	imageProcessingView_iPhone.EventTitle = txtCompnay.text;
	if([txtName.text length]>0)
		imageProcessingView_iPhone.StDate = txtName.text;
	else
		imageProcessingView_iPhone.StDate = @"";
	if([txtJobTitle.text length]>0)
		imageProcessingView_iPhone.EnDate =txtJobTitle.text;
	else
		imageProcessingView_iPhone.EnDate = @"";
	
	
	imageProcessingView_iPhone.image_Card = image_Card;
	imageProcessingView_iPhone.image_photoLib = img_picLib;
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
	UIImagePickerController *controller = [[UIImagePickerController alloc] init];
	[controller setDelegate:self];
	[self presentModalViewController:controller animated:TRUE];
}
#pragma mark imagePickerController

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[picker dismissModalViewControllerAnimated:YES];	
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	img_picLib = image;
	img_picLib = [[self imageWithImage:image scaledToSize:CGSizeMake(65,65)] retain];
	[btnPhotoLibImage setBackgroundImage:image forState:UIControlStateNormal];
	[self dismissModalViewControllerAnimated:YES];
}

- (UIImage*)imageWithImage:(UIImage*)image 
			  scaledToSize:(CGSize)newSize;
{
	UIGraphicsBeginImageContext( newSize );
	[image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newImage;
}
-(void)textFieldDidChange:(id)sender
{
	UITextField *txt = (id)sender;
	
	if(txt.tag == 0)
	{
		if([txtCompnay.text length] > 0)
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
		if([txtName.text length] > 0)
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
		if([txtJobTitle.text length] > 0)
		{
			BtnContinue.enabled = TRUE;
		}
		else 
		{
			BtnContinue.enabled = FALSE;
		}
	}
	
	if([txtCompnay.text length] > 0 || [txtName.text length] > 0 || [txtJobTitle.text length] >0 )
	{
		BtnContinue.enabled = TRUE;
	}
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if([textField isEqual:txtCompnay])
	{
		[txtName becomeFirstResponder];
	}
	if([textField isEqual:txtName])
	{
		[txtJobTitle becomeFirstResponder];
	}
	if([textField isEqual:txtJobTitle])
	{
		[txtJobTitle resignFirstResponder];
	}
	
	return YES;
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
