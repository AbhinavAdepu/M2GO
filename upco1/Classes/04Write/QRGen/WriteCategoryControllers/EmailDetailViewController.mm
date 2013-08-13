//
//  EmailDetailViewController.m
//  KrenMarketing
//
//  Created by Jayna Gandhi on 03/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "EmailDetailViewController.h"
#import "FileManager.h"
#import "qr_draw_png.h"
#import "QR_Encode.h"
#import "QRGenDetailViewController.h"
#import "DAL.h"

@implementation EmailDetailViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
        // Custom initialization.
    }
    return self;
}

-(IBAction)BackToRoot
{
	[self.navigationController popViewControllerAnimated:TRUE];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	txtMessage.font = [UIFont fontWithName:@"Helvetica" size:16];
	if([txtMessage.text length]>0)
	{
		
	}
	else 
	{
		lblPlaceholder.hidden = NO;
	}
	scrollTexts.contentSize = CGSizeMake(0, 450);
}

-(void)TimeandDate
{
	NSDate* date = [NSDate date];
	NSDateFormatter *Date1=[[[NSDateFormatter alloc] init] autorelease];
	NSDateFormatter *Time1=[[[NSDateFormatter alloc] init] autorelease];
	[Date1 setDateFormat:@"E MM/dd/yy"];
	[Time1 setDateFormat:@"h:MM aa"];
	
	
	NSString *Date12=[Date1 stringFromDate:date];
	NSString *Time12=[Time1 stringFromDate:date];	
	
	dateLabel= [[[UILabel alloc]init]autorelease];
	TimeLabel= [[[UILabel alloc]init]autorelease];
	dateLabel.text = [NSString stringWithFormat:@"Created and Added to Library on %@",Date12];
	[TimeLabel setText:Time12];
}



