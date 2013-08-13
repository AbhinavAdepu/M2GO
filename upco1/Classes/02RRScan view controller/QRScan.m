//
//  QRScan.m
//  KrenMarketing
//
//  Created by Jayna Gandhi on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QRScan.h"
#import "SHKItem.h"
#import "SHKActionSheet.h"


@implementation QRScan


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

/*(IBAction) buttonFacebooKClicked:(id)sender
{
	
		
	NSString *text=@"hello";
	SHKItem *item = [SHKItem text:text];
	[NSClassFromString(@"SHKFacebook") performSelector:@selector(shareItem:) withObject:item];
	
	
}*/
-(IBAction)buttonFacebooKClicked:(id)sender
{
		appDel = (KrenMarketingAppDelegate*)[[UIApplication sharedApplication]delegate];
	//NSString *text=@"hello";
	SHKItem *item = [SHKItem image:appDel.img.image];
	[NSClassFromString(@"SHKFacebook") performSelector:@selector(shareItem:) withObject:item];
	
}
-(IBAction) buttonTwitterClicked:(id)sender
{
	//
	
	appDel = (KrenMarketingAppDelegate*)[[UIApplication sharedApplication]delegate];

	//NSString *text=@"hello";
	
	SHKItem *item = [SHKItem image:appDel.img.image title:nil];
	//SHKItem *item = [SHKItem text:text];
	
	[NSClassFromString(@"SHKTwitter") performSelector:@selector(shareItem:) withObject:item];
	
	//[NSClassFromString(@"SHKTwitter") performSelector:@selector(shareItem:) withObject:item];
	
}


/*- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{   
    //message.hidden = NO;
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //message.text = @"Result: canceled";
            break;
        case MFMailComposeResultSaved:
            //message.text = @"Result: saved";
            break;
        case MFMailComposeResultSent:
            //message.text = @"Result: sent";
            break;
        case MFMailComposeResultFailed:
            //message.text = @"Result: failed";
            break;
        default:
            //message.text = @"Result: not sent";
            break;
    }
	[self dismissModalViewControllerAnimated:YES];
	//translateScreen = true;
}*/
/*-(IBAction)emailbtn_click:(id)sender
{
	
	/*NSString *text=@"hello";
	
	SHKItem *item = [SHKItem text:text];
	[NSClassFromString(@"SHKMail") performSelector:@selector(shareItem:) withObject:item];*/
	
	/*appDel = (KrenMarketingAppDelegate*)[[UIApplication sharedApplication]delegate];
	//img.image=appDel.img.image;
	//NSString *text=@"hello";
	NSData *data = UIImagePNGRepresentation(appDel.img.image);
	SHKItem *item = [SHKItem file:data filename:@"QRCode" mimeType:@"jpg/png" title:@"QRCode"];
	
	[NSClassFromString(@"SHKMail") performSelector:@selector(shareItem:) withObject:item];
	
	
}*/


-(IBAction)emailbtn_click:(id)sender
{
	appDel = (KrenMarketingAppDelegate*)[[UIApplication sharedApplication]delegate];
    
	int w=appDel.img.image.size.width;
	int h=appDel.img.image.size.height;
	
	
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef context = CGBitmapContextCreate(NULL, w, h+155, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
	
	// CGContextDrawImage(context, CGRectMake(0, 155, w, h), image.image.CGImage);
	CGContextDrawImage(context, CGRectMake(0, 155, w, 400), appDel.img.image.CGImage);
    
    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1);
	
	CGContextSelectFont(context, "Arial", 22, kCGEncodingMacRoman);
	
	CGContextSetTextDrawingMode(context, kCGTextFill);
	CGContextSetRGBFillColor(context, 0, 0, 0, 1);
	
	UIGraphicsPushContext(context);
	
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0.0f, h+155);
    CGContextScaleCTM(context, 1.0f, -1.0f);
	/*
	 [strTemp drawInRect:CGRectMake(5, h+5, w-10, 100) withFont:[UIFont systemFontOfSize:16]];
	 
	 [strTemp1 drawInRect:CGRectMake(w-155, h+100, 150, 35) withFont:[UIFont systemFontOfSize:14]];
	 */	
    CGContextRestoreGState(context);
	
    UIGraphicsPopContext();
	
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
	
    CGContextRelease(context);
	
    CGColorSpaceRelease(colorSpace);
	
    UIImage *imgText = [UIImage imageWithCGImage:imageMasked];
	UIGraphicsBeginImageContext(CGSizeMake(320, 365));
	[imgText drawInRect:CGRectMake(0, 0, 320, 365)];
	//UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
	
    
    
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
	

    
    
    //open it for sharekit
	/*UIGraphicsEndImageContext();
	SHKItem *item = [SHKItem image:appDel.img.image title:@"QR CODE"];
	[NSClassFromString(@"SHKMail") performSelector:@selector(shareItem:) withObject:item];*/
	
	
		
}


-(void)displayComposerSheet
{
	//appDel.img.image = [self captureScreenInRect:CGRectMake(0,0 ,700, btnEmail.frame.origin.y)];
	appDel = (KrenMarketingAppDelegate*)[[UIApplication sharedApplication]delegate];
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	
	
	/*NSString *tmpBody = @"";
	 tmpBody =[tmpBody stringByAppendingString:@"<br></br>"];
	 tmpBody =[tmpBody stringByAppendingString:@"<br></br>"];
	 //NSString *strURL = [NSString stringWithFormat:@"%@image.ashx?ID=%d&imagesize=W600xH420&imagetype=MainImage",WEB_SERVICE_URL,[idNew intValue]];
	 tmpBody =[tmpBody stringByAppendingFormat:@"<b><img src='%@'></b>",imgScreen];
	 [picker setMessageBody:tmpBody isHTML:YES];*/
	
    NSLog(@"appdel==%@",appDel.tempImageScan);
	NSData *imgData = UIImagePNGRepresentation(appDel.tempImageScan);
	[picker addAttachmentData:imgData mimeType:@"image/png" fileName:@"Result"];//[tmpBody release];
	
	
	picker.modalPresentationStyle =UIModalPresentationFormSheet;
	picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[appDel.viewController  presentModalViewController:picker animated:YES];
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
	
	[appDel.viewController  dismissModalViewControllerAnimated:YES];
}



- (void)dealloc {
    [super dealloc];
}


@end
