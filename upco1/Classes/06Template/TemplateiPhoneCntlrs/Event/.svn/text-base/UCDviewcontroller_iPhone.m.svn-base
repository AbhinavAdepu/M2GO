//
//  UCDviewcontroller_iPhone.m
//  KrenMarketing
//
//  Created by Jayna Gandhi on 13/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UCDviewcontroller_iPhone.h"
#import "PreviewShareView_iPhone.h"
#import "DAL.h"


@implementation UCDviewcontroller_iPhone
@synthesize strFlag;
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
	
    [super viewDidLoad];
}


#pragma mark Save in Library Section

-(NSString *)TimeandDate{
	
	//Date
	NSDate* date = [NSDate date];
	NSDateFormatter *Date1=[[[NSDateFormatter alloc] init] autorelease];
	[Date1 setDateFormat:@"E MM/dd/yy"];
	//[Date1 setDateFormat:@"MMMM dd, yyyy"];
	NSString *Date12=[Date1 stringFromDate:date];    
	NSLog(@"Date: %@", Date12);
	//Time
	NSDateFormatter *Time1=[[[NSDateFormatter alloc] init] autorelease];
	[Time1 setDateFormat:@"h:mm aaa"];
	NSString *Time12=[Time1 stringFromDate:date];    
	NSLog(@"Date: %@",Time12);
	NSString *createdDate = [NSString stringWithFormat:@"Created on %@",Date12];
	//Time12 = [Time12 stringByReplacingOccurrencesOfString:@"PM" withString:@"P.M."];
	//Time12 = [Time12 stringByReplacingOccurrencesOfString:@"AM" withString:@"A.M."];
	//[TimeLabel setText:Time12];
	return createdDate;
}
-(void)saveToLibSection:(UIImage *)img
{
	NSString *createdDate = [self TimeandDate];
	
	NSString *sql = [NSString stringWithFormat:@"select *from library"];
	NSMutableArray *array=[DAL ExecuteArraySet:sql];
	
	UIImage *newImage = img;
	
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MM-dd-yyyy-HH-mm-ss"];
	
	NSString * date = [dateFormatter stringFromDate:[NSDate date]];
	
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString* path = [documentsDirectory stringByAppendingPathComponent: 
					  [NSString stringWithFormat:@"qr%@.png",date]];
	NSData* data = UIImagePNGRepresentation(newImage);
	[data writeToFile:path atomically:YES];
	if ([strFlag isEqualToString:@"UCD"])
	{
		[DAL insert_library_CreatedDate:createdDate 
								  Image:[NSString stringWithFormat:@"qr%@.png",date] 
							   Category:@"Event"
							Description:@""
						  starting_Date:@""
							Ending_Date:@""
								Address:@""
								  Links:@"NODATA" 
								  Email:@"NODATA" 
							  Locations:@"NODATA" 
								Message:@"NODATA" 
							 Department:@"NODATA" 
									Job:@"NODATA" 
								 Suffix:@"NODATA" 
							 MiddleName:@"NODATA" 
							   LastName:@"NODATA" 
							  FirstName:@"NODATA" 
								 Prefix:@"NODATA" 
								PhoneNo:@"NODATA" 
								Subject:@"NODATA" 
								  Notes:@""];
	}
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadData" object:nil];
}
-(IBAction)btnphotoalbumPressed:(id)sender
{
	UIImagePickerController *controller = [[UIImagePickerController alloc] init];
	[controller setDelegate:self];
	[self presentModalViewController:controller animated:TRUE];
}
-(IBAction)btnCreatePressed:(id)sender
{
	[self saveToLibSection:[self captureScreenInRect:imgBgFromPhotoAlbum.frame]];
	PreviewShareView_iPhone *previewShareView_iPhone = [[PreviewShareView_iPhone alloc]initWithNibName:@"PreviewShareView_iPhone" bundle:nil];
	previewShareView_iPhone.strFlag = strFlag;
	previewShareView_iPhone.imageBCard = [self captureScreenInRect:imgBgFromPhotoAlbum.frame];
	[self.navigationController pushViewController:previewShareView_iPhone animated:YES];
	[previewShareView_iPhone release];
	
	
}
-(IBAction)btnHomePressed:(id)sender
{
	[self.navigationController popToViewController:[[self.navigationController viewControllers]objectAtIndex:1] animated:YES];
}

-(IBAction)btnBackPressed:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
#pragma mark imagePickerController

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	
	[picker dismissModalViewControllerAnimated:YES];	
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	
	btnCreate.enabled = YES;
	[btnCreate setBackgroundImage:[UIImage imageNamed:@"btnCreate_AmritNormaliphone.png"] forState:UIControlStateNormal];

	imgBgFromPhotoAlbum.image = [self imageWithImage:image scaledToSize:CGSizeMake(580, 304)];
	[self dismissModalViewControllerAnimated:YES];
}
#pragma mark for image scalling
- (UIImage*)imageWithImage:(UIImage*)image 
			  scaledToSize:(CGSize)newSize;
{
	UIGraphicsBeginImageContext( newSize );
	[image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newImage;
}
#pragma mark for image screenshot create
- (UIImage *)captureScreenInRect:(CGRect)captureFrame {
    CALayer *layer;
    layer = viewImgCard.layer;
	
    UIGraphicsBeginImageContext(viewImgCard.frame.size); 
    CGContextClipToRect (UIGraphicsGetCurrentContext(),captureFrame);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

	
    return screenImage;
	
	
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
