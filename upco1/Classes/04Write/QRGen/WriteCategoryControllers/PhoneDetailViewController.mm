         //
//  PhoneDetailViewController.m
//  KrenMarketing
//
//  Created by Jayna Gandhi on 03/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PhoneDetailViewController.h"
#import "QRGenDetailViewController.h"
#import "FileManager.h"
#import "qr_draw_png.h"
#import "QR_Encode.h"
#import "DAL.h"
//#define NUMBERS @" +-()1234567890"
#define NUMBERS @" ()-1234567890"
@implementation PhoneDetailViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
        // Custom initialization.
    }
    return self;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(IBAction)BackToRoot
{
	[self.navigationController popViewControllerAnimated:TRUE];
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
 
    NSString *tmpstr=txtPhone.text;
    BOOL isValid=NO;
    BOOL isValid1=NO;
    NSString* str=@"";
    NSString *encstr=@"";
    if([tmpstr rangeOfString:@"("].location!=NSNotFound || [tmpstr rangeOfString:@")"].location!=NSNotFound || [tmpstr rangeOfString:@"-"].location!=NSNotFound || [tmpstr rangeOfString:@" "].location!=NSNotFound)
    {
        
        if([tmpstr length]==14)
        {
            NSString *phoneRegex = @"\\([0-9]{3}\\)+ +[0-9]{3}\\-[0-9]{4}";
            NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
            isValid = [phoneTest evaluateWithObject:tmpstr];
            
            
            tmpstr=[tmpstr stringByReplacingOccurrencesOfString:@"(" withString:@""];
            tmpstr=[tmpstr stringByReplacingOccurrencesOfString:@")" withString:@""];
            tmpstr=[tmpstr stringByReplacingOccurrencesOfString:@" " withString:@""];
            tmpstr=[tmpstr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }
        
        
    }
    else {
        if([tmpstr length]==10)
        {
            
            isValid1=YES;
        }
    }
    
    
    if(isValid || isValid1)
    {
        flagphon=YES;
        txtPhone.text=tmpstr;
    if ([txtPhone.text length] > 0)
	{
		str = [str stringByAppendingString:[NSString stringWithFormat:@"Mobile Number:%@",txtPhone.text]];
		//str = [str stringByReplacingOccurrencesOfString:@"(" withString:@""];
//		str = [str stringByReplacingOccurrencesOfString:@")" withString:@""];
//		str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
		str = [str stringByAppendingFormat:@"\n"];
        encstr=[encstr stringByAppendingFormat:[NSString stringWithFormat:@"tel:%@",txtPhone.text]];
	}
		
	strattr = [NSMutableAttributedString attributedStringWithString:str];
	[strattr setTextColor:[UIColor blackColor]];
	[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
	
	if([txtPhone.text length] > 0)
	{
		[strattr setTextBold:YES range:[str rangeOfString:@"Mobile Number:"]];
		//[strattr setTextColor:[UIColor blackColor] range:[str rangeOfString:@"Phone:"]];
	}
	
	CGSize maximumLabelSize1 = CGSizeMake(280,9999);
	CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
	height = expectedLabelSize1.height;	
	
	
        sampleString =encstr;
        
	[txtPhone resignFirstResponder];
	
	[self TimeandDate];
    }
    else {
        flagphon=NO;
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter a valid Phone Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
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

-(IBAction)GenerateQrCode
{
    flagphon=NO;
	char filename [ [[[FileManager sharedFileManager] qRFile] length] + 1];
	[[[FileManager sharedFileManager] qRFile] getCString:filename maxLength:[[[FileManager sharedFileManager] qRFile] length] + 1 encoding:NSUTF8StringEncoding];
	
	
	[self MainDescription];
	
    if(flagphon)
    {
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
    
    //
    
	[data writeToFile:path atomically:YES];
	
	[DAL insert_library_CreatedDate:dateLabel.text Image:[NSString stringWithFormat:@"qr%@.png",date] Category:@"Phone" Description:txtPhone.text starting_Date:@"" Ending_Date:@"" Address:@"" Links:@"" Email:@"" Locations:@"" Message:@"" Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:@"" Notes:@""];	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadData" object:nil];
}	


-(void)textFieldDidChange:(id)sender
{
	if([txtPhone.text length] > 0)
	{
		BtnEncode.enabled = TRUE;
	}
	else 
	{
		BtnEncode.enabled = FALSE;
	}
	
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{	
	if ([textField isEqual:txtPhone]) 
	{
		NSCharacterSet *cs;
		NSString *filtered;
		cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
		filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		if ([filtered length]>0 )
		{
			BtnEncode.enabled = YES;
		}
		
		return [string isEqualToString:filtered];
	}
	
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
