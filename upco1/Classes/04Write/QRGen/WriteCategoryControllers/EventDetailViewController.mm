//
//  EventDetailViewController.m
//  KrenMarketing
//
//  Created by amrit on 04/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "EventDetailViewController.h"
#import "QRGenDetailViewController.h"
#import "FileManager.h"
#import "qr_draw_png.h"
#import "QR_Encode.h"
#import "DAL.h"

#define ALPHABET @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ  "
#define NUMBERS @" +-1234567890"
//#define NUMBERS @" ()-1234567890"
#define ZIP @" 1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-"

@implementation EventDetailViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}

-(void)MainDescription
{
	
	NSString* str=@"";
	
	NSString *strStart = LblDate1.text;
	NSString *strEnd = LblDate2.text;
    strStart = [strStart stringByReplacingOccurrencesOfString:@"Start Date" withString:@""];
	strEnd = [strEnd stringByReplacingOccurrencesOfString:@"End Date" withString:@""];

    
    NSString *sDate,*eDate;
    
    sDate=@"";
    eDate=@"";
    
    if([LblDate1.text length]>0)
    {
      
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
              
        if([strStart length]>13)
        {
            [dateFormat setDateFormat:@"EEE MM/dd/yy hh:mm a"];
            
        }
        else {
            [dateFormat setDateFormat:@"EEE MM/dd/yy"];
        }
       
        
        
        NSDate *date1=[dateFormat dateFromString:strStart];
      
        [dateFormat setDateFormat:@"yyyyMMdd'T'HHmmss'Z"];
      
        sDate=[dateFormat stringFromDate:date1];
     
        NSLog(@"startdate:%@",sDate);
     
        
        
    }
    if([LblDate2.text length]>0)
    {
        NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];

        if([strEnd length]>13)
        {
            [dateFormat2 setDateFormat:@"EEE MM/dd/yy hh:mm a"];
            
        }
        else {
            [dateFormat2 setDateFormat:@"EEE MM/dd/yy"];
        }
          NSDate *date2=[dateFormat2 dateFromString:strEnd];
          [dateFormat2 setDateFormat:@"yyyyMMdd'T'HHmmss'Z"];
           eDate=[dateFormat2 stringFromDate:date2];
           NSLog(@"enddate:%@",eDate);
    
    }
    
	
		 NSString *enstr=@"";
	
	if ([txtEventTitle.text length] > 0)
	{
		str = [str stringByAppendingString:[NSString stringWithFormat:@"Event:%@",txtEventTitle.text]];
		str = [str stringByAppendingFormat:@"\n\n"];
        
        
        enstr=[enstr stringByAppendingFormat:[NSString stringWithFormat:@"SUMMARY:%@",txtEventTitle.text]];
        enstr=[enstr stringByAppendingFormat:@"\n"];
        
	}
	if([strStart length] > 0)
	{
		str = [str stringByAppendingString:[NSString stringWithFormat:@"Start Date & Time:%@",strStart]];
		str = [str stringByAppendingFormat:@"\n\n"];
        
        enstr=[enstr stringByAppendingFormat:[NSString stringWithFormat:@"DTSTART:%@",sDate]];
        enstr=[enstr stringByAppendingFormat:@"\n"];
        
	}
	if([strEnd length] > 0)
	{
		str = [str stringByAppendingString:[NSString stringWithFormat:@"End Date & Time:%@",strEnd]];
		str = [str stringByAppendingFormat:@"\n\n"];
        
        
        enstr=[enstr stringByAppendingFormat:[NSString stringWithFormat:@"DTEND:%@",eDate]];
        enstr=[enstr stringByAppendingFormat:@"\n"];
	}
    
    NSString *temploc=[[NSString alloc]init];
    temploc=@"";
    
    
	if ([txtStreet.text length] > 0)
	{
		str = [str stringByAppendingString:[NSString stringWithFormat:@"Street Address:%@",txtStreet.text]];
		str = [str stringByAppendingFormat:@"\n\n"];
        
        
        temploc=[temploc stringByAppendingFormat:@"%@ ",txtStreet.text];

	}
	if ([txtCity.text length] > 0)
	{
		str = [str stringByAppendingString:[NSString stringWithFormat:@"City:%@",txtCity.text]];
		str = [str stringByAppendingFormat:@"\n\n"];
        
          temploc=[temploc stringByAppendingFormat:@"%@ ",txtCity.text];
	}
	if ([txtState.text length] > 0)
	{
		str = [str stringByAppendingString:[NSString stringWithFormat:@"State:%@",txtState.text]];
		str = [str stringByAppendingFormat:@"\n\n"];
        
          temploc=[temploc stringByAppendingFormat:@"%@ ",txtState.text];
	}
	if ([txtZipCode.text length] > 0)
	{
		str = [str stringByAppendingString:[NSString stringWithFormat:@"Zip Code:%@",txtZipCode.text]];
		str = [str stringByAppendingFormat:@"\n\n"];
        
         temploc=[temploc stringByAppendingFormat:@"%@ ",txtZipCode.text];
        
	}
	if ([txtCountry.text length] > 0)
	{
		str = [str stringByAppendingString:[NSString stringWithFormat:@"Country:%@",txtCountry.text]];
		str = [str stringByAppendingFormat:@"\n\n"];
        
        temploc=[temploc stringByAppendingFormat:@"%@ ",txtCountry.text];

        
	}
    
    
    enstr=[enstr stringByAppendingFormat:@"LOCATION:%@",temploc];
    enstr=[enstr stringByAppendingFormat:@"\n"];
    
	if ([txtNotes.text length] > 0)
	{
		str = [str stringByAppendingString:[NSString stringWithFormat:@"Notes:%@",txtNotes.text]];
		str = [str stringByAppendingFormat:@"\n\n"];
        
        
        enstr=[enstr stringByAppendingFormat:[NSString stringWithFormat:@"DESCRIPTION:%@",txtNotes.text]];
        enstr=[enstr stringByAppendingFormat:@"\n"];
	}
	
	strattr = [NSMutableAttributedString attributedStringWithString:str];
	[strattr setTextColor:[UIColor blackColor]];
	[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
	
	if([txtEventTitle.text length] > 0)
	{
		[strattr setTextBold:YES range:[str rangeOfString:@"Event:"]];
	}
	if([strStart length] > 0)
	{
		[strattr setTextBold:YES range:[str rangeOfString:@"Start Date & Time:"]];
	}
	if([strEnd length] > 0)
	{
		[strattr setTextBold:YES range:[str rangeOfString:@"End Date & Time:"]];
	}
	if([txtStreet.text length] > 0)
	{
		[strattr setTextBold:YES range:[str rangeOfString:@"Street Address:"]];
	}
	if([txtCity.text length] > 0)
	{
		[strattr setTextBold:YES range:[str rangeOfString:@"City:"]];
	}
	if([txtState.text length] > 0)
	{
		[strattr setTextBold:YES range:[str rangeOfString:@"State:"]];
	}
	if([txtZipCode.text length] > 0)
	{
		[strattr setTextBold:YES range:[str rangeOfString:@"Zip Code:"]];
	}
	if([txtCountry.text length] > 0)
	{
		[strattr setTextBold:YES range:[str rangeOfString:@"Country:"]];
	}
	if([txtNotes.text length] > 0)
	{
		[strattr setTextBold:YES range:[str rangeOfString:@"Notes:"]];
	}
	
	
	height;
	CGSize maximumLabelSize1 = CGSizeMake(280,9999);
	CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
	height = expectedLabelSize1.height;	
    
    
    sampleString = [NSString stringWithString:@"BEGIN:VCALENDAR"];
    sampleString = [sampleString stringByAppendingFormat:@"\n"];
    sampleString = [sampleString stringByAppendingFormat:@"VERSION:2.0"];
    
    
    sampleString = [sampleString stringByAppendingFormat:@"\n"];
    
    sampleString = [sampleString stringByAppendingFormat:@"BEGIN:VEVENT"];
    sampleString = [sampleString stringByAppendingFormat:@"\n"];

    
    sampleString = [sampleString stringByAppendingFormat:enstr];
    
    // sampleString=showLebel.text;
    sampleString = [sampleString stringByAppendingFormat:@"\n"];
    
   
    
    sampleString = [sampleString stringByAppendingFormat:@"END:VEVENT"];
    sampleString = [sampleString stringByAppendingFormat:@"\n"];
    

    
    
    sampleString = [sampleString stringByAppendingFormat:@"END:VCALENDAR"];
	
	
	//sampleString = str;
    NSLog(@"msg send to encode image:%@",sampleString);
	
	[txtStreet resignFirstResponder];
	[txtState resignFirstResponder];
	[txtZipCode resignFirstResponder];
	[txtEventTitle resignFirstResponder];
	[txtCountry resignFirstResponder];
	[txtCity resignFirstResponder];
	[txtNotes resignFirstResponder];
	
	[self TimeandDate];
}

