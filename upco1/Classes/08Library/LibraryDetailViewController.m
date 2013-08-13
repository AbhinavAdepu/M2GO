//
//  LibraryDetailViewController.m
//  KrenMarketing
//
//  Created by Ankit Vyas on 22/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LibraryDetailViewController.h"
#import "DAL.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "SHKItem.h"
#import "SHKActionSheet.h"
#import "generalcalculations.h"

@implementation LibraryDetailViewController

@synthesize changeColor,array_catagory;

-(id)initWithImage:(UIImage *)QRImage text:(NSString*)textLable topText:(NSString *)toptextLable string:(NSMutableAttributedString*)str index:(int)index ImageName:(NSString*)imagedesc
{
	if (self = [super init])
	{
        appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
        flagcon=flageven=flagphon=YES;
        actbutl=[[UIButton alloc]init];
        lblcalendarnote=[[UITextView alloc]init];
		catDes = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 50, 30)];
		
		txtScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, 320, 300)];
		//	txtScroll.backgroundColor = [UIColor redColor];
		
		qrcodeImage	=	[[UIImageView alloc] initWithImage:QRImage];
		qrcodeImage.frame = CGRectMake(7, 10, 100, 100);
		
		createdDate	=	[[UILabel alloc] initWithFrame:CGRectMake(110,30,190,60)];
		createdDate.text	=	textLable;
		NSLog(@"%@",createdDate.text);
		createdDate.numberOfLines = 2;
		createdDate.font = [UIFont fontWithName:@"Helvetica" size:14];
		createdDate.backgroundColor = [UIColor clearColor];
		
		topLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 18, 200, 21)];
		topLabel.text = toptextLable;
		topLabel.textAlignment = UITextAlignmentLeft;
		topLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor blackColor];
		
		/*
		if([topLabel.text isEqualToString:@"IDBadge"])
		{
			qrcodeImage.frame = CGRectMake(15, 120, 290, 152);
			createdDate.frame = CGRectMake(15, 25, 190, 60);
			topLabel.frame = CGRectMake(15, 10, 200, 21);
		}
		*/
		 
		txtDisplay = [[OHAttributedLabel alloc]init];
		txtDisplay.frame = CGRectMake(16, 130, 290, index);
		txtDisplay.attributedText = str;
		[txtScroll addSubview:txtDisplay];
        if([topLabel.text isEqualToString:@"Event"])
        {
         
            txtDisplay.textColor=[UIColor blackColor];
            txtDisplay.linkColor = [UIColor blackColor];
               [txtDisplay removeAllCustomLinks];
            
        }
        if([topLabel.text isEqualToString:@"CourseInfo"])
        {
            txtDisplay.textColor=[UIColor blackColor];
             txtDisplay.linkColor = [UIColor blackColor];
            [txtDisplay removeAllCustomLinks];
        }
        
        
        