-(void)MainDescription
{
	
	NSString* str=@"";
    NSString* tempemail=@"";
	
	if ([txtFrom.text length] > 0)
	{
		str = [str stringByAppendingString:[NSString stringWithFormat:@"From:%@",txtFrom.text]];
		str = [str stringByAppendingFormat:@"\n\n"];
        tempemail=[tempemail stringByAppendingFormat:@"MAILTO:%@",txtFrom.text];
      
	}
	if ([txtSubject.text length] > 0)
	{
		str = [str stringByAppendingString:[NSString stringWithFormat:@"Subject:%@",txtSubject.text]];
		str = [str stringByAppendingFormat:@"\n\n"];
        tempemail=[tempemail stringByAppendingFormat:@"?SUBJECT:%@",txtSubject.text];
	}
	
	if([txtMessage.text isEqualToString:@""])
	{
		
	}
	else
	{
		if ([txtMessage.text length] > 0)
		{
			str = [str stringByAppendingString:[NSString stringWithFormat:@"Message:%@",txtMessage.text]];
			str = [str stringByAppendingFormat:@"\n"];
             tempemail=[tempemail stringByAppendingFormat:@"&BODY:%@",txtMessage.text];
		}
	}
	
	
	strattr = [NSMutableAttributedString attributedStringWithString:str];
	[strattr setTextColor:[UIColor blackColor]];

	[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
	
	if([txtFrom.text length] > 0)
	{
		[strattr setTextBold:YES range:[str rangeOfString:@"From:"]];
        CGColorRef bluClr = [UIColor blueColor].CGColor;
        NSDictionary *newAttributes = [NSDictionary dictionaryWithObject:(id)bluClr forKey:(id)kCTForegroundColorAttributeName];
        [strattr addAttributes:newAttributes range:[str rangeOfString:txtFrom.text]];
        
	}
	if([txtSubject.text length] > 0)
	{
		[strattr setTextBold:YES range:[str rangeOfString:@"Subject:"]];
	}
	if([txtMessage.text isEqualToString:@""])
	{
		
	}
	else 
	{
		if([txtMessage.text length] > 0)
		{
			[strattr setTextBold:YES range:[str rangeOfString:@"Message:"]];
		}
	}
    
	
	height;
	CGSize maximumLabelSize1 = CGSizeMake(280,9999);
	CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
	height = expectedLabelSize1.height;	
	
	
	sampleString = tempemail;
	
	[txtFrom resignFirstResponder];
	[txtMessage resignFirstResponder];
	[txtSubject resignFirstResponder];
	
	[self TimeandDate];
}

-(UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage
{
	UIView	*MaskView=[[UIView alloc] init];
	UIImageView *image1=[[UIImageView alloc]init];
	UIImageView *image2=[[UIImageView alloc]init];
	MaskView.frame=CGRectMake(0, 0,500,500);	
	image1.frame=CGRectMake(0,0,160, 160);	
	image2.frame=CGRectMake(60,54,40,40);
	image1.image=image;
	image2.image=maskImage;
	[MaskView addSubview:image1];
	[MaskView addSubview:image2];	
	
	UIGraphicsBeginImageContext(CGSizeMake(160,160));
	
	[MaskView.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *finishedPic = UIGraphicsGetImageFromCurrentImageContext();	
	//	Imagesaved=finishedPic;
	//	[self saveQrCode:Imagesaved];
	return finishedPic;
	
	
}

-(IBAction) QrGenerateCode:(id) sender
{
	NSLog(@"Encode Button Pressed!");
	
	[self CheckValidation];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if ([textField isEqual:txtFrom] ) 
	{
		[txtSubject becomeFirstResponder];
		
		//[txtMessage becomeFirstResponder];
	}
	if([textField isEqual:txtSubject])
	{
		[txtMessage performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0f];
	}
	
	return YES;
}


- (void)textViewDidChange:(UITextView *)textView
{	
	
	NSLog(@"%@",txtMessage.text);
	lblPlaceholder.hidden = TRUE;
		
	if([txtMessage.text length] > 0)
	{
		BtnEncode.enabled = TRUE;
	}
	else
	{
		if([txtFrom.text length] > 0 || [txtSubject.text length] >0)
		{
			BtnEncode.enabled = TRUE;
			lblPlaceholder.hidden = FALSE;
		}
		else 
		{
			lblPlaceholder.hidden = FALSE;
			
			BtnEncode.enabled = FALSE;
		}
	}
	
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	if([text isEqualToString:@"\n"])
	{
		[txtMessage resignFirstResponder];
	}
	else 
	{
		
	}
	return YES;
}

-(void)CheckValidation
{
	if(![self validateEmail:txtFrom.text])
	{
		UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter valid EMAIL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];	
	}
	else 
	{
		[self GenerateQrCode];
	}
}

-(void)textFieldDidChange:(id)sender
{
	if([txtFrom.text length] > 0)
	{
		BtnEncode.enabled = TRUE;
	}
	else 
	{
		BtnEncode.enabled = FALSE;
	}
	
	if([txtSubject.text length] > 0)
	{
		BtnEncode.enabled = TRUE;
	}
	else 
	{
		BtnEncode.enabled = FALSE;
	}
	
	if([txtFrom.text length] > 0 || [txtSubject.text length] >0)
	{
		BtnEncode.enabled = TRUE;
	}
}


-(void)GenerateQrCode
{
	char filename [ [[[FileManager sharedFileManager] qRFile] length] + 1];
	[[[FileManager sharedFileManager] qRFile] getCString:filename maxLength:[[[FileManager sharedFileManager] qRFile] length] + 1 encoding:NSUTF8StringEncoding];
	
	
	[self MainDescription];
	
	char str [[sampleString length] + 1];
	[sampleString getCString:str maxLength:[sampleString length] + 1 encoding:NSUTF8StringEncoding];
	
	CQR_Encode encoder;
	encoder.EncodeData(1, 0, true, -1, str);
	
	QRDrawPNG qrDrawPNG;
	qrDrawPNG.draw(filename, 4, encoder.m_nSymbleSize, encoder.m_byModuleData, NULL);
	
	NSData *data = [[NSData alloc] initWithContentsOfFile:[[FileManager sharedFileManager] qRFile]];
	UIImage *image = [UIImage imageWithData:data];
	[data release];	
	ImageQRCode.image=image;
	UIImage *image12 = [UIImage imageNamed:@"QR_Code_M_Letter-80.png"];	
	ImageQRCode.image=[self maskImage:ImageQRCode.image withMask:image12];
	[self saveQrCode:ImageQRCode.image];
	QRGenDetailViewController *obj_Detail = [[QRGenDetailViewController alloc] initWithNibName:@"QRGenDetailViewController" bundle:nil imageQr:ImageQRCode.image string:lblHeader.text Attribute:strattr index:height Date:dateLabel.text Time:TimeLabel.text];
	[self.navigationController pushViewController:obj_Detail animated:true];
	[obj_Detail release];
	
}

	
	
-(void)saveQrCode:(UIImage *)image
{
	
	//NSString *sql = [NSString stringWithFormat:@"select *from library"];
	//NSMutableArray *array=[DAL ExecuteArraySet:sql];
	
	UIImage *newImage = ImageQRCode.image;
	
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MM-dd-yyyy-HH-mm-ss"];
	
	NSString * date = [dateFormatter stringFromDate:[NSDate date]];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString* path = [documentsDirectory stringByAppendingPathComponent: 
					  [NSString stringWithFormat:@"qr%@.png",date] ];
	NSData* data = UIImagePNGRepresentation(newImage);
	[data writeToFile:path atomically:YES];
    
    
    
	
	[DAL insert_library_CreatedDate:dateLabel.text Image:[NSString stringWithFormat:@"qr%@.png",date] Category:@"Email" Description:txtFrom.text starting_Date:@"" Ending_Date:@"" Address:@"" Links:@"" Email:@"" Locations:@"" Message:txtMessage.text Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:txtSubject.text Notes:@""];	
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadData" object:nil];
	
}	

-(BOOL) validateEmail: (NSString *) email 
{
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	BOOL isValid = [emailTest evaluateWithObject:email];
	return isValid;
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