-(IBAction)startDateClicked
{
	strFlagForTextfield = @"Start";
	StartEndDayController* objStartEndDayController=[[StartEndDayController alloc] initWithNibName:@"StartEndDayController" bundle:[NSBundle mainBundle]];
	objStartEndDayController.delegate = (id<dateSelectionDelegate>)self;
    objStartEndDayController.isFrom=@"TM";
	objStartEndDayController.selectedDate=@"start";
	
	[self presentModalViewController:objStartEndDayController animated:TRUE];
	[objStartEndDayController release];
}
-(IBAction)endDateClicked
{
	strFlagForTextfield = @"End";
	StartEndDayController* objStartEndDayController=[[StartEndDayController alloc] initWithNibName:@"StartEndDayController" bundle:[NSBundle mainBundle]];
	objStartEndDayController.delegate = (id<dateSelectionDelegate>)self;
    objStartEndDayController.isFrom=@"TM";
	objStartEndDayController.selectedDate=@"end";
	
	[self presentModalViewController:objStartEndDayController animated:TRUE];
	[objStartEndDayController release];
}

-(void) completeDateselection:(NSString*) sDate:(NSString*) eDate:(NSString*) allday
{
	if ([sDate length]>0 && [eDate length]>0) {
		
		NSDateFormatter* df=[[[NSDateFormatter alloc]init] autorelease];
		//if([allday isEqualToString:@"All Day"])
		//	[df setDateFormat:@"MM/dd/yy"];	
		LblDate1.text = sDate;
		LblDate2.text = eDate;
		NSDateFormatter* df1=[[[NSDateFormatter alloc]init] autorelease];
		[df1 setDateFormat:@"EEE MM/dd/yy hh:mm a"];
		NSDate *startdate = [df1 dateFromString:LblDate1.text];
		NSDate *enddate = [df1 dateFromString:eDate];
		if ([enddate compare:startdate] == NSOrderedAscending)
		{
			NSLog(@"NSOrderedAscending");
			UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"End date should be larger than start date" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
			[alert release];
			LblDate2.text =@"";
			
		}
		else {
			NSLog(@"NSOrderedDescending");
			LblDate2.text=eDate;
			//[self dismissdatePopOver];
			[txtStreet becomeFirstResponder];
		}
	}
	else {
		if ([allday isEqualToString:@""]) {
			if ([strFlagForTextfield isEqualToString:@"Start"]) {	
				LblDate1.text = sDate;
				[txtEventTitle resignFirstResponder];
				[self performSelector:@selector(endDateClicked) withObject:nil afterDelay:0.5];
				//[self onBtnEndClick_Event];
			}
			else {
				//txt_End.text = eDate;
				NSDateFormatter* df=[[[NSDateFormatter alloc]init] autorelease];
				[df setDateFormat:@"EEE MM/dd/yy"];
				NSDate *startdate = [df dateFromString:LblDate1.text];
				NSDate *enddate = [df dateFromString:eDate];
				if ([enddate compare:startdate] == NSOrderedAscending)
				{
					[txtStreet resignFirstResponder];
					NSLog(@"NSOrderedAscending");
					UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"End date should be larger than start date" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					[alert show];
					[alert release];
					LblDate2.text =@"";
					
				}
				else {
					//[self dismissdatePopOver];
					NSLog(@"NSOrderedDescending");
					LblDate2.text=eDate;
					[txtStreet becomeFirstResponder];
				}
			}
		}
		else {
			//[self dismissdatePopOver];
			[txtStreet becomeFirstResponder];
			NSDateFormatter* df=[[[NSDateFormatter alloc]init] autorelease];
			//if([allday isEqualToString:@"All Day"])
			//	[df setDateFormat:@"MM/dd/yy"];	
			LblDate1.text = sDate;
			LblDate2.text = eDate;
		}
	}
}


