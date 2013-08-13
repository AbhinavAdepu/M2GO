//
//  BusinessCardDetailViewController.m
//  KrenMarketing
//
//  Created by Ankit Vyas on 14/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BusinessCardDetailViewController.h"
#import "LibraryViewController.h"
#import "ImageProcessingView_iPhone.h"

#define ALPHABET @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ  "
#define NUMBERS @" ()-1234567890"
#define ZIP @" 1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-"

@implementation BusinessCardDetailViewController
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
	
	scrollTexts.contentSize = CGSizeMake(0, 1000);
}
-(IBAction)BtnContinueClicked
{
		appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	ImageProcessingView_iPhone *imageProcessingView_iPhone = [[ImageProcessingView_iPhone alloc]initWithNibName:@"ImageProcessingView_iPhone" bundle:nil];
	appDel.aEventTitle = txtCompanyName.text;
	if([txtName.text length]>0)
		appDel.aStDate = txtName.text;
	else
		appDel.aStDate = @"";
	if([txtJobTitle.text length]>0)
		appDel.aEnDate =txtJobTitle.text;
	else
		appDel.aEnDate = @"";
	appDel.aphoneNo = nil;
    appDel.aNotes = nil;
	if([txtPhone.text length] > 0)
		appDel.aphoneNo = [NSString stringWithFormat:@"Phone Number: %@",txtPhone.text];
	if([txtEmail.text length] > 0)
		appDel.aNotes = [NSString stringWithFormat:@"%@%@",@"Email: ",txtEmail.text];
	
	appDel.astreetAdress = txtStreet.text;
	appDel.acity = txtCity.text;
	appDel.aState = txtState.text;
	appDel.aZip = txtZipCode.text;
	appDel.acountry = txtCountry.text;
	
	imageProcessingView_iPhone.image_Card = image_Card;
	imageProcessingView_iPhone.btnIndex = btnIndex;
	
	[self.navigationController pushViewController:imageProcessingView_iPhone animated:YES];
	[imageProcessingView_iPhone release];
}
/*
-(IBAction)BtnContinueClicked
{
	ImageProcessingView_iPhone *imageProcessingView_iPhone = [[ImageProcessingView_iPhone alloc]initWithNibName:@"ImageProcessingView_iPhone" bundle:nil];
	imageProcessingView_iPhone.EventTitle = txtCompanyName.text;
	if([txtName.text length]>0)
		imageProcessingView_iPhone.StDate = txtName.text;
	else
		imageProcessingView_iPhone.StDate = @"";
	if([txtJobTitle.text length]>0)
		imageProcessingView_iPhone.EnDate =txtJobTitle.text;
	else
		imageProcessingView_iPhone.EnDate = @"";
	
	if([txtPhone.text length] > 0)
		imageProcessingView_iPhone.phoneNo = [NSString stringWithFormat:@"%@%@",@"Phone: ",txtPhone.text];
	if([txtEmail.text length] > 0)
		imageProcessingView_iPhone.Notes = [NSString stringWithFormat:@"%@%@",@"Email: ",txtEmail.text];
	
	imageProcessingView_iPhone.streetAdress = txtStreet.text;
	imageProcessingView_iPhone.city = txtCity.text;
	imageProcessingView_iPhone.State = txtState.text;
	imageProcessingView_iPhone.Zip = txtZipCode.text;
	imageProcessingView_iPhone.country = txtCountry.text;
	
	imageProcessingView_iPhone.image_Card = image_Card;
	imageProcessingView_iPhone.btnIndex = btnIndex;
	
	[self.navigationController pushViewController:imageProcessingView_iPhone animated:YES];
	[imageProcessingView_iPhone release];
}*/
-(IBAction)btnHomePressed:(id)sender
{
	[self.navigationController popToViewController:[[self.navigationController viewControllers]objectAtIndex:1] animated:YES];
}
-(IBAction)BackToRoot
{
	[self.navigationController popViewControllerAnimated:TRUE];
}
-(IBAction)btnLibraryClicked
{
	LibraryViewController *obj_LibraryViewController = [[LibraryViewController alloc]initWithNibName:@"LibraryViewController" bundle:nil];
	obj_LibraryViewController.flagFromTemp = YES;
	[self presentModalViewController:obj_LibraryViewController animated:YES];
}
#pragma mark Email id & PhoneNumber
-(BOOL) validateEmail: (NSString *) email 
{
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	BOOL isValid = [emailTest evaluateWithObject:email];
	return isValid;
}

