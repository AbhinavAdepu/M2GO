//
//  WriteDetailViewController.m
//  KrenMarketing
//
//  Created by Jayna Gandhi on 02/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WriteDetailViewController.h"
#import "FileManager.h"
#import "QRGenDetailViewController.h"
#import "qr_draw_png.h"
#import "QR_Encode.h"
#import "DAL.h"

@implementation WriteDetailViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Text:(NSString*)text
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
	{
		text_QR = [[NSString alloc]initWithString:text];
		[text_QR retain];
    }
    return self;
}
/*

-(id)initwithIndex:(NSString*)index
{
	if (self = [super init])
	{
		lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 320, 21)];
		lblHeader.textAlignment = UITextAlignmentCenter;
		lblHeader.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
		lblHeader.backgroundColor = [UIColor clearColor];
		lblHeader.textColor = [UIColor whiteColor];
		lblHeader.text = index;
			
		[self.view addSubview:lblHeader];
	}
	
	return self;
}
 */

-(IBAction)BackToRoot
{
	[self.navigationController popViewControllerAnimated:TRUE];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	
    [super viewDidLoad];
	lblHeader.text = text_QR;
	txtShortenURL.font = [UIFont fontWithName:@"Helvetica" size:16];
	txtShortenURL.textColor=[UIColor lightGrayColor];
	txtShortenURL.text = @"Shorten URL";

}

-(void)textFieldDidChange:(id)sender
{
	
	if([txtURL.text length] > 0)
	{
		btnEncode.enabled = TRUE;
	}
	else 
	{
		btnEncode.enabled = FALSE;
	}
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];	
	return YES;
}

#pragma mark TIME & DATE
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
	if(lblHeader.text == @"URL")
	{
		NSString* str=@"";
		if(![txtShortenURL.text isEqualToString:@"Shorten URL"])
		{
			sampleString = txtShortenURL.text;
			str = [str stringByAppendingString:[NSString stringWithFormat:@"URL: %@",txtShortenURL.text]];
			
			strattr = [NSMutableAttributedString attributedStringWithString:str];
			[strattr setTextColor:[UIColor blackColor]];
			[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
			
			[strattr setTextBold:YES range:[str rangeOfString:@"URL:"]];
			
			height;
			CGSize maximumLabelSize1 = CGSizeMake(280,9999);
			CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			height = expectedLabelSize1.height;	
		}
		else 
		{
            NSString *tempurl=@"";
			if ([txtURL.text length] > 0)
			{
				str = [str stringByAppendingString:[NSString stringWithFormat:@"URL: %@",txtURL.text]];
				str = [str stringByAppendingFormat:@"\n"];
                tempurl=[tempurl stringByAppendingFormat:@"%@",txtURL.text];
			}
		
			strattr = [NSMutableAttributedString attributedStringWithString:str];
			[strattr setTextColor:[UIColor blackColor]];
			[strattr setFontFamily:@"Helvetica" size:18 bold:NO italic:NO range:[str rangeOfString:str]];
		
			if([txtURL.text length] > 0)
			{
				[strattr setTextBold:YES range:[str rangeOfString:@"URL:"]];
			}
				
			height;
			CGSize maximumLabelSize1 = CGSizeMake(280,9999);
			CGSize expectedLabelSize1 = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18] constrainedToSize:maximumLabelSize1 lineBreakMode:UILineBreakModeWordWrap];
			height = expectedLabelSize1.height;	
				   
		
			sampleString = tempurl;
		}
	
		[txtURL resignFirstResponder];
		[txtShortenURL resignFirstResponder];
	}
	
	[self TimeandDate];
}