-(void)textFieldDidChange:(id)sender
{
	UITextField *txt = (id)sender;
	if(txt.tag == 0)
	{
		if([txtEventTitle.text length] > 0)
		{
			BtnEncode.enabled = TRUE;
		}
		else 
		{
			BtnEncode.enabled = FALSE;
		}
	}
	if(txtStreet.tag == 1)
	{
		if([txt.text length] > 0)
		{
			BtnEncode.enabled = TRUE;
		}
		else 
		{
			BtnEncode.enabled = FALSE;
		}
	}
	if(txt.tag == 2)
	{
		if([txtCity.text length] > 0)
		{
			BtnEncode.enabled = TRUE;
		}
		else 
		{
			BtnEncode.enabled = FALSE;
		}
	}
	if(txt.tag == 3)
	{
		if([txtState.text length] > 0)
		{
			BtnEncode.enabled = TRUE;
		}
		else 
		{
			BtnEncode.enabled = FALSE;
		}
	}
	if(txt.tag == 4)
	{
		if([txtZipCode.text length] > 0)
		{
			BtnEncode.enabled = TRUE;
		}
		else 
		{
			BtnEncode.enabled = FALSE;
		}
	}
	if(txt.tag == 5)
	{
		if([txtCountry.text length] > 0)
		{
			BtnEncode.enabled = TRUE;
		}
		else 
		{
			BtnEncode.enabled = FALSE;
		}
	}
	if(txt.tag == 6)
	{
		if([txtNotes.text length] > 0)
		{
			BtnEncode.enabled = TRUE;
		}
		else 
		{
			BtnEncode.enabled = FALSE;
		}
	}
	
	if([txtEventTitle.text length] > 0 || [txtStreet.text length] >0 || [txtCity.text length] > 0 || [txtState.text length] > 0 || [txtZipCode.text length] >0 || [txtCountry.text length] >0 || [txtNotes.text length] >0)
	{
		BtnEncode.enabled = TRUE;
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
			BtnEncode.enabled = YES;
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
			BtnEncode.enabled = YES;
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
			BtnEncode.enabled = YES;
		}
		
		return [string isEqualToString:filtered];
	}
	
	
	return YES;
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