//        if([topLabel.text isEqualToString:@"Phone"])
//        {
//            txtDisplay.linkColor = [UIColor blueColor];
//        }
		//[self MainDescription];
		//[self performSelectorInBackground:@selector(MainDescription) withObject:nil];
        appDel.dataper=@"";
        appDel.dataper=[str string];
        
        NSLog(@"text stting for calculation in lib:%@",[str string]);
        generalcalculations *geni=[[generalcalculations alloc]init];
        
        if([topLabel.text isEqualToString:@"Contact"])
        {
            
            NSString *txtstring=[str string];
            if([geni canbeadded:txtstring :@"Contact" :0])
            {
               [actbutl setImage:[UIImage imageNamed:@"activecontact.png"] forState:UIControlStateNormal]; 
                [actbutl setEnabled:YES];
                flagcon=YES;
            }
            else {
                [actbutl setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
                  [actbutl setEnabled:NO];
                flagcon=NO;
            }
            
            
        }
        if([topLabel.text isEqualToString:@"Phone"])
        {
            NSString *txtstring=[str string];
            if([geni canbeadded:txtstring :@"Phone" :0])
            {
                [actbutl setImage:[UIImage imageNamed:@"activecontact.png"] forState:UIControlStateNormal]; 
                  [actbutl setEnabled:YES];
                flagphon=YES;
            }
            else {
                [actbutl setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
                  [actbutl setEnabled:NO];
                flagphon=NO;
            }

           
        }
        if([topLabel.text isEqualToString:@"Event"])
        {
            NSString *txtstring=[str string];
            if([geni canbeadded:txtstring :@"Event" :0])
            {
                [actbutl setImage:[UIImage imageNamed:@"calenderactive.png"] forState:UIControlStateNormal]; 
                  [actbutl setEnabled:YES];
                flageven=YES;
            }
            else {
                [actbutl setImage:[UIImage imageNamed:@"inactivecalender.png"] forState:UIControlStateNormal];
                  [actbutl setEnabled:NO];
                flageven=NO;
            }

        }
        
        
               actbutl.frame=CGRectMake(16, txtDisplay.frame.origin.y+txtDisplay.frame.size.height+05, 120, 50);
		
        [actbutl addTarget:self action:@selector(actionbutton) forControlEvents:UIControlEventTouchUpInside];
        
		txtScroll.contentSize = CGSizeMake(0, txtDisplay.frame.origin.y+txtDisplay.frame.size.height + 60+100);
		
		strImage = imagedesc;
		[txtScroll addSubview:qrcodeImage];
		[txtScroll addSubview:createdDate];
		[txtScroll addSubview:topLabel];
        [txtScroll addSubview:actbutl];
        [txtScroll addSubview:lblcalendarnote];
        lblcalendarnote.frame=CGRectMake(16, actbutl.frame.size.height+actbutl.frame.origin.y+5, 300, 200);
       // lblcalendarnote.lineBreakMode=YES;
        lblcalendarnote.text=@"*If the device with iOS 5.0 and above is not configured with iCloud, Events will not be added to the calendar.";
            [lblcalendarnote setFont:[UIFont italicSystemFontOfSize:12]];
        lblcalendarnote.userInteractionEnabled=NO;
        
        
        if([topLabel.text isEqualToString:@"Event"])
        {
            lblcalendarnote.hidden=NO;
        }
        else {
             lblcalendarnote.hidden=YES;
            
        }
        

		[self.view addSubview:txtScroll];
		
	}
	return self;
}
-(void)actionbutton
{
    NSLog(@"into cat but");
    generalcalculations *geni=[[generalcalculations alloc]init];

    NSString *txtstring=appDel.dataper;
    
    if([topLabel.text isEqualToString:@"Contact"])
    {
       
        if(flagcon)
        {
            flagcon=NO;
            [actbutl setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
            [geni canbeadded:txtstring :@"Contact" :1];
             [actbutl setEnabled:NO];
            
        }
        else {
            flagcon=NO;
            [actbutl setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
             [actbutl setEnabled:NO];
            
        }
    }
    if([topLabel.text isEqualToString:@"Phone"])
    {
        
        if(flagphon)
        {
            flagphon=NO;
            [actbutl setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
            [geni canbeadded:txtstring :@"Phone" :1];
             [actbutl setEnabled:NO];
            
        }
        else {
            flagphon=NO;
            [actbutl setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
             [actbutl setEnabled:NO];
            
        }
    }
    if([topLabel.text isEqualToString:@"Event"])
    {
        
        if(flageven)
        {
            flageven=NO;
            [actbutl setImage:[UIImage imageNamed:@"inactivecalender.png"] forState:UIControlStateNormal];
            NSLog(@"textstring going:%@",txtstring);
            [geni canbeadded:txtstring :@"Event" :1];
             [actbutl setEnabled:NO];
            
        }
        else {
            flageven=NO;
           /* UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Alert!" 
                                                              message:@"iCloud services are not enabled on this device, so Event can't be added!" 
                                                             delegate:nil 
                                                    cancelButtonTitle:@"OK" 
                                                    otherButtonTitles:nil];
            
            [message show];
            [message release];*/
            [actbutl setImage:[UIImage imageNamed:@"inactivecalender.png"] forState:UIControlStateNormal];
             [actbutl setEnabled:NO];
            
        }
    }
    
}

-(IBAction)DeleteQRCode
{
	//NSString *sql = [NSString stringWithFormat:@"select Image from library where Image =(SELECT MAX(Image) from library)"];
	//NSMutableArray *array=[DAL ExecuteArraySet:sql];
	
	/*NSString  *sql1 =[NSString stringWithFormat:@"delete from library where Image = '%@' ",strImage];
	
	[DAL ExecuteArraySet:sql1];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString * pdfname = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strImage]];
	
	[[NSFileManager defaultManager] removeItemAtPath:pdfname error:nil];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadData" object:nil];
	
	[self.navigationController popViewControllerAnimated:TRUE];
    */
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Are you sure you want to delete this?" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
    [alert show];
   
    [alert release];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     if(buttonIndex == 0)
        {
            NSString  *sql1 =[NSString stringWithFormat:@"delete from library where Image = '%@' ",strImage];
             
             [DAL ExecuteArraySet:sql1];
             
             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
             NSString *documentsDirectory = [paths objectAtIndex:0];
             NSString * pdfname = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strImage]];
             
             [[NSFileManager defaultManager] removeItemAtPath:pdfname error:nil];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadData" object:nil];
             
             [self.navigationController popViewControllerAnimated:TRUE];
        }
    
}
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		
		
		

    }
    return self;
}