-(IBAction) QrGenerateCode:(id) sender
{
	NSLog(@"Encode Button Pressed!");
	
	[self CheckValidation];
	
	
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

#pragma mark Validation

-(BOOL) validateURL: (NSString *) email 
{
	NSString *emailRegex = @"(http|https)://((\\w)*|([0-9]*)|([-|_|\\.])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
	
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	BOOL isValid = [emailTest evaluateWithObject:email];
	return isValid;
}

-(void)CheckValidation
{
	if(lblHeader.text == @"URL")
	{
	if ([txtURL.text rangeOfString:@"http://"].location == NSNotFound && [txtURL.text rangeOfString:@"https://"].location == NSNotFound)
	{
		NSString* str=[@"http://" stringByAppendingFormat:txtURL.text];
		txtURL.text=str;
		
	}
	if(![self validateURL:txtURL.text])
	{
		UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter valid URL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
		return;
	}
	else 
	{
		[self GenerateQrCode];
	}
	}
}


#pragma mark ParsingMethods

-(BOOL) checkInternetConnection
{
	NSString *requestString =@"";
	NSData *requestData = [NSData dataWithBytes: [requestString UTF8String] length: [requestString length]];
	NSMutableURLRequest *request1=[[[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:@"http://www.google.com"]] autorelease];
	[request1 setTimeoutInterval:5];
	[request1 setHTTPMethod: @"POST"];
	[request1 setHTTPBody: requestData];
	return [ NSURLConnection sendSynchronousRequest: request1 returningResponse: nil error: nil ]!=nil;
}

-(IBAction)shortenurlclick
{
	if (Imagecheck.hidden == NO) 
	{
		Imagecheck.hidden=YES;
		txtShortenURL.font = [UIFont fontWithName:@"Helvetica" size:12];
		txtShortenURL.textColor=[UIColor lightGrayColor];
		txtShortenURL.text = @"Shorten URL";
	}
	else
	{
		BOOL inter;
		inter = [self checkInternetConnection];
		
		if (inter) 
		{
			[txtURL resignFirstResponder];
			Imagecheck.hidden=NO;
			if ([txtURL.text rangeOfString:@"http://"].location == NSNotFound && [txtURL.text rangeOfString:@"https://"].location == NSNotFound)
			{
				NSString* str=[@"http://" stringByAppendingFormat:txtURL.text];
				txtURL.text=str;
				
			}
			if(![self validateURL:txtURL.text])
			{
				UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter valid URL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				[alert show];
				[alert release];
				Imagecheck.hidden = TRUE;
				return;
			}
			
			[self start];
			
		}
		
		
		else
		{	
			UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please check your internet connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
			[alert release];
			return;
		}
	}
	/*
	 if(![self validateURL:txturl1.text] && CounterBtn==0)
	 {
	 UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter valid URL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
	 [alert show];
	 [alert release];
	 
	 return;
	 }
	 else{	
	 if ([txturl1.text rangeOfString:@"http://"].location == NSNotFound && [txturl1.text rangeOfString:@"https://"].location == NSNotFound)
	 {
	 NSString* str=[@"http://" stringByAppendingFormat:txturl1.text];
	 txturl1.text=str;
	 
	 }
	 [self start];
	 }*/
	
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
	
	[DAL insert_library_CreatedDate:dateLabel.text Image:[NSString stringWithFormat:@"qr%@.png",date] Category:@"URL" Description:txtURL.text starting_Date:@"" Ending_Date:@"" Address:@"" Links:@"" Email:@"" Locations:@"" Message:@"" Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:@"" Notes:@""];	
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadData" object:nil];
}	



#pragma mark XML PARSING FOR Shorten URL
- (void)start
{
	NSString *URLString =[NSString stringWithFormat:@"http://api.bit.ly/v3/shorten?login=krenmarketing&apikey=R_c39f6d58acd30fdfb10b943062aa58b5&longUrl=%@&format=xml",txtURL.text];
	//NSString *URLString = @"http://api.bit.ly/v3/shorten?login=krenmarketing&apikey=R_c39f6d58acd30fdfb10b943062aa58b5&longUrl=http://www.facebook.com&format=xml";
	//URLString = [NSString stringWithFormat:@"http://www.google.com/ig/api?weather=%@", currentLocation];
	NSLog(@"urlstring: %@", URLString);
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (theConnection)
	{
		
		responseData = [[NSMutableData alloc] retain];
	}
	
	
	
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	NSLog(@"Receiving data...");	
	NSString* myString;
	myString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	NSLog(@"myString: %@",myString);
	xmlParser = [[NSXMLParser alloc] initWithData:[myString dataUsingEncoding:NSUTF8StringEncoding]];
    [xmlParser setDelegate:(id<NSXMLParserDelegate>)self];
    [xmlParser setShouldProcessNamespaces:NO];
    [xmlParser setShouldReportNamespacePrefixes:NO];
    [xmlParser setShouldResolveExternalEntities:NO];
    [xmlParser parse];
	//[responseData appendData:data];
	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Connection fail with error..Fail!");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSLog(@"Finished loading...");
	[connection release];
	
}

- (void)parserDidStartDocument:(NSXMLParser *)parser 
{
    NSLog(@"Document started", nil);
    depth = 0;
    currentElement = nil;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError 
{
    NSLog(@"Error: %@", [parseError localizedDescription]);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
    attributes:(NSDictionary *)attributeDict
{
    [currentElement release];
    currentElement = [elementName copy];
	
	currentName = [[NSMutableString alloc] init];
	
	
    if ([currentElement isEqualToString:@"data"])
    {
        ++depth;
        
    }
    else if ([currentElement isEqualToString:@"url"])
    {
		
    }
	else if ([currentElement isEqualToString:@"status_txt"])
    {
		
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
{
	
    if ([elementName isEqualToString:@"data"]) 
    {
        --depth;        
    }
    else if ([elementName isEqualToString:@"url"])
    {	
		NSLog(@"Outer name tag: %@", currentName);
		txtShortenURL.textColor=[UIColor blackColor];
		txtShortenURL.text=  currentName;
    }
	else if ([elementName isEqualToString:@"status_txt"])
    {	
		NSLog(@"Outer name tag: %@", currentName);
		if([currentName isEqualToString:@"INVALID_URI"]){
			UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter valid url" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		
    }
}        

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([currentElement isEqualToString:@"url"]) 
    {
        [currentName appendString:string];
    } 
	if ([currentElement isEqualToString:@"status_txt"]) 
    {
		if([string isEqualToString:@"INVALID_URI"]){
			[currentName appendString:string];}
    } 
	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser 
{
    NSLog(@"Document finished");
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