-(void)calledendclick
{
	[self performSelector:@selector(endDateClicked) withObject:nil afterDelay:0.5];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if ([textField isEqual:txtStreet] ) 
	{
		scrollTexts.contentOffset = CGPointMake(0,50);
	}
	if([textField isEqual:txtCity])
	{
		scrollTexts.contentOffset = CGPointMake(0,150);
		//[txtState becomeFirstResponder];
	}
	if([textField isEqual:txtState])
	{
		scrollTexts.contentOffset = CGPointMake(0,200);
		//[txtZipCode becomeFirstResponder];
	}
	if([textField isEqual:txtZipCode])
	{
		scrollTexts.contentOffset = CGPointMake(0,250);
		//txtCountry.keyboardType = UIKeyboardTypeAlphabet;
		//[txtCountry becomeFirstResponder];
	}
	if([textField isEqual:txtCountry])
	{
		scrollTexts.contentOffset = CGPointMake(0,300);
		//[txtNotes becomeFirstResponder];
	}
	
	
	
	return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if ([textField isEqual:txtEventTitle] ) 
	{
		[self startDateClicked];
	}
	if ([textField isEqual:txtStreet] ) 
	{
		//scrollTexts.contentOffset = CGPointMake(0,100);
		[txtCity becomeFirstResponder];
	}
	if([textField isEqual:txtCity])
	{
		//scrollTexts.contentOffset = CGPointMake(0,150);
		[txtState becomeFirstResponder];
	}
	if([textField isEqual:txtState])
	{
		//scrollTexts.contentOffset = CGPointMake(0,200);
		[txtZipCode becomeFirstResponder];
	}
	if([textField isEqual:txtZipCode])
	{
		//scrollTexts.contentOffset = CGPointMake(0,250);
		txtCountry.keyboardType = UIKeyboardTypeAlphabet;
		[txtCountry becomeFirstResponder];
	}
	if([textField isEqual:txtCountry])
	{
		//scrollTexts.contentOffset = CGPointMake(0,300);
		[txtNotes performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0f];
	}
	
	return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
	if([textView isEqual:txtNotes])
	{
		scrollTexts.contentOffset = CGPointMake(0, 350);
		//[txtNotes performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0f];
	}
	
}
- (void)textViewDidChange:(UITextView *)textView
{	
	
	lblPlaceholder.hidden = TRUE;
	
	
	if([txtNotes.text length] > 0)
	{
		BtnEncode.enabled = TRUE;
	}
	else
	{
		if([txtEventTitle.text length] > 0 || [txtStreet.text length] > 0 || [txtZipCode.text length] > 0||[txtCity.text length]>0 || [txtCountry.text length] > 0 || [txtState.text length] > 0)
		{
			BtnEncode.enabled = TRUE;
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
		[txtNotes resignFirstResponder];
	}
	else 
	{
		
	}
	return YES;
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




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	scrollTexts.contentSize = CGSizeMake(0,880);
	
	txtNotes.font = [UIFont fontWithName:@"Helvetica" size:16];
	if([txtNotes.text length]>0)
	{}
	else 
	{
		lblPlaceholder.hidden = NO;
	}
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	
	NSString *str1=@"";
	
	if (![txtStreet.text isEqualToString:@""]) {				
		str1 = [str1 stringByAppendingFormat:@"%@",txtStreet.text];	
	}
	if (![txtCity.text isEqualToString:@""]) {				
		str1 = [str1 stringByAppendingFormat:@" %@",txtCity.text];	
	}
	if (![txtState.text isEqualToString:@""]) {				
		str1 = [str1 stringByAppendingFormat:@" %@",txtState.text];	
	}
	if (![txtZipCode.text isEqualToString:@""]) {				
		str1 = [str1 stringByAppendingFormat:@" %@",txtZipCode.text];	
	}
	if (![txtCountry.text isEqualToString:@""]) {				
		str1 = [str1 stringByAppendingFormat:@" %@",txtCountry.text];	
	}
	
	NSString *strStart = LblDate1.text;
	NSString *strEnd = LblDate2.text;
	
	strStart = [strStart stringByReplacingOccurrencesOfString:@"Start Date:" withString:@""];
	strEnd = [strEnd stringByReplacingOccurrencesOfString:@"End Date:" withString:@""];
	
	
	[DAL insert_library_CreatedDate:dateLabel.text Image:[NSString stringWithFormat:@"qr%@.png",date] Category:@"Event" Description:[txtEventTitle.text stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]] starting_Date:strStart Ending_Date:strEnd Address:str1 Links:txtNotes.text Email:@"" Locations:@"" Message:@"" Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:@"" Notes:txtNotes.text];	
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadData" object:nil];
}	



-(IBAction)BackToRoot
{
	[self.navigationController popViewControllerAnimated:TRUE];
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
