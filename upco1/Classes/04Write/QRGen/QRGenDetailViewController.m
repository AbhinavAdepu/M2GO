//
//  QRGenDetailViewController.m
//  KrenMarketing
//
//  Created by Jayna Gandhi on 02/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "QRGenDetailViewController.h"
#import "DAL.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "SHKItem.h"
#import "SHKActionSheet.h"
#import "generalcalculations.h"

@implementation QRGenDetailViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil imageQr:(UIImage*)image string:(NSString*)str Attribute:(NSMutableAttributedString*)attribute index:(int)height Date:(NSString*)date Time:(NSString*)time
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
        generalcalculations *geni=[[generalcalculations  alloc]init];
    
		txtScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45, 320, 300)];
		//txtScroll.backgroundColor = [UIColor redColor];
		
        	actionbutton=[[UIButton alloc]init];
         [actionbutton addTarget:self action:@selector(actionbuttonmet) forControlEvents:UIControlEventTouchUpInside];
        
        
        imgQR = [[UIImageView alloc] initWithImage:image];
		imgQR.frame = CGRectMake(10, 10, 100, 100);
	
		text_QR = [[NSString alloc]initWithString:str];
		[text_QR retain];
		
		
		txtDisplay = [[OHAttributedLabel alloc]init];
		txtDisplay.frame = CGRectMake(20, 120, 280,height);
		txtDisplay.attributedText=attribute;
        txtDisplay.linkColor=[UIColor blueColor];
		if([text_QR isEqualToString:@"Event"])
        {
            txtDisplay.linkColor = [UIColor blackColor];
        }
        
        
        	NSString *tmpstr=[attribute string];
        
        
        
    /*    UITapGestureRecognizer *pgr = [[UITapGestureRecognizer alloc] 
                                         initWithTarget:self action:@selector(handlePinch:)];
        pgr.delegate = self;
        [txtDisplay addGestureRecognizer:pgr];
        [pgr release];
        */
        
        if([text_QR isEqualToString:@"Email"])
        {
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(handleSingleTap:)];
        gestureRecognizer.delegate=self;
        
        [txtScroll addGestureRecognizer:gestureRecognizer];
        }
        
        
        
        
        
        
        addcon=addeven=addphon=NO;
        
        if([text_QR isEqualToString:@"Contact"])
        {
           if([geni canbeadded:tmpstr :@"Contact":0])           
           {
                   actionbutton.hidden=NO;
            [actionbutton setImage:[UIImage imageNamed:@"activecontact.png"] forState:UIControlStateNormal];
               addcon=YES;
                 [actionbutton setEnabled:YES];
           }
           else {
               actionbutton.hidden=NO;
               [actionbutton setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
               addcon=NO;
                 [actionbutton setEnabled:NO];
           }
        }
        else if ([text_QR isEqualToString:@"Phone"]) {
            if([geni canbeadded:tmpstr :@"Phone":0])           
            {
                actionbutton.hidden=NO;
                [actionbutton setImage:[UIImage imageNamed:@"activecontact.png"] forState:UIControlStateNormal];
                addphon=YES;
                  [actionbutton setEnabled:YES];
            }
            else {
                actionbutton.hidden=NO;
                [actionbutton setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
                addphon=NO;
                  [actionbutton setEnabled:NO];
            }

        }
        else if ([text_QR isEqualToString:@"Event"]) {
            if([geni canbeadded:tmpstr :@"Event":0])           
            {
                NSLog(@"iphoneeventtest");
                
                actionbutton.hidden=NO;
                [actionbutton setImage:[UIImage imageNamed:@"calenderactive.png"] forState:UIControlStateNormal];
                addeven=YES;
                  [actionbutton setEnabled:YES];
            }
            else {
                actionbutton.hidden=NO;
                [actionbutton setImage:[UIImage imageNamed:@"inactivecalender.png"] forState:UIControlStateNormal];
                addeven=NO;
                  [actionbutton setEnabled:NO];
            }

        }
        else {
               actionbutton.hidden=YES;
              addcon=addeven=addphon=NO;
        }
       
		
		dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 20, 170, 30)];
		dateLabel.font = [UIFont fontWithName:@"Arial" size:12];
		dateLabel.numberOfLines = 0;
		dateLabel.backgroundColor = [UIColor clearColor];
		dateLabel.text = date;
		
		TimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 42, 100, 30)];
		TimeLabel.font = [UIFont fontWithName:@"Arial" size:12];
		TimeLabel.backgroundColor = [UIColor clearColor];
		TimeLabel.text = time;
         [actionbutton setFrame:CGRectMake(20, height+130, 120, 50)];
		
		txtScroll.contentSize = CGSizeMake(0, txtDisplay.frame.origin.y+txtDisplay.frame.size.height + 40 +actionbutton.frame.size.height);
	
      

		[self.view addSubview:txtScroll];
		[txtScroll addSubview:imgQR];
		[txtScroll addSubview:txtDisplay];
		[txtScroll addSubview:dateLabel];
		[txtScroll addSubview:TimeLabel];
        
       
        
        
        [txtScroll addSubview:actionbutton];
        [txtScroll bringSubviewToFront:actionbutton];
        
        
		
    }
    return self;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    NSLog(@"hello");
    CGPoint tappedPoint=[touch locationInView:txtScroll];
    NSLog(@"The tapped point :%@ and frame :",NSStringFromCGPoint(tappedPoint));
       NSLog(@"%f,%f,%f,%f",txtDisplay.frame.origin.x,txtDisplay.frame.origin.y,txtDisplay.frame.size.width,txtDisplay.frame.size.height);
    
    
    
    CGRect newframe=CGRectMake(txtDisplay.frame.origin.x+30,txtDisplay.frame.origin.y,txtDisplay.frame.size.width/1.3,txtDisplay.frame.size.height/4);
    if(CGRectContainsPoint(newframe, tappedPoint))
    {
    
    
    return YES;    
    }
    else {
        return NO; 
    }
    
}





- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"handle tap gesture");
    [self displayComposerSheet];
}

- (void)handlePinch:(UITapGestureRecognizer *)touchGestureRecognizer
{ NSString *type=@"";
    if([type isEqualToString:@"Email"])
    {
        NSLog(@"Action: One finger, one taps");
    }
    else {
        NSLog(@"NoAction");
    }

}     



-(IBAction)BackToHome
{
	[self.navigationController popToRootViewControllerAnimated:TRUE];
}

-(void)actionbuttonmet
{
    NSLog(@"into action button");
    NSString *tmpstr=[txtDisplay.attributedText string];
    
   // NSLog(@"buttonclick:%@",tmpstr);
     generalcalculations *geni=[[generalcalculations  alloc]init];
    if(addcon)
    {
        [geni canbeadded:tmpstr :@"Contact":1];
        addcon=NO;
        [actionbutton setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
        [actionbutton setEnabled:NO];
    }
    else {
        addcon=NO;
    }
    if(addphon)
    {
        [geni canbeadded:tmpstr :@"Phone":1];
        addphon=NO;
         [actionbutton setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
          [actionbutton setEnabled:NO];
    }
    else {
        addphon=NO;
    }
    if(addeven)
    {
        [geni canbeadded:tmpstr :@"Event":1];
        addeven=NO;
         [actionbutton setImage:[UIImage imageNamed:@"inactivecalender.png"] forState:UIControlStateNormal];
          [actionbutton setEnabled:NO];
    }
    else {
     /*   UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Alert!" 
                                                          message:@"iCloud services are not enabled on this device, so Event can't be added!" 
                                                         delegate:nil 
                                                cancelButtonTitle:@"OK" 
                                                otherButtonTitles:nil];
        
        [message show];
        [message release];*/
         [actionbutton setImage:[UIImage imageNamed:@"inactivecalender.png"] forState:UIControlStateNormal];
        addeven=NO;
          [actionbutton setEnabled:NO];
    }
    
    
    
    
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	lblHeader.text = text_QR;
	
	appDel = (KrenMarketingAppDelegate*)[[UIApplication sharedApplication]delegate];
	
	
	if(appDel.fontdic)
	{
		//NSString* fontname=[appDel.fontdic valueForKey:@"fontName"];
		int alignment=[[appDel.fontdic valueForKey:@"fontAlign"]intValue];
		
		
		//txtDisplay.attributedText = attribute;
	
      
        
        
		[txtDisplay setLineBreakMode:UILineBreakModeCharacterWrap];
		[txtDisplay setNumberOfLines:9999];
		
		if(alignment==21)
			txtDisplay.textAlignment=UITextAlignmentLeft;
		else if(alignment==22)
			txtDisplay.textAlignment=UITextAlignmentCenter;
		else if(alignment==23)
			txtDisplay.textAlignment=UITextAlignmentRight;
		else if(alignment==24)
			txtDisplay.textAlignment=UITextAlignmentJustify;
		else 
			txtDisplay.textAlignment=UITextAlignmentJustify;
		
        txtDisplay.linkColor=[UIColor blueColor];
        
        
		
		//txtDisplay.textColor=[UIColor blackColor];
		txtDisplay.backgroundColor=[UIColor clearColor];
	}
	else 
	{
		
	}
	
}

-(IBAction)BackToRoot
{
	[self.navigationController popViewControllerAnimated:TRUE];
}

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
	
	[self.navigationController popViewControllerAnimated:TRUE];
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
	[picker addAttachmentData:imgData mimeType:@"image/png" fileName:@"Result"];//[tmpBody release];
	
	
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

- (UIImage *)captureScreenInRect:(CGRect)captureFrame {
    CALayer *layer;
    layer = imgQR.layer; //self.view.layer;
    UIGraphicsBeginImageContext( imgQR.bounds.size);  // self.view.bounds.size); 
    CGContextClipToRect (UIGraphicsGetCurrentContext(),captureFrame);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenImage;
}

-(IBAction)btnTwitterClicked
{
	//NSString *text=@"hello";
	SHKItem *item = [SHKItem image:imgQR.image title:nil];
	//SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
	//[actionSheet showFromToolbar:self.navigationController.toolbar];
	
	//SHKItem *item = [SHKItem image:qrImageview.image];
	[NSClassFromString(@"SHKTwitter") performSelector:@selector(shareItem:) withObject:item];
}

-(IBAction)btnFacebookClicked
{
	//NSString *text=@"hello";
	SHKItem *item = [SHKItem image:imgQR.image];
	[NSClassFromString(@"SHKFacebook") performSelector:@selector(shareItem:) withObject:item];
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