#pragma mark TextField delegateMethods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	
	if([textField isEqual:txtPhone]||[textField isEqual:txtStreet] ||
	   [textField isEqual:txtCity])
	{
		scrollTexts.contentOffset = CGPointMake(0,150);
	}
	if([textField isEqual:txtState]|| [textField isEqual:txtZipCode])
	{
		scrollTexts.contentOffset = CGPointMake(0,230);
	}
	if([textField isEqual:txtCountry])
	{
		scrollTexts.contentOffset = CGPointMake(0,280);
	}
	return YES;
}
-(void)textFieldDidChange:(id)sender
{
	UITextField *txt = (id)sender;
	if(txt.tag == 0)
	{
		if([txtCompanyName.text length] > 0)
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
	if(txt.tag == 2)
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
		
	if(txt.tag == 3)
	{
		if([txtEmail.text length] > 0)
		{
			BtnContinue.enabled = TRUE;
		}
		else 
		{
			BtnContinue.enabled = FALSE;
		}
	}
	
	if(txt.tag == 4)
	{
		if([txtPhone.text length] > 0)
		{
			BtnContinue.enabled = TRUE;
		}
		else 
		{
			BtnContinue.enabled = FALSE;
		}
	}
	if(txt.tag == 5)
	{
		if([txtStreet.text length] > 0)
		{
			BtnContinue.enabled = TRUE;
		}
		else 
		{
			BtnContinue.enabled = FALSE;
		}
	}
	if(txt.tag == 6)
	{
		if([txtCity.text length] > 0)
		{
			BtnContinue.enabled = TRUE;
		}
		else 
		{
			BtnContinue.enabled = FALSE;
		}
	}
	if(txt.tag == 7)
	{
		if([txtState.text length] > 0)
		{
			BtnContinue.enabled = TRUE;
		}
		else 
		{
			BtnContinue.enabled = FALSE;
		}
	}
	if(txt.tag == 8)
	{
		if([txtZipCode.text length] > 0)
		{
			BtnContinue.enabled = TRUE;
		}
		else 
		{
			BtnContinue.enabled = FALSE;
		}
	}
	if(txt.tag == 9)
	{
		if([txtCountry.text length] > 0)
		{
			BtnContinue.enabled = TRUE;
		}
		else 
		{
			BtnContinue.enabled = FALSE;
		}
	}
	
	if([txtCompanyName.text length] > 0 ||[txtName.text length] >0||[txtJobTitle.text length] >0|| [txtEmail.text length]>0|| [txtPhone.text length] >0 ||[txtStreet.text length] >0 || [txtCity.text length] > 0 || [txtState.text length] > 0 || [txtZipCode.text length] >0 || [txtCountry.text length] >0)
	{
		BtnContinue.enabled = TRUE;
	}
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{	
	
	
	if ([textField isEqual:txtCity]) 
	{
		NSCharacterSet *cs;
		NSString *filtered;
		cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHABET] invertedSet];
		filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		if ([filtered length]>0 )
		{
			BtnContinue.enabled = YES;
		}
		
		return [string isEqualToString:filtered];
	}
	else if ([textField isEqual:txtCountry]) 
	{
		NSCharacterSet *cs;
		NSString *filtered;
		cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHABET] invertedSet];
		filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		if ([filtered length]>0 )
		{
			BtnContinue.enabled = YES;
		}
		
		return [string isEqualToString:filtered];
	}
	
	else if ([textField isEqual:txtZipCode]) 
	{
		NSCharacterSet *cs;
		NSString *filtered;
		cs = [[NSCharacterSet characterSetWithCharactersInString:ZIP] invertedSet];
		filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		if ([filtered length]>0 )
		{
			BtnContinue.enabled = YES;
		}
		
		return [string isEqualToString:filtered];
	}
	
	else if ([textField isEqual:txtPhone]) 
	{
		NSCharacterSet *cs;
		NSString *filtered;
		cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
		filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		if ([filtered length]>0 )
		{
			BtnContinue.enabled = YES;
		}
		
		return [string isEqualToString:filtered];
	}
	
	
	return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if ([textField isEqual:txtCompanyName] ) 
	{
		[txtName becomeFirstResponder];
	}
	if ([textField isEqual:txtName] ) 
	{
		[txtJobTitle becomeFirstResponder];
	}
	if ([textField isEqual:txtJobTitle] ) 
	{
		[txtEmail becomeFirstResponder];
	}
	if ([textField isEqual:txtEmail] ) 
	{
		if([txtEmail.text length] > 0)
		{
			BOOL validEmail = [self validateEmail:txtEmail.text];
			if(validEmail)
			{
				[txtPhone becomeFirstResponder];
			}
			else {
				UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter valid EMAIL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				[alert show];
				[alert release];
			}
		}

		else {
			
			[txtPhone becomeFirstResponder];
		}

		
	}
	
	if ([textField isEqual:txtPhone] ) 
	{
		[txtStreet becomeFirstResponder];
	}
	if ([textField isEqual:txtStreet] ) 
	{
		[txtCity becomeFirstResponder];
	}
	if([textField isEqual:txtCity])
	{
		[txtState becomeFirstResponder];
	}
	if([textField isEqual:txtState])
	{
		[txtZipCode becomeFirstResponder];
	}
	if([textField isEqual:txtZipCode])
	{
		[txtCountry becomeFirstResponder];
	}
	if([textField isEqual:txtCountry])
	{
		[txtCountry resignFirstResponder];
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