-(IBAction)BackToLibrary
{
	[self.navigationController popViewControllerAnimated:TRUE];
}


 
// Implement viewDidLoad to additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	
	//txtDisplay = [[OHAttributedLabel alloc]init];
//	
//	[self MainDescription];
//	//[self performSelectorInBackground:@selector(MainDescription) withObject:nil];
//	txtDisplay.frame = CGRectMake(20, 200, 280, height);
//	
//	[self.view addSubview:txtDisplay];
}

-(IBAction)btnEmailClicked
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

-(void)displayComposerSheet
{
	UIImage *imgScreen = [self captureScreenInRect:CGRectMake(0,0 ,100, 100)];
	
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	
	
	/*NSString *tmpBody = @"";
	 tmpBody =[tmpBody stringByAppendingString:@"<br></br>"];
	 tmpBody =[tmpBody stringByAppendingString:@"<br></br>"];
	 //NSString *strURL = [NSString stringWithFormat:@"%@image.ashx?ID=%d&imagesize=W600xH420&imagetype=MainImage",WEB_SERVICE_URL,[idNew intValue]];
	 tmpBody =[tmpBody stringByAppendingFormat:@"<b><img src='%@'></b>",imgScreen];
	 [picker setMessageBody:tmpBody isHTML:YES];*/
	
	NSData *imgData = UIImagePNGRepresentation(imgScreen);
	[picker addAttachmentData:imgData mimeType:@"image/png" fileName:@"Result.png"];//[tmpBody release];
	
	
	//picker.modalPresentationStyle =UIModalPresentationFormSheet;
	//picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[appDel.iphonerootController presentModalViewController:picker animated:YES];
	//[self presentModalViewController:picker animated:YES];
    
	//[picker release];
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

#pragma mark capture screen
- (UIImage *)captureScreenInRect:(CGRect)captureFrame {
    CALayer *layer;
    layer = qrcodeImage.layer; //self.view.layer;
    UIGraphicsBeginImageContext( qrcodeImage.bounds.size);  // self.view.bounds.size); 
    CGContextClipToRect (UIGraphicsGetCurrentContext(),captureFrame);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenImage;
}

-(IBAction)btnTwitterClicked
{
	NSString *text=@"hello";
	SHKItem *item = [SHKItem image:qrcodeImage.image title:nil];
	//SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
	//[actionSheet showFromToolbar:self.navigationController.toolbar];
	
	//SHKItem *item = [SHKItem image:qrImageview.image];
	[NSClassFromString(@"SHKTwitter") performSelector:@selector(shareItem:) withObject:item];
}

-(IBAction)btnFacebookClicked
{
	NSString *text=@"hello";
	SHKItem *item = [SHKItem image:qrcodeImage.image];
	[NSClassFromString(@"SHKFacebook") performSelector:@selector(shareItem:) withObject:item];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	//if(interfaceOrientation == UIInterfaceOrientationPortrait ||
//	   interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
//	{
//		
//	}
//	else 
//	{
//		qrcodeImage.frame = CGRectMake(15, 120, 290, 152);
//		
//	}
//	
	return NO;
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
	
	[catDes removeFromSuperview];
	[catDes release];
	
	[qrcodeImage removeFromSuperview];
	[qrcodeImage release];
	
	[topLabel removeFromSuperview];
	[topLabel release];
	
	[array_catagory release];
}


@end
