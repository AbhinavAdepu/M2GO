//
//  ScannedResultViewController.m
//  KrenMarketing
//
//  Created by Ankit Vyas on 02/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ScannedResultViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "SHKItem.h"
#import "DAL.h"
#import "generalcalculations.h"


@implementation ScannedResultViewController
@synthesize img_iPhone_fromScan,result_scan;
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
	
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

    
    
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
    geni=[[generalcalculations alloc]init];
    NSLog(@"appDel=%@",appDel);
    flagevent=NO;
    flagphone=NO;
    flagcontact=NO;
	imgView_scanQR.image = img_iPhone_fromScan;
	//result_scan = [[NSMutableString alloc] initWithString:@""];
  
    appDel.redundantdatai=@"";
    actionbuts =[[UIButton alloc]init];
    lbldisplaycal=[[UILabel alloc]init];
  
    
   	
	if(appDel.fromCamera)
	{
		btnBackTOsmwhere.frame = CGRectMake(btnBackTOsmwhere.frame.origin.x, btnBackTOsmwhere.frame.origin.y, 26, 23);
		[btnBackTOsmwhere setImage:[UIImage imageNamed:@"iphone_Camera Roll_Icon.png"] forState:UIControlStateNormal];
	}
	else
	{
		btnBackTOsmwhere.frame = CGRectMake(btnBackTOsmwhere.frame.origin.x, btnBackTOsmwhere.frame.origin.y, 28, 21);
		[btnBackTOsmwhere setImage:[UIImage imageNamed:@"iphone_Camera_Icon.png"] forState:UIControlStateNormal];
	}
    NSLog(@"came to step");
  
	
	if([result_scan length] >= 3)
	if([[result_scan substringToIndex:3] isEqualToString:@"htt"] || 
	   [[result_scan substringToIndex:3] isEqualToString:@"WWW"] ||
	   [[result_scan substringToIndex:3] isEqualToString:@"www"] )
	{
        
        if([result_scan rangeOfString:@"?"].location == NSNotFound)
        {
			lblHeading.text = @"URL";
            appDel.redundantdatai= ScanDataLabel.text = result_scan;
        }
        else {
            lblHeading.text = @"Map Location";
            result_scan=[@"" stringByAppendingFormat:@"Map URL:%@",result_scan];
             appDel.redundantdatai=  result_scan;
            ScanDataLabel.text = [geni dividestring:result_scan:@"Map Location"];
        }
      
        
	}
	
		
	result_scan= [result_scan stringByReplacingOccurrencesOfString:@"DTSTART:" withString:@"\nStart Date & Time:"];
	
	result_scan= [result_scan stringByReplacingOccurrencesOfString:@"DTEND:" withString:@"\nEnd Date & Time:"];
	
	result_scan= [result_scan stringByReplacingOccurrencesOfString:@"SUMMARY:" withString:@"Event:"];
	result_scan=[result_scan stringByAppendingFormat:@"\n"];
	result_scan= [result_scan stringByReplacingOccurrencesOfString:@";" withString:@"\n"];
	
	
	result_scan= [result_scan stringByReplacingOccurrencesOfString:@"   " withString:@""];
    result_scan= [result_scan stringByReplacingOccurrencesOfString:@":;" withString:@":"];
    result_scan= [result_scan stringByReplacingOccurrencesOfString:@";" withString:@"\n"];
    
    
    //Event detection
    if ([result_scan rangeOfString:@"Event:"].location == NSNotFound)
    { 
        
    }
    else {
        
        lblHeading.text = @"Event";
    }
     if([result_scan length] > 15)
        if([[result_scan substringToIndex:15] isEqualToString:@"BEGIN:VCALENDAR"])
        {
            lblHeading.text = @"Event";
        }
    if([result_scan length] > 12)
        if([[result_scan substringToIndex:12] isEqualToString:@"BEGIN:VEVENT"])
        {
            lblHeading.text = @"Event";
        }
    
    
    result_scan= [result_scan stringByReplacingOccurrencesOfString:@"BEGIN:VCALENDAR" withString:@""];
    result_scan= [result_scan stringByReplacingOccurrencesOfString:@"END:VCALENDAR" withString:@""];
    result_scan= [result_scan stringByReplacingOccurrencesOfString:@"BEGIN:VEVENT" withString:@""];
    result_scan= [result_scan stringByReplacingOccurrencesOfString:@"END:VEVENT" withString:@""];
   

    
    if([lblHeading.text isEqualToString:@"Event"])
    {
         appDel.redundantdatai =  result_scan;
        ScanDataLabel.text =[geni dividestring:result_scan :@"Event"];
    }
    
    
    if([result_scan length] > 7)
        if([[result_scan substringToIndex:7] isEqualToString:@"MECARD:"])
        {
            result_scan=  [result_scan stringByReplacingOccurrencesOfString:@"MECARD:" withString:@"BEGIN:VCARD"]; 
            
        }
    
	if([result_scan length] > 11)
        if([[result_scan substringToIndex:11] isEqualToString:@"BEGIN:VCARD"])
        {
            result_scan= [result_scan stringByReplacingOccurrencesOfString:@"BEGIN:VCARD" withString:@""];
            result_scan= [result_scan stringByReplacingOccurrencesOfString:@"END:VCARD" withString:@""];    
            
            lblHeading.text = @"Contact";
           appDel.redundantdatai=  result_scan;
            ScanDataLabel.text =[geni dividestring:result_scan :@"Contact"];
        }
    
       // result_scan= [result_scan stringByReplacingOccurrencesOfString:@"," withString:@""];    
    
    
    
   
	
	
	
	//For Mail
	if([result_scan length] >= 10)
		if([[result_scan substringToIndex:10] isEqualToString:@"MATMSG:TO:"] || [[result_scan substringToIndex:7] isEqualToString:@"mailto:"])
		{
			result_scan= [result_scan stringByReplacingOccurrencesOfString:@"MATMSG:TO:" withString:@"from:"];
            result_scan= [result_scan stringByReplacingOccurrencesOfString:@"mailto:" withString:@"from:"];
			result_scan = [result_scan stringByAppendingFormat:@"\n"];
			result_scan = [result_scan stringByReplacingOccurrencesOfString:@"SUB:" withString:@"\nsubject:"];
            result_scan = [result_scan stringByReplacingOccurrencesOfString:@"SUBJECT:" withString:@"\nsubject:"];
			result_scan = [result_scan stringByAppendingFormat:@"\n"];
			result_scan = [result_scan stringByReplacingOccurrencesOfString:@"BODY:" withString:@"body:"];
			result_scan = [result_scan stringByReplacingOccurrencesOfString:@";" withString:@""];
            
            result_scan = [result_scan stringByReplacingOccurrencesOfString:@"SUB=" withString:@"\nsubject:"];
            result_scan = [result_scan stringByReplacingOccurrencesOfString:@"SUBJECT=" withString:@"\nsubject:"];
            result_scan = [result_scan stringByReplacingOccurrencesOfString:@"BODY=" withString:@"body:"];

            
            
            
		 appDel.redundantdatai=	 result_scan;
            ScanDataLabel.text =[geni dividestring:result_scan:@"Email"];
			lblHeading.text = @"Email";
		}
    
    //for email
		if([result_scan length] >= 7 )
	if([[result_scan substringToIndex:7] isEqualToString:@"MAILTO:"])
	{
		result_scan= [result_scan stringByReplacingOccurrencesOfString:@"MAILTO:" withString:@"from:"];
        result_scan= [result_scan stringByReplacingOccurrencesOfString:@"mailto:" withString:@"from:"];
        result_scan = [result_scan stringByAppendingFormat:@"\n"];
        result_scan = [result_scan stringByReplacingOccurrencesOfString:@"SUB:" withString:@"\nfubject:"];
        result_scan = [result_scan stringByReplacingOccurrencesOfString:@"SUBJECT:" withString:@"\nsubject:"];
        result_scan = [result_scan stringByAppendingFormat:@"\n"];
        result_scan = [result_scan stringByReplacingOccurrencesOfString:@"BODY:" withString:@"body:"];
        result_scan = [result_scan stringByReplacingOccurrencesOfString:@";" withString:@""];
        
        result_scan = [result_scan stringByReplacingOccurrencesOfString:@"SUB=" withString:@"\ndubject:"];
        result_scan = [result_scan stringByReplacingOccurrencesOfString:@"SUBJECT=" withString:@"\nsubject:"];
        result_scan = [result_scan stringByReplacingOccurrencesOfString:@"BODY=" withString:@"body:"];
        
		 appDel.redundantdatai=result_scan;
        ScanDataLabel.text=[geni dividestring:result_scan:@"Email"];
		lblHeading.text = @"Email";
	}
    
    
	
	//For Tel NO
	if([result_scan length] > 5)
		if([[result_scan substringToIndex:6] isEqualToString:@"TEL NO"] ||
		   [[result_scan substringToIndex:4] isEqualToString:@"TEL:"] || [[result_scan substringToIndex:4] isEqualToString:@"tel:"] )
		{
			
			result_scan= [result_scan stringByReplacingOccurrencesOfString:@"TEL NO" withString:@"Phone Number:"];
			result_scan= [result_scan stringByReplacingOccurrencesOfString:@"TEL:" withString:@"Phone Number:"];
            result_scan= [result_scan stringByReplacingOccurrencesOfString:@"tel:" withString:@"Phone Number:"];
			
			NSMutableAttributedString *strattr = [NSMutableAttributedString attributedStringWithString:result_scan];
			[strattr setTextColor:[UIColor blackColor]];
			[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[result_scan rangeOfString:result_scan]];
			
			if([result_scan length] > 0)
			{
				[strattr setTextBold:YES range:[result_scan rangeOfString:@"Phone Number:"]];
			}	
            NSLog(@"sending strig to display:%@",result_scan);
			 appDel.redundantdatai= result_scan;
             ScanDataLabel.text=[geni dividestring:result_scan:@"Phone"];
			lblHeading.text = @"Phone";
		}
    
    
  /*  if([result_scan length] > 12)
		if([[result_scan substringToIndex:13] isEqualToString:@"Phone Number:"])
		{
            result_scan= [result_scan stringByReplacingOccurrencesOfString:@"TEL NO" withString:@"Phone Number:"];
			result_scan= [result_scan stringByReplacingOccurrencesOfString:@"TEL:" withString:@"Phone Number:"];
            result_scan= [result_scan stringByReplacingOccurrencesOfString:@"tel:" withString:@"Phone Number:"];
			
			NSMutableAttributedString *strattr = [NSMutableAttributedString attributedStringWithString:result_scan];
			[strattr setTextColor:[UIColor blackColor]];
			[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[result_scan rangeOfString:result_scan]];
			
			if([result_scan length] > 0)
			{
				[strattr setTextBold:YES range:[result_scan rangeOfString:@"Phone Number:"]];
			}			
			ScanDataLabel.attributedText = strattr;
			lblHeading.text = @"Phone";
            
        }*/
    
    linksdata=@"";
    
    
       //For SMS Data
	if([result_scan length] > 6)
		
		//For SMS Data
		if([[result_scan substringToIndex:6] isEqualToString:@"SMSTO:"]||[[result_scan substringToIndex:6] isEqualToString:@"smsto:"])
		{
			result_scan= [result_scan stringByReplacingOccurrencesOfString:@"SMSTO:" withString:@"From:"];
            result_scan= [result_scan stringByReplacingOccurrencesOfString:@"smsto:" withString:@"From:"];
            
			NSArray* components = [result_scan componentsSeparatedByString:@":"];
			NSString *strTempSMS=@"";
			for(int i=0;i<[components count];i++)
			{
				if(i==[components count]-1)
					strTempSMS = [strTempSMS stringByAppendingFormat:@":%@",[components objectAtIndex:i]];
				else {
					if(i==0)
						strTempSMS = [strTempSMS stringByAppendingFormat:@"%@:",[components objectAtIndex:i]];
					else
						strTempSMS = [strTempSMS stringByAppendingFormat:@"%@",[components objectAtIndex:i]];
					
				}
				
				
				
			}
            appDel.redundantdatai=	 result_scan;
			lblHeading.text = @"SMS";
            
            ScanDataLabel.text =[geni dividestring:result_scan:@"SMS"];
            NSLog(@"received string:%@",ScanDataLabel.text);
		}
	


    
    
	
	if([lblHeading.text isEqualToString:@"Scan"])
    {
		lblHeading.text = @"Text";
       appDel.redundantdatai=  ScanDataLabel.text =result_scan;
    }

	
	CGFloat height = 0;
	CGSize maximumLabelSize1 = CGSizeMake(280,9999);
	CGSize expectedLabelSize1 = [result_scan sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
	height = expectedLabelSize1.height;
	ScanDataLabel.frame = CGRectMake(ScanDataLabel.frame.origin.x, ScanDataLabel.frame.origin.y, 290, height+50);
	
		[ScanDataLabel setTextColor:[UIColor blackColor]];
    [ScanDataLabel setLinkColor:[UIColor blackColor]];
	
	
	    
    [ScrScanResult addSubview:actionbuts];
   // [ScrScanResult addSubview:lbldisplaycal];
    lbldisplaycal.text=@"Note:To add event to calendar sync calendar to icloud";
    [actionbuts setFrame:CGRectMake(ScanDataLabel.frame.origin.x, height+ScanDataLabel.frame.origin.y, 120, 50)];
    [actionbuts addTarget:self action:@selector(actionbutsmet) forControlEvents:UIControlEventTouchUpInside];
   
    [ScrScanResult bringSubviewToFront:actionbuts];
    [ScrScanResult bringSubviewToFront:ScanDataLabel];

    tempstrcopy=[[NSString alloc]init];
    tempstrcopy=result_scan;
    
    NSLog(@"tempstrcopy%@",tempstrcopy);
  
    
    
    
    generalcalculations *geni=[[generalcalculations alloc]init];

    if([lblHeading.text isEqualToString:@"Contact"])
    {
        actionbuts.hidden=NO;
        if([geni canbeadded:tempstrcopy :@"Contact" :0])
        {
           [actionbuts setImage:[UIImage imageNamed:@"activecontact.png"] forState:UIControlStateNormal];
            flagcontact=YES;
              [actionbuts setEnabled:YES];
        }
        else {
            [actionbuts setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
            flagcontact=NO;
              [actionbuts setEnabled:NO];
        }
        
    }
    else if([lblHeading.text isEqualToString:@"Phone"])
    {
        actionbuts.hidden=NO;

        if([geni canbeadded:tempstrcopy :@"Phone" :0])
        {
            [actionbuts setImage:[UIImage imageNamed:@"activecontact.png"] forState:UIControlStateNormal];
            flagphone=YES;
              [actionbuts setEnabled:YES];
        }
        else {
            [actionbuts setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
            flagphone=NO;
              [actionbuts setEnabled:NO];
        }
        
    }
    else if([lblHeading.text isEqualToString:@"Event"]){
        actionbuts.hidden=NO;

        if([geni canbeadded:tempstrcopy :@"Event" :0])
        {
            [actionbuts setImage:[UIImage imageNamed:@"calenderactive.png"] forState:UIControlStateNormal];
            flagevent=YES;
              [actionbuts setEnabled:YES];
        }
        else {
            [actionbuts setImage:[UIImage imageNamed:@"inactivecalender.png"] forState:UIControlStateNormal];
            flagevent=YES;
              [actionbuts setEnabled:NO];
        }
        
    }
    
    
    
    else {
        actionbuts.hidden=YES;
    }
    
      ScanDataLabel.linkColor=[UIColor blueColor];
    
	[self TimeandDate];
   
	ScrScanResult.contentSize = CGSizeMake(320,height+ScanDataLabel.frame.origin.y+20+actionbuts.frame.size.height);

	
	alert_SaveQR = [[UIAlertView alloc]initWithTitle:@"Save QR Code to Library"
												   message:@"Do you want to save this QR Code to the Library?" 
												  delegate:self 
										 cancelButtonTitle:@"Save"
										 otherButtonTitles:@"Don't Save",nil];
	[alert_SaveQR show];
	[alert_SaveQR release];
    [super viewDidLoad];
}

-(void)actionbutsmet
{
    NSLog(@"action but metho");
    generalcalculations *geni=[[generalcalculations alloc]init];
    if([lblHeading.text isEqualToString:@"Contact"] && flagcontact)
    {
        [geni canbeadded:tempstrcopy :@"Contact" :1];
            [actionbuts setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
            flagcontact=NO;
    [actionbuts setEnabled:NO];
        
    }
    else if([lblHeading.text isEqualToString:@"Phone"] && flagphone)
    {
        actionbuts.hidden=NO;
         [geni canbeadded:tempstrcopy :@"Phone" :1];
        
       
            [actionbuts setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
            flagphone=NO;
        [actionbuts setEnabled:NO];
               
    }
    else if([lblHeading.text isEqualToString:@"Event"] && flagevent){
        actionbuts.hidden=NO;
        if(flagevent)
        {
         [geni canbeadded:tempstrcopy :@"Event" :1];
       
            [actionbuts setImage:[UIImage imageNamed:@"inactivecalender.png"] forState:UIControlStateNormal];
            flagevent=NO;
        [actionbuts setEnabled:NO];
        }
        else {
          /*  UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Alert!" 
                                                              message:@"iCloud services are not enabled on this device, so Event can't be added!" 
                                                             delegate:nil 
                                                    cancelButtonTitle:@"OK" 
                                                    otherButtonTitles:nil];
            
            [message show];
            [message release];*/
            [actionbuts setImage:[UIImage imageNamed:@"inactivecalender.png"] forState:UIControlStateNormal];
            [actionbuts setEnabled:NO];
        }
               
    }
    
    
    
}

#pragma mark TIME & DATE
-(void)TimeandDate{
	//Date
	NSDate* date = [NSDate date];
	NSDateFormatter *Date1=[[[NSDateFormatter alloc] init] autorelease];
	
	[Date1 setDateFormat:@"E MM/dd/yy"];
	
	
	NSString *Date12=[Date1 stringFromDate:date];	
	NSLog(@"Date: %@", Date12);
	//Time
	NSDateFormatter *Time1=[[[NSDateFormatter alloc] init] autorelease];
	[Time1 setDateFormat:@"h:MM aa"];
	NSString *Time12=[Time1 stringFromDate:date];
	
	NSLog(@"Date: %@",Time12);
	
	
	Date12 = [NSString stringWithFormat:@"Scanned on %@",Date12];
	
	[dtLabel setText:Date12];
	[TimeLabel setText:Time12];
	appDel.QRScanDate = dtLabel.text;
	
}

-(IBAction)btnBackPressed:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Shareing options
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
-(IBAction)btnTwitterClicked:(id)sender
{
	NSString *text=@"hello";
	SHKItem *item = [SHKItem image:img_iPhone_fromScan title:nil];
	[NSClassFromString(@"SHKTwitter") performSelector:@selector(shareItem:) withObject:item];
}

-(IBAction)btnFacebookClicked:(id)sender
{
	NSString *text=@"hello";
	SHKItem *item = [SHKItem image:img_iPhone_fromScan];
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

-(void)displayComposerSheet
{
	
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
		
	NSData *imgData = UIImagePNGRepresentation(img_iPhone_fromScan);
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0)
		[self saveQrCode];
		//[self performSelectorInBackground:@selector(saveQrCode) withObject:nil];
	
}
#pragma mark saveQrCode screen

-(NSString *)strdate:(NSString *)str
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd'T'HHmmss'Z"];
    NSDate *date=[dateFormat dateFromString:str];
    if(date != nil)
    {
        [dateFormat setDateFormat:@"EEE MM/dd/yy hh:mm a"];
        return [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:date]]; 
    }
    else {
        str=[str substringToIndex:8];
        NSLog(@"%d",str.length);
        [dateFormat setDateFormat:@"yyyyMMdd"];
        NSDate *date=[dateFormat dateFromString:str];
        [dateFormat setDateFormat:@"EEE MM/dd/yy hh:mm a"];
        NSLog(@"returnd string:%@",[dateFormat stringFromDate:date]);
        return [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:date]]; 
    }
    
}





-(void)saveQrCode
{
	UIImage *imageQR = imgView_scanQR.image;
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MM-dd-yyyy-HH-mm-ss"];
	NSString * date = [dateFormatter stringFromDate:[NSDate date]];
	
		
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString* path = [documentsDirectory stringByAppendingPathComponent: 
					  [NSString stringWithFormat:@"qr%@.png",date]];
	NSData* data = UIImagePNGRepresentation(imageQR);
	[data writeToFile:path atomically:YES];
	
    NSLog(@"redundantdata%@", appDel.redundantdatai);
    
    NSString *tmpDatastr = appDel.redundantdatai;
	
	//For SMS Data
    if([lblHeading.text isEqualToString:@"SMS"])
	if([tmpDatastr length] > 4)
	{
		//For SMS Data
		if([[tmpDatastr substringToIndex:5] isEqualToString:@"From:"])
		{
			tmpDatastr= [tmpDatastr stringByReplacingOccurrencesOfString:@"From:" withString:@""];
			
		}
	
	}
	//For Phone Data
    if([lblHeading.text isEqualToString:@"Phone"])
	if([tmpDatastr length] > 12)
	{
		//For Phone Data
		if([[tmpDatastr substringToIndex:8] isEqualToString:@"Phone Number:"])
		{
			tmpDatastr= [tmpDatastr stringByReplacingOccurrencesOfString:@"Phone Number:" withString:@""];
			
		}
		
	}
	
	//For Mail
     if([lblHeading.text isEqualToString:@"Email"])
	if([tmpDatastr length] > 5)
		if([[tmpDatastr substringToIndex:5] isEqualToString:@"From:"] || [[tmpDatastr substringToIndex:5] isEqualToString:@"from:"] || [[tmpDatastr substringToIndex:5] isEqualToString:@"FROM:"])
		{
			tmpDatastr= [tmpDatastr stringByReplacingOccurrencesOfString:@"From:" withString:@"from:"];
            tmpDatastr = [tmpDatastr stringByReplacingOccurrencesOfString:@"Subject:" withString:@"subject:"];
			tmpDatastr=[tmpDatastr stringByReplacingOccurrencesOfString:@"Body:" withString:@"body:"];
            
            tmpDatastr= [tmpDatastr stringByReplacingOccurrencesOfString:@"FROM:" withString:@"from:"];
            tmpDatastr = [tmpDatastr stringByReplacingOccurrencesOfString:@"SUBJECT:" withString:@"subject:"];
			tmpDatastr=[tmpDatastr stringByReplacingOccurrencesOfString:@"BODY:" withString:@"body:"];
            
           			
		}
    //for Mail
     if([lblHeading.text isEqualToString:@"Email"])
    if([tmpDatastr length] > 7)
		if([[tmpDatastr substringToIndex:7] isEqualToString:@"Mailto:"] || [[tmpDatastr substringToIndex:7] isEqualToString:@"MAILTO:"] || [[tmpDatastr substringToIndex:5] isEqualToString:@"mailto:"])
		{
			tmpDatastr= [tmpDatastr stringByReplacingOccurrencesOfString:@"Mailto:" withString:@"from:"];
            tmpDatastr = [tmpDatastr stringByReplacingOccurrencesOfString:@"Subject:" withString:@"subject:"];
			tmpDatastr=[tmpDatastr stringByReplacingOccurrencesOfString:@"Body:" withString:@"body:"];
            
            tmpDatastr= [tmpDatastr stringByReplacingOccurrencesOfString:@"MAILTO:" withString:@"from:"];
            tmpDatastr = [tmpDatastr stringByReplacingOccurrencesOfString:@"SUBJECT:" withString:@"subject:"];
			tmpDatastr=[tmpDatastr stringByReplacingOccurrencesOfString:@"BODY:" withString:@"body:"];
            
            
            tmpDatastr=[tmpDatastr stringByReplacingOccurrencesOfString:@"SUB:" withString:@"subject:"];
              tmpDatastr=[tmpDatastr stringByReplacingOccurrencesOfString:@"sub:" withString:@"subject:"];
            
            
		}
    
    
	
	
	//For Event
if([tmpDatastr length] > 15)
		if([[tmpDatastr substringToIndex:15] isEqualToString:@"BEGIN:VCALENDAR"])
		{
			tmpDatastr= [tmpDatastr stringByReplacingOccurrencesOfString:@"BEGIN:VCALENDAR" withString:@""];

		}
	if([tmpDatastr length] > 11)
     
     if([[tmpDatastr substringToIndex:11] isEqualToString:@"BEGIN:VCARD"])
		{
			tmpDatastr= [tmpDatastr stringByReplacingOccurrencesOfString:@"BEGIN:VCARD" withString:@""];

		}
	

    tmpDatastr= [tmpDatastr stringByReplacingOccurrencesOfString:@"BEGIN:VCARD" withString:@""];
	tmpDatastr= [tmpDatastr stringByReplacingOccurrencesOfString:@"END:VCARD" withString:@""];
    tmpDatastr=[tmpDatastr stringByReplacingOccurrencesOfString:@"BEGIN:VEVENT" withString:@""];
     tmpDatastr=[tmpDatastr stringByReplacingOccurrencesOfString:@"END:VEVENT" withString:@""];
     tmpDatastr=[tmpDatastr stringByReplacingOccurrencesOfString:@"BEGIN:VCALENDAR" withString:@""];
     tmpDatastr=[tmpDatastr stringByReplacingOccurrencesOfString:@"END:VCALENDAR" withString:@""];
       tmpDatastr=[tmpDatastr stringByReplacingOccurrencesOfString:@"Map URL:" withString:@""];
    NSLog(@"tmpDatastr:%@",tmpDatastr);
	
	if([lblHeading.text isEqualToString:@"Contact"]||[lblHeading.text isEqualToString:@"Event"] ||[lblHeading.text isEqualToString:@"Phone"])
    {
        NSDictionary *keyval;
        NSMutableArray *keysdata=[[NSMutableArray alloc]initWithCapacity:1];
        NSMutableArray *valuedata=[[NSMutableArray alloc]initWithCapacity:1];
        NSString *redundantphoneno;
        redundantphoneno=@"";
        
        int rot=0;
        NSLog(@"tempstr:%@",tmpDatastr);
        NSArray *words = [tmpDatastr componentsSeparatedByString:@"\n"];
        //  NSLog(@"count:%d",[words count]);
        
        for(int i=0;i<[words count];i++)
        {
            // NSLog(@"str:%@",[words objectAtIndex:i]);
            if(![[words objectAtIndex:i] isEqualToString:@""])
            {
                NSArray *divwords=[[words objectAtIndex:i] componentsSeparatedByString:@":"];
                
                if([divwords count]==2)
                {
                    [keysdata addObject:[divwords objectAtIndex:0]];
                    
                    if([[divwords objectAtIndex:0] isEqualToString:@"Start Date & Time"] || [[divwords objectAtIndex:0] isEqualToString:@"End Date & Time"])
                    {
                        NSLog(@"start/end date /time");
                        
                        if ([[divwords objectAtIndex:1] rangeOfString:@"/"].location != NSNotFound)
                        { 
                            [valuedata addObject:[divwords objectAtIndex:1]];
                        }
                        else {
                            NSLog(@"into els part of date");
                            /* NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                             NSLog(@"inp:#%@#",[divwords objectAtIndex:1]);
                             [dateFormat setDateFormat:@"yyyyMMdd'T'HHmmss'Z"];
                             NSDate *date=[dateFormat dateFromString:[divwords objectAtIndex:1]];
                             [dateFormat setDateFormat:@"EEE MM/dd/yy hh:mm a"];
                             NSLog(@"date:%@",[dateFormat stringFromDate:date]);
                             [valuedata addObject:[NSString stringWithFormat:@"%@", [dateFormat stringFromDate:date]]]; */
                            NSLog(@"%@",[divwords objectAtIndex:1]);
                            NSString *rawdate=[divwords objectAtIndex:1];
                            
                            // [foo stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                            rawdate=[rawdate stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                            [valuedata addObject:[self strdate:rawdate]];
                            
                        }
                        
                        
                        
                        
                    }
                    else {
                        [valuedata addObject:[divwords objectAtIndex:1]];
                    }
                    
                    
                    // keyval=[NSDictionary dictionaryWithObject:valuedata forKey:keysdata];
                }
                if([divwords count]==1)
                {
                    [keysdata addObject:@"D"];
                    [valuedata addObject:[divwords objectAtIndex:0]]; 
                }
                
                if([divwords count]==3)
                {
                    if([[divwords objectAtIndex:0] isEqualToString:@"Start Date & Time"])
                    {
                        [keysdata addObject:[divwords objectAtIndex:0]];
                        
                        if([[divwords objectAtIndex:1] length]>0 && [[divwords objectAtIndex:2] length]>0)
                        {
                            [valuedata addObject:[[divwords objectAtIndex:1] stringByAppendingFormat:@":%@",[divwords objectAtIndex:2]]]; 
                            
                        }
                        if([[divwords objectAtIndex:1] length]>0 && [[divwords objectAtIndex:2] length]<=0)
                        {
                            [valuedata addObject:[divwords objectAtIndex:1]];
                            
                        }
                        
                    }
                }
                if([divwords count]==3)
                {
                    if([[divwords objectAtIndex:0] isEqualToString:@"End Date & Time"])
                    {
                        [keysdata addObject:[divwords objectAtIndex:0]];
                        
                        if([[divwords objectAtIndex:1] length]>0 && [[divwords objectAtIndex:2] length]>0)
                        {
                            [valuedata addObject:[[divwords objectAtIndex:1] stringByAppendingFormat:@":%@",[divwords objectAtIndex:2]]]; 
                            
                        }
                        if([[divwords objectAtIndex:1] length]>0 && [[divwords objectAtIndex:2] length]<=0)
                        {
                            [valuedata addObject:[divwords objectAtIndex:1]];
                            
                        }
                        
                    }
                }
                
                
                rot++;
                divwords =nil;
            }
            
            
            
        }
        keyval=[NSDictionary dictionaryWithObjects:valuedata forKeys:keysdata];
        //
        
        //string1 = [string1 stringByAppendingString:string2]
        NSString  *add_temp=@"";
        if([lblHeading.text isEqualToString:@"Event"])
        {
            if([[keyval objectForKey:@"Street Address"] length]>0)
            {
                add_temp=[add_temp stringByAppendingFormat:@"%@ ",[keyval objectForKey:@"Street Address"]];
            }
            if([[keyval objectForKey:@"City"] length]>0)
            {
                add_temp=[add_temp stringByAppendingFormat:@"%@ ",[keyval objectForKey:@"City"]];      
            }
            if([[keyval objectForKey:@"State"] length]>0)
            {
                add_temp=[add_temp stringByAppendingFormat:@"%@ ",[keyval objectForKey:@"State"]];      
            }
            if([[keyval objectForKey:@"Zip Code"] length]>0)
            {
                add_temp=[add_temp stringByAppendingFormat:@"%@ ",[keyval objectForKey:@"Zip Code"]];      
            }
            if([[keyval objectForKey:@"Country"] length]>0)
            {
                add_temp=[add_temp stringByAppendingFormat:@"%@ ",[keyval objectForKey:@"Country"]];      
            }
            if([[keyval objectForKey:@"LOCATION"] length]>0)
            {
                add_temp=[add_temp stringByAppendingFormat:@"%@ ",[keyval objectForKey:@"LOCATION"]];      
            }
            
            
            
        }
        else {
            add_temp=@"";
        }
        
        
        
    //    NSString*   loc_temp=(([[keyval objectForKey:@"CELL"] length]<=0)?(([[keyval objectForKey:@"VOICE"] length]<=0)?(([[keyval objectForKey:@"TEL"] length]==0)?[keyval objectForKey:@"Phone Number"]:[keyval objectForKey:@"TEL"]):([keyval objectForKey:@"VOICE"])):[keyval objectForKey:@"CELL"]);
        
        NSString *temsavdes;
        NSLog(@"Event name:%@",[keyval description]);
        if([lblHeading.text isEqualToString:@"Event"])
        {
            temsavdes=[keyval objectForKey:@"Event"];
        }
        else {
            
            temsavdes=([[keyval objectForKey:@"FN"] length]>0)?([keyval objectForKey:@"FN"]):([[keyval objectForKey:@"N"] length]>0)?[keyval objectForKey:@"N"]:@"";
            
            
        }
        
        redundantphoneno=(([[keyval objectForKey:@"CELL"] length]<=0)?(([[keyval objectForKey:@"VOICE"] length]<=0)?(([[keyval objectForKey:@"TEL"] length]==0)?[keyval objectForKey:@"Phone Number"]:[keyval objectForKey:@"TEL"]):([keyval objectForKey:@"VOICE"])):[keyval objectForKey:@"CELL"]);
        
        if([[keyval objectForKey:@" Phone Number"] length]>0)
        {
            
            redundantphoneno=[keyval objectForKey:@" Phone Number"];
        }
        
        if([lblHeading.text isEqualToString:@"Phone"] && [[keyval objectForKey:@"Mobile Number"] length]>0)
        {
            redundantphoneno=[keyval objectForKey:@"Mobile Number"];
            
        }
        if([lblHeading.text isEqualToString:@"Phone"])
        {
            temsavdes=redundantphoneno;
        }
        
      //  temsavdes=  [temsavdes stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSLog(@"saving date to library:%@",[keyval objectForKey:@"Start Date & Time"]);
         NSLog(@"saving date to library:%@",[keyval objectForKey:@"End Date & Time"]);
          temsavdes=[temsavdes stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
 
        
        [DAL insert_library_CreatedDate:date
                                  Image:[NSString stringWithFormat:@"qr%@.png",date] 
         
                               Category:lblHeading.text
                            Description:temsavdes 
                          starting_Date:[keyval objectForKey:@"Start Date & Time"]
                            Ending_Date:[keyval objectForKey:@"End Date & Time"]
                                Address:add_temp 
                                  Links:@"" 
                                  Email:[keyval objectForKey:@"Email"] 
                              Locations:@"" 
                                Message:[keyval objectForKey:@"Message"] 
                             Department:([[keyval objectForKey:@"ORG"] length]<=0)?[keyval objectForKey:@"Department"]:[keyval objectForKey:@"ORG"]
                                    Job:([[keyval objectForKey:@"TITLE"] length]<=0)?[keyval objectForKey:@"JobTitle"]:[keyval objectForKey:@"TITLE"]
                                 Suffix:[keyval objectForKey:@"Suffix"] 
                             MiddleName:[keyval objectForKey:@"Middle"] 
                               LastName:[keyval objectForKey:@"PhoneticLastName"]
                              FirstName:[keyval objectForKey:@"PhoneticFirstName"]
                                 Prefix:[keyval objectForKey:@"Prefix"] 
                                PhoneNo:redundantphoneno
                                Subject:@"" 
                                  Notes:([[keyval objectForKey:@"Notes"] length]<=0)?[keyval objectForKey:@"DESCRIPTION"]:[keyval objectForKey:@"Notes"]
         ];	

        NSLog(@"saving to db");

    
    
    }
    else {
        
        if([lblHeading.text isEqualToString:@"SMS"])
        {
            NSLog(@"into sms");
            NSString *tmpsms=tmpDatastr;
            tmpsms=  [tmpsms stringByReplacingOccurrencesOfString:@"From:" withString:@""];
             tmpsms=  [tmpsms stringByReplacingOccurrencesOfString:@"from:" withString:@""];
            NSArray *words = [tmpsms componentsSeparatedByString:@":"];
            NSString *despho=@"";
            NSString *mess=@"";
            if([words count]==1)
            {
                if([[words objectAtIndex:0] length]>0)
                    despho=[words objectAtIndex:0];
            }
            if([words count]==2)
            {
                if([[words objectAtIndex:0] length]>0)
                    despho=[words objectAtIndex:0];
                if([[words objectAtIndex:1] length]>0)
                    mess=[words objectAtIndex:1];
            }
            if([words count]>2)
            {
                NSLog(@"length >[words count]");
                for(int i=0;i<[words count];i++)
                {
                    NSLog(@"%@",[words objectAtIndex:i]);
                }
            }
            
            NSLog(@"temp phon:%@",despho);
            
            NSLog(@"temp msg:%@",mess);
            [DAL insert_library_CreatedDate:date Image:[NSString stringWithFormat:@"qr%@.png",date]  Category:lblHeading.text Description:despho starting_Date:@"" Ending_Date:@"" Address:@"" Links:@"" Email:@"" Locations:@"" Message:mess Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:@"" Notes:@""];
            NSLog(@"saving sms to db");
            
        }  
        else if([lblHeading.text isEqualToString:@"Email"])
        {
            NSLog(@"into email");
            NSString *tmpemail=tmpDatastr;
            tmpemail=[tmpemail stringByReplacingOccurrencesOfString:@"?" withString:@";"];
            tmpemail=[tmpemail stringByReplacingOccurrencesOfString:@"&" withString:@";"];
            tmpemail=[tmpemail stringByReplacingOccurrencesOfString:@"=" withString:@":"];
            tmpemail=[tmpemail stringByReplacingOccurrencesOfString:@"\n" withString:@";"];
            NSArray *words = [tmpemail componentsSeparatedByString:@";"];
            NSDictionary *keyval;
            NSMutableArray *keysdata=[[NSMutableArray alloc]initWithCapacity:1];
            NSMutableArray *valuedata=[[NSMutableArray alloc]initWithCapacity:1];
            
            
            for(int i=0;i<[words count];i++)
            {
                if(![[words objectAtIndex:i] isEqualToString:@""])
                {
                    NSArray *divwords=[[words objectAtIndex:i] componentsSeparatedByString:@":"]; 
                    
                    if([divwords count]==2)
                    {
                        
                        [keysdata addObject:[divwords objectAtIndex:0]];
                        
                        [valuedata addObject:[divwords objectAtIndex:1]];
                        
                    }
                    
                }
                
                
            }
            keyval=[NSDictionary dictionaryWithObjects:valuedata forKeys:keysdata];
            NSLog(@"%@",keyval);
           [DAL insert_library_CreatedDate:date Image:[NSString stringWithFormat:@"qr%@.png",date]  Category:lblHeading.text Description:[[keyval objectForKey:@"from"] length]>0?[keyval objectForKey:@"from"]:[[keyval objectForKey:@"From"] length]>0?[keyval objectForKey:@"From"]:[[keyval objectForKey:@"FROM"] length]>0?[keyval objectForKey:@"FROM"]:@"" starting_Date:@"" Ending_Date:@"" Address:@"" Links:@"" Email:@"" Locations:@"" Message:[[keyval objectForKey:@"body"] length]>0?[keyval objectForKey:@"body"]:[[keyval objectForKey:@"BODY"] length]>0?[keyval objectForKey:@"BODY"]:[[keyval objectForKey:@"Body"] length]>0?[keyval objectForKey:@"Body"]:@"" Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:[[keyval objectForKey:@"SUBJECT"] length]>0?[keyval objectForKey:@"SUBJECT"]:[[keyval objectForKey:@"SUB"] length]>0?[keyval objectForKey:@"SUB"]:[[keyval objectForKey:@"subject"] length]>0?[keyval objectForKey:@"subject"]:[[keyval objectForKey:@"sub"] length]>0?[keyval objectForKey:@"sub"]:[[keyval objectForKey:@"Subject"] length]>0?[keyval objectForKey:@"Subject"]:@"" Notes:@""]; 

            
            

        }
        
        else if([lblHeading.text isEqualToString:@"Map Location"] || [lblHeading.text isEqualToString:@"Map Location "])
        {
            
            
            NSLog(@"into maplocation");
                      
            NSLog(@"srr in map loc:%@",tmpDatastr);
          //  NSArray *words=[tmpDatastr componentsSeparatedByString:@"\n"];
            tmpDatastr=[tmpDatastr stringByReplacingOccurrencesOfString:@";" withString:@"\n"];
            tmpDatastr=[tmpDatastr stringByReplacingOccurrencesOfString:@"Map URL:" withString:@""];
            NSArray *words=[tmpDatastr componentsSeparatedByString:@"\n"];
            
            NSLog(@"%@",words);
            NSDictionary *keyval;
            NSMutableArray *keysdata=[[NSMutableArray alloc]initWithCapacity:1];
            NSMutableArray *valuedata=[[NSMutableArray alloc]initWithCapacity:1];
            
            for(int i=0;i<[words count];i++)
            {
                if(![[words objectAtIndex:i] isEqualToString:@""])
                {
                    NSArray *divwords=[[words objectAtIndex:i] componentsSeparatedByString:@":"]; 
                    
                    if([divwords count]==2)
                    {
                        
                        if([[divwords objectAtIndex:0] isEqualToString:@"http"])
                        {
                            [keysdata addObject:@"Map URL"];
                            [valuedata addObject:[NSString stringWithFormat:@"%@:%@",[divwords objectAtIndex:0],[divwords objectAtIndex:1]]];
                        }
                        else
                        {
                            [keysdata addObject:[divwords objectAtIndex:0]];
                            
                            [valuedata addObject:[divwords objectAtIndex:1]];
                            
                        }
                        
                        
                    }
                    
                }
                
                
            }
            keyval=[NSDictionary dictionaryWithObjects:valuedata forKeys:keysdata];   
           
            
            
            [DAL insert_library_CreatedDate:date Image:[NSString stringWithFormat:@"qr%@.png",date]  Category:lblHeading.text Description:([[keyval objectForKey:@"Map URL"] length]>0)?[keyval objectForKey:@"Map URL"]:@"" starting_Date:@"" Ending_Date:@"" Address:@"" Links:([[keyval objectForKey:@"Notes"] length]>0)?[keyval objectForKey:@"Notes"]:@"" Email:@"" Locations:@"" Message:@"" Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:@"" Notes:@""];
            NSLog(@"saving to db");
            
            
            
            
        }

        
        
        
        else {
                     
            
            
            
            
            
            
            
            
            
            
            
            [DAL insert_library_CreatedDate:date Image:[NSString stringWithFormat:@"qr%@.png",date]  Category:lblHeading.text Description:tmpDatastr starting_Date:@"" Ending_Date:@"" Address:@"" Links:@"" Email:@"" Locations:@"" Message:@"" Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:@"" Notes:@""];

        }
        
        
        
           }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    	    

    
    
    
    
    
    
    
    
       
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"ReloadData" object:nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadData" object:nil];

}

-(IBAction)btnBack_CameraView:(id)sender
{
	
	[self.navigationController popViewControllerAnimated:YES];
	
	if(appDel.fromCamera)
	{
		appDel.photoalbumOpen = YES;
		appDel.cameraOpen = NO;
	}
	else
	{
		appDel.photoalbumOpen = NO;
		appDel.cameraOpen = YES;
	}
	NSLog(@"BAck to PhotoLib");
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Camera_PhotoAlbumOpen" object:nil];

	

	
}
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
