//
//  PreviewShareView_iPhone.m
//  KrenMarketing
//
//  Created by Ankit Vyas on 05/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PreviewShareView_iPhone.h"
#import "SHK.h"
#import "DAL.h"



@implementation PreviewShareView_iPhone
@synthesize imageBCard,strFlag,phoneNumber,align;
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
	btnCall.enabled = TRUE;
	imgViewBCard.image = imageBCard;
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	if(align == 0)
	{
		btnCall.frame = CGRectMake(15,155,80,20);
	}
	else if(align == 1)
	{
		btnCall.frame = CGRectMake(15,215,80,20);
	}
	else if(align == 2)
	{
		btnCall.frame = CGRectMake(15,155,80,20);
	}

	else if(align == 3)
	{
		btnCall.frame = CGRectMake(150,155,80,20);
	}

	if([strFlag isEqualToString:@"UCD"])
	{
		lblHeading.text = @"Upload a Completed Design";
	}
	else {
		lblHeading.text = @"Use Designed Templates";
	}

	//[self saveQrCode:imageBCard];
    [super viewDidLoad];
}

#pragma mark Shareing options
-(IBAction)btnTwitterClicked:(id)sender
{
	  
    
	SHKItem *item = [SHKItem image:imageBCard title:nil];
	[NSClassFromString(@"SHKTwitter") performSelector:@selector(shareItem:) withObject:item];
}

-(IBAction)btnFacebookClicked:(id)sender
{

    
    SHKItem *item = [SHKItem image:imgViewBCard.image title:nil];
//	[NSClassFromString(@"SHKFacebook") performSelector:@selector(shareItem:) withObject:item];
    //SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    
	// Display the action sheet
	//[actionSheet showFromToolbar:navigationController.toolbar];

    
//	SHKItem *item = [SHKItem image:imageBCard];
    
   /// NSString *someText = @"This is a blurb of text I highlighted from a document.";
   // SHKItem *item = [SHKItem text:someText];
    
	[NSClassFromString(@"SHKFacebook") performSelector:@selector(shareItem:) withObject:item];
}

-(IBAction)btnEmailClicked:(id)sender
{
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
	}
}

#pragma mark DeleteQRCode
-(IBAction)DeleteQRCode
{
	NSString *sql = [NSString stringWithFormat:@"select Image from library where Image =(SELECT MAX(Image) from library)"];
	NSMutableArray *array=[DAL ExecuteArraySet:sql];
	
	NSString  *sql1 =[NSString stringWithFormat:@"delete from library where Image = '%@' ",[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"Image"]]];
	
	[DAL ExecuteArraySet:sql1];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString * pdfname = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"Image"]]];	
	[[NSFileManager defaultManager] removeItemAtPath:pdfname error:nil];
	

	[[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadData" object:nil];
	
	[self.navigationController popToViewController:[[self.navigationController viewControllers]objectAtIndex:3] animated:YES];
	//[self.navigationController popViewControllerAnimated:TRUE];
}

-(void)displayComposerSheet
{
	
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	
	NSData *imgData = UIImagePNGRepresentation(imageBCard);
	[picker addAttachmentData:imgData mimeType:@"image/png" fileName:@"Result"];//[tmpBody release];
	
	[appDel.iphonerootController presentModalViewController:picker animated:YES];
	
}

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:jayna.gandhi@silvertouch.com?cc=second@example.com,third@example.com&subject=Hello from California!";
	NSString *body = @"&body=It is raining in sunny California!";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	//message.hidden = NO;
	
	[appDel.iphonerootController dismissModalViewControllerAnimated:YES];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(void)viewDidDisappear:(BOOL)animated
{}
-(void)viewWillDisappear:(BOOL)animated
{}
	
-(IBAction)btnCallPressed:(id)sender
{
	btnCall.enabled = NO;
	NSLog(@"phone==%@",phoneNumber);
	phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"Phone: " withString:@""];
	if([phoneNumber length] > 0)
	{
	NSString *callStr = [NSString stringWithFormat:@"tel:%@",phoneNumber];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:callStr]];
	}
}

-(IBAction)btnAddPressed:(id)sender
{
	appDel.QRImageFromLib = nil;
	[self.navigationController popToViewController:[[self.navigationController viewControllers]objectAtIndex:3] animated:YES];
}
-(IBAction)btnbackPressed:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
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
