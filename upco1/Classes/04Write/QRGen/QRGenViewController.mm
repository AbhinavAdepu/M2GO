

//  QRGenViewController.m
//  QRGen
//
//  Created by Patrick Hogan on 7/26/11.
//  Copyright 2011 Kuapay LLC. All rights reserved.


#import "QRGenViewController.h"
#import "Reachability.h"
#import "FileManager.h"
#import "qr_draw_png.h"
#import "QR_Encode.h"
#import "SHKItem.h"
#import "SHKActionSheet.h"
#import "PopOver.h"
#import "StartEndDayController.h"
#import "FontViewViewController.h"
#import "NSAttributedString+Attributes.h"
#import "DAL.h"
#import "LibraryCell-Landscape.h"
#import "WriteDetailViewController.h"
#import "MapLocationViewController.h"
#import "PhoneDetailViewController.h"
#import "SMSDetailViewController.h"
#import "EmailDetailViewController.h"
#import "TextDetailViewController.h"
#import "EventDetailViewController.h"
#import "ContactDetailViewController.h"
#import "iseventcan.h"

#define ALPHA @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.+-@#$!?%^&*(){}[],:\"\\;/<>| " " "
//#define NUMBERS @"+-1234567890"
#define NUMBERS @" ()-1234567890"
#define ALPHABET @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ  "

#define ZIP @"1234567890"
//#define ALPHA   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"


@implementation QRGenViewController
@synthesize imageview,txtName,realph,tmpst,realph1;
@synthesize isBold,isItalic,isUnderline;
@synthesize egoTextView=_egoTextView;
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

	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		
	}
	else 
	{
		//[tblWrite_iphone reloadData];
	}
	
}



- (void)viewDidLoad
{
	[super viewDidLoad];
    
    
  
   
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
	prevvalue=20;
	//ResultString=[[NSString alloc] init];
	activetxt = [[UITextField alloc]init];
	activetxtview=[[UITextView alloc]init];
	Imagecheck.hidden=YES;
	ctr = 1;
	LblMailMessage.hidden=YES;
	LblsmsMessage.hidden=YES;
	arrLocal = [[NSMutableArray alloc]init];
	MaskView=[[UIView alloc] init];	
	BtnTrash.selected=FALSE;
	imageSetting.hidden=YES;
	BtnEncode.enabled = NO;
	CounterBtn=0;
	sampleString=@"";             
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication]delegate];
	appDel.fromTwitter=FALSE;
	firstTime=TRUE;
	oncePort=FALSE;
	EmailView.hidden=YES;
	ViewText.hidden=YES;
    URLView.hidden=NO;
	ContactView.hidden=YES;
	Mapview.hidden=YES;
	SMSView.hidden=YES;
	PhoneView.hidden=YES;
    EventView.hidden=YES;
	//BtnTrash.selected=FALSE;
	Start=FALSE;
	END=FALSE;
        
    temploc=[[NSString alloc]init];
    tempevennotes=[[NSString alloc]init];
        tempevenloc=[[NSString alloc]init];
	scrollView = [[UIScrollView alloc] init];	
	AddButton = [[NSMutableArray alloc]init];
	arrField=[[NSMutableArray alloc] init];
	[ContactView addSubview:scrollView];
	OtherButton=[[NSMutableArray alloc] init];
	
        //--*
        scrolldata = [[UIScrollView alloc] initWithFrame:CGRectMake(150,400, 800, 800 )];
        
        
       actionButton=[[UIButton alloc] initWithFrame:CGRectMake(100, 400, 50, 50)];
        [actionButton setEnabled:YES];
        [actionButton addTarget:self action:@selector(actbutmet) forControlEvents:UIControlEventTouchUpInside];
        [scrolldata addSubview:actionButton];
       // [actionButton release];
        actionButton.titleLabel.text=@"action";
      //  [actionButton setImage:[UIImage imageNamed:@"WriteQR-Portrait_0005_Generate-QR-Code-BTNs.png"] forState:UIControlStateNormal];
       [actionButton setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        flagcon=NO;
        flagphon=NO;
        flageven=NO;
        
        scrolldata.hidden=YES;
        actionButton.hidden=YES;
        
        
    
    NSMutableDictionary* dic;
    dic=[[NSMutableDictionary alloc] init];
    [dic setObject:@"yes" forKey:@"isactive"];
    [dic setObject:@"Name" forKey:@"placeholder"];
    [dic setObject:@"" forKey:@"value"];
    [arrField addObject:dic];
    [dic release];
    
    dic=[[NSMutableDictionary alloc] init];
    [dic setObject:@"yes" forKey:@"isactive"];
    [dic setObject:@"Phone Number" forKey:@"placeholder"];
    [dic setObject:@"" forKey:@"value"];
    [arrField addObject:dic];
    [dic release];
    
    dic=[[NSMutableDictionary alloc] init];
    [dic setObject:@"no" forKey:@"isactive"];
    [dic setObject:@"Prefix" forKey:@"placeholder"];
    [dic setObject:@"" forKey:@"value"];
    [arrField addObject:dic];
    [dic release];
	
    dic=[[NSMutableDictionary alloc] init];
    [dic setObject:@"no" forKey:@"isactive"];
    [dic setObject:@"Phonetic First Name" forKey:@"placeholder"];
    [dic setObject:@"" forKey:@"value"];
    [arrField addObject:dic];
    [dic release];
	
    dic=[[NSMutableDictionary alloc] init];
    [dic setObject:@"no" forKey:@"isactive"];
    [dic setObject:@"Phonetic Last Name" forKey:@"placeholder"];
    [dic setObject:@"" forKey:@"value"];
    [arrField addObject:dic];
    [dic release];
	
    dic=[[NSMutableDictionary alloc] init];
    [dic setObject:@"no" forKey:@"isactive"];
    [dic setObject:@"Middle" forKey:@"placeholder"];
    [dic setObject:@"" forKey:@"value"];
    [arrField addObject:dic];
    [dic release];
	
    dic=[[NSMutableDictionary alloc] init];
    [dic setObject:@"no" forKey:@"isactive"];
    [dic setObject:@"Suffix" forKey:@"placeholder"];
    [dic setObject:@"" forKey:@"value"];
    [arrField addObject:dic];
    [dic release];
	
    dic=[[NSMutableDictionary alloc] init];
    [dic setObject:@"no" forKey:@"isactive"];
    [dic setObject:@"Job Title" forKey:@"placeholder"];
    [dic setObject:@"" forKey:@"value"];
    [arrField addObject:dic];
    [dic release];
	
    dic=[[NSMutableDictionary alloc] init];
    [dic setObject:@"no" forKey:@"isactive"];
    [dic setObject:@"Department" forKey:@"placeholder"];
    [dic setObject:@"" forKey:@"value"];
    [arrField addObject:dic];
    [dic release];	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"didRotate" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(didRotate:) 
												 name:UIApplicationDidChangeStatusBarOrientationNotification
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(rotateStuff) 
												 name:UIApplicationDidChangeStatusBarOrientationNotification
											   object:nil];
	
	txtDisplayWEb.automaticallyAddLinksForType = NSTextCheckingAllSystemTypes;
        
        
        [self URLClicked:nil];
        
         UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(handleSingleTap:)];
          gestureRecognizer.delegate=self;
        
         [ScrllLabel addGestureRecognizer:gestureRecognizer];
        
	}
	else 
	{
		NSLog(@"Iphone");
		selectedRow = 500;
		arr_iphoneData = [[NSMutableArray alloc] initWithObjects:@"URL",@"Contact",@"Event",@"Map Location",@"SMS",@"Phone",@"Email",@"Text",nil];
		array_NormalImages = [[NSMutableArray alloc] initWithObjects:@"URL_WriteNormal_iphone.png",@"Contact_WriteNormal_iphone.png",@"Event_WriteNormal_iphone.png",@"Map_WriteNormal_iphone.png",@"SMS_WriteNormal_iphone.png",@"Phone_WriteNormal_iphone.png",@"Email_WriteNormal_iphone.png",@"Text_WriteNormal_iphone.png",nil];
		array_SelectedImages = [[NSMutableArray alloc] initWithObjects:@"URL_WriteSelected_iphone.png",@"Contact_WriteSelected_iphone.png",@"Event_WriteSelected_iphone.png",@"Map_WriteSelected_iphone.png",@"SMS_WriteSelected_iphone.png",@"Phone_WriteSelected_iphone.png",@"Email_WriteSelected_iphone.png",@"Text_WriteSelected_iphone.png",nil];
		
	}
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{	
	return [arr_iphoneData count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 72;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString *CellIdentifier = @"CustomCell";
	LibraryCell_Landscape *cell = (LibraryCell_Landscape *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LibraryCell-Landscape" owner:self options:nil];
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (LibraryCell_Landscape *) currentObject;
				break;
			}
		}
	}
	
	UIImageView *img = [[UIImageView alloc]init];
	img.image = [UIImage imageNamed:@"_0000_seperation-lines-set1-copy-20.png"];
	img.frame = CGRectMake(0, 0, 320, 72);
	[cell.contentView addSubview:img];
	[img release];
	
	UIImageView *img1 = [[UIImageView alloc]init];
	img1.image = [UIImage imageNamed:[array_NormalImages objectAtIndex:indexPath.row]];
	img1.frame = CGRectMake(10, 8, 56, 56);
	[cell.contentView addSubview:img1];
	[img1 release];
	
	
	UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(80, 22, 150, 30)];
	lbl1.text = [arr_iphoneData objectAtIndex:indexPath.row];
	[lbl1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
	[cell.contentView addSubview:lbl1];
	[lbl1 release];
	
	UIImageView *img_aero = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Arrow_WriteDark_iphone.png"]];
	img_aero.frame = CGRectMake(300, 32, 6, 11);
	[cell.contentView addSubview:img_aero];
	
	img.highlightedImage = [UIImage imageNamed:@"_0001_seperation-lines-set1-20.png"];
	img.image = [UIImage imageNamed:@"_0000_seperation-lines-set1-copy-20.png"];
	lbl1.highlightedTextColor = [UIColor whiteColor];
	img_aero.highlightedImage = [UIImage imageNamed:@"Arrow_WriteNormal_iphone.png"];
	img1.highlightedImage = [UIImage imageNamed:[array_SelectedImages objectAtIndex:indexPath.row]];
	
	/*
	if(selectedRow == indexPath.row)
	{
		img.image = [UIImage imageNamed:@"_0001_seperation-lines-set1-20.png"];
		img1.image =[UIImage imageNamed:[array_SelectedImages objectAtIndex:indexPath.row]];
		lbl1.backgroundColor = [UIColor clearColor];
		lbl1.textColor = [UIColor whiteColor];
		img_aero.image = [UIImage imageNamed:@"Arrow_WriteNormal_iphone.png"];
	}
	*/
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	selectedRow = indexPath.row;
	[tblWrite_iphone reloadData];
	if(selectedRow == 0)
	{
		WriteDetailViewController *obj_write = [[WriteDetailViewController alloc] initWithNibName:@"WriteDetailViewController" bundle:nil Text:[arr_iphoneData objectAtIndex:selectedRow]];
		[self.navigationController pushViewController:obj_write animated:TRUE];
		[obj_write release];
	}
	else if(selectedRow == 1)
	{
		ContactDetailViewController *obj_Contact = [[ContactDetailViewController alloc] initWithNibName:@"ContactDetailViewController" bundle:nil];
		[self.navigationController pushViewController:obj_Contact animated:TRUE];
		[obj_Contact release];
	}
	else if(selectedRow == 2)
	{
		EventDetailViewController *obj_Event = [[EventDetailViewController alloc] initWithNibName:@"EventDetailViewController" bundle:nil];
		[self.navigationController pushViewController:obj_Event animated:TRUE];
		[obj_Event release];
	}
	
	else if(selectedRow == 3)
	{
		MapLocationViewController *obj_Map = [[MapLocationViewController alloc] initWithNibName:@"MapLocationViewController" bundle:nil];
		[self.navigationController pushViewController:obj_Map animated:TRUE];
		[obj_Map release];
	}
	else if(selectedRow == 4)
	{
		SMSDetailViewController *obj_SMS = [[SMSDetailViewController alloc] initWithNibName:@"SMSDetailViewController" bundle:nil];
		[self.navigationController pushViewController:obj_SMS animated:TRUE];
		[obj_SMS release];
	}
	
	else if(selectedRow == 5)
	{
		PhoneDetailViewController *obj_Phone = [[PhoneDetailViewController alloc] initWithNibName:@"PhoneDetailViewController" bundle:nil];
		[self.navigationController pushViewController:obj_Phone animated:TRUE];
		[obj_Phone release];
	}
	else if(selectedRow == 6)
	{
		EmailDetailViewController *obj_Email = [[EmailDetailViewController alloc] initWithNibName:@"EmailDetailViewController" bundle:nil];
		[self.navigationController pushViewController:obj_Email animated:TRUE];
		[obj_Email release];
	}
	else if(selectedRow == 7)
	{
		TextDetailViewController *obj_TextDetail = [[TextDetailViewController alloc] initWithNibName:@"TextDetailViewController" bundle:nil];
		[self.navigationController pushViewController:obj_TextDetail animated:TRUE];
		[obj_TextDetail release];
	}
	
}

-(void) rotateStuff
{
	[self dismissdatePopOver];
	[self didmissfontpicker];
	if(newPopOver)
		[newPopOver dismissPopoverAnimated:YES];
}

#pragma mark ReloadUI
-(void)reloadUI
{
    ctr=1;
    for(int i=0;i<[OtherButton count];i++)
    {
        [[OtherButton objectAtIndex:i] removeFromSuperview];
    }
	if([arrLocal count]>0)
		[arrLocal removeAllObjects];
    height=0;
    int j=0;
	if(prevvalue<[arrField count])
		[[arrField objectAtIndex:prevvalue]setObject:@"" forKey:@"value"];	
    for (int i=0; i<[arrField count]; i++)
    {        
        if ([[[arrField objectAtIndex:i] valueForKey:@"isactive"] isEqualToString:@"yes"]) 
        {          
            btnName = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnName setFrame:CGRectMake(0, (scrollView.frame.origin.y+ 25)*j, scrollView.frame.size.width-15, 44)];
			[btnName setBackgroundImage:[UIImage imageNamed:@"_0005_txt-box1.png"] forState:UIControlStateNormal];
            btnName.userInteractionEnabled =YES;
			btnName.clipsToBounds =YES;
			btnName.adjustsImageWhenHighlighted = NO;
			btnName.autoresizingMask=UIViewAutoresizingFlexibleWidth;			
			
			UITextField *txtFieldPlaceholder = [[UITextField alloc]init];
		    txtFieldPlaceholder.delegate = self;
			txtFieldPlaceholder.textAlignment = UITextAlignmentLeft;
            txtFieldPlaceholder.borderStyle = UITextBorderStyleNone;
            txtFieldPlaceholder.keyboardType = UIKeyboardTypeAlphabet;
			txtFieldPlaceholder.autocapitalizationType = UITextAutocapitalizationTypeWords;
			txtFieldPlaceholder.font = [UIFont fontWithName:@"Helvetica" size:18];
            txtFieldPlaceholder.returnKeyType = UIReturnKeyDone;
			txtFieldPlaceholder.frame = CGRectMake(12,9,btnName.frame.size.width-45, 44);
			txtFieldPlaceholder.autoresizingMask=UIViewAutoresizingFlexibleWidth;
            if ( [[[arrField objectAtIndex:i] valueForKey:@"value"] length] >0) {
                txtFieldPlaceholder.text =[[arrField objectAtIndex:i] valueForKey:@"value"];				
            }else            
				txtFieldPlaceholder.placeholder = [[arrField objectAtIndex:i] valueForKey:@"placeholder"];

            
			txtFieldPlaceholder.tag = i;
			NSLog(@"tag==>%d",i);
			if([[[arrField objectAtIndex:i] valueForKey:@"placeholder"] isEqualToString:@"Phone Number"])
				txtFieldPlaceholder.keyboardType=UIKeyboardTypeNumberPad;
            
            if(i>1)
			{
				NSLog(@"btnframe==>%f",scrollView.frame.size.width);
				UIButton *btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
				[btnDelete setBackgroundImage:[UIImage imageNamed:@"minus_button.png"] forState:UIControlStateNormal];
				btnDelete.frame = CGRectMake(btnName.frame.size.width-40,5, 34, 34);
				btnDelete.autoresizingMask=UIViewAutoresizingFlexibleWidth;
				btnDelete.tag=i;
				NSLog(@"===>%d",btnDelete.tag);
				[btnDelete addTarget:self action:@selector(DeleteRow:)
				   forControlEvents:UIControlEventTouchDown];				
				[btnName addSubview:btnDelete];
			}
			
            [btnName addSubview:txtFieldPlaceholder];			
            [scrollView addSubview:btnName];
			[OtherButton addObject:btnName];
            height=height+scrollView.frame.origin.y+25;
            j++;
			[arrLocal addObject:txtFieldPlaceholder];
        }
    }	
    scrollView.contentSize=CGSizeMake(0, height+100);
	
   // 
	[self imageDraw];

}

-(void)DeleteRow:(id) sender
{	
	NSString *str;
	str=@"";	
	UIButton* b=(UIButton*) sender;
	prevvalue=b.tag;
	NSLog(@"===>%d",b.tag);
	[[arrField objectAtIndex:b.tag]setObject:@"no" forKey:@"isactive"];	
	
	[self reloadUI];

}

#pragma mark GenerateCode
-(void)GenerateCode:(id)sender
{
	
    NSString *Value;
    NSString   *showValue;
	//[activetxt resignFirstResponder];
    showValue=[[NSString alloc]init];
    for (int i=0; i<[arrField count]; i++)
    {
        
        if ([[[arrField objectAtIndex:i] valueForKey:@"isactive"] isEqualToString:@"yes"]) 
        {
            if (![[[arrField objectAtIndex:i] valueForKey:@"value"] isEqualToString:@""]) {
                Value = [[arrField objectAtIndex:i] valueForKey:@"value"] ;
                showValue = [showValue stringByAppendingFormat:@" ,%@", Value];
               // NSLog(@"%@",showValue);
				
                
            }
            
        }
		
    }
    showLebel .text =showValue;
}

-(void)imageDraw
{
	
    for(int j=0;j<[AddButton count];j++)
	{		
		[[AddButton objectAtIndex:j] removeFromSuperview];
    }
	
    addbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addbtn setFrame:CGRectMake(0, (height)-4, 57, 57)];
    addbtn.backgroundColor = [UIColor clearColor];
    addbtn.userInteractionEnabled =YES;
    
    UIImage *img = [UIImage imageNamed:@"_0040_+.png"];
    //    btnAdd.tag = k;
    [addbtn addTarget:self action:@selector(Add:) forControlEvents:UIControlEventTouchUpInside];
    [addbtn setBackgroundImage:img forState:UIControlStateNormal];
    [scrollView addSubview:addbtn];
    
    UIButton *Otherbtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[Otherbtn setFrame:CGRectMake(65, (height+2),scrollView.frame.size.width-80, 44)];
    Otherbtn.backgroundColor = [UIColor clearColor];
	[Otherbtn setBackgroundImage:[UIImage imageNamed:@"_0004_txt-box2-add-field.png"] forState:UIControlStateNormal];
    Otherbtn.userInteractionEnabled =NO;
    [scrollView addSubview:Otherbtn];
	
    UITextField *txtField = [[UITextField alloc]init];
    txtField.delegate = self;
    txtField.textAlignment = UITextAlignmentLeft;
    txtField.borderStyle = UITextBorderStyleNone;
    txtField.keyboardType = UIKeyboardTypeDefault;
    txtField.backgroundColor = [UIColor clearColor];
    txtField.returnKeyType = UIReturnKeyDone;
	txtField.font = [UIFont fontWithName:@"Helvetica" size:18];
    txtField.placeholder =@"Add Field";
    txtField.frame = CGRectMake(12,9, scrollView.frame.size.width-150,40);
    [Otherbtn addSubview:txtField];

    UIButton *generatebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [generatebtn setFrame:CGRectMake(340, (height+80), 150, 50)];
    generatebtn.backgroundColor = [UIColor clearColor];
    generatebtn.userInteractionEnabled =YES;
    [generatebtn addTarget:self action:@selector(GenerateCode:) forControlEvents:UIControlEventTouchUpInside];
		
    showLebel = [[UILabel alloc] initWithFrame:CGRectMake(150.0, (height+150), 470, 30.0)];
    showLebel.textAlignment = UITextAlignmentLeft;
    showLebel.textColor=[UIColor blackColor];
    
    [showLebel setFont:[UIFont systemFontOfSize:16.0f]];
    showLebel.backgroundColor = [UIColor greenColor];
	
    
	[AddButton addObject:addbtn];
	[AddButton addObject:Otherbtn];
	[AddButton addObject:txtField];
    
}



-(void)Add:(id)sender
{
	[activetxt resignFirstResponder];
    obj_OtherOptionController = [[OtherOptionController alloc] initWithNibName:@"OtherOptionController" bundle:nil];
    obj_OtherOptionController.delegate=(id<OtherOptionDelegate>)self;
    obj_OtherOptionController.tblArr=[arrField retain];
    UINavigationController* tNav=[[UINavigationController alloc] initWithRootViewController:obj_OtherOptionController];	
    newPopOver=[[UIPopoverController alloc] initWithContentViewController:tNav];
    newPopOver.popoverContentSize=CGSizeMake(320, 400);
    [newPopOver presentPopoverFromRect:CGRectMake(addbtn.frame.origin.x, addbtn.frame.origin.y, addbtn.frame.size.width, addbtn.frame.size.height) inView:scrollView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [tNav release];
	
}

-(void) completeSelection:(NSMutableArray*) arr
{
    [arrField removeAllObjects];
    [arrField addObject:arr];
	[self dismissPopOver];
    [self reloadUI];
}

-(void) doneClicked:(NSMutableArray*) arr
{
    arrField = [arr copy];
    [self dismissPopOver];
	[self reloadUI];
}

-(void) dismissPopOver
{
	if(newPopOver)
	{
		[newPopOver dismissPopoverAnimated:YES];
		[newPopOver release];
		newPopOver=nil;
	}
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	NSLog(@"textField.tag==>%d",ctr);
	//ctr=1;
	[textField resignFirstResponder];
	if ([textField isEqual:Txtsms] && CounterBtn==4 ) {
		[txtsmsMessage performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0f];
		//[txtsmsMessage becomeFirstResponder];
	}else if ([textField isEqual:txtemail1] && CounterBtn==6) {
		[txtemail2 becomeFirstResponder];		
	}else if ([textField isEqual:txtemail2] && CounterBtn==6) {
		//[txtviewemail3 becomeFirstResponder];
		[txtviewemail3 performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0f];
	}else if ([textField isEqual:Txtmap1] && CounterBtn==3) {
		[Txtmap2 becomeFirstResponder];
	}else if ([textField isEqual:Txtmap2] && CounterBtn==3) {
		[Txtmap3 becomeFirstResponder];
	}else if ([textField isEqual:Txtmap3] && CounterBtn==3) {
		[Txtmap4 becomeFirstResponder];
	}else if ([textField isEqual:Txtmap4] && CounterBtn==3) {
		[Txtmap5 becomeFirstResponder];
	}else if ([textField isEqual:Txtmap5] && CounterBtn==3) {
		[Txtmap6 becomeFirstResponder];
	}else if ([textField isEqual:txtevent1] && CounterBtn==2) {
		[self StartsClick :BtnStarts];		
	}else if ([textField isEqual:txtevent3] && CounterBtn==2) {
		[txtevent4 becomeFirstResponder];
	}else if ([textField isEqual:txtevent4] && CounterBtn==2) {
		[txtevent5 becomeFirstResponder];
	}else if ([textField isEqual:txtevent5] && CounterBtn==2) {
		[txtevent6 becomeFirstResponder];
	}else if ([textField isEqual:txtevent6] && CounterBtn==2) {
		[txtevent7 becomeFirstResponder];
	}else if ([textField isEqual:txtevent7] && CounterBtn==2) {
		[txtevent8 becomeFirstResponder];
	}
	
	else if (CounterBtn==1) 
	{	
		if(ctr < [arrLocal count])		
		{
			[[arrLocal objectAtIndex:ctr++] becomeFirstResponder];	
			
		}		
		else {
			if ([arrLocal count]==2) {
				[self Add:nil];
			}
			ctr=1;
		}
	}	
    return YES;
}

int charcount;
- (void)textFieldDidEndEditing:(UITextField *)textField
{
	
	if(CounterBtn==1){
		[[arrField objectAtIndex:[textField tag]] setObject:textField.text forKey:@"value"];
    }
	charcount=0;
	NSString *str=@"";
	for (int i=0; i<[arrField count]; i++)
	{		
		if ([[[arrField objectAtIndex:i] valueForKey:@"isactive"] isEqualToString:@"yes"]) 
		{
			if (![[[arrField objectAtIndex:i] valueForKey:@"value"] isEqualToString:@""]) 
			{
				str = [str stringByAppendingFormat:[[arrField objectAtIndex:i] valueForKey:@"value"]];
			}
		}
	}
	charcount=[str length];	
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (CounterBtn==0) {
		Imagecheck.hidden=YES;
		LblUrl2.textColor=[UIColor lightGrayColor] ;
		LblUrl2.text=@"Shorten URL";
		
	}
	if([txtsmsMessage.text isEqualToString:@""] && CounterBtn==4 ){
	txtsmsMessage.textColor=[UIColor lightGrayColor];		
	}else if ([txtviewemail3.text isEqualToString:@""] && CounterBtn==6) {
		txtviewemail3.text=@"Message";
		txtviewemail3.textColor=[UIColor lightGrayColor];

	}
    activetxt=textField;	
	for(int i=0;i<[arrLocal count];i++)
	{
		if([[arrLocal objectAtIndex:i] isEqual:textField])
		{
			ctr=i+1;
			break;
		}
		
	}	
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{	
	if (CounterBtn==2) {
		
		if ([textField isEqual:txtevent4]) {
			NSCharacterSet *cs;
			NSString *filtered;
			cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHABET] invertedSet];
			filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
			if ([filtered length]>0 ) {
				BtnEncode.enabled = YES;
			}
			else{
				if( [txtevent1.text length]==1 && [txtevent3.text length]==0 && [txtevent4.text length]==0  && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0) { //event
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==1 && [txtevent4.text length]==0  && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==1 && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==1  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==0  && [txtevent6.text length]==1  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==1  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==1 && [string length]==0){
					BtnEncode.enabled = NO;
				}
			}
			return [string isEqualToString:filtered];
		}
		else if ([textField isEqual:txtevent5]) {
			NSCharacterSet *cs;
			NSString *filtered;
			cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHABET] invertedSet];
			filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
			if ([filtered length]>0 ) {
				BtnEncode.enabled = YES;
			}else{
				if( [txtevent1.text length]==1 && [txtevent3.text length]==0 && [txtevent4.text length]==0  && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0) { //event
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==1 && [txtevent4.text length]==0  && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==1 && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==1  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==0  && [txtevent6.text length]==1  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==1  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==1 && [string length]==0){
					BtnEncode.enabled = NO;
				}
			}
			return [string isEqualToString:filtered];
		}
		else if ([textField isEqual:txtevent6]) {
			NSCharacterSet *cs;
			NSString *filtered;
			cs = [[NSCharacterSet characterSetWithCharactersInString:ZIP] invertedSet];
			filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
			if ([filtered length]>0) {
				BtnEncode.enabled = YES;
			}else{
				if( [txtevent1.text length]==1 && [txtevent3.text length]==0 && [txtevent4.text length]==0  && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0) { //event
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==1 && [txtevent4.text length]==0  && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==1 && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==1  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==0  && [txtevent6.text length]==1  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==1  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==1 && [string length]==0){
					BtnEncode.enabled = NO;
				}
			}
			return [string isEqualToString:filtered];
		}
		else if ([textField isEqual:txtevent7]) {
			NSCharacterSet *cs;
			NSString *filtered;
			cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHABET] invertedSet];
			filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
			if ([filtered length]>0) {
				BtnEncode.enabled = YES;
			}else{
				if( [txtevent1.text length]==1 && [txtevent3.text length]==0 && [txtevent4.text length]==0  && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0) { //event
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==1 && [txtevent4.text length]==0  && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==1 && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==1  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==0  && [txtevent6.text length]==1  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==1  && [txtevent8.text length]==0 && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==1 && [string length]==0){
					BtnEncode.enabled = NO;
				}
			}
			return [string isEqualToString:filtered];
		}else{
			if( [txtevent1.text length]==1 && [txtevent3.text length]==0 && [txtevent4.text length]==0  && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0) { //event
				BtnEncode.enabled = NO;
			}else if( [txtevent1.text length]==0 && [txtevent3.text length]==1 && [txtevent4.text length]==0  && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
				BtnEncode.enabled = NO;
			}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==1 && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
				BtnEncode.enabled = NO;
			}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==1  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
				BtnEncode.enabled = NO;
			}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==0  && [txtevent6.text length]==1  && [txtevent7.text length]==0  && [txtevent8.text length]==0 && [string length]==0){
				BtnEncode.enabled = NO;
			}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==1  && [txtevent8.text length]==0 && [string length]==0){
				BtnEncode.enabled = NO;
			}else if( [txtevent1.text length]==0 && [txtevent3.text length]==0 && [txtevent4.text length]==0 && [txtevent5.text length]==0  && [txtevent6.text length]==0  && [txtevent7.text length]==0  && [txtevent8.text length]==1 && [string length]==0){
				BtnEncode.enabled = NO;
			}else{
				BtnEncode.enabled = YES;
			}
		}	
	} //End of if Counterbtn==2
	else if (CounterBtn==3) {
		
		if ([textField isEqual:Txtmap2]) {
			NSCharacterSet *cs;
			NSString *filtered;
			cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHABET] invertedSet];
			filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
			if ([filtered length]>0 ) {
				BtnEncode.enabled = YES;
			}
			else{
				if( [Txtmap1.text length]==1 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0 && [string length]==0) { //map
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==1 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0  && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==1  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0  && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==1  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0  && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==1  && [Txtmap6.text length]==0  && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==1  && [string length]==0){
					BtnEncode.enabled = NO;
				}				
			}
			return [string isEqualToString:filtered];
		}else if ([textField isEqual:Txtmap3]) {
			NSCharacterSet *cs;
			NSString *filtered;
			cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHABET] invertedSet];
			filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
			if ([filtered length]>0 ) {
				BtnEncode.enabled = YES;
			}else{
				if( [Txtmap1.text length]==1 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0 && [string length]==0) { //map
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==1 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0  && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==1  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0  && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==1  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0  && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==1  && [Txtmap6.text length]==0  && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==1  && [string length]==0){
					BtnEncode.enabled = NO;
				}		
			}
			return [string isEqualToString:filtered];
		}else if ([textField isEqual:Txtmap4]) {
			NSCharacterSet *cs;
			NSString *filtered;
			cs = [[NSCharacterSet characterSetWithCharactersInString:ZIP] invertedSet];
			filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
			if ([filtered length]>0) {
				BtnEncode.enabled = YES;
			}else{
				if( [Txtmap1.text length]==1 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0 && [string length]==0) { //map
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==1 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0  && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==1  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0  && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==1  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0  && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==1  && [Txtmap6.text length]==0  && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==1  && [string length]==0){
					BtnEncode.enabled = NO;
				}		
				
			}
			return [string isEqualToString:filtered];
		}else if ([textField isEqual:Txtmap5]) {
			NSCharacterSet *cs;
			NSString *filtered;
			cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHABET] invertedSet];
			filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
			if ([filtered length]>0) {
				BtnEncode.enabled = YES;
			}else{
				if( [Txtmap1.text length]==1 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0 && [string length]==0) { //map
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==1 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0  && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==1  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0  && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==1  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0  && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==1  && [Txtmap6.text length]==0  && [string length]==0){
					BtnEncode.enabled = NO;
				}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==1  && [string length]==0){
					BtnEncode.enabled = NO;
				}		
				
			}
			return [string isEqualToString:filtered];
		}else{
			if( [Txtmap1.text length]==1 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0 && [string length]==0) { //map
				BtnEncode.enabled = NO;
			}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==1 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0  && [string length]==0){
				BtnEncode.enabled = NO;
			}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==1  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0  && [string length]==0){
				BtnEncode.enabled = NO;
			}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==1  && [Txtmap5.text length]==0  && [Txtmap6.text length]==0  && [string length]==0){
				BtnEncode.enabled = NO;
			}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==1  && [Txtmap6.text length]==0  && [string length]==0){
				BtnEncode.enabled = NO;
			}else if( [Txtmap1.text length]==0 && [Txtmap2.text length]==0 && [Txtmap3.text length]==0  && [Txtmap4.text length]==0  && [Txtmap5.text length]==0  && [Txtmap6.text length]==1  && [string length]==0){
				BtnEncode.enabled = NO;
			}else{
				BtnEncode.enabled = YES;
			}	
		}	
	}//End of counterbtn==3
	
	else{	
	NSLog(@"textField shouldChangeCharactersInRange =>%@",textField.text);
	if([txturl1.text length]>1 && string ){ //url
		BtnEncode.enabled = YES;
	}else if (string && CounterBtn==2) { //event
		BtnEncode.enabled = YES;
	}else if(string && CounterBtn==3){ //map
		BtnEncode.enabled = YES;
	}else if(string && CounterBtn==6){ //email
		BtnEncode.enabled = YES;
		if ([txtviewemail3.text isEqualToString:@""]) {
			txtviewemail3.text=@"Message";
			txtviewemail3.textColor=[UIColor lightGrayColor];
		}
	}else if ([Ego_Textview.text length]>0) {
		BtnEncode.enabled = YES;
	}else if([Txtsms.text length]>1 && CounterBtn==4){ //SMS
		BtnEncode.enabled = YES;
		if ([txtsmsMessage.text isEqualToString:@""]) {			
			txtsmsMessage.textColor=[UIColor lightGrayColor];
		}
	}else if (CounterBtn==5 && [txtPhone.text length]>1) {
		BtnEncode.enabled =YES;
	}else {		
		BtnEncode.enabled = NO;
	}
	if(CounterBtn == 0 && [string length]>0)
		BtnEncode.enabled = YES;
	if (CounterBtn==1 && string ) {
		BtnEncode.enabled = YES;
	}
	

	NSLog(@"tag==>%d",textField.tag);
		
		
	if( [txtemail1.text length]==1 && [txtemail2.text length]==0 && [txtviewemail3.text isEqualToString:@"Message"] && [string length]==0) { //map
		BtnEncode.enabled = NO;
		txtviewemail3.text=@"Message";
		txtviewemail3.textColor=[UIColor lightGrayColor];

	}else if( [txtemail1.text length]==0 && [txtemail2.text length]==1 && [txtviewemail3.text isEqualToString:@"Message"]  && [string length]==0){
		BtnEncode.enabled = NO;
		txtviewemail3.text=@"Message";
		txtviewemail3.textColor=[UIColor lightGrayColor];

	}else if( [txtemail1.text length]==0 && [txtemail2.text length]==1 && [txtviewemail3.text isEqualToString:@""]  && [string length]==0){
		BtnEncode.enabled = NO;
		txtviewemail3.text=@"Message";
		txtviewemail3.textColor=[UIColor lightGrayColor];

	}else if( [txtemail1.text length]==1 && [txtemail2.text length]==0 && [txtviewemail3.text isEqualToString:@""]  && [string length]==0){
		BtnEncode.enabled = NO;
		txtviewemail3.text=@"Message";
		txtviewemail3.textColor=[UIColor lightGrayColor];

	}
	
	
	if(textField.keyboardType== UIKeyboardTypeNumberPad)
	{
		NSCharacterSet *cs;
		NSString *filtered;
		cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
		filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		
		if([string isEqualToString:filtered] && CounterBtn==4){
			BtnEncode.enabled = YES;
		}
		
		else if([string isEqualToString:filtered] && CounterBtn==5){
			//BtnEncode.enabled = YES;
			/*if([txtPhone.text length]==0  && CounterBtn==5 && [filtered length]==0){
				BtnEncode.enabled =NO;			
			}else {
				BtnEncode.enabled =YES;
			}*/
			
		}
		
		
		if([txtPhone.text length]==1  && CounterBtn==5  && [string length]==0){
			BtnEncode.enabled =NO;			
		}else {		
			if ( [filtered length]>0  || [txtPhone.text length]>0 ) {
				BtnEncode.enabled =YES;
			}			
		}
		
		
		//SMS
		if (CounterBtn==4 && [txtsmsMessage.text isEqualToString:@"Message"] && [Txtsms.text length]==1  && [string length]==0) {
			BtnEncode.enabled =NO;
			//txtsmsMessage.text=@"Message"; /// deval chauhan 30/12/2011 // changes to stop visibility if textmessage not enter
			txtsmsMessage.textColor=[UIColor lightGrayColor];			
		}else if (CounterBtn==4 && [txtsmsMessage.text isEqualToString:@""] && [Txtsms.text length]==1  && [string length]==0) {
			BtnEncode.enabled =NO;
			//txtsmsMessage.text=@"Message"; /// deval chauhan 30/12/2011 // changes to stop visibility if textmessage not enter
			txtsmsMessage.textColor=[UIColor lightGrayColor];
		}else if (CounterBtn==4 && [txtsmsMessage.text isEqualToString:@""] && [Txtsms.text length]==0  && [string length]==0) {
			BtnEncode.enabled =NO;
			//txtsmsMessage.text=@"Message"; /// deval chauhan 30/12/2011 // changes to stop visibility if textmessage not enter
			txtsmsMessage.textColor=[UIColor lightGrayColor];
		}else if (CounterBtn==4 && [txtsmsMessage.text isEqualToString:@"Message "] && [Txtsms.text length]==1  && [string length]==0) {
			BtnEncode.enabled =NO;
			//txtsmsMessage.text=@"Message"; /// deval chauhan 30/12/2011 // changes to stop visibility if textmessage not enter
			txtsmsMessage.textColor=[UIColor lightGrayColor];			
		}
		if (CounterBtn==1) 
		{	
			
			if([string isEqualToString:@""])
				charcount=charcount-1;
			else if([string isEqualToString:filtered])
				charcount=charcount+1;
			
			if(charcount>0)
				BtnEncode.enabled=YES;
			else
				BtnEncode.enabled=NO;
			
		}
		if (textField.tag==1) {
			if([textField.text length] == 1)
				textField.placeholder=@"Phone Number";
			
		}
		NSLog(@"char==>%d",charcount);
		
		return [string isEqualToString:filtered];
	}
	
	if(textField.keyboardType== UIKeyboardTypeAlphabet)
	{
		NSCharacterSet *cs;
		NSString *filtered;
		cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHA] invertedSet];
		filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		
		if (CounterBtn==1) 
		{		
			if([string isEqualToString:@""])
				charcount=charcount-1;
			else if([string isEqualToString:filtered]) 
				charcount=charcount+1;
			
			if(charcount>0)
				BtnEncode.enabled=YES;
			else
				BtnEncode.enabled=NO;
			
		}
		
		
		if (textField.tag==0) {
			if([textField.text length] == 1)
				textField.placeholder=@"Name";
						
		}
		if (textField.tag==2) {
			if([textField.text length] == 1)
				textField.placeholder=@"Prefix";
			
		}
		if (textField.tag==3) {
			if([textField.text length] == 1)
				textField.placeholder=@"Phonetic First Name";
			
		}
		if (textField.tag==4) {
			if([textField.text length] == 1)
				textField.placeholder=@"Phonetic Last Name";
			
		}
		if (textField.tag==5) {
			if([textField.text length] == 1)
				textField.placeholder=@"Middle";
			
		}
		if (textField.tag==6) {
			if([textField.text length] == 1)
				textField.placeholder=@"Suffix";
			
		}
		if (textField.tag==7) {
			if([textField.text length] == 1)
				textField.placeholder=@"Job Title";
			
		}
		if (textField.tag==8) {
			if([textField.text length] == 1)
				textField.placeholder=@"Department";
			
		}
		NSLog(@"char==>%d",charcount);
		return [string isEqualToString:filtered];
		
	}
  }//End of if For counterbutton ==2
	
	return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	NSLog(@"shouldChangeTextInRange");
	if ([text isEqualToString:@"\n"]) {
		
		[textView resignFirstResponder];
		
	}

	return YES;
}


- (void)textViewDidBeginEditing:(UITextView *)textView{	
	activetxtview=textView;
	if ([txtsmsMessage.text isEqualToString:@"Message"]|| [txtsmsMessage.text isEqualToString:@"Message "]  || [txtviewemail3.text isEqualToString:@"Message " ]  || [txtviewemail3.text isEqualToString:@"Message" ]) {
		txtsmsMessage.text=@"";
		txtviewemail3.text=@"";
	}
	
	textView.textColor=[UIColor blackColor];
}


/*
- (void)textViewDidChange:(UITextView *)textView
{
	if( [textView isEqual:TxtViewText])
	{
		TxtViewText.hidden=YES;
		txtWeb.hidden=NO;		
		NSMutableAttributedString* attrStr = [NSMutableAttributedString attributedStringWithString:TxtViewText.text];
		[txtWeb setLineBreakMode:UILineBreakModeCharacterWrap];
		[txtWeb setNumberOfLines:9999];
		
		if(fontdic)
		{
			[attrStr setFont:[UIFont fontWithName:[fontdic valueForKey:@"fontName"] size:[[fontdic valueForKey:@"fontSize"] intValue]]];
			int color=[[fontdic valueForKey:@"fontColor"] intValue];
			if(color==101)
				[attrStr setTextColor:[UIColor blackColor]];
			else if(color==102)
				[attrStr setTextColor:[UIColor whiteColor]];
			else if(color==103)
				[attrStr setTextColor:[UIColor grayColor]];
			else if(color==104)
				[attrStr setTextColor:[UIColor yellowColor]];
			else if(color==105)  
				[attrStr setTextColor:[UIColor colorWithRed:0 green:0.6 blue:0.8 alpha:1]];
			else if(color==106)
				[attrStr setTextColor:[UIColor colorWithRed:0 green:0.4 blue:0 alpha:1]];
			else if(color==107)
				[attrStr setTextColor:[UIColor redColor]];
			else if(color==108)
				[attrStr setTextColor:[UIColor orangeColor]];
			
			
			if([[fontdic valueForKey:@"isBold"] isEqualToString:@"YES"])
				isBold=YES;
			else 
				isBold=NO;
			
			if([[fontdic valueForKey:@"isItalic"] isEqualToString:@"YES"])
				isItalic=YES;
			else 
				isItalic=NO;
			
			
			[attrStr setFontFamily:[fontdic valueForKey:@"fontName"] size:[[fontdic valueForKey:@"fontSize"] intValue] bold:isBold italic:isItalic range:[TxtViewText.text rangeOfString:TxtViewText.text]];
			
			if([[fontdic valueForKey:@"isUnderline"] isEqualToString:@"YES"])
				[attrStr setTextIsUnderlined:YES];
			
		}
		else 
		{
			[attrStr setFont:[UIFont fontWithName:@"Times New Roman" size:24]];
			[attrStr setTextColor:[UIColor blackColor]];
			//[attrStr setTextBold:YES range:[TxtViewText.text rangeOfString:TxtViewText.text]];
			[attrStr setFontFamily:@"Times New Roman" size:24 bold:NO italic:NO range:[TxtViewText.text rangeOfString:TxtViewText.text]];
			txtWeb.textAlignment=UITextAlignmentJustify;
		}		
		txtWeb.attributedText=attrStr;
	/*	NSString *str;
		str=attrStr;
		ScrlText.userInteractionEnabled=YES;
		ScrlText.scrollEnabled=YES;
		
		CGSize boundingSize = CGSizeMake(txtWeb.frame.size.width, CGFLOAT_MAX);
		CGSize requiredSize = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:20]
							  constrainedToSize:boundingSize
								  lineBreakMode:UILineBreakModeWordWrap];
		CGFloat requiredHeight = requiredSize.height+100;
		
		ScrlText.contentSize=CGSizeMake(0,requiredHeight);
		
		*/
		
		
	//}
/*	NSLog(@"TxtViewText.text ==>%@",TxtViewText.text );
	NSLog(@"txtWeb.text ==>%@",txtWeb.text );
	NSLog(@"TxtViewText.text ==>%d",[TxtViewText.text length] );
	NSLog(@"txtWeb.text ==>%d",[txtWeb.text length] );
*//*	
	NSLog(@"txtsmsMessage.text===>%d",[txtsmsMessage.text length]);
	NSLog(@"Txtsms.text===>%d",[Txtsms.text length]);

	/*
	if ([txtsmsMessage.text length]==1 && [Txtsms.text length]==0) {
		BtnEncode.enabled = NO;
		txtsmsMessage.text=@"Message ";
		txtsmsMessage.textColor=[UIColor lightGrayColor];
		[Txtsms becomeFirstResponder];
	}else*/ 
	/*if (CounterBtn==4 && [txtsmsMessage.text length]==0 && [Txtsms.text length]==0) {
		BtnEncode.enabled = NO;
		txtsmsMessage.text=@"Message";
		txtsmsMessage.textColor=[UIColor lightGrayColor];
		
	}else if(CounterBtn==6 && [txtemail1.text length]==0 && [txtemail2.text length]==0 && [txtviewemail3.text length]==0){
		BtnEncode.enabled = NO;		
		txtviewemail3.textColor=[UIColor blackColor];
		txtviewemail3.text=@"Message";
		txtviewemail3.textColor=[UIColor lightGrayColor];
		//[txtemail1 becomeFirstResponder];
	}else if ([TxtViewText.text length]==0 && CounterBtn==7 ){
		BtnEncode.enabled = NO;
	}else{
		txtviewemail3.textColor=[UIColor blackColor];
		txtsmsMessage.textColor=[UIColor blackColor];
		txtWeb.textColor=[UIColor blackColor];
		BtnEncode.enabled = YES;
	}
	
}
*/

- (void)textViewDidChange:(UITextView *)textView
{
	textView.autocapitalizationType = UITextAutocapitalizationTypeSentences;
	
	if ([textView.text isEqualToString:@"\n"]) {
		[textView resignFirstResponder];
		BtnEncode.enabled = NO;
	}
	
	NSLog(@"txtsmsMessage.text===>%d",[txtviewemail3.text length]);
	NSLog(@"Txtsms.text===>%d",[txtemail2.text length]);
		
	if (CounterBtn==4 && [txtsmsMessage.text length]==0 && [Txtsms.text length]==0) {
		BtnEncode.enabled = NO;
		txtsmsMessage.text=@"";
		txtsmsMessage.textColor=[UIColor blackColor];
	}else if(CounterBtn==6 && [txtemail1.text length]==0 && [txtemail2.text length]==0 && [txtviewemail3.text length]==0){
		BtnEncode.enabled = NO;
		txtviewemail3.text=@"";
		txtviewemail3.textColor=[UIColor blackColor];
	}else if ([Ego_Textview.text length]==0 && CounterBtn==7 ){
		BtnEncode.enabled = NO;
	}else{
		txtviewemail3.textColor=[UIColor blackColor];
		txtsmsMessage.textColor=[UIColor blackColor];
		BtnEncode.enabled = YES;
		if (CounterBtn==4 && [txtsmsMessage.text isEqualToString:@"\n"] && [Txtsms.text length]==0) {
			BtnEncode.enabled = NO;
			txtsmsMessage.text=@"Message";
			txtsmsMessage.textColor=[UIColor lightGrayColor];
		}else if (CounterBtn==6 && [txtviewemail3.text isEqualToString:@"\n"] && [txtemail1.text length]==0 && [txtemail2.text length]==0 ) {
			BtnEncode.enabled = NO;
			txtviewemail3.text=@"Message";
			txtviewemail3.textColor=[UIColor lightGrayColor];
		}
	}		
}

#pragma mark -
#pragma mark EGOTextViewDelegate

- (BOOL)egoTextViewShouldBeginEditing:(EGOTextView *)textView {
    return YES;
}

- (BOOL)egoTextViewShouldEndEditing:(EGOTextView *)textView {
	
	return YES;
}

- (void)egoTextViewDidBeginEditing:(EGOTextView *)textView 
{
	//ResultString=@"";
//	NSMutableAttributedString* attrStr = [NSMutableAttributedString attributedStringWithString:@"Text here"];
//		[attrStr setFontFamily:[appDel.fontdic valueForKey:@"fontName"] size:24 bold:NO italic:NO range:[textView.text rangeOfString:textView.text]];
	[LblPlaceholder removeFromSuperview];
	if ([textView.text isEqualToString:@"Text here"]) {
		textView.text=@"";
	}
}

- (void)egoTextViewDidEndEditing:(EGOTextView *)textView {
	//Ego_Textview.text=textView.text;
	if ([ResultString length]==0) {
		[ViewText addSubview:LblPlaceholder];
	}
	
	ResultString =  [NSString stringWithString:textView.text] ;
	[ResultString retain];
	NSLog(@"ResultString===>%@",ResultString);
}

- (void)egoTextViewDidChange:(EGOTextView *)textView {
	
	NSLog(@"hjdfh=%@",self.egoTextView.text);
	
		
	/*if ([view1.text isEqualToString:@"\n"]) {
		[view1 resignFirstResponder];
	}else{
		if ([textView.text length]>0) {
			BtnEncode.enabled=YES;
		}else{
			BtnEncode.enabled=NO;			
		}*/
		 attrStr = [NSMutableAttributedString attributedStringWithString:textView.text];
	/*	[attrStr setTextAlignment:kCTJustifiedTextAlignment lineBreakMode:kCTLineBreakByWordWrapping range:[textView.text rangeOfString:textView.text]];
		
		
		if(appDel.fontdic)
		{
			[attrStr setFont:[UIFont fontWithName:[appDel.fontdic valueForKey:@"fontName"] size:[[appDel.fontdic valueForKey:@"fontSize"] intValue]]];
			int color=[[appDel.fontdic valueForKey:@"fontColor"] intValue];
			if(color==101)
				[attrStr setTextColor:[UIColor blackColor]];
			else if(color==102)
				[attrStr setTextColor:[UIColor whiteColor]];
			else if(color==103)
				[attrStr setTextColor:[UIColor grayColor]];
			else if(color==104)
				[attrStr setTextColor:[UIColor yellowColor]];
			else if(color==105)  
				[attrStr setTextColor:[UIColor colorWithRed:0 green:0.6 blue:0.8 alpha:1]];
			else if(color==106)
				[attrStr setTextColor:[UIColor colorWithRed:0 green:0.4 blue:0 alpha:1]];
			else if(color==107)
				[attrStr setTextColor:[UIColor redColor]];
			else if(color==108)
				[attrStr setTextColor:[UIColor orangeColor]];
			
			
			if([[appDel.fontdic valueForKey:@"isBold"] isEqualToString:@"YES"])
				isBold=YES;
			else 
				isBold=NO;
			
			if([[appDel.fontdic valueForKey:@"isItalic"] isEqualToString:@"YES"])
				isItalic=YES;
			else 
				isItalic=NO;
			
			
			[attrStr setFontFamily:[appDel.fontdic valueForKey:@"fontName"] size:[[appDel.fontdic valueForKey:@"fontSize"] intValue] bold:isBold italic:isItalic range:[textView.text rangeOfString:textView.text]];
			
			if([[appDel.fontdic valueForKey:@"isUnderline"] isEqualToString:@"YES"])
				[attrStr setTextIsUnderlined:YES];
		}
		else 
		{				
			[attrStr setFont:[UIFont fontWithName:@"Times New Roman" size:24]];
			[attrStr setTextColor:[UIColor blackColor]];
			[attrStr setFontFamily:@"Times New Roman" size:24 bold:NO italic:NO range:[textView.text rangeOfString:textView.text]];
			[self.egoTextView setCustomAttributedString:attrStr];
		}	
*/
	ResultString =  [NSString stringWithString:textView.text] ;
	[ResultString retain];
	NSLog(@"ResultString=in text did chande==>%@",ResultString);
	if ([textView.text length]>0) {
		BtnEncode.enabled=YES;
	}else{
		BtnEncode.enabled=NO;			
	}
	/*NSString *str = self.egoTextView.text;
	if (![self.egoTextView.text isEqualToString:@""]) {
		str =[str substringFromIndex: [str length]-1];
		if([str isEqualToString:@"\n"])
		{		
		 [self.egoTextView resignFirstResponder];
		}
	}	
	*/
}

- (void)egoTextView:(EGOTextView*)textView didSelectURL:(NSURL *)URL {
	
}

-(void) fontandsizeselected:(NSString*) fontname:(int) size :(int) style :(int) alignment:(int) color:(int) fontIndex:(int) lastFontsize
{
	
	if(appDel.fontdic)
	{
		[appDel.fontdic release];
		appDel.fontdic=nil;
	}
	appDel.fontdic=[[NSMutableDictionary alloc] init];
		
	isBold=objFontView.Bold;
	isItalic=objFontView.Italic;
	isUnderline=objFontView.Underline;
	/*if(style==11)
	{
		isBold=NO;
		isItalic=NO;
		isUnderline=NO;
	}
	else if(style==12)
	{
		isBold=YES;
		isItalic=NO;
		isUnderline=NO;
	}
	else if(style==13)
	{
		isBold=YES;
		isItalic=YES;
		isUnderline=NO;
	}
	else if(style==14)
	{
		isBold=NO;
		isItalic=YES;
		isUnderline=NO;
	}
	else if(style==15)
	{
		isBold=NO;
		isItalic=NO;
		isUnderline=YES;
	}*/
	
	
	if(isBold)
		[appDel.fontdic setObject:@"YES" forKey:@"isBold"];
	else 
		[appDel.fontdic setObject:@"NO" forKey:@"isBold"];
	
	if(isItalic)
		[appDel.fontdic setObject:@"YES" forKey:@"isItalic"];
	else 
		[appDel.fontdic setObject:@"NO" forKey:@"isItalic"];
	
	if(isUnderline)
		[appDel.fontdic setObject:@"YES" forKey:@"isUnderline"];
	else 
		[appDel.fontdic setObject:@"NO" forKey:@"isUnderline"];
	
	[appDel.fontdic setObject:fontname forKey:@"fontName"];
	[appDel.fontdic setObject:[NSString stringWithFormat:@"%d",size] forKey:@"fontSize"];
	[appDel.fontdic setObject:[NSString stringWithFormat:@"%d",fontIndex] forKey:@"lastFont"];
	[appDel.fontdic setObject:[NSString stringWithFormat:@"%d",color] forKey:@"fontColor"];
	[appDel.fontdic setObject:[NSString stringWithFormat:@"%d",alignment] forKey:@"fontAlign"];
	[appDel.fontdic setObject:[NSString stringWithFormat:@"%d",style] forKey:@"styleIndex"];
	[appDel.fontdic setObject:[NSString stringWithFormat:@"%d",size] forKey:@"lastSize"];
	
	
	NSMutableAttributedString* attrStr = [NSMutableAttributedString attributedStringWithString:self.egoTextView.text];
	
	[attrStr setFont:[UIFont fontWithName:fontname size:size]];
	
	int color1=[[appDel.fontdic valueForKey:@"fontColor"] intValue];
	if(color1==101)
		[attrStr setTextColor:[UIColor blackColor]];
	else if(color1==102)
		[attrStr setTextColor:[UIColor whiteColor]];
	else if(color1==103)
		[attrStr setTextColor:[UIColor grayColor]];
	else if(color1==104)
		[attrStr setTextColor:[UIColor yellowColor]];
	else if(color1==105)  
		[attrStr setTextColor:[UIColor colorWithRed:0 green:0.6 blue:0.8 alpha:1]];
	else if(color1==106)
		[attrStr setTextColor:[UIColor colorWithRed:0 green:0.4 blue:0 alpha:1]];
	else if(color1==107)
		[attrStr setTextColor:[UIColor redColor]];
	else if(color1==108)
		[attrStr setTextColor:[UIColor orangeColor]];
	
	[attrStr setFontFamily:fontname size:size bold:isBold italic:isItalic range:[self.egoTextView.text rangeOfString:self.egoTextView.text]];
	
	if(isUnderline)
		[attrStr setTextIsUnderlined:YES];
	
	// -(void)setFontFamily:(NSString*)fontFamily size:(CGFloat)size bold:(BOOL)isBold italic:(BOOL)isItalic range:(NSRange)range {
	//-(void)setTextAlignment:(CTTextAlignment)alignment lineBreakMode:(CTLineBreakMode)lineBreakMode
	//[attrStr setTextAlignment:UITextAlignmentLeft lineBreakMode:UILineBreakModeCharacterWrap];
	
	/*[Ego_Textview setLineBreakMode:UILineBreakModeCharacterWrap];
	[Ego_Textview setNumberOfLines:9999];*/
	
	
	if(alignment==21)	
		[attrStr setTextAlignment:kCTLeftTextAlignment lineBreakMode:kCTLineBreakByWordWrapping range:[self.egoTextView.text rangeOfString:self.egoTextView.text]];
//		//Ego_Textview.textAlignment=UITextAlignmentLeft;
	else if(alignment==22)
		[attrStr setTextAlignment:kCTCenterTextAlignment lineBreakMode:kCTLineBreakByWordWrapping range:[self.egoTextView.text rangeOfString:self.egoTextView.text]];
//	//	Ego_Textview.textAlignment=UITextAlignmentCenter;
	else if(alignment==23)
		[attrStr setTextAlignment:kCTRightTextAlignment lineBreakMode:kCTLineBreakByWordWrapping range:[self.egoTextView.text rangeOfString:self.egoTextView.text]];
//	//	Ego_Textview.textAlignment=UITextAlignmentRight;
	else if(alignment==24)
		[attrStr setTextAlignment:kCTJustifiedTextAlignment lineBreakMode:kCTLineBreakByWordWrapping range:[self.egoTextView.text rangeOfString:self.egoTextView.text]];
//	//	Ego_Textview.textAlignment=UITextAlignmentJustify;
	else 
		[attrStr setTextAlignment:kCTJustifiedTextAlignment lineBreakMode:kCTLineBreakByWordWrapping range:[self.egoTextView.text rangeOfString:self.egoTextView.text]];
//	//	Ego_Textview.textAlignment=UITextAlignmentJustify;
	
	  [self.egoTextView reloadText:self.egoTextView.attributedString.string];
	
}


#pragma mark saveQrCode
/*-(void)saveQrCode
 {
 
 NSString *sql = [NSString stringWithFormat:@"select *from library"];
 NSMutableArray *array=[DAL ExecuteArraySet:sql];
 
 UIImage *newImage = imageview.image;
 
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 NSString *documentsDirectory = [paths objectAtIndex:0];
 NSString* path = [documentsDirectory stringByAppendingPathComponent: 
 [NSString stringWithFormat:@"qr%d.png",[array count]+1] ];
 NSData* data = UIImagePNGRepresentation(newImage);
 [data writeToFile:path atomically:YES];
 
 [DAL insert_library_CreatedDate:dateLabel.text Image: [NSString stringWithFormat:@"qr%d.png",[array count]+1] Category:@"QREvents" Description:@"GenQRCode" starting_Date:@"NODATA" Ending_Date:@"NODATA" Address:@"NODATA" Links:@"NODATA" Email:@"NODATA" Locations:@"NODATA"];
 
 
 }*/
#pragma mark saveQrCode
-(void)saveQrCode:(UIImage *)image
{
	
	//NSString *sql = [NSString stringWithFormat:@"select *from library"];
	//NSMutableArray *array=[DAL ExecuteArraySet:sql];
	
	UIImage *newImage = Imagesaved;
	
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MM-dd-yyyy-HH-mm-ss"];
	
	NSString * date = [dateFormatter stringFromDate:[NSDate date]];
	//int tag = arc4random() % 99999;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString* path = [documentsDirectory stringByAppendingPathComponent: 
					  [NSString stringWithFormat:@"qr%@.png",date] ];
	NSData* data = UIImagePNGRepresentation(newImage);
	[data writeToFile:path atomically:YES];
	if (CounterBtn==0) {//URL
		[DAL insert_library_CreatedDate:dateLabel.text 
								  Image:[NSString stringWithFormat:@"qr%@.png",date] 
							   Category:@"URL" 
							Description:txtViewDisplay.text starting_Date:@"" Ending_Date:@"" Address:@"" Links:@"" Email:@"" Locations:@"" Message:@"" Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:@"" Notes:@""];
	}else if (CounterBtn==1) {//Contact
		
		[DAL insert_library_CreatedDate:dateLabel.text 
								  Image:[NSString stringWithFormat:@"qr%@.png",date] 
							   Category:@"Contact" 
							Description:[[arrField objectAtIndex:0] valueForKey:@"value"]
						  starting_Date:@"" 
							Ending_Date:@"" 
								Address:@"" 
								  Links:@"" 
								  Email:@"" 
							  Locations:@"" 
								Message:@"" 
							 Department:[[arrField objectAtIndex:8] valueForKey:@"value"]
									Job:[[arrField objectAtIndex:7] valueForKey:@"value"] 
								 Suffix:[[arrField objectAtIndex:6] valueForKey:@"value"] 
							 MiddleName:[[arrField objectAtIndex:5] valueForKey:@"value"] 
							   LastName:[[arrField objectAtIndex:4] valueForKey:@"value"] 
							  FirstName:[[arrField objectAtIndex:3] valueForKey:@"value"] 
								 Prefix:[[arrField objectAtIndex:2] valueForKey:@"value"] 
								PhoneNo:[[arrField objectAtIndex:1] valueForKey:@"value"]
								Subject:@"" 
								  Notes:@""];	
		
		
	}else if (CounterBtn==2) {//EVENT
		NSString *str1,*str2,*str3,*str4,*str5;
		str4=@"";
		
		
		if ([txtevent1.text length]==0) {
			str3=@"";
		}else{
			str3=txtevent1.text;
		}
		
		if (![txtevent3.text isEqualToString:@""]) {				
			str4 = [str4 stringByAppendingFormat:@"%@",txtevent3.text];	
		}
		if (![txtevent4.text isEqualToString:@""]) {				
			str4 = [str4 stringByAppendingFormat:@" %@",txtevent4.text];	
		}
		if (![txtevent5.text isEqualToString:@""]) {				
			str4 = [str4 stringByAppendingFormat:@" %@",txtevent5.text];	
		}
		if (![txtevent6.text isEqualToString:@""]) {				
			str4 = [str4 stringByAppendingFormat:@" %@",txtevent6.text];	
		}
		if (![txtevent7.text isEqualToString:@""]) {				
			str4 = [str4 stringByAppendingFormat:@" %@",txtevent7.text];	
		}
		
		if ([txtevent8.text length]==0) {
			str5=@"";
		}else{
			str5=txtevent8.text;
		}
		
		if ([LblDate1.text length]==0) {
			str1=@"";
		}else {
			if ([LblDate1.text isEqual:@"All Day"]) {
				str1=LblDate1.text;
			}else{
				str1=[NSString stringWithFormat:@"%@  %@",LblDate1.text,LblTime1.text];
			}
			
		}
		if ([LblDate2.text length]==0) {
			str2=@"";
		}else {
			if ([LblDate2.text isEqual:@"All Day"]) {
				str2=LblDate2.text;
			}else{
				str2=[NSString stringWithFormat:@"%@  %@",LblDate2.text,LblTime2.text];
			}
		}
		[DAL insert_library_CreatedDate:dateLabel.text Image:[NSString stringWithFormat:@"qr%@.png",date] Category:@"Event" Description:str3 starting_Date:str1 Ending_Date:str2 Address:str4 Links:@"" Email:@"" Locations:@"" Message:@"" Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:@"" Notes:str5];	
		
	}else if (CounterBtn==3) {//MAP
		NSString *str1=@"";
		
		if (![Txtmap1.text isEqualToString:@""]) {				
			str1 = [str1 stringByAppendingFormat:@"%@",Txtmap1.text];	
		}
		if (![Txtmap2.text isEqualToString:@""]) {				
			str1 = [str1 stringByAppendingFormat:@" %@",Txtmap2.text];	
		}
		if (![Txtmap3.text isEqualToString:@""]) {				
			str1 = [str1 stringByAppendingFormat:@" %@",Txtmap3.text];	
		}
		if (![Txtmap4.text isEqualToString:@""]) {				
			str1 = [str1 stringByAppendingFormat:@" %@",Txtmap4.text];	
		}
		if (![Txtmap5.text isEqualToString:@""]) {				
			str1 = [str1 stringByAppendingFormat:@" %@",Txtmap5.text];	
		}
		str1=[str1 stringByReplacingOccurrencesOfString:@" " withString:@"+"];
		
		
		
		str1=[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@",str1];
		[DAL insert_library_CreatedDate:dateLabel.text Image:[NSString stringWithFormat:@"qr%@.png",date] Category:@"Map Location" Description:str1 starting_Date:@"" Ending_Date:@"" Address:@"" Links:Txtmap6.text Email:@"" Locations:@"" Message:@"" Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:@"" Notes:@""];
		
	}else if (CounterBtn==4) {//sms
		if ([txtsmsMessage.text isEqualToString:@"Message"] || [txtsmsMessage.textColor isEqual:[UIColor lightGrayColor]]) {
			[DAL insert_library_CreatedDate:dateLabel.text Image:[NSString stringWithFormat:@"qr%@.png",date] Category:@"SMS" Description:Txtsms.text starting_Date:@"" Ending_Date:@"" Address:@"" Links:@"" Email:@"" Locations:@"" Message:@"" Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:@"" Notes:@""];
		}
		else if ([txtsmsMessage.text length]==0) {			
			[DAL insert_library_CreatedDate:dateLabel.text Image:[NSString stringWithFormat:@"qr%@.png",date] Category:@"SMS" Description:Txtsms.text starting_Date:@"" Ending_Date:@"" Address:@"" Links:@"" Email:@"" Locations:@"" Message:@"" Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:@"" Notes:@""];
			
		}else if ([Txtsms.text length]==0) {
			[DAL insert_library_CreatedDate:dateLabel.text Image:[NSString stringWithFormat:@"qr%@.png",date] Category:@"SMS" Description:@"" starting_Date:@"" Ending_Date:@"" Address:@"" Links:@"" Email:@"" Locations:@"" Message:txtsmsMessage.text Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:@"" Notes:@""];
			
		}else{
			[DAL insert_library_CreatedDate:dateLabel.text Image:[NSString stringWithFormat:@"qr%@.png",date] Category:@"SMS" Description:Txtsms.text starting_Date:@"" Ending_Date:@"" Address:@"" Links:@"" Email:@"" Locations:@"" Message:txtsmsMessage.text Department:@"" Job:@"" Suffix:@"" MiddleName:@"" LastName:@"" FirstName:@"" Prefix:@"" PhoneNo:@"" Subject:@"" Notes:@""];
			
		}
		
	}else if (CounterBtn==5) {//phone
		[DAL insert_library_CreatedDate:dateLabel.text 
								  Image:[NSString stringWithFormat:@"qr%@.png",date] 
							   Category:@"Phone" 
							Description:txtPhone.text 
						  starting_Date:@"" 
							Ending_Date:@"" 
								Address:@"" 
								  Links:@"" 
								  Email:@"" 
							  Locations:@"" 
								Message:@"" 
							 Department:@"" 
									Job:@"" 
								 Suffix:@"" 
							 MiddleName:@"" 
							   LastName:@"" 
							  FirstName:@"" 
								 Prefix:@"" 
								PhoneNo:@"" 
								Subject:@"" 
								  Notes:@""];
		
	}else if (CounterBtn==6) {//EMAIL
		NSString *str1;
		NSString *str2;
		NSString *str3;
		if ([txtemail1.text length]==0) {
			str1=@"";
		}else{
			str1=txtemail1.text;
		}
		if ([txtemail2.text length]==0) {
			str2=@"";
		}else{
			str2=txtemail2.text;
		}
		if ([txtviewemail3.text length]==0 ) {
				str3=@"";
		}else if([txtviewemail3.text isEqualToString:@"Message"]&& [txtviewemail3.textColor isEqual:[UIColor lightGrayColor]]){
			str3=@"";
		}else{
			str3=txtviewemail3.text;
		}
		[DAL insert_library_CreatedDate:dateLabel.text 
								  Image:[NSString stringWithFormat:@"qr%@.png",date] 
							   Category:@"Email" 
							Description:str1 
						  starting_Date:@"" 
							Ending_Date:@"" 
								Address:@"" 
								  Links:@"" 
								  Email:@"" 
							  Locations:@"" 
								Message:str3
							 Department:@"" 
									Job:@"" 
								 Suffix:@"" 
							 MiddleName:@"" 
							   LastName:@"" 
							  FirstName:@"" 
								 Prefix:@"" 
								PhoneNo:@"" 
								Subject:str2
								  Notes:@""];
		
		
	}else if (CounterBtn==7) { //Text
		[DAL insert_library_CreatedDate:dateLabel.text 
								  Image:[NSString stringWithFormat:@"qr%@.png",date] 
							   Category:@"Text"
							Description:ResultString 
						  starting_Date:@"" 
							Ending_Date:@"" 
								Address:@"" 
								  Links:@"" 
								  Email:@"" 
							  Locations:@"" 
								Message:@"" 
							 Department:@"" 
									Job:@"" 
								 Suffix:@"" 
							 MiddleName:@"" 
							   LastName:@"" 
							  FirstName:@"" 
								 Prefix:@"" 
								PhoneNo:@"" 
								Subject:@"" 
								  Notes:@""];
		
	}
	
	
	//[DAL insert_library_CreatedDate:dateLabel.text Image: [NSString stringWithFormat:@"qr%d.png",[array count]+1] Category:@"QREvents" Description:@"GenQRCode" starting_Date:@"NODATA" Ending_Date:@"NODATA" Address:@"NODATA" Links:@"NODATA" Email:@"NODATA" Locations:@"NODATA"];
	
	
}
#pragma mark Email id & PhoneNumber
-(BOOL) validateEmail: (NSString *) email 
{
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	BOOL isValid = [emailTest evaluateWithObject:email];
	return isValid;
}

-(BOOL) validateURL: (NSString *) email 
{
	NSString *emailRegex = @"(http|https)://((\\w)*|([0-9]*)|([-|_|\\.])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
	
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	BOOL isValid = [emailTest evaluateWithObject:email];
	return isValid;
}

#pragma mark URL IN BROWSER
-(IBAction)btnScanURL:(id)sender
{
	NSString *str;
	
	if (CounterBtn==0) {
		str=txtViewDisplay.text;
		NSLog(@"==>%@",txtViewDisplay.text);
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
		
	}
	else if(CounterBtn==3){	
		str=@"";
		str=[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@",Txtmap1.text];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
		
	}
}
#pragma mark TEXTEMPLTY
-(void)EmptyText{
	txturl1.text=@"";
	
	LblUrl2.textColor=[UIColor lightGrayColor];
	LblUrl2.text=@"Shorten url";
	txtemail1.text=@"";
	txtemail2.text=@"";
	//txtviewemail3.text=@"";
	txtevent1.text=@"";
	txtevent3.text=@"";
	txtevent4.text=@"";
	txtevent5.text=@"";
	txtevent6.text=@"";
	txtevent7.text=@"";
	txtevent8.text=@"";
	
	txtPhone.text=@"";
	Txtmap1.text=@"";
	Txtmap2.text=@"";
	Txtmap3.text=@"";
	Txtmap4.text=@"";
	Txtmap5.text=@"";
	Txtmap6.text=@"";

	Txtsms.text=@"";
	//txtsmsMessage=@"";
	ctr=1;
}
#pragma mark Bottom Button Click
-(IBAction)URLClicked:(id)sender{
	Imagecheck.hidden=YES;
	ButonBack.hidden=YES;
	ScrlText.hidden=YES;
	BtnEncode.hidden=NO;	
	BtnEncode.enabled = NO;
	BtnEncode.selected=FALSE;
	ScrllLabel.hidden=YES;
	dateLabel.hidden=YES;
	TimeLabel.hidden=YES;
	CounterBtn=0;
	[self EmptyText];	
	
	imageBottomBar.hidden=YES;
	BtnFacebook.hidden=YES;	
	BtnMail.hidden=YES;
	BtnTrash.hidden=YES;
	BtnTwitter.hidden=YES;
	txturl1.font = [UIFont fontWithName:@"Helvetica" size:18];
	LblUrl2.font = [UIFont fontWithName:@"Helvetica" size:18];
	LblUrl2.textColor=[UIColor lightGrayColor];
	txturl1.placeholder=@"http://www.example.com";
	LblUrl2.text=@"Shorten URL";
	imageview.hidden=YES;
    //--*
    scrolldata.hidden=YES;
    actionButton.hidden=YES;

    
	txtViewDisplay.hidden=YES;
	btnFont.hidden=YES;
	EmailView.hidden=YES;
	ViewText.hidden=YES;
    URLView.hidden=NO;	
	ContactView.hidden=YES;
	Mapview.hidden=YES;
	SMSView.hidden=YES;
	PhoneView.hidden=YES;
    EventView.hidden=YES;
	if(appDel.ori == UIInterfaceOrientationPortrait || 
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		imageSeperator.hidden=NO;
		BtnEncode.frame=CGRectMake(250,410,223,57);
        imageview.hidden=YES;
        scrolldata.hidden=YES;
        actionButton.hidden=YES;

		//[BtnEncode setImage:[UIImage imageNamed:@"WriteQR-Portrait_0005_Generate-QR-Code-BTNs.png"] forState:UIControlStateNormal];
		
		
		URLView.frame=CGRectMake(46,80,595,350);
		
		
		[BtnURL setImage:[UIImage imageNamed:@"url_selected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Connect_unselected.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Event_unselected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Map_unselected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"sms_unselected.png"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Phone_unselected.png"] forState:UIControlStateNormal];	
		[BtnEmail setImage:[UIImage imageNamed:@"Email_unselected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Text_unselected.png"] forState:UIControlStateNormal];
		
	}else{
		ScrllLabel.hidden=YES;
		imageview.hidden=YES;
        //--*
        scrolldata.hidden=YES;
        actionButton.hidden=YES;
        
		imageSeperator.hidden=YES;
		//if(oncePort == TRUE)
			BtnEncode.frame=CGRectMake(478,500,205,57);
		//else
		//	BtnEncode.frame=CGRectMake(500,500,205,57);
		//URLView.frame=CGRectMake(400,80, 500,300);			
		
		[BtnURL setImage:[UIImage imageNamed:@"Land_url_selected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Land_Contact_unselectect.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Land_Event_unselected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Land_Map_unselected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"Land_sms_unselected.png"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Land_phone_unselected.png"] forState:UIControlStateNormal];	
		[BtnEmail setImage:[UIImage imageNamed:@"Land_Email_unselected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Land_Text_unselected-1.png"] forState:UIControlStateNormal];
	}	
	[self ReleaseEgo_Text];	
}
-(IBAction)ContactClicked:(id)sender{
	[self EmptyText];	
	ScrlText.hidden=YES;
	ButonBack.hidden=YES;
	ScrllLabel.hidden=YES;
	dateLabel.hidden=YES;
	TimeLabel.hidden=YES;
	BtnEncode.selected=FALSE;
	CounterBtn=1;
	imageview.hidden=YES;
    //--*
    scrolldata.hidden=YES;
    actionButton.hidden=YES;
      [actionButton setEnabled:YES];
    
	BtnEncode.enabled = NO;
	EmailView.hidden=YES;
	ViewText.hidden=YES;
    URLView.hidden=YES;
	btnFont.hidden=YES;
	
	ContactView.hidden=NO;
	Mapview.hidden=YES;
	SMSView.hidden=YES;
	PhoneView.hidden=YES;
    EventView.hidden=YES;
	
	imageBottomBar.hidden=YES;
	BtnFacebook.hidden=YES;	
	BtnMail.hidden=YES;
	BtnTrash.hidden=YES;
	BtnTwitter.hidden=YES;
	//BtnTrash.selected=FALSE;
	for(int j=0;j<[arrField count];j++)
	{
		NSMutableDictionary* dic=[arrField objectAtIndex:j];
		[dic setObject:@"" forKey:@"value"];
		if([[dic valueForKey:@"placeholder"] isEqualToString:@"Name"] || [[dic valueForKey:@"placeholder"] isEqualToString:@"Phone Number"])
		{}
		else 
			[dic setObject:@"no" forKey:@"isactive"];
		
	}
	
	
	[self reloadUI];
	BtnEncode.hidden=NO;	
	if(appDel.ori == UIInterfaceOrientationPortrait || 
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		imageSeperator.hidden=NO;
		//[BtnEncode setImage:[UIImage imageNamed:@"WriteQR-Portrait_0005_Generate-QR-Code-BTNs.png"] forState:UIControlStateNormal];
		BtnEncode.frame=CGRectMake(250,410,223,57);		
		
		ContactView.frame=CGRectMake(46,80,595,350);
		[BtnContact setImage:[UIImage imageNamed:@"Connect_selected.png"] forState:UIControlStateNormal];
		[BtnURL setImage:[UIImage imageNamed:@"URL_unselected.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Event_unselected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Map_unselected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"sms_unselected.png"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Phone_unselected.png"] forState:UIControlStateNormal];	
		[BtnEmail setImage:[UIImage imageNamed:@"Email_unselected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Text_unselected.png"] forState:UIControlStateNormal];
	}else{
		ScrllLabel.hidden=YES;
		imageview.hidden=YES;
        //--*
        scrolldata.hidden=YES;
        actionButton.hidden=YES;
          [actionButton setEnabled:YES];
        
		imageSeperator.hidden=YES;
		//[BtnEncode setImage:[UIImage imageNamed:@"_0037_Deactive1_Generate-BTN.png"] forState:UIControlStateNormal];
		//BtnEncode.frame=CGRectMake(549,400, 223,57);
		//if(oncePort == TRUE)
			BtnEncode.frame=CGRectMake(478,500,205,57);
		//else
		//	BtnEncode.frame=CGRectMake(500,500,205,57);
		//ContactView.frame=CGRectMake(400,80,504,280);		
		[BtnURL setImage:[UIImage imageNamed:@"Land_url_unselected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Land_Contact_selected.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Land_Event_unselected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Land_Map_unselected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"Land_sms_unselected.png"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Land_phone_unselected.png"] forState:UIControlStateNormal];	
		[BtnEmail setImage:[UIImage imageNamed:@"Land_Email_unselected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Land_Text_unselected-1.png"] forState:UIControlStateNormal];
		
	}	
	
	height=0;
    
	[self ReleaseEgo_Text];
	
	
	
	
}
-(IBAction)EventClicked:(id)sender{	
	[self EmptyText];	
	ScrlText.hidden=YES;
	ButonBack.hidden=YES;
	EmailView.hidden=YES;
	ViewText.hidden=YES;
    URLView.hidden=YES;
	ContactView.hidden=YES;
	Mapview.hidden=YES;
	SMSView.hidden=YES;
	PhoneView.hidden=YES;
    EventView.hidden=NO;
	BtnEncode.selected=FALSE;
	imageview.hidden=YES;
    
    //--*
    scrolldata.hidden=YES;
    actionButton.hidden=YES;
      [actionButton setEnabled:YES];
	BtnEncode.hidden=NO;	
	ScrllLabel.hidden=YES;
	dateLabel.hidden=YES;
	TimeLabel.hidden=YES;
	BtnEncode.enabled = NO;
	btnFont.hidden=YES;
	
	imageBottomBar.hidden=YES;
	BtnFacebook.hidden=YES;	
	BtnMail.hidden=YES;
	BtnTrash.hidden=YES;
	BtnTwitter.hidden=YES;
	
	txtevent4.keyboardType=UIKeyboardTypeAlphabet;
	txtevent5.keyboardType=UIKeyboardTypeAlphabet;
	txtevent7.keyboardType=UIKeyboardTypeAlphabet;
	txtevent6.keyboardType=UIKeyboardTypeNumberPad;
	
	
	txtevent1.font = [UIFont fontWithName:@"Helvetica" size:18];
	txtevent3.font = [UIFont fontWithName:@"Helvetica" size:18];
	txtevent4.font = [UIFont fontWithName:@"Helvetica" size:18];
	txtevent5.font = [UIFont fontWithName:@"Helvetica" size:18];
	txtevent6.font = [UIFont fontWithName:@"Helvetica" size:18];
	txtevent7.font = [UIFont fontWithName:@"Helvetica" size:18];
	txtevent8.font = [UIFont fontWithName:@"Helvetica" size:18];

	LblDate1.font = [UIFont fontWithName:@"Helvetica" size:18];
	LblDate2.font = [UIFont fontWithName:@"Helvetica" size:18];
	LblTime1.font = [UIFont fontWithName:@"Helvetica" size:18];
	LblTime2.font = [UIFont fontWithName:@"Helvetica" size:18];
	Lblstart.font=[UIFont fontWithName:@"Helvetica" size:18];
	LblEnd.font=[UIFont fontWithName:@"Helvetica" size:18];
	txtevent1.autocapitalizationType = UITextAutocapitalizationTypeWords;
	txtevent3.autocapitalizationType = UITextAutocapitalizationTypeWords;
	txtevent4.autocapitalizationType = UITextAutocapitalizationTypeWords;
	txtevent1.placeholder=@"Event Title";
	txtevent3.placeholder=@"Street Address";
	txtevent4.placeholder=@"City";
	txtevent5.placeholder=@"State";
	txtevent6.placeholder=@"Zip Code";
	txtevent7.placeholder=@"Country";
	txtevent8.placeholder=@"Notes";
	LblDate1.text=@"";
	LblDate2.text=@"";
	LblTime1.text=@"";
	LblTime2.text=@"";
	
	CounterBtn=2;
	//BtnTrash.selected=FALSE;
	
	if(appDel.ori == UIInterfaceOrientationPortrait || 
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		imageSeperator.hidden=NO;
		//[BtnEncode setImage:[UIImage imageNamed:@"WriteQR-Portrait_0005_Generate-QR-Code-BTNs.png"] forState:UIControlStateNormal];
		BtnEncode.frame=CGRectMake(250,410,223,57);
		
		
		EventView.frame=CGRectMake(46,80,595,350);
		
		[BtnEvent setImage:[UIImage imageNamed:@"Event_selected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Connect_unselected.png"] forState:UIControlStateNormal];
		[BtnURL setImage:[UIImage imageNamed:@"URL_unselected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Map_unselected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"sms_unselected.png"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Phone_unselected.png"] forState:UIControlStateNormal];	
		[BtnEmail setImage:[UIImage imageNamed:@"Email_unselected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Text_unselected.png"] forState:UIControlStateNormal];
	}else{
		ScrllLabel.hidden=YES;
		imageview.hidden=YES;
        
        //--*
        scrolldata.hidden=YES;
        actionButton.hidden=YES;
          [actionButton setEnabled:YES];
		imageSeperator.hidden=YES;
		//[BtnEncode setImage:[UIImage imageNamed:@"_0037_Deactive1_Generate-BTN.png"] forState:UIControlStateNormal];
	//	if(oncePort == TRUE)
			BtnEncode.frame=CGRectMake(478,500,205,57);
		//else
		//	BtnEncode.frame=CGRectMake(500,500,205,57);
	//	EventView.frame=CGRectMake(400,80,595,300);
		
		
		[BtnURL setImage:[UIImage imageNamed:@"Land_url_unselected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Land_Contact_unselectect.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Land_event_selected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Land_Map_unselected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"Land_sms_unselected.png"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Land_phone_unselected.png"] forState:UIControlStateNormal];	
		[BtnEmail setImage:[UIImage imageNamed:@"Land_Email_unselected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Land_Text_unselected-1.png"] forState:UIControlStateNormal];
		
	}	
	[self ReleaseEgo_Text];
	
	
	
}
-(IBAction)MapClicked:(id)sender{
	[self EmptyText];	
	ScrlText.hidden=YES;
	ButonBack.hidden=YES;
	BtnEncode.hidden=NO;	
	ScrllLabel.hidden=YES;
	dateLabel.hidden=YES;
	TimeLabel.hidden=YES;
	BtnEncode.selected=FALSE;
	BtnEncode.enabled = NO;
	CounterBtn=3;
	imageBottomBar.hidden=YES;
	BtnFacebook.hidden=YES;	
	BtnMail.hidden=YES;
	BtnTrash.hidden=YES;
	BtnTwitter.hidden=YES;
	Txtmap2.keyboardType=UIKeyboardTypeAlphabet;
	Txtmap3.keyboardType=UIKeyboardTypeAlphabet;
	Txtmap5.keyboardType=UIKeyboardTypeAlphabet;
	Txtmap4.keyboardType=UIKeyboardTypeNumberPad;
	
	Txtmap1.font = [UIFont fontWithName:@"Helvetica" size:18];
	Txtmap2.font = [UIFont fontWithName:@"Helvetica" size:18];
	Txtmap3.font = [UIFont fontWithName:@"Helvetica" size:18];
	Txtmap4.font = [UIFont fontWithName:@"Helvetica" size:18];
	Txtmap5.font = [UIFont fontWithName:@"Helvetica" size:18];
	Txtmap6.font = [UIFont fontWithName:@"Helvetica" size:18];
	
	Txtmap1.autocapitalizationType = UITextAutocapitalizationTypeWords;
	Txtmap2.autocapitalizationType = UITextAutocapitalizationTypeWords;
	Txtmap3.autocapitalizationType = UITextAutocapitalizationTypeWords;
	Txtmap4.autocapitalizationType = UITextAutocapitalizationTypeWords;
	Txtmap5.autocapitalizationType = UITextAutocapitalizationTypeWords;
	Txtmap6.autocapitalizationType = UITextAutocapitalizationTypeWords;
	
	Txtmap1.placeholder=@"Street Address";
	Txtmap2.placeholder=@"City";
	Txtmap3.placeholder=@"State";
	Txtmap4.placeholder=@"Zip Code";
	Txtmap5.placeholder=@"Country";
	Txtmap6.placeholder=@"Notes";
	
	EmailView.hidden=YES;
	ViewText.hidden=YES;
    URLView.hidden=YES;
	ContactView.hidden=YES;
	Mapview.hidden=NO;
	SMSView.hidden=YES;
	PhoneView.hidden=YES;
    EventView.hidden=YES;
	imageview.hidden=YES;
    
    //--*
    scrolldata.hidden=YES;
    actionButton.hidden=YES;
	btnFont.hidden=YES;
	//BtnTrash.selected=FALSE;
	
	if(appDel.ori == UIInterfaceOrientationPortrait || 
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		imageSeperator.hidden=NO;
		//[BtnEncode setImage:[UIImage imageNamed:@"WriteQR-Portrait_0005_Generate-QR-Code-BTNs.png"] forState:UIControlStateNormal];
		BtnEncode.frame=CGRectMake(250,410,223,57);
		
		Mapview.frame=CGRectMake(46,80,595,350);
		
		
		[BtnMap setImage:[UIImage imageNamed:@"Map_selected.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Event_unselected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Connect_unselected.png"] forState:UIControlStateNormal];
		[BtnURL setImage:[UIImage imageNamed:@"URL_unselected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"sms_unselected.png"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Phone_unselected.png"] forState:UIControlStateNormal];	
		[BtnEmail setImage:[UIImage imageNamed:@"Email_unselected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Text_unselected.png"] forState:UIControlStateNormal];
	}else{
		ScrllLabel.hidden=YES;
		imageview.hidden=YES;
        //--*
        scrolldata.hidden=YES;
        actionButton.hidden=YES;
        
		imageSeperator.hidden=YES;
		
		//if(oncePort == TRUE)
			BtnEncode.frame=CGRectMake(478,500,205,57);
		//else
		//	BtnEncode.frame=CGRectMake(500,500,205,57);
		//Mapview.frame=CGRectMake(400,80,595,300);
		
		[BtnURL setImage:[UIImage imageNamed:@"Land_url_unselected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Land_Contact_unselectect.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Land_Event_unselected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Land_Map_selected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"Land_sms_unselected.png"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Land_phone_unselected.png"] forState:UIControlStateNormal];	
		[BtnEmail setImage:[UIImage imageNamed:@"Land_Email_unselected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Land_Text_unselected-1.png"] forState:UIControlStateNormal];
		
		
	}	
	
	[self ReleaseEgo_Text];
	
	
}
-(IBAction)SMSClicked:(id)sender{
	[self EmptyText];
	ScrlText.hidden=YES;
	ButonBack.hidden=YES;
	BtnEncode.hidden=NO;	
	ScrllLabel.hidden=YES;
	dateLabel.hidden=YES;
	TimeLabel.hidden=YES;
	BtnEncode.selected=FALSE;
	imageview.hidden=YES;
    //--*
    scrolldata.hidden=YES;
    actionButton.hidden=YES;
    
	BtnEncode.enabled = NO;
	CounterBtn=4;
	btnFont.hidden=YES;
	
	EmailView.hidden=YES;
	ViewText.hidden=YES;
    URLView.hidden=YES;
	ContactView.hidden=YES;
	Mapview.hidden=YES;
	SMSView.hidden=NO;
	PhoneView.hidden=YES;
    EventView.hidden=YES;
	imageBottomBar.hidden=YES;
	BtnFacebook.hidden=YES;	
	BtnMail.hidden=YES;
	BtnTrash.hidden=YES;
	BtnTwitter.hidden=YES;
	Txtsms.text=@"";
	//	BtnTrash.selected=FALSE;
	Txtsms.autocapitalizationType = UITextAutocapitalizationTypeWords;
	txtsmsMessage.autocapitalizationType = UITextAutocapitalizationTypeWords;

	Txtsms.font = [UIFont fontWithName:@"Helvetica" size:18];	
	Txtsms.font = [UIFont fontWithName:@"Helvetica" size:18];
	txtsmsMessage.font = [UIFont fontWithName:@"Helvetica" size:18];
	txtsmsMessage.textColor=[UIColor lightGrayColor];
	Txtsms.placeholder=@"Mobile Number";
	
	txtsmsMessage.text=@"Message"; /// deval chauhan 30/12/2011 // changes to stop visibility if textmessage not enter
	txtsmsMessage.textColor=[UIColor lightGrayColor];
	if(appDel.ori == UIInterfaceOrientationPortrait || 
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		imageSeperator.hidden=NO;
		//[BtnEncode setImage:[UIImage imageNamed:@"WriteQR-Portrait_0005_Generate-QR-Code-BTNs.png"] forState:UIControlStateNormal];
		BtnEncode.frame=CGRectMake(250,410,223,57);
		
		SMSView.frame=CGRectMake(46,80,595,350);
		
		[BtnSMS setImage:[UIImage imageNamed:@"sms_selected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Map_unselected.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Event_unselected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Connect_unselected.png"] forState:UIControlStateNormal];
		[BtnURL setImage:[UIImage imageNamed:@"URL_unselected.png"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Phone_unselected.png"] forState:UIControlStateNormal];	
		[BtnEmail setImage:[UIImage imageNamed:@"Email_unselected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Text_unselected.png"] forState:UIControlStateNormal];
	}else{
		ScrllLabel.hidden=YES;
		imageview.hidden=YES;
        
        //--*
        scrolldata.hidden=YES;
        actionButton.hidden=YES;
		imageSeperator.hidden=YES;
	
		//if(oncePort == TRUE)
			BtnEncode.frame=CGRectMake(478,500,205,57);
		//else
			//BtnEncode.frame=CGRectMake(500,500,205,57);
		[BtnURL setImage:[UIImage imageNamed:@"Land_url_unselected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Land_Contact_unselectect.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Land_Event_unselected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Land_Map_unselected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"Land_sms_selected.png"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Land_phone_unselected.png"] forState:UIControlStateNormal];	
		[BtnEmail setImage:[UIImage imageNamed:@"Land_Email_unselected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Land_Text_unselected-1.png"] forState:UIControlStateNormal];
		
	}	
	[self ReleaseEgo_Text];
	
}
-(IBAction)PhoneClicked:(id)sender{
	[self EmptyText];	
	ScrlText.hidden=YES;
	ButonBack.hidden=YES;
	BtnEncode.hidden=NO;	
	ScrllLabel.hidden=YES;
	dateLabel.hidden=YES;
	TimeLabel.hidden=YES;
	BtnEncode.selected=FALSE;
	imageview.hidden=YES;
    
    //--*
    scrolldata.hidden=YES;
    actionButton.hidden=YES;
      [actionButton setEnabled:YES];
	BtnEncode.enabled = NO;
	CounterBtn=5;
	btnFont.hidden=YES;
	
	EmailView.hidden=YES;
	ViewText.hidden=YES;
    URLView.hidden=YES;
	ContactView.hidden=YES;
	Mapview.hidden=YES;
	SMSView.hidden=YES;
	PhoneView.hidden=NO;
    EventView.hidden=YES;
	txtPhone.text=@"";
	txtPhone.autocapitalizationType = UITextAutocapitalizationTypeWords;
	
	txtPhone.placeholder=@"Phone Number";
	txtPhone.font = [UIFont fontWithName:@"Helvetica" size:18];
	imageBottomBar.hidden=YES;
	BtnFacebook.hidden=YES;	
	BtnMail.hidden=YES;
	BtnTrash.hidden=YES;
	BtnTwitter.hidden=YES;
	//	BtnTrash.selected=FALSE;
	
	if(appDel.ori == UIInterfaceOrientationPortrait || 
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{	
		imageSeperator.hidden=NO;
		//[BtnEncode setImage:[UIImage imageNamed:@"WriteQR-Portrait_0005_Generate-QR-Code-BTNs.png"] forState:UIControlStateNormal];
		BtnEncode.frame=CGRectMake(250,410,223,57);
		
		PhoneView.frame=CGRectMake(46,80,595,300);
		
		[BtnPhone setImage:[UIImage imageNamed:@"Phone_selected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"sms_unselected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Map_unselected.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Event_unselected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Connect_unselected.png"] forState:UIControlStateNormal];
		[BtnURL setImage:[UIImage imageNamed:@"URL_unselected.png"] forState:UIControlStateNormal];
		[BtnEmail setImage:[UIImage imageNamed:@"Email_unselected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Text_unselected.png"] forState:UIControlStateNormal];
		
	}else{
		imageSeperator.hidden=YES;
		ScrllLabel.hidden=YES;
		imageview.hidden=YES;
        
        //--*
        scrolldata.hidden=YES;
        actionButton.hidden=YES;
          [actionButton setEnabled:YES];
		//[BtnEncode setImage:[UIImage imageNamed:@"_0037_Deactive1_Generate-BTN.png"] forState:UIControlStateNormal];
		
		//PhoneView.frame=CGRectMake(400,80, 500,300);
		//if(oncePort == TRUE)
			BtnEncode.frame=CGRectMake(478,500,205,57);
		//else
		//	BtnEncode.frame=CGRectMake(500,500,205,57);
		[BtnURL setImage:[UIImage imageNamed:@"Land_url_unselected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Land_Contact_unselectect.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Land_Event_unselected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Land_Map_unselected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"Land_sms_unselected.png"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Land_PhoneButton_selected.png"] forState:UIControlStateNormal];	
		[BtnEmail setImage:[UIImage imageNamed:@"Land_Email_unselected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Land_Text_unselected-1.png"] forState:UIControlStateNormal];
	}
[self ReleaseEgo_Text];
	
}
-(IBAction)MailCicked:(id)sender{
	[self EmptyText];	
	ScrlText.hidden=YES;
	ButonBack.hidden=YES;
	BtnEncode.hidden=NO;	
	ScrllLabel.hidden=YES;	
	dateLabel.hidden=YES;
	TimeLabel.hidden=YES;
	BtnEncode.selected=FALSE;
	imageview.hidden=YES;
    
    //--*
    scrolldata.hidden=YES;
    actionButton.hidden=YES;
	BtnEncode.enabled = NO;
	EmailView.hidden=NO;
	ViewText.hidden=YES;
    URLView.hidden=YES;
	ContactView.hidden=YES;
	Mapview.hidden=YES;
	SMSView.hidden=YES;
	PhoneView.hidden=YES;
    EventView.hidden=YES;
	btnFont.hidden=YES;
	
	imageBottomBar.hidden=YES;
	BtnFacebook.hidden=YES;	
	BtnMail.hidden=YES;
	BtnTrash.hidden=YES;
	BtnTwitter.hidden=YES;
	
	//BtnTrash.selected=FALSE;
	txtemail1.text=@"";
	txtemail2.text=@"";
	txtemail1.autocapitalizationType = UITextAutocapitalizationTypeWords;
	txtemail2.autocapitalizationType = UITextAutocapitalizationTypeWords;
	txtviewemail3.autocapitalizationType = UITextAutocapitalizationTypeWords;
	txtviewemail3.font = [UIFont fontWithName:@"Helvetica" size:18];
	txtemail1.font = [UIFont fontWithName:@"Helvetica" size:18];
	txtemail2.font = [UIFont fontWithName:@"Helvetica" size:18];
	txtviewemail3.font = [UIFont fontWithName:@"Helvetica" size:18];
	txtviewemail3.textColor=[UIColor lightGrayColor];
	txtviewemail3.textColor=[UIColor lightGrayColor];
	txtviewemail3.text=@"";
	txtviewemail3.text=@"Message";
	txtemail1.placeholder=@"From";
	txtemail2.placeholder=@"Subject";
	CounterBtn=6;	
	if(appDel.ori == UIInterfaceOrientationPortrait || 
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		imageSeperator.hidden=NO;
		//[BtnEncode setImage:[UIImage imageNamed:@"WriteQR-Portrait_0005_Generate-QR-Code-BTNs.png"] forState:UIControlStateNormal];
		
		EmailView.frame=CGRectMake(46,80,595,350);
		BtnEncode.frame=CGRectMake(250,410,223,57);
		
		[BtnEmail setImage:[UIImage imageNamed:@"Email_selected.png"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Phone_unselected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"sms_unselected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Map_unselected.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Event_unselected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Connect_unselected.png"] forState:UIControlStateNormal];
		[BtnURL setImage:[UIImage imageNamed:@"URL_unselected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Text_unselected.png"] forState:UIControlStateNormal];
	}else{
		imageSeperator.hidden=YES;
		ScrllLabel.hidden=YES;
		imageview.hidden=YES;
        //--*
        scrolldata.hidden=YES;
        actionButton.hidden=YES;
		//[BtnEncode setImage:[UIImage imageNamed:@"_0037_Deactive1_Generate-BTN.png"] forState:UIControlStateNormal];
		//EmailView.frame=CGRectMake(400,80,595,300);
		//if(oncePort == TRUE)
        BtnEncode.frame=CGRectMake(478,500,205,57);
		//else
		//	BtnEncode.frame=CGRectMake(500,500,205,57);
		[BtnURL setImage:[UIImage imageNamed:@"Land_url_unselected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Land_Contact_unselectect.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Land_Event_unselected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Land_Map_unselected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"Land_sms_unselected.png"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Land_phone_unselected.png"] forState:UIControlStateNormal];	
		[BtnEmail setImage:[UIImage imageNamed:@"Land_Email_selected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Land_Text_unselected-1.png"] forState:UIControlStateNormal];
        
	}	
    
	[self ReleaseEgo_Text];
	
}
-(void)ReleaseEgo_Text{
	if (self.egoTextView) {
		[self.egoTextView removeFromSuperview];
		[self.egoTextView release];	
		self.egoTextView = nil;
	}
}
-(IBAction)TextCicked:(id)sender{
	[self EmptyText];	
	ScrlText.hidden=NO;
	ButonBack.hidden=YES;
	BtnEncode.hidden=NO;	
	BtnEncode.enabled=NO;
	ScrllLabel.hidden=YES;
	dateLabel.hidden=YES;
	TimeLabel.hidden=YES;
	BtnEncode.selected=FALSE;
	imageview.hidden=YES;
    //--*
    scrolldata.hidden=YES;
    actionButton.hidden=YES;
	btnFont.hidden=NO;
	CounterBtn=7;	
	EmailView.hidden=YES;
	ViewText.hidden=NO;
    URLView.hidden=YES;
	ContactView.hidden=YES;
	Mapview.hidden=YES;
	SMSView.hidden=YES;
	PhoneView.hidden=YES;
    EventView.hidden=YES;
	imageBottomBar.hidden=YES;
	BtnFacebook.hidden=YES;	
	BtnMail.hidden=YES;
	BtnTrash.hidden=YES;
	BtnTwitter.hidden=YES;
	[appDel.fontdic removeAllObjects];	
	
	LblPlaceholder.text=@"Text here";
	LblPlaceholder.font = [UIFont fontWithName:@"Helvetica" size:18];
	LblPlaceholder.textColor=[UIColor lightGrayColor];
	
	
	if (self.egoTextView) {
		[self.egoTextView removeFromSuperview];
		[self.egoTextView release];			
		self.egoTextView = nil;
	}
		
	
//	self.egoTextView = [[EGOTextView alloc] initWithFrame:CGRectMake(12,35,imgtxtBack.frame.size.width-30,imgtxtBack.frame.size.height-20)];
	
	if(appDel.ori == UIInterfaceOrientationPortrait || 
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{
		imageSeperator.hidden=NO;
		//[BtnEncode setImage:[UIImage imageNamed:@"WriteQR-Portrait_0005_Generate-QR-Code-BTNs.png"] forState:UIControlStateNormal];
		BtnEncode.frame=CGRectMake(360,410,223,57);
		ViewText.frame=CGRectMake(46,80,595,350);
		self.egoTextView = [[EGOTextView alloc] initWithFrame:CGRectMake(12,36,imgtxtBack.frame.size.width-30,imgtxtBack.frame.size.height-20)];
		[BtnText setImage:[UIImage imageNamed:@"Text_selected.png"] forState:UIControlStateNormal];
		[BtnEmail setImage:[UIImage imageNamed:@"Email_unselected"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Phone_unselected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"sms_unselected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Map_unselected.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Event_unselected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Connect_unselected.png"] forState:UIControlStateNormal];
		[BtnURL setImage:[UIImage imageNamed:@"URL_unselected.png"] forState:UIControlStateNormal];
	}else{
		ScrllLabel.hidden=YES;
		imageview.hidden=YES;
        //--*
        scrolldata.hidden=YES;
        actionButton.hidden=YES;
		imageSeperator.hidden=YES;		
		self.egoTextView = [[EGOTextView alloc] initWithFrame:CGRectMake(12,36,imgtxtBack.frame.size.width-30,imgtxtBack.frame.size.height-20)];
		BtnEncode.frame=CGRectMake(610,500, 205,58);
		btnFont.frame=CGRectMake(390,500, 205, 58);
		
		[BtnURL setImage:[UIImage imageNamed:@"Land_url_unselected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Land_Contact_unselectect.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Land_Event_unselected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Land_Map_unselected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"Land_sms_unselected.png"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Land_phone_unselected.png"] forState:UIControlStateNormal];	
		[BtnEmail setImage:[UIImage imageNamed:@"Land_Email_unselected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Land_Text_selected.png"] forState:UIControlStateNormal];
	}	
	
	self.egoTextView.returnKeyType = UIReturnKeyDone;
	self.egoTextView.font = [UIFont fontWithName:@"Times New Roman" size:24];
	//self.egoTextView.autocapitalizationType = UITextAutocapitalizationTypeWords;
	//self.egoTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.egoTextView.autoresizingMask = UIViewAutoresizingNone;
	self.egoTextView.delegate = (id<EGOTextViewDelegate>)self;
    self.egoTextView = self.egoTextView;
	[ViewText addSubview:self.egoTextView];
	[ViewText addSubview:LblPlaceholder];
	
	//[view1 release]; 
 	appDel.fontdic=[[NSMutableDictionary alloc] init];
	[appDel.fontdic setObject:@"NO" forKey:@"isBold"];	
	[appDel.fontdic setObject:@"NO" forKey:@"isItalic"];	
	[appDel.fontdic setObject:@"NO" forKey:@"isUnderline"];
	
	
	[appDel.fontdic setObject:@"1" forKey:@"styleIndex"];
	[appDel.fontdic setObject:@"21" forKey:@"fontAlign"];
	[appDel.fontdic setObject:@"101" forKey:@"fontColor"];

	[appDel.fontdic setObject:@"24" forKey:@"fontSize"];
	[appDel.fontdic setObject:@"101" forKey:@"fontColor"];
	[appDel.fontdic setObject:@"Times New Roman" forKey:@"fontName"];
	
	isBold=NO;
	isUnderline=NO;
	isItalic=NO;
	
}

#pragma mark Buttons for Event tab
-(IBAction)StartsClick:(id)sender
{
	Start=TRUE;
	END=FALSE;
	
	[txtevent1 resignFirstResponder];
	[txtevent3 resignFirstResponder];
	[txtevent4 resignFirstResponder];
	if(dateSelection)
		[self dismissdatePopOver];
	UIButton* b=(UIButton*)sender;
	StartEndDayController* objStartEndDayController=[[StartEndDayController alloc] initWithNibName:@"StartEndDayController" bundle:[NSBundle mainBundle]];
	objStartEndDayController.delegate = (id<dateSelectionDelegate>)self;
    
	objStartEndDayController.selectedDate=@"start";
	objStartEndDayController.isFrom=@"Gen";
	UINavigationController* tempNav=[[UINavigationController alloc] initWithRootViewController:objStartEndDayController];
	dateSelection=[[UIPopoverController alloc] initWithContentViewController:tempNav];
	
	if(appDel.ori == UIInterfaceOrientationPortrait || 
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
		[dateSelection presentPopoverFromRect:CGRectMake(b.frame.origin.x-530, b.frame.origin.y+30, b.frame.size.width, b.frame.size.height) inView:EventView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
	else
		[dateSelection presentPopoverFromRect:CGRectMake(b.frame.origin.x-420, b.frame.origin.y+30, b.frame.size.width, b.frame.size.height) inView:EventView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
	
	[tempNav release];
	[objStartEndDayController release];
	
}
-(void)calledendclick
{
	[self EndsClick:BtnEnds];
}
-(void)event3respond{
	[txtevent3 becomeFirstResponder];
}
-(IBAction)EndsClick:(id)sender
{
	Start=FALSE;
	END=TRUE;
	
	if(dateSelection)
		[self dismissdatePopOver];
	UIButton* b=(UIButton*)sender;
	StartEndDayController* objStartEndDayController=[[StartEndDayController alloc] initWithNibName:@"StartEndDayController" bundle:[NSBundle mainBundle]];
	//objStartEndDayController.delegate=self;
    objStartEndDayController.delegate = (id<dateSelectionDelegate>)self;
	objStartEndDayController.isFrom=@"Gen";
	objStartEndDayController.selectedDate=@"end";	
	objStartEndDayController.startDate=[NSDate date];
	objStartEndDayController.endDate=[NSDate date];
	UINavigationController* tempNav=[[UINavigationController alloc] initWithRootViewController:objStartEndDayController];
	dateSelection=[[UIPopoverController alloc] initWithContentViewController:tempNav];
	
	if(appDel.ori == UIInterfaceOrientationPortrait || 
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
		[dateSelection presentPopoverFromRect:CGRectMake(b.frame.origin.x-530, b.frame.origin.y+30, b.frame.size.width, b.frame.size.height) inView:EventView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
	else
		[dateSelection presentPopoverFromRect:CGRectMake(b.frame.origin.x-445, b.frame.origin.y+30, b.frame.size.width, b.frame.size.height) inView:EventView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
	
	[tempNav release];
	[objStartEndDayController release];
}

-(void) dismissdatePopOver
{
	if (dateSelection) 
	{
		[dateSelection dismissPopoverAnimated:YES];
		[dateSelection release];
		dateSelection=nil;
	}	
}

-(void) completeDateselection:(NSString*) sDate:(NSString*) eDate:(NSString*) allday
{
/*	NSArray *Calender = [sDate componentsSeparatedByString:@" "];
	NSArray *Calender1 = [eDate componentsSeparatedByString:@" "];
	
	if([allday length]>0){		
		LblDate1.text=sDate;
		
		LblTime1.text=@"";
		LblTime1.hidden=YES;
		LblDate2.text=eDate;
		LblTime2.text=@"";
		LblTime2.hidden=YES;
		
		
	}else{
		if ([sDate length]>0) {
			LblTime1.hidden=NO;	
			NSString *string = [NSString stringWithFormat:@"%@ %@", [Calender objectAtIndex:0],[Calender objectAtIndex:1]];

			LblDate1.text=string;
			LblTime1.text=[Calender objectAtIndex:2];
			LblTime1.text = [LblTime1.text stringByReplacingOccurrencesOfString:@"PM" withString:@" pm"];
			LblTime1.text = [LblTime1.text stringByReplacingOccurrencesOfString:@"AM" withString:@" am"];
			
		}
		
		if ([eDate length]>0) {
			LblTime2.hidden=NO;
			NSString *string = [NSString stringWithFormat:@"%@ %@", [Calender1 objectAtIndex:0],[Calender1 objectAtIndex:1]];
			
			LblDate2.text=string;
			LblTime2.text=[Calender1 objectAtIndex:2];
			LblTime2.text = [LblTime2.text stringByReplacingOccurrencesOfString:@"PM" withString:@" pm"];
			LblTime2.text = [LblTime2.text stringByReplacingOccurrencesOfString:@"AM" withString:@" am"];
			
			
		}}
		
	NSDateFormatter* df=[[[NSDateFormatter alloc]init] autorelease];
	if([allday isEqualToString:@"All Day"])
		[df setDateFormat:@"MM/dd/yy"];	
	else 
		[df setDateFormat:@"E MM-dd-yy"];
	
	
	
	if([LblDate1.text length]==8)
		[df setDateFormat:@"MM/dd/yy"];	
	else 
		[df setDateFormat:@"E MM-dd-yy"];
	
	if([LblDate2.text length]==8)
		[df setDateFormat:@"MM/dd/yy"];	
	else 
		[df setDateFormat:@"E MM-dd-yy"];
	
	NSString *newDate1;
	NSString *newDate2;
	newDate1=[LblDate1.text stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
	newDate2=[LblDate2.text stringByReplacingOccurrencesOfString:@"/" withString:@"-"];

	NSDate* today =[df dateFromString:newDate1];
	NSDate* visitDate =[df dateFromString:newDate2];
		
	if ([visitDate compare:today] == NSOrderedAscending)
	{
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"End date should be larger than start date" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		[txtevent3 resignFirstResponder];
		LblDate2.text=@"";                         
		LblTime2.hidden=YES;
		
	}else 
		{
			if([allday length]>0){
			LblDate2.text=LblDate1.text;
			LblTime2.text=LblTime1.text;
			LblTime2.hidden=NO;
			}	
		} 		
	*/             
	if ([sDate length]>0 && [eDate length]>0) {
		
		NSDateFormatter* df=[[[NSDateFormatter alloc]init] autorelease];
		//if([allday isEqualToString:@"All Day"])
		//	[df setDateFormat:@"MM/dd/yy"];	
		LblDate1.text = sDate;
		LblDate2.text = eDate;
		NSDateFormatter* df1=[[[NSDateFormatter alloc]init] autorelease];
		[df1 setDateFormat:@"E MM/dd/yy h:mm aaa"];
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
			[self dismissdatePopOver];
			[txtevent3 becomeFirstResponder];
		}
	}
	else {
	if ([allday isEqualToString:@""]) {
		if ([sDate length]>0) {			
			LblDate1.text = sDate;
			
			//[self onBtnEndClick_Event];
		}
		else {
			//txt_End.text = eDate;
			NSDateFormatter* df=[[[NSDateFormatter alloc]init] autorelease];
			[df setDateFormat:@"E MM/dd/yy h:mm aaa"];
			NSDate *startdate = [df dateFromString:LblDate1.text];
			NSDate *enddate = [df dateFromString:eDate];
			if ([enddate compare:startdate] == NSOrderedAscending)
			{
				[txtevent3 resignFirstResponder];
				NSLog(@"NSOrderedAscending");
				UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"End date should be larger than start date" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				[alert show];
				[alert release];
				LblDate2.text =@"";
				
			}
			else {
				[self dismissdatePopOver];
				NSLog(@"NSOrderedDescending");
				LblDate2.text=eDate;
				[txtevent3 becomeFirstResponder];
			}
		}
	}
	else {
		[self dismissdatePopOver];
		[txtevent3 becomeFirstResponder];
		NSDateFormatter* df=[[[NSDateFormatter alloc]init] autorelease];
		//if([allday isEqualToString:@"All Day"])
		//	[df setDateFormat:@"MM/dd/yy"];	
		LblDate1.text = sDate;
		LblDate2.text = eDate;
	}
	}
}

#pragma mark Text ButtonClick
-(IBAction) fontButtonClick:(id) sender
{
	if(fontPicker)
		[self dismissdatePopOver];
	UIButton* b=(UIButton*)sender;
	if (objFontView) {
		
	}
	else {
		objFontView=[[FontViewViewController alloc] initWithNibName:@"FontViewViewController" bundle:[NSBundle mainBundle]];
	}
	objFontView.delegate=self;
	if(appDel.fontdic)
	{
		objFontView.styleIndex = [[appDel.fontdic valueForKey:@"styleIndex"] intValue];
		objFontView.alignIndex =  [[appDel.fontdic valueForKey:@"fontAlign"] intValue];
		objFontView.colorIndex =  [[appDel.fontdic valueForKey:@"fontColor"] intValue];
		objFontView.lastFontIndex = [[appDel.fontdic valueForKey:@"lastFont"] intValue];
		objFontView.lastfontSize =[[appDel.fontdic valueForKey:@"lastSize"] intValue];
		if (objFontView.lastfontSize==0) {
			objFontView.lastfontSize=24;
		}
		NSLog(@"lastfont===>%d",objFontView.lastfontSize);
		/*if (objFontView.styleIndex==0) {
			objFontView.styleIndex = 11;
			objFontView.alignIndex = 21;
			objFontView.colorIndex = 101;
			objFontView.lastFontIndex=0;			
		}else if (objFontView.alignIndex==0) {
			objFontView.styleIndex = 11;
			objFontView.alignIndex = 21;
			objFontView.colorIndex = 101;
			objFontView.lastFontIndex=0;
		}*/
	}
	else 
	{
		objFontView.styleIndex = 1;
		objFontView.alignIndex = 21;
		objFontView.colorIndex = 101;
		objFontView.lastFontIndex=0;
		isBold=NO;
		isUnderline=NO;
		isItalic=NO;
		
	}
	
	UINavigationController* tempNav=[[UINavigationController alloc] initWithRootViewController:objFontView];
	fontPicker=[[UIPopoverController alloc] initWithContentViewController:tempNav];
	[fontPicker presentPopoverFromRect:CGRectMake(b.frame.origin.x-10, b.frame.origin.y, b.frame.size.width, b.frame.size.height) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
	[tempNav release];
}

-(void) didmissfontpicker
{
	//NSLog(@"font");
	if (fontPicker) 
	{
		[fontPicker dismissPopoverAnimated:YES];
		[fontPicker release];
		fontPicker=nil;
	}	
}

#pragma mark ButtonClick
-(IBAction)DecodeClick:(id)sender{ 		
	if(![self validateEmail:txtemail1.text] && CounterBtn==6){
		UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter valid EMAIL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];	
		
	}
	else
	{
		if(CounterBtn==0)
		{
			if ([txturl1.text rangeOfString:@"http://"].location == NSNotFound && [txturl1.text rangeOfString:@"https://"].location == NSNotFound)
			{
				NSString* str=[@"http://" stringByAppendingFormat:txturl1.text];
				txturl1.text=str;
				
			}
			if(![self validateURL:txturl1.text] && CounterBtn==0)
			{
				UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter valid URL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				[alert show];
				[alert release];
				return;
			}
			
		}	else{
			
		}	
		[self generateQR];
	}	
}

-(void)setTextBold:(BOOL)isBold range:(NSRange)range {
}

-(void)actbutmet
{
    NSLog(@"into the action button method");
    
    
    if (CounterBtn==1 || CounterBtn==5 )
    {
        
        if(flagcon || flagphon)
        {
            
            [actionButton setImage:[UIImage imageNamed:@"inactivecontact"] forState:UIControlStateNormal ];
         [actionButton setEnabled:NO];
            //[actionButton state:UIControlStateDisabled];
        NSLog(@"both contacts and phone");
        ABAddressBookRef addressBook = ABAddressBookCreate(); 
        
        ABRecordRef person = ABPersonCreate();
        
        if(CounterBtn==1)
            ABRecordSetValue(person, kABPersonFirstNameProperty, [[arrField objectAtIndex:0] valueForKey:@"value"]  , nil);
        //ABRecordSetValue(person, kABPersonLastNameProperty, @"hi", nil);
        
        ABMutableMultiValueRef phoneNumberMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        
        if(CounterBtn==1)
            ABMultiValueAddValueAndLabel(phoneNumberMultiValue,[[arrField objectAtIndex:1] valueForKey:@"value"] , kABHomeLabel, nil);
        if(CounterBtn==5)
            ABMultiValueAddValueAndLabel(phoneNumberMultiValue,txtPhone.text , kABHomeLabel, nil);
        // ABMultiValueAddValueAndLabel(phoneNumberMultiValue, @"9876543210", kABPersonPhoneMobileLabel, nil);
        // ABMultiValueAddValueAndLabel(phoneNumberMultiValue, @"04022222222", kABWorkLabel, nil);
        ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumberMultiValue, nil);
        
        //ABMutableMultiValueRef emailMultiValue = ABMultiValueCreateMutable(kABPersonEmailProperty);
        // ABMultiValueAddValueAndLabel(emailMultiValue, @"whatever@gmail.com", kABWorkLabel, nil);
        // ABRecordSetValue(person, kABPersonEmailProperty, emailMultiValue, nil);
        
        // NSDictionary *dictionary = [[NSDictionary alloc] initWithObjects: [NSArray arrayWithObjects:@"1234 Whatever Street", @"Hyderabad", @"AP", @"INDIA", @"500008", nil] forKeys: [NSArray arrayWithObjects: (NSString *)kABPersonAddressStreetKey, (NSString *)kABPersonAddressCityKey, (NSString *)kABPersonAddressStateKey, (NSString *)kABPersonAddressCountryKey, (NSString *)kABPersonAddressZIPKey, nil]];
        // ABMultiValueRef addressMultiValue = ABMultiValueCreateMutable(kABDictionaryPropertyType);
        // ABMultiValueAddValueAndLabel(addressMultiValue, (CFDictionaryRef *)dictionary, kABWorkLabel, nil);
        //  ABRecordSetValue(person, kABPersonAddressProperty, addressMultiValue, nil); ABRecordCopyValue(person, kABPersonAddressProperty);
        
        ABAddressBookAddRecord(addressBook, person, nil);
        ABAddressBookSave(addressBook, nil);
        
        CFRelease(person);
        //  CFRelease(addressMultiValue);
        CFRelease(phoneNumberMultiValue);
        // CFRelease(emailMultiValue);
        //  [dictionary release];
            
            flagcon=NO;
            flagphon=NO;
            
            
            
            UIAlertView *alertviewcon=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Contact Added successfully!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertviewcon show];
            [alertviewcon release];

            
        }
        
    }
    
    if(CounterBtn==2)
    {
        if(flageven)
        {
        NSLog(@"events");
            [actionButton setImage:[UIImage imageNamed:@"inactivecalender"] forState:UIControlStateNormal];
              [actionButton setEnabled:NO];
            flageven=NO;
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        
        EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
            NSString *evntname=txtevent1.text;
             evntname=[evntname stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        event.title=evntname;
        
        NSString *stdate=LblDate1.text;
        
        stdate=[stdate substringFromIndex:4];
        
        NSString *endate=LblDate2.text;
        
        endate=[endate substringFromIndex:4];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"M/d/y h:mm a";
        
        NSDate *date = [formatter dateFromString:stdate];
        
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        formatter1.dateFormat = @"M/d/y h:mm a";
        
        NSDate *date1 = [formatter dateFromString:endate];
        event.startDate = date;
        event.endDate = date1;
        event.location=appDel.locationevent;
            event.notes= appDel.evetnotesper;
              
        
        
               
        
        
        
        
        
        //[event setAlarms:[NSArray arrayWithObjects:@"At time of event",nil]];
        
        
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        
        [eventStore saveEvent:event span:EKSpanThisEvent error:&err]; 
        if(!err)
        {
            
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:event.title message:@"Event Added successfully!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertview show];
            [alertview release];
            
        }
        else {
            NSLog(@"error is %@",err);  
        }
        
        }
        else {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Alert!" 
                                                              message:@"iCloud services are not enabled on this device, so Event can't be added!" 
                                                             delegate:nil 
                                                    cancelButtonTitle:@"OK" 
                                                    otherButtonTitles:nil];
            
            [message show];
            [message release];
            [actionButton setImage:[UIImage imageNamed:@"inactivecalender"] forState:UIControlStateNormal];
            [actionButton setEnabled:NO];
        }
        
    }
   

    
    
    
   
    
    
}






-(void)generateQR
{ 	

	BOOL isGenerate=NO;
	txtViewDisplay.hidden=YES;
	txtDisplayWEb.hidden=YES;
	dateLabel.hidden=YES;
	TimeLabel.hidden=YES;
	imageview.hidden=YES;
    //--*
    scrolldata.hidden=YES;
    actionButton.hidden=YES;
	
	ScrllLabel.hidden=YES;
	BtnFacebook.hidden=YES;
	BtnTwitter.hidden=YES;
	BtnMail.hidden=YES;
	BtnTrash.hidden=YES;
	imageBottomBar.hidden=YES;
	imageview.hidden=YES;
    
 
    
  	
	txtViewDisplay.text=@"";
	[txtsmsMessage resignFirstResponder];
	[txtviewemail3 resignFirstResponder];	
	[activetxt resignFirstResponder];
    
       //++*
    [scrolldata addSubview:imageview];
   //imageview.frame=CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    [scrolldata addSubview:dateLabel];
    [scrolldata addSubview:TimeLabel];
    [scrolldata addSubview:ScrllLabel];
  //  scrolldata.backgroundColor=[[UIColor purpleColor]colorWithAlphaComponent:0.5];
  
    [self.view addSubview:scrolldata];

    
    
	
	if(appDel.ori == UIInterfaceOrientationPortrait || 
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{  		
        
        scrolldata.frame=CGRectMake(40,505 ,600,350);
        scrolldata.contentSize = CGSizeMake(0,CGRectGetHeight(scrolldata.frame)+40); 
        imageview.frame=CGRectMake(40, 10, 110, 110);
        ScrllLabel.frame=CGRectMake(40, 130, 550, 150);
        dateLabel.frame=CGRectMake(180, 35, 350, 20);
         TimeLabel.frame=CGRectMake(180, 60, 350, 20);
        actionButton.frame=CGRectMake(50, 285, 130, 70);
        
		if (CounterBtn==0) 
		{   
			//URL CLICK			
			if([txturl1.text length]>0)
			{
				txtViewDisplay.hidden=NO;
               // txtViewDisplay.backgroundColor=[[UIColor greenColor] colorWithAlphaComponent:0.5];
				txtDisplayWEb.hidden=YES;
				ScrllLabel.contentSize=CGSizeMake(0,30);
				txtViewDisplay.textColor=[UIColor blueColor];
				if (Imagecheck.hidden==TRUE) {
					txtViewDisplay.text=txturl1.text;
					sampleString =txturl1.text;
				}
				else{
					txtViewDisplay.text=LblUrl2.text;
					sampleString =LblUrl2.text;
				}
					
				
				[txtDisplayWEb removeAllCustomLinks];				
				ScrllLabel.userInteractionEnabled=YES;
				ScrllLabel.scrollEnabled=YES;
				
				CGSize boundingSize = CGSizeMake(txturl1.frame.size.width, CGFLOAT_MAX);
				CGSize requiredSize = [sampleString sizeWithFont:[UIFont fontWithName:@"Helvetica" size:20]
											   constrainedToSize:boundingSize
												   lineBreakMode:UILineBreakModeWordWrap];
				CGFloat requiredHeight = requiredSize.height+50;
				
				ScrllLabel.contentSize=CGSizeMake(0,requiredHeight);
				isGenerate=YES;
				
			}
			else 
			{
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=YES;
				isGenerate=NO;
				UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter url" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
				[alert release];
				return;
			}
			
		}
		else if (CounterBtn==1)
		{   //CONTACT CLICK
			ScrllLabel.contentSize=CGSizeMake(0,30);		
			
			txtDisplayWEb.hidden=YES;
			txtViewDisplay.hidden=NO;
          //  txtViewDisplay.backgroundColor=[[UIColor greenColor] colorWithAlphaComponent:0.5];
			isGenerate=[self ContactDisplay];	
		}
		else if (CounterBtn==2) 
		{   //EVENT CLCIK
			ScrllLabel.contentSize=CGSizeMake(0,150);	
			isGenerate= [self Eventdisplay];
			if(isGenerate)
			{
				txtViewDisplay.hidden=YES;			
				txtDisplayWEb.hidden=NO;
			}
			else 
			{
				txtViewDisplay.hidden=YES;			
				txtDisplayWEb.hidden=YES;
			}
		}
		else if (CounterBtn==3) 
		{ 
			//Map CLCIK
			isGenerate=[self Mapdisplay];
			if(isGenerate)
			{
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=NO;
			}
			else 
			{
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=YES;
			}
			
		}   
		else if (CounterBtn==4) 
		{ //SMS CLICK	
			
			isGenerate=[self smsdisplay];
			if(isGenerate)
			{
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=NO;
			}
			else 
			{
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=YES;
			}
		}
		else if (CounterBtn==5) 
		{ //PHONE CLCIK
			isGenerate=[self PhoneDisplay];
			if(isGenerate)
			{
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=NO;
			}
			else 
			{
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=YES;
			}
			
		}
		else if (CounterBtn==6) 
		{ //MAIL CLICK
			
			isGenerate=[self Maildisplay];
			if (isGenerate) {
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=NO;
			}else{
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=YES;
				
			}
		}
		else if (CounterBtn==7) 
		{ //TEXT CLCIK
		NSLog(@"ResultString=length==>%d",[ResultString length]);
		NSLog(@"ResultString=leght==>%@",ResultString);
			txtDisplayWEb.text =ResultString;
			sampleString=ResultString;
			isGenerate=[self generatedDisplay];
			//txtDisplayWEb.attributedText =TxtViewText.text;
						if (isGenerate) {
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=NO;
			}else{
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=YES;
				
			}
			
			
		}
		
	}
	else
	{ //For Landscape
		
        //--*
        scrolldata.frame=CGRectMake(250,40 ,680,600);
       // scrolldata.contentSize = CGSizeMake(0,30); 
        imageview.frame=CGRectMake(40, 30, 120, 120);
        ScrllLabel.frame=CGRectMake(40, 170, 550, 220);
        dateLabel.frame=CGRectMake(180, 35, 350, 20);
        TimeLabel.frame=CGRectMake(180, 60, 350, 20);
		actionButton.frame=CGRectMake(50, 400, 130, 70);
        
        
        
		if (CounterBtn==0)
		{   //URL CLICK
			if([txturl1.text length]>0)
			{
				txtViewDisplay.hidden=NO;
				txtDisplayWEb.hidden=YES;
				txtViewDisplay.textColor=[UIColor blueColor];
				if (Imagecheck.hidden==TRUE) {
					txtViewDisplay.text=txturl1.text;
					sampleString =txturl1.text;
				}
				else{
					txtViewDisplay.text=LblUrl2.text;
					sampleString =LblUrl2.text;
				}
                
                
                [txtDisplayWEb removeAllCustomLinks];				
				ScrllLabel.userInteractionEnabled=YES;
				ScrllLabel.scrollEnabled=YES;
                [self.view bringSubviewToFront:ScrllLabel];
				
				CGSize boundingSize = CGSizeMake(txturl1.frame.size.width, CGFLOAT_MAX);
				CGSize requiredSize = [sampleString sizeWithFont:[UIFont fontWithName:@"Helvetica" size:20]
											   constrainedToSize:boundingSize
												   lineBreakMode:UILineBreakModeWordWrap];
				CGFloat requiredHeight = requiredSize.height+50;
				
				ScrllLabel.contentSize=CGSizeMake(0,requiredHeight);
				isGenerate=YES;
			}
			else 
			{
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=YES;
				UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter url" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
				[alert release];
				isGenerate=NO;
				return;
			}
		}
		else if (CounterBtn==1) 
		{  //CONTACT CLICK			
			txtDisplayWEb.hidden=NO;
			txtViewDisplay.hidden=YES;
			isGenerate=[self ContactDisplay];	
		}
		else if (CounterBtn==2) 
		{   //EVENT CLCIK
			ScrllLabel.contentSize=CGSizeMake(0,150);			
			
			isGenerate=[self Eventdisplay];	
			if(isGenerate)
			{
				txtDisplayWEb.hidden=NO;
				txtViewDisplay.hidden=YES;	
			}
			else 
			{
				txtViewDisplay.hidden=YES;			
				txtDisplayWEb.hidden=YES;
			}
		}
		else if (CounterBtn==3) 
		{  //Map CLCIK
			isGenerate=[self Mapdisplay];
			if(isGenerate)
			{
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=NO;
			}
			else 
			{
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=YES;
			}
			
		}
		else if (CounterBtn==4) 
		{ //SMS CLICK
			
			
			isGenerate=[self smsdisplay];
			if(isGenerate)
			{
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=NO;
			}
			else 
			{
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=YES;
			}
			
		}else if (CounterBtn==5) 
		{ //PHONE CLCIK
			isGenerate=[self PhoneDisplay];
			if(isGenerate)
			{
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=NO;
			}
			else 
			{
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=YES;
			}
			
		}else if (CounterBtn==6) 
		{ //MAIL CLICK			
			isGenerate=[self Maildisplay];
			if (isGenerate) {
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=NO;
			}else{
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=YES;
			}
		}
		else if (CounterBtn==7)
		{ //TEXT CLCIK
			NSLog(@"ResultString=in text did chande==>%@",ResultString);
			txtDisplayWEb.text =ResultString;
			sampleString=ResultString;
			isGenerate=[self generatedDisplay];
			if (isGenerate) {
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=NO;
			}else{
				txtViewDisplay.hidden=YES;
				txtDisplayWEb.hidden=YES;
				
			}
		}
		
	}
	
	
	
	
	if(isGenerate)
	{
		BtnTrash.selected=FALSE;
		BtnEncode.selected=TRUE;
		ScrllLabel.hidden=NO;
		//ScrllLabel.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.5];
		BtnFacebook.hidden=NO;
		BtnTwitter.hidden=NO;
		BtnMail.hidden=NO;
		BtnTrash.hidden=NO;
		imageBottomBar.hidden=NO;
		imageview.hidden=NO;
        //--*
        scrolldata.hidden=NO;
      //  actionButton.hidden=NO;
		
		if(appDel.ori == UIInterfaceOrientationPortrait || 
		   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
		{  }
		else {
			BtnEncode.hidden=YES;
			ButonBack.hidden=NO;
			dateLabel.hidden=NO;
       // dateLabel.backgroundColor=[[UIColor yellowColor] colorWithAlphaComponent:0.5];
			TimeLabel.hidden=NO;
			//TimeLabel.backgroundColor=[[UIColor yellowColor] colorWithAlphaComponent:0.5];
			btnFont.hidden=YES;	
          //  scrolldata.frame=CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
            
			imageSeperator.hidden=YES;		
			EmailView.hidden=YES;
			ViewText.hidden=YES;
			URLView.hidden=YES;
			ContactView.hidden=YES;
			Mapview.hidden=YES;
			SMSView.hidden=YES;
			PhoneView.hidden=YES;
			EventView.hidden=YES;
			ScrllLabel.hidden=NO;
            
            
            
		}
		
		[self TimeandDate];
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(didRotate:) 
													 name:UIApplicationDidChangeStatusBarOrientationNotification
												   object:nil];
		//char filename = [[FileManager alloc] init];
		char filename [ [[[FileManager sharedFileManager] qRFile] length] + 1];
		[[[FileManager sharedFileManager] qRFile] getCString:filename maxLength:[[[FileManager sharedFileManager] qRFile] length] + 1 encoding:NSUTF8StringEncoding];
		
		//NSString *sampleString = [NSString stringWithString:@"http://www.kuapay.com"];
        
        //sampleString = [NSString stringWithString:@"BEGIN:VCARD /n VERSION:2.1 N:;Company Name /n FN:Company Name /n                                              END:VCARD"];
        
       //sampleString = [NSString stringWithString:@"BEGIN:VCARD\nFN:Fullname\nTEL:+4312345\nEMAIL:office@example.local\nURL:http://example.local\nN://Lastname;Firstname\nVERSION:3.0\nEND:VCARD\n"];

      	
		
		char str [[sampleString length] + 1];
		[sampleString getCString:str maxLength:[sampleString length] + 1 encoding:NSUTF8StringEncoding];
		
		CQR_Encode encoder;
		encoder.EncodeData(1, 0, true, -1, str);
		
		QRDrawPNG qrDrawPNG;
		qrDrawPNG.draw(filename, 4, encoder.m_nSymbleSize, encoder.m_byModuleData, NULL);
		
		NSData *data = [[NSData alloc] initWithContentsOfFile:[[FileManager sharedFileManager] qRFile]];
		UIImage *image = [UIImage imageWithData:data];
		[data release];	
		imageview.image=image;
		UIImage *image12 = [UIImage imageNamed:@"QR_Code_M_Letter-80.png"];	
		imageview.image=[self maskImage:imageview.image withMask:image12];	
	}	
	
}

- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
	MaskView=[[UIView alloc] init];
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
	Imagesaved=finishedPic;
	[self saveQrCode:Imagesaved];
	return finishedPic;
	
	//[data1 writeToFile:path atomically:YES];
	
	//int w=MaskView.frame.size.width;
	//int h=MaskView.frame.size.height;
	
  	//UIImage *newImage = [self captureScreenInRect:MaskView.frame];
	
	/* CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	 
	 CGContextRef context = CGBitmapContextCreate(NULL, w, h+155, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
	 
	 // CGContextDrawImage(context, CGRectMake(0, 155, w, h), image.image.CGImage);
	 CGContextDrawImage(context, CGRectMake(0, 155, w, 400), MaskView);
	 
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
	/* CGContextRestoreGState(context);
	 
	 UIGraphicsPopContext();
	 
	 CGImageRef imageMasked = CGBitmapContextCreateImage(context);
	 
	 CGContextRelease(context);
	 
	 CGColorSpaceRelease(colorSpace);
	 
	 UIImage *imgText = [UIImage imageWithCGImage:imageMasked];
	 UIGraphicsBeginImageContext(CGSizeMake(320, 365));
	 [imgText drawInRect:CGRectMake(0, 0, 320, 365)];
	 UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
	 
	 UIGraphicsEndImageContext();
	 */
	
	
}

/*
 - (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
 
 UIImageView *image1=[[UIImageView alloc]init];
 UIImageView *image2=[[UIImageView alloc]init];
 [imageview addSubview:MaskView];
 MaskView.frame=CGRectMake(0, 0,150, 150);	
 image1.frame=CGRectMake(0,0,150, 150);	
 image2.frame=CGRectMake(45,40,60,60);
 image1.image=image;
 image2.image=maskImage;
 [MaskView addSubview:image1];
 [MaskView addSubview:image2];	
 
 int w=MaskView.frame.size.width;
 int h=MaskView.frame.size.height;	
 
 CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
 
 CGContextRef context = CGBitmapContextCreate(NULL, w, h+155, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
 
 CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1);
 
 CGContextSelectFont(context, "Arial", 22, kCGEncodingMacRoman);
 
 CGContextSetTextDrawingMode(context, kCGTextFill);
 CGContextSetRGBFillColor(context, 0, 0, 0, 1);
 
 UIGraphicsPushContext(context);
 
 CGContextSaveGState(context);
 CGContextTranslateCTM(context, 0.0f, h+155);
 CGContextScaleCTM(context, 1.0f, -1.0f);
 
 CGContextRestoreGState(context);
 
 UIGraphicsPopContext();
 
 CGImageRef imageMasked = CGBitmapContextCreateImage(context);
 
 CGContextRelease(context);
 
 CGColorSpaceRelease(colorSpace);
 
 UIImage *imgText = [UIImage imageWithCGImage:imageMasked];
 UIGraphicsBeginImageContext(CGSizeMake(320, 365));
 [imgText drawInRect:CGRectMake(0, 0, 320, 365)];
 UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
 
 UIGraphicsEndImageContext();	
 
 return destImage;
 
 }
 
 
 */
-(BOOL)generatedDisplay
{
	NSLog(@"result string===>%@",ResultString);
	if(appDel.fontdic)
	{
		
		int style=[[appDel.fontdic valueForKey:@"styleIndex"] intValue];
		int color=[[appDel.fontdic valueForKey:@"fontColor"]intValue];
		int alignment=[[appDel.fontdic valueForKey:@"fontAlign"]intValue];
		NSString* fontname=[appDel.fontdic valueForKey:@"fontName"];
		int size=[[appDel.fontdic valueForKey:@"fontSize"]intValue];
		
		isBold=objFontView.Bold;
		isItalic=objFontView.Italic;
		isUnderline=objFontView.Underline;
		/*if(style==11)
		{
			isBold=NO;
			isItalic=NO;
			isUnderline=NO;
		}
		else if(style==12)
		{
			isBold=YES;
			isItalic=NO;
			isUnderline=NO;
		}
		else if(style==13)
		{
			isBold=YES;
			isItalic=YES;
			isUnderline=NO;
		}
		else if(style==14)
		{
			isBold=NO;
			isItalic=YES;
			isUnderline=NO;
		}
		else if(style==15)
		{
			isBold=NO;
			isItalic=NO;
			isUnderline=YES;
		}
		*/
		
		NSMutableAttributedString* attrStr = [NSMutableAttributedString attributedStringWithString:ResultString];
		
		[attrStr setFont:[UIFont fontWithName:fontname size:size]];
		if(color==101)
			[attrStr setTextColor:[UIColor blackColor]];
		else if(color==102)
			[attrStr setTextColor:[UIColor whiteColor]];
		else if(color==103)
			[attrStr setTextColor:[UIColor grayColor]];
		else if(color==104)
			[attrStr setTextColor:[UIColor yellowColor]];
		else if(color==105)  
			[attrStr setTextColor:[UIColor colorWithRed:0 green:0.6 blue:0.8 alpha:1]];
		else if(color==106)
			[attrStr setTextColor:[UIColor colorWithRed:0 green:0.4 blue:0 alpha:1]];
		else if(color==107)
			[attrStr setTextColor:[UIColor redColor]];
		else if(color==108)
			[attrStr setTextColor:[UIColor orangeColor]];
		
		//[attrStr setTextBold:YES range:[TxtViewText.text rangeOfString:TxtViewText.text]];
		[attrStr setFontFamily:fontname size:size bold:isBold italic:isItalic range:[ResultString rangeOfString:ResultString]];
		
		if(isUnderline)
			[attrStr setTextIsUnderlined:YES];
		
		// -(void)setFontFamily:(NSString*)fontFamily size:(CGFloat)size bold:(BOOL)isBold italic:(BOOL)isItalic range:(NSRange)range {
		//-(void)setTextAlignment:(CTTextAlignment)alignment lineBreakMode:(CTLineBreakMode)lineBreakMode
		//[attrStr setTextAlignment:UITextAlignmentLeft lineBreakMode:UILineBreakModeCharacterWrap];
		[txtDisplayWEb setLineBreakMode:UILineBreakModeCharacterWrap];
		[txtDisplayWEb setNumberOfLines:9999];
		txtDisplayWEb.attributedText=attrStr;
		if(alignment==21)
			txtDisplayWEb.textAlignment=UITextAlignmentLeft;
		else if(alignment==22)
			txtDisplayWEb.textAlignment=UITextAlignmentCenter;
		else if(alignment==23)
			txtDisplayWEb.textAlignment=UITextAlignmentRight;
		else if(alignment==24)
			txtDisplayWEb.textAlignment=UITextAlignmentJustify;
		else 
			txtDisplayWEb.textAlignment=UITextAlignmentJustify;
	}
	else 
	{
		NSMutableAttributedString* attrStr = [NSMutableAttributedString attributedStringWithString:ResultString];
		[attrStr setFontFamily:@"Times New Roman" size:24 bold:NO italic:NO range:[ResultString rangeOfString:ResultString]];
		txtDisplayWEb.attributedText=attrStr;
	}
	CGSize boundingSize = CGSizeMake(txtsmsMessage.frame.size.width, CGFLOAT_MAX);
	CGSize requiredSize = [ResultString sizeWithFont:[UIFont fontWithName:@"Helvetica" size:20]
						  constrainedToSize:boundingSize
							  lineBreakMode:UILineBreakModeWordWrap];
	CGFloat requiredHeight = requiredSize.height+230;
	ScrllLabel.contentOffset=CGPointMake(0,0);
	ScrllLabel.contentSize=CGSizeMake(0,requiredHeight);
	
	if([ResultString length]>0)
		return YES;
	else 
	{
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter text" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}
	
	[ResultString release];
}
-(BOOL)Mapdisplay{
	
	txtViewDisplay.hidden=YES;
	txtDisplayWEb.hidden=NO;
	 actionButton.hidden=YES;
	NSString *str=@"";
	NSString *str1=@"";
	if (![Txtmap1.text isEqualToString:@""]) {				
		str1 = [str1 stringByAppendingFormat:@"%@",Txtmap1.text];	
	}
	if (![Txtmap2.text isEqualToString:@""]) {				
		str1 = [str1 stringByAppendingFormat:@" %@",Txtmap2.text];	
	}
	if (![Txtmap3.text isEqualToString:@""]) {				
		str1 = [str1 stringByAppendingFormat:@" %@",Txtmap3.text];	
	}
	if (![Txtmap4.text isEqualToString:@""]) {				
		str1 = [str1 stringByAppendingFormat:@" %@",Txtmap4.text];	
	}
	if (![Txtmap5.text isEqualToString:@""]) {				
		str1 = [str1 stringByAppendingFormat:@" %@",Txtmap5.text];	
	}
	str1=[str1 stringByReplacingOccurrencesOfString:@" " withString:@"+"];
	
	NSLog(@"Txtmap==>%@",str1);
	
	str=[NSString stringWithFormat:@"Map URL : http://maps.google.com/maps?q=%@",str1];
	str=[str stringByAppendingFormat:@"\n"];
	NSLog(@" %@",Txtmap6.text);
	if (![Txtmap6.text isEqualToString:@""]) {
		str=[str stringByAppendingFormat:[NSString stringWithFormat:@"Notes : %@",Txtmap6.text]];
		str=[str stringByAppendingFormat:@"\n"];	
	}
	
	sampleString = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@",str1];
	sampleString = [sampleString stringByAppendingFormat:@";"];
	if (![Txtmap6.text isEqualToString:@""]) {
		sampleString = [sampleString stringByAppendingFormat:@"Notes: %@",Txtmap6.text];
	}
	
	NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
	[attrStr1 setFont:[UIFont fontWithName:@"Helvetica" size:20]];
	[attrStr1 setTextColor:[UIColor blackColor]];
	if (![Txtmap1.text isEqualToString:@""]) {
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"Map URL :"]];
	}
	if (![Txtmap6.text isEqualToString:@""]) {
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"Notes :"]];
	}
	
	txtDisplayWEb.attributedText=attrStr1;	
	txtDisplayWEb.linkColor=[UIColor blueColor];
    txtDisplayWEb.userInteractionEnabled=YES;
	ScrllLabel.userInteractionEnabled=YES;
	ScrllLabel.scrollEnabled=YES;
	
	CGSize boundingSize = CGSizeMake(Txtmap1.frame.size.width, CGFLOAT_MAX);
	CGSize requiredSize = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:20]
						  constrainedToSize:boundingSize
							  lineBreakMode:UILineBreakModeWordWrap];
	CGFloat requiredHeight = requiredSize.height+100;
	
	ScrllLabel.contentSize=CGSizeMake(0,requiredHeight);
	
	if([Txtmap1.text length]>0 || [Txtmap2.text length]>0 ||[Txtmap3.text length]>0 || [Txtmap4.text length]>0 || [Txtmap5.text length]>0  )
		return YES;
	else 
	{
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter location detail" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}	
}

-(BOOL)smsdisplay{
	
	txtViewDisplay.hidden=YES;
	txtDisplayWEb.hidden=NO;
    
    actionButton.hidden=YES;

    
	
	NSString *str=@"";
	if (![Txtsms.text isEqualToString:@""]) {
		str=[NSString stringWithFormat:@"Mobile Number : %@",Txtsms.text];
		str=[str stringByAppendingFormat:@"\n"];
		
	}
	NSLog(@" %@",txtsmsMessage.text);
	if ([txtsmsMessage.text isEqualToString:@"Message"] || [txtsmsMessage.text isEqualToString:@""]) {
		
	}
	else {
		str=[str stringByAppendingFormat:[NSString stringWithFormat:@"Message : %@",txtsmsMessage.text]];
		str=[str stringByAppendingFormat:@"\n"];			
	}

	
	if([Txtsms.text length] > 0)
    {
        sampleString = [NSString stringWithFormat:@"SMSTO:%@",Txtsms.text];
      
    }
	if ([txtsmsMessage.text isEqualToString:@"Message"] || [txtsmsMessage.text isEqualToString:@""]) {
		
	}
	else 
    {
        sampleString = [sampleString stringByAppendingFormat:@":%@",txtsmsMessage.text];
	}
    
    if ([Txtsms.text length] == 0 && [txtsmsMessage.text length] > 0)
	{
        sampleString=@"";
        sampleString=[sampleString stringByAppendingFormat:@"SMSTO::%@",txtsmsMessage.text];
    }
	
	NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
	[attrStr1 setFont:[UIFont fontWithName:@"Helvetica" size:20]];
	[attrStr1 setTextColor:[UIColor blackColor]];
	if (![Txtsms.text isEqualToString:@""]) {
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"Mobile Number :"]];
        [attrStr1 setTextColor:[UIColor blueColor] range:[str rangeOfString:Txtsms.text]];
	}
	if ([txtsmsMessage.text isEqualToString:@"Message"] || [txtsmsMessage.text isEqualToString:@""]) {
		
	}
	else {
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"Message :"]];
	}

	
	
	txtDisplayWEb.attributedText=attrStr1;	
	

	
	CGSize boundingSize = CGSizeMake(txtsmsMessage.frame.size.width, CGFLOAT_MAX);
	CGSize requiredSize = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:20]
						  constrainedToSize:boundingSize
							  lineBreakMode:UILineBreakModeWordWrap];
	CGFloat requiredHeight = requiredSize.height+100;
	
	ScrllLabel.contentSize=CGSizeMake(0,requiredHeight);
    
    ScrllLabel.userInteractionEnabled=YES;
	ScrllLabel.scrollEnabled=YES;
    
	//NSLog(@"samplestring in sms==>%@",sampleString);
	if([txtsmsMessage.text length]>0 || [Txtsms.text length]>0)
		return YES;
	else 
	{
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter sms detail" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}
	
	
}

-(BOOL)ContactDisplay{
	 actionButton.hidden=NO;
      [actionButton setEnabled:YES];
	txtViewDisplay.hidden=YES;
	txtDisplayWEb.hidden=NO;
	[activetxt resignFirstResponder];
	NSString *Value;
	NSString   *showValue;
    NSString *tempstr;
    NSString *showValue1;
	showValue=[[NSString alloc]init];
    showValue1=[[NSString alloc]init];

	NSString *str=@"";
    BOOL nameok=NO;
    BOOL phonok=NO;
    showValue=@"";
    showValue1=@"";
    NSString *totname=[[NSString alloc]init];
    totname=@"";
    
    realph1=@"";
    
       
    
    
    
    
    
	for (int i=0; i<[arrField count]; i++)
	{		
        
        NSLog(@"%@",[arrField objectAtIndex:i]);
        
        
		if ([[[arrField objectAtIndex:i] valueForKey:@"isactive"] isEqualToString:@"yes"]) 
		{
			if (![[[arrField objectAtIndex:i] valueForKey:@"value"] isEqualToString:@""])
            {
				
                Value = [[arrField objectAtIndex:i] valueForKey:@"value"] ;
				tempstr=[Value stringByAppendingString:@";"];
               
                
                if([[[arrField objectAtIndex:i] valueForKey:@"placeholder"] isEqualToString:@"Name"])
                {
                    nameok=YES;
                }
                
                
                
                if([[[arrField objectAtIndex:i] valueForKey:@"placeholder"] isEqualToString:@"Phone Number"])
                {
                    realph1=Value;
                    
                    BOOL isValid=NO;
                    BOOL isValid1=NO;
                    if([realph1 rangeOfString:@"("].location!=NSNotFound || [realph1 rangeOfString:@")"].location!=NSNotFound || [realph1 rangeOfString:@"-"].location!=NSNotFound || [realph1 rangeOfString:@" "].location!=NSNotFound)
                    {
                        
                        if([realph1 length]==14)
                        {
                            NSString *phoneRegex = @"\\([0-9]{3}\\)+ +[0-9]{3}\\-[0-9]{4}";
                            NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
                            isValid = [phoneTest evaluateWithObject:[[arrField objectAtIndex:1] valueForKey:@"value"]];
                            
                            
                            realph1=[realph1 stringByReplacingOccurrencesOfString:@"(" withString:@""];
                            realph1=[realph1 stringByReplacingOccurrencesOfString:@")" withString:@""];
                            realph1=[realph1 stringByReplacingOccurrencesOfString:@" " withString:@""];
                            realph1=[realph1 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                        }
                        
                        
                    }
                    else {
                        if([realph1 length]==10)
                        {
                          
                            isValid1=YES;
                        }
                    }
                    
                    
                    if(isValid || isValid1)
                    {
                    phonok=YES;
                        Value=realph1;
                    }
                    else {
                        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter a valid Phone Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                        return NO;
                        
                       
                    }
                }
                
                
                
                
                
                
                
                
            
                //standradising formats.
                if([[[arrField objectAtIndex:i] valueForKey:@"placeholder"] isEqualToString:@"Name"])
                {
                    showValue1 = [showValue1 stringByAppendingFormat:@"FN:%@",Value];
                    showValue1 = [showValue1 stringByAppendingFormat:@"\n"];
                }
                if([[[arrField objectAtIndex:i] valueForKey:@"placeholder"] isEqualToString:@"Phone Number"])
                {
                    showValue1 = [showValue1 stringByAppendingFormat:@"TEL:%@",Value];
                    showValue1 = [showValue1 stringByAppendingFormat:@"\n"];

                    
                }
                
                if([[[arrField objectAtIndex:i] valueForKey:@"placeholder"] isEqualToString:@"Prefix"])
                {
                    totname = [totname stringByAppendingFormat:@"%@ ",Value];
                    
                }
                if([[[arrField objectAtIndex:i] valueForKey:@"placeholder"] isEqualToString:@"Phonetic First Name"])
                {
                    totname = [totname stringByAppendingFormat:@"%@ ",Value];
                    
                    
                }
                if([[[arrField objectAtIndex:i] valueForKey:@"placeholder"] isEqualToString:@"Middle"])
                {
                    totname = [totname stringByAppendingFormat:@"%@ ",Value];
                    
                    
                }
                if([[[arrField objectAtIndex:i] valueForKey:@"placeholder"] isEqualToString:@"Phonetic Last Name"])
                {
                    totname = [totname stringByAppendingFormat:@"%@ ",Value];
                    
                    
                }
                if([[[arrField objectAtIndex:i] valueForKey:@"placeholder"] isEqualToString:@"Suffix"])
                {
                    totname = [totname stringByAppendingFormat:@"%@",Value];
                    
                    
                }

                
                
                
                
               
                if([[[arrField objectAtIndex:i] valueForKey:@"placeholder"] isEqualToString:@"Job Title"])
                {
                    showValue1 = [showValue1 stringByAppendingFormat:@"TITLE:%@",Value];
                    showValue1 = [showValue1 stringByAppendingFormat:@"\n"];

                }
                if([[[arrField objectAtIndex:i] valueForKey:@"placeholder"] isEqualToString:@"Department"])
                {
                    showValue1 = [showValue1 stringByAppendingFormat:@"ORG:%@",Value];
                    showValue1 = [showValue1 stringByAppendingFormat:@"\n"];

                }
               
                
                
                
                
                
				showValue = [showValue stringByAppendingFormat:@"%@:%@",[[arrField objectAtIndex:i] valueForKey:@"placeholder"] ,Value];
              showValue = [showValue stringByAppendingFormat:@";"];
				NSLog(@"showvalue%@",showValue);	
				str= [str stringByAppendingFormat:@"%@ : %@",[[arrField objectAtIndex:i] valueForKey:@"placeholder"] ,Value];
				str = [str stringByAppendingFormat:@"\n"];
			}					
		}				
	}
    if([totname length]>0)
    showValue1 = [showValue1 stringByAppendingFormat:@"N:%@",totname];
    showValue1 = [showValue1 stringByAppendingFormat:@"\n"];
    
	showLebel.text =showValue;
    /**
     *  Text overriding
     */
    
     //sampleString = [NSString stringWithString:@"BEGIN:VCARD\nFN:Fullname\nTEL:+4312345\nEND:VCARD\n"];
    
     sampleString = [NSString stringWithString:@"BEGIN:VCARD"];
     sampleString = [sampleString stringByAppendingFormat:@"\n"];
     sampleString = [sampleString stringByAppendingFormat:showValue1];
    
   // sampleString=showLebel.text;
   
     sampleString = [sampleString stringByAppendingFormat:@"END:VCARD"];
     sampleString = [sampleString stringByAppendingFormat:@"\n"];

	 sampleString=[sampleString stringByReplacingOccurrencesOfString:@";" withString:@"\n"];
	//sampleString=[sampleString stringByReplacingOccurrencesOfString:@" " withString:@""];
	
	
	NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
	[attrStr1 setFont:[UIFont fontWithName:@"Helvetica" size:20]];
	[attrStr1 setTextColor:[UIColor blackColor]];
	for (int i=0; i<[arrField count]; i++)
	{		
		if ([[[arrField objectAtIndex:i] valueForKey:@"isactive"] isEqualToString:@"yes"]) 
		{
			if (![[[arrField objectAtIndex:i] valueForKey:@"value"] isEqualToString:@""]) {
				[attrStr1 setTextBold:YES range:[str rangeOfString:[[arrField objectAtIndex:i] valueForKey:@"placeholder"]]];
			}
            
            
            
            
		}
	}
    
	
	txtDisplayWEb.attributedText=attrStr1;
	
	
	ScrllLabel.userInteractionEnabled=YES;
	ScrllLabel.scrollEnabled=YES;
	
	CGSize boundingSize = CGSizeMake(txtsmsMessage.frame.size.width, CGFLOAT_MAX);
	CGSize requiredSize = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:20]
						  constrainedToSize:boundingSize
							  lineBreakMode:UILineBreakModeWordWrap];
	CGFloat requiredHeight = requiredSize.height+100;
	
	ScrllLabel.contentSize=CGSizeMake(0,requiredHeight);
	if([str length]>0)
    {
        int addcon1=1;
        ABAddressBookRef addressBook = ABAddressBookCreate();
        
        
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBook );
        CFIndex nPeople = ABAddressBookGetPersonCount( addressBook );
        
        
        for ( int i = 0; i < nPeople; i++ )
        {
            ABRecordRef ref = CFArrayGetValueAtIndex( allPeople, i );
            NSString *firstName = (NSString *)ABRecordCopyValue(ref, kABPersonFirstNameProperty);
          
            NSLog(@"%@",firstName);
            if ([firstName isEqualToString:[[arrField objectAtIndex:0] valueForKey:@"value"]] ) {
                NSLog(@"%@",[[arrField objectAtIndex:0] valueForKey:@"value"] );
                addcon1=0;
            }
            
        }
        

        
        
        
        if(phonok && nameok && addcon1)
        {
            addcon1=1;
           // UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Save to Contacts?" message:@"Do you want to add the following contact to Contact book" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
           // alert1.tag=201;
           // [alert1 show];
          //  [alert1 release];
            flagcon=YES;
            [actionButton setImage:[UIImage imageNamed:@"activecontact.png"] forState:UIControlStateNormal];
              [actionButton setEnabled:YES];
            
        }
        else {
            flagcon=NO;
            [actionButton setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
              [actionButton setEnabled:NO];
        }
		return YES;
	}
        else 
	{
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter contact detail" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}
	
	
}








- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    
    if(CounterBtn==0)
    {
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString: txtViewDisplay.text ]];  
    }
    if(CounterBtn==6)
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

        
        
    
    NSLog(@"tapped");
    
}

/*- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    return CGRectContainsPoint(CGRectInset([_textContentView convertRect:_selectionView.frame toView:self], -20.0f, -20.0f) , [gestureRecognizer locationInView:self]);
    
    
    
	if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
		return YES;
        NSLog(@"into gesture reg met");
	}
	else
    {
        return NO;
    }
    
    
    
}*/




- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
       appDel.ori == UIInterfaceOrientationLandscapeRight)
    {
       NSLog(@"into gesture reg met");
        CGPoint tappedPoint=[touch locationInView:scrolldata];
        
       // NSLog(@"%f,%f",tappedPoint.x,tappedPoint.y);
         NSLog(@"The tapped point :%@ and frame :",NSStringFromCGPoint(tappedPoint));
           NSLog(@"%f,%f,%f,%f",ScrllLabel.frame.origin.x,ScrllLabel.frame.origin.y,ScrllLabel.frame.size.width,ScrllLabel.frame.size.height);
        
    
   CGRect newframe=CGRectMake(ScrllLabel.frame.origin.x+80,ScrllLabel.frame.origin.y+10,ScrllLabel.frame.size.width/2,ScrllLabel.frame.size.height/8);
        
    if(CGRectContainsPoint(newframe, tappedPoint))
    {
        NSLog(@"tapped yes");
        return YES;
    }
    else 
    {
            NSLog(@"tapped no");
           return NO;
    }
    } 
    else {
        NSLog(@"potrait");
        CGPoint tappedPoint=[touch locationInView:scrolldata];
        
      //  NSLog(@"%f,%f",tappedPoint.x,tappedPoint.y);
       // NSLog(@"The tapped point :%@ and frame :",NSStringFromCGPoint(tappedPoint));
       //   NSLog(@"%f,%f,%f,%f",ScrllLabel.frame.origin.x,ScrllLabel.frame.origin.y,ScrllLabel.frame.size.width,ScrllLabel.frame.size.height);
        
        CGRect newframe=CGRectMake(ScrllLabel.frame.origin.x+70,ScrllLabel.frame.origin.y+10,ScrllLabel.frame.size.width/2,ScrllLabel.frame.size.height/4.2);
        if(CGRectContainsPoint(newframe, tappedPoint))
        {
            NSLog(@"tapped yes");
            return YES;
        }
        else 
        {
            NSLog(@"tapped no");
            return NO;
        }

        
        
        return YES;
    }
    

    
}


-(BOOL)PhoneDisplay{
    
     realph=txtPhone.text;
     actionButton.hidden=NO;
    BOOL isValid=NO;
    BOOL isValid1=NO;
    if([txtPhone.text rangeOfString:@"("].location!=NSNotFound || [txtPhone.text rangeOfString:@")"].location!=NSNotFound || [txtPhone.text rangeOfString:@"-"].location!=NSNotFound || [txtPhone.text rangeOfString:@" "].location!=NSNotFound)
       {
           
           if([realph length]==14)
           {
           NSString *phoneRegex = @"\\([0-9]{3}\\)+ +[0-9]{3}\\-[0-9]{4}";
           NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
           isValid = [phoneTest evaluateWithObject:txtPhone.text];
           
          
               realph=[realph stringByReplacingOccurrencesOfString:@"(" withString:@""];
               realph=[realph stringByReplacingOccurrencesOfString:@")" withString:@""];
               realph=[realph stringByReplacingOccurrencesOfString:@" " withString:@""];
                 realph=[realph stringByReplacingOccurrencesOfString:@"-" withString:@""];
           }
                     
         
       }
    else {
        if([realph length]==10)
        {
            isValid1=YES;
        }
    }
      
	
	if(isValid || isValid1)
	{
        
        //txtViewDisplay.frame=CGRectMake(0, 0, 500, 100);
        
		txtPhone.text=realph;
		txtViewDisplay.hidden=YES;
		txtDisplayWEb.hidden=NO;
        NSString *str=@"";
        
		txtViewDisplay.text=[NSString stringWithFormat:@"Phone Number : %@",txtPhone.text];
		sampleString =[NSString stringWithFormat:@"tel:%@",txtPhone.text];
		str=[NSString stringWithFormat:@"Phone Number : %@",txtPhone.text];
		NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
		[attrStr1 setFont:[UIFont fontWithName:@"Helvetica" size:20]];
		[attrStr1 setTextColor:[UIColor blackColor]];
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"Phone Number :"]];
       
        [self.view bringSubviewToFront:scrolldata];
		
		txtDisplayWEb.attributedText=attrStr1;	
		txtDisplayWEb.linkColor=[UIColor blueColor];
    
        txtDisplayWEb.userInteractionEnabled=YES;
		
       
        
		
		CGSize boundingSize = CGSizeMake(txtsmsMessage.frame.size.width, CGFLOAT_MAX);
		CGSize requiredSize = [sampleString sizeWithFont:[UIFont fontWithName:@"Helvetica" size:20]
									   constrainedToSize:boundingSize
										   lineBreakMode:UILineBreakModeWordWrap];
		CGFloat requiredHeight = requiredSize.height+100;
		
		ScrllLabel.contentSize=CGSizeMake(0,requiredHeight);
        ScrllLabel.userInteractionEnabled=YES;
		ScrllLabel.scrollEnabled=YES;
        
        
         
        
//saving to contact book phone no        
        
        ABAddressBookRef addressBook = ABAddressBookCreate();
        
        
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBook );
        CFIndex nPeople = ABAddressBookGetPersonCount( addressBook );
       
        int addpho1=1;
        NSString *searchString = nil;
        
        for ( int i = 0; i < nPeople; i++ )
        {
            ABRecordRef ref = CFArrayGetValueAtIndex( allPeople, i );
             ABMultiValueRef phonnumb = (ABMultiValueRef) ABRecordCopyValue(ref,kABPersonPhoneProperty);
          //  NSString *phonenum1 = (NSString *)ABRecordCopyValue(ref, kABPersonPhoneProperty);
          //  NSString *phonenum2 = (NSString *)ABRecordCopyValue(ref,kABPersonPhoneMobileLabel);
         //   NSString *phonenum3 = (NSString *)ABRecordCopyValue(ref, kABWorkLabel);
            
            for (CFIndex i = 0; i < ABMultiValueGetCount(phonnumb); i++) 
            {
                searchString = (NSString *)ABMultiValueCopyValueAtIndex(phonnumb, i);
                if([searchString isEqualToString:realph])
                addpho1=0;
                
            }
            
            

           
            
        }

        if(addpho1)
        {
            addpho1=1;
          //  UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Save to Contacts?" message:@"Do you want to add the following Phone Number to Contact book" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
           // alert1.tag=301;
           // [alert1 show];
           // [alert1 release]; 
            flagphon=YES;
            actionButton.hidden=NO;
            [actionButton setImage:[UIImage imageNamed:@"activecontact.png"] forState:UIControlStateNormal];
              [actionButton setEnabled:YES];
        }
        else {
            flagphon=NO;
            [actionButton setImage:[UIImage imageNamed:@"inactivecontact.png"] forState:UIControlStateNormal];
              [actionButton setEnabled:NO];
        }
        
        
        
        
        
		return YES;
	}
	else 
	{
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter a valid Phone Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}
	
}
-(BOOL)Maildisplay{
	 actionButton.hidden=YES;
	txtViewDisplay.hidden=YES;
	txtDisplayWEb.hidden=NO;
	NSString *str=@"";
	if (![txtemail1.text isEqualToString:@""]) {
		str=[NSString stringWithFormat:@"From : %@",txtemail1.text];
		str=[str stringByAppendingFormat:@"\n"];
	}
	if (![txtemail2.text isEqualToString:@""]) {
		str=[str stringByAppendingFormat:[NSString stringWithFormat:@"Subject : %@",txtemail2.text]];
		str=[str stringByAppendingFormat:@"\n"];
	}
	
	if ([txtviewemail3.text isEqualToString:@"Message"] || [txtviewemail3.text isEqualToString:@""]) 
    {
	}else{
		str=[str stringByAppendingFormat:[NSString stringWithFormat:@"Message : %@",txtviewemail3.text]];
		str=[str stringByAppendingFormat:@"\n"];

	}
    if([txtemail1.text length] > 0)
    {
        sampleString=[NSString stringWithFormat:@"MAILTO:%@",txtemail1.text];
       
    }
    if([txtemail2.text length] > 0)
    {
        sampleString=[sampleString stringByAppendingFormat:@"?SUBJECT=%@",txtemail2.text];
    
    }
    if ([txtviewemail3.text isEqualToString:@"Message"] || [txtviewemail3.text isEqualToString:@""]) 
    {
	}
    else
    {       
        sampleString=[sampleString stringByAppendingFormat:@"&BODY=%@",txtviewemail3.text];
    }
    NSLog(@"sample string appending:%@",sampleString);
	
	NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
	[attrStr1 setFont:[UIFont fontWithName:@"Helvetica" size:20]];
	[attrStr1 setTextColor:[UIColor blackColor]];
    
	if (![txtemail1.text isEqualToString:@""]) {
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"From :"]];
	}
	if (![txtemail2.text isEqualToString:@""]) {
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"Subject :"]];
	}
	if ([txtviewemail3.text isEqualToString:@"Message"] || [txtviewemail3.text isEqualToString:@""]) {
		
	}else{
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"Message :"]];
	}
	
	txtDisplayWEb.attributedText=attrStr1;
	txtDisplayWEb.linkColor=[UIColor blueColor];
	txtDisplayWEb.userInteractionEnabled=YES;
	
		
	ScrllLabel.userInteractionEnabled=YES;
	ScrllLabel.scrollEnabled=YES;
	
	CGSize boundingSize = CGSizeMake(txtsmsMessage.frame.size.width, CGFLOAT_MAX);
	CGSize requiredSize = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:20]
						  constrainedToSize:boundingSize
							  lineBreakMode:UILineBreakModeWordWrap];
	CGFloat requiredHeight = requiredSize.height+100;
	
	ScrllLabel.contentSize=CGSizeMake(0,requiredHeight);
	if([txtemail1.text length]>0 || [txtemail2.text length]>0 || [txtviewemail3.text length]>0)
		return YES;
	else 
	{
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter email detail" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		
		return NO;
	}
	
}
-(BOOL)Eventdisplay{
	 actionButton.hidden=NO;
      [actionButton setEnabled:YES];
	NSString *newDate1;
	NSString *newDate2;
	//newDate1=[LblDate1.text stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
	//newDate2=[LblDate2.text stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
	NSString *sDate,*eDate;
	
	//sDate=LblDate1.text;
	//eDate=LblDate2.text;
	/*
	NSDateFormatter* df=[[[NSDateFormatter alloc] init] autorelease];
	[df setDateFormat:@"MM-dd-yy"];
	NSDate* dt=[df dateFromString:newDate1];
	[df setDateFormat:@"dd MMMM, yyyy"];
	sDate=[df stringFromDate:dt];
	[df setDateFormat:@"MM-dd-yy"];
	dt=[df dateFromString:newDate2];
	[df setDateFormat:@"dd MMMM, yyyy"];
	eDate =[df stringFromDate:dt];
	
	if([LblDate1.text length]>0){}
	else 
		sDate=@"";
	if([LblDate2.text length]>0){}
	else 
		eDate=@"";*/
    
    sDate=@"";
    eDate=@"";
    newDate1=@"";
    newDate2=@"";
    if([LblDate1.text length]>0)
    {
        newDate1=LblDate1.text;
                
         NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
       
        
        if([newDate1 length]>13)
        {
            [dateFormat setDateFormat:@"EEE MM/dd/yy hh:mm a"];
            
        }
        else {
             [dateFormat setDateFormat:@"EEE MM/dd/yy"];
        }
               
        NSDate *date1=[dateFormat dateFromString:newDate1];
               [dateFormat setDateFormat:@"yyyyMMdd'T'HHmmss'Z"];
       
        sDate=[dateFormat stringFromDate:date1];
       
        NSLog(@"startdate:%@",sDate);
       

    
    }
    
    if([LblDate2.text length]>0)
    {
             newDate2=LblDate2.text;
           NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
        if([newDate2 length]>13)
        {
            [dateFormat2 setDateFormat:@"EEE MM/dd/yy hh:mm a"];
            
        }
        else {
            [dateFormat2 setDateFormat:@"EEE MM/dd/yy"];
        }
        NSDate *date2=[dateFormat2 dateFromString:newDate2];
         [dateFormat2 setDateFormat:@"yyyyMMdd'T'HHmmss'Z"];
         eDate=[dateFormat2 stringFromDate:date2];
         NSLog(@"enddate:%@",eDate);

        
    }
    
    
    
    tempevenloc=@"";
    
	NSString* str=@"";
    
    NSString *enstr=@"";
    tmpst=[NSMutableString stringWithCapacity: 1];
   [tmpst setString:@""];
	//if (![txtevent1.text isEqualToString:@""])
    if([txtevent1.text length] > 0)
    {
		str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Event : %@",txtevent1.text]];
		str = [str stringByAppendingFormat:@"\n"];
        
        enstr=[enstr stringByAppendingFormat:[NSString stringWithFormat:@"SUMMARY:%@",txtevent1.text]];
        enstr=[enstr stringByAppendingFormat:@"\n"];
	}
	//if (![LblDate1.text isEqualToString:@""]) 
    if([LblDate1.text length] > 0)    
    {
		str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Start Date & Time : %@ %@ ",LblDate1.text,[[LblTime1.text stringByReplacingOccurrencesOfString:@"pm" withString:@" PM"] stringByReplacingOccurrencesOfString:@"am" withString:@" AM"]]];
		str = [str stringByAppendingFormat:@"\n"];
        
        enstr=[enstr stringByAppendingFormat:[NSString stringWithFormat:@"DTSTART:%@",sDate]];
        enstr=[enstr stringByAppendingFormat:@"\n"];
        
        
	}
	//if (![LblDate2.text isEqualToString:@""]) 
    if([LblDate2.text length] > 0)
    {
		str = [str stringByAppendingFormat:[NSString stringWithFormat:@"End Date & Time : %@ %@ ",LblDate2.text,[[LblTime2.text stringByReplacingOccurrencesOfString:@"pm" withString:@" PM"] stringByReplacingOccurrencesOfString:@"am" withString:@" AM"]]];
		str = [str stringByAppendingFormat:@"\n"];
        
        enstr=[enstr stringByAppendingFormat:[NSString stringWithFormat:@"DTEND:%@",eDate]];
        enstr=[enstr stringByAppendingFormat:@"\n"];

        
	}
	//if (![txtevent3.text isEqualToString:@""]) 
    
  
    temploc=@"";
    if([txtevent3.text length] > 0)
    {
    [tmpst appendFormat:@"%@ ",txtevent3.text];
   
        
		//NSString *str1=[txtevent3.text stringByReplacingOccurrencesOfString:@"," withString:@",\n"];
		str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Street Address : %@",txtevent3.text]];
		str = [str stringByAppendingFormat:@"\n"];
        
        temploc=[temploc stringByAppendingFormat:@"%@ ",txtevent3.text];
        tempevenloc=[tempevenloc stringByAppendingFormat:@"%@ ",txtevent3.text];
        
	}
	//if (![txtevent4.text isEqualToString:@""]) 
    if([txtevent4.text length] > 0)
    {
        [tmpst appendFormat:@"%@ ",txtevent4.text];

        
        
		str = [str stringByAppendingFormat:[NSString stringWithFormat:@"City : %@",txtevent4.text]];
		str	= [str stringByAppendingFormat:@"\n"];
        
         temploc=[temploc stringByAppendingFormat:@"%@ ",txtevent4.text];
            tempevenloc=[tempevenloc stringByAppendingFormat:@"%@ ",txtevent4.text];    
        
	}
	//if (![txtevent5.text isEqualToString:@""]) 
    if([txtevent5.text length] > 0)
    {
        [tmpst appendFormat:@"%@ ",txtevent5.text];

        
        
		str = [str stringByAppendingFormat:[NSString stringWithFormat:@"State : %@",txtevent5.text]];
		str	= [str stringByAppendingFormat:@"\n"];
        
          temploc=[temploc stringByAppendingFormat:@"%@ ",txtevent5.text];
         tempevenloc=[tempevenloc stringByAppendingFormat:@"%@ ",txtevent5.text];
        	}
	//if (![txtevent6.text isEqualToString:@""]) 
    if([txtevent6.text length] > 0)
    {
        [tmpst appendFormat:@"%@ ",txtevent6.text];

        
        
		str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Zip Code : %@",txtevent6.text]];
		str	= [str stringByAppendingFormat:@"\n"];
        
         temploc=[temploc stringByAppendingFormat:@"%@ ",txtevent6.text]; 
         tempevenloc=[tempevenloc stringByAppendingFormat:@"%@ ",txtevent6.text];
       	}
	//if (![txtevent7.text isEqualToString:@""]) 
    if([txtevent7.text length] > 0)
    {
        [tmpst appendFormat:@"%@  ",txtevent7.text];

        
		str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Country : %@",txtevent7.text]];
		str	= [str stringByAppendingFormat:@"\n"];
        
         temploc=[temploc stringByAppendingFormat:@"%@ ",txtevent7.text];
         tempevenloc=[tempevenloc stringByAppendingFormat:@"%@ ",txtevent7.text];
	}
    
    NSLog(@"temparary location:%@",tempevenloc);
	//if (![txtevent8.text isEqualToString:@""]) 
    appDel.locationevent=tempevenloc;
    
    enstr=[enstr stringByAppendingFormat:@"LOCATION:%@",temploc];
    enstr=[enstr stringByAppendingFormat:@"\n"];

    
    appDel.evetnotesper=@"";
    tempevennotes=@"";
    if([txtevent8.text length] > 0)
    {
        [tmpst appendFormat:@"Notes:%@",txtevent8.text];


        tempevennotes=txtevent8.text;
        appDel.evetnotesper=txtevent8.text;
        
		str = [str stringByAppendingFormat:[NSString stringWithFormat:@"Notes : %@",txtevent8.text]];
		str	= [str stringByAppendingFormat:@"\n"];
        
        
        enstr=[enstr stringByAppendingFormat:[NSString stringWithFormat:@"DESCRIPTION:%@",txtevent8.text]];
        enstr=[enstr stringByAppendingFormat:@"\n"];
	}
    
    sampleString = [NSString stringWithString:@"BEGIN:VCALENDAR"];
     sampleString = [sampleString stringByAppendingFormat:@"\n"];
    
    sampleString = [sampleString stringByAppendingFormat:@"VERSION:2.0"];

    
    sampleString = [sampleString stringByAppendingFormat:@"\n"];
    
    sampleString = [sampleString stringByAppendingFormat:@"BEGIN:VEVENT"];
     sampleString = [sampleString stringByAppendingFormat:@"\n"];
    NSLog(@"final string to encode:%@",enstr);
    
    sampleString = [sampleString stringByAppendingFormat:enstr];
    
    // sampleString=showLebel.text;
     sampleString = [sampleString stringByAppendingFormat:@"\n"];
    
    sampleString = [sampleString stringByAppendingFormat:@"END:VEVENT"];
    sampleString = [sampleString stringByAppendingFormat:@"\n"];
    
    sampleString = [sampleString stringByAppendingFormat:@"END:VCALENDAR"];
   
    
    sampleString=[sampleString stringByReplacingOccurrencesOfString:@";" withString:@"\n"];
	//sampleString=[sampleString stringByReplacingOccurrencesOfString:@" " withString:@""];

    
    
    
    
    
 //   [sampleString stringByAppendingString:@"BEGIN:VEVENT"];
 //   [sampleString stringByAppendingString:@"\n"];
  //  [sampleString stringByAppendingString:str];
  //   [sampleString stringByAppendingString:@"\n"];
  //   [sampleString stringByAppendingString:@"END:VEVENT"];
    //
    //sampleString = str;
	
	txtViewDisplay.text=str;
			
	NSMutableAttributedString* attrStr1 = [NSMutableAttributedString attributedStringWithString:str];
	//[attrStr1 setFont:[UIFont fontWithName:@"Helvetica" size:20]];
	[attrStr1 setTextColor:[UIColor blackColor]];
	[attrStr1 setFontFamily:@"Helvetica" size:20 bold:NO italic:NO range:[str rangeOfString:str]];
	if (![txtevent1.text isEqualToString:@""]) {
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"Event :"]];
	}
	if (![LblDate1.text isEqualToString:@""]) {
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"Start Date & Time :"]];
	}
	if (![LblDate2.text isEqualToString:@""]) {
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"End Date & Time :"]];
	}
	if (![txtevent3.text isEqualToString:@""]) {
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"Street Address :"]];
	}
	if (![txtevent4.text isEqualToString:@""]) {
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"City :"]];
	}
	if (![txtevent5.text isEqualToString:@""]) {
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"State :"]];
	}
	if (![txtevent6.text isEqualToString:@""]) {
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"Zip Code :"]];
	}
	if (![txtevent7.text isEqualToString:@""]) {
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"Country :"]];
	}
	if (![txtevent8.text isEqualToString:@""]) {
		[attrStr1 setTextBold:YES range:[str rangeOfString:@"Notes :"]];
	}
	
	
	txtDisplayWEb.attributedText=attrStr1;
	txtDisplayWEb.linkColor=[UIColor blackColor];
	
	
	ScrllLabel.userInteractionEnabled=YES;
	ScrllLabel.scrollEnabled=YES;
	
	CGSize boundingSize = CGSizeMake(txtsmsMessage.frame.size.width, CGFLOAT_MAX);
	CGSize requiredSize = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:20]
						  constrainedToSize:boundingSize
							  lineBreakMode:UILineBreakModeWordWrap];
	CGFloat requiredHeight = requiredSize.height+100;
	
	ScrllLabel.contentSize=CGSizeMake(0,requiredHeight);
	
	
	if([txtevent1.text length]>0 || [sDate length]>0 || [eDate length]>0 || [txtevent3.text length]>0 || [txtevent4.text length]>0)
    {
        if([txtevent1.text length]>0 && [sDate length]>0 && [eDate length]>0)
        {
        
       /*     EKEventStore *eventStore = [[EKEventStore alloc] init];
            NSArray * calendars = [eventStore calendars];
            for(NSString * str in calendars) {
                NSLog(@"events in eventt store%@",str);
            }

            
            
            const double secondsInAYear = (60.0*60.0*24.0)*365.0;
            NSPredicate* predicate = [eventStore predicateForEventsWithStartDate:[NSDate dateWithTimeIntervalSinceNow:secondsInAYear] endDate:[NSDate dateWithTimeIntervalSinceNow:secondsInAYear] calendars:nil];
            
            
        //    NSDate *startDate = [NSDate date];
         //   NSDate *endDate   = [NSDate distantFuture];
        //    
          //  NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:startDate
                                                                  //       endDate:endDate
                                                                  //     calendars:calendars];
            
            NSArray *events = [eventStore eventsMatchingPredicate:predicate]; 
            
            
         EKEvent *eves=  [eventStore eventWithIdentifier:txtevent1.text];
            
            NSLog(@"event identifeir:%@",eves.title);
            
            for(NSString * myStr in events) {
                NSLog(@"events in eventt store%@",myStr);
            }*/
            flageven=YES;
             int seconds_in_year = 60*60*24*365;
            NSDate *dat1=[[NSDate alloc]init];
            EKEventStore *eventStore = [[EKEventStore alloc] init];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mma"];
            NSDate *start = [dat1 dateByAddingTimeInterval:-seconds_in_year];
            NSDate *finish = [dat1 dateByAddingTimeInterval:seconds_in_year];
            
            
            // use Dictionary for remove duplicates produced by events covered more one year segment
            NSMutableDictionary *eventsDict = [NSMutableDictionary dictionaryWithCapacity:1024];
            
            NSDate* currentStart = [NSDate dateWithTimeInterval:0 sinceDate:start];
            
           
            
            // enumerate events by one year segment because iOS do not support predicate longer than 4 year !
            while ([currentStart compare:finish] == NSOrderedAscending) {
                
                NSDate* currentFinish = [NSDate dateWithTimeInterval:seconds_in_year sinceDate:currentStart];
                
                if ([currentFinish compare:finish] == NSOrderedDescending) {
                    currentFinish = [NSDate dateWithTimeInterval:0 sinceDate:finish];
                }
                NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:currentStart endDate:currentFinish calendars:nil];
                [eventStore enumerateEventsMatchingPredicate:predicate
                                                  usingBlock:^(EKEvent *event, BOOL *stop) {
                                                      
                                                      if (event) {
                                                          
                                                          if(event.eventIdentifier != nil)
                                                          [eventsDict setObject:event forKey:event.eventIdentifier];
                                                          else {
                                                              NSLog(@"no event dictonary");
                                                              flageven=NO;
                                                          }
                                                      }
                                                      
                                                  }];       
                currentStart = [NSDate dateWithTimeInterval:(seconds_in_year + 1) sinceDate:currentStart];
                
            }
            
            NSArray *events = [eventsDict allKeys];
            
            
            for(int i=0;i<[events count];i++)
            {
                EKEvent *evn=[eventsDict objectForKey:[events objectAtIndex:i]];
              //  NSLog(@"title of event:%@",evn.title);
              if([evn.title length]!= 0)
              {
                  NSString *evntstrcmp=txtevent1.text;
                   evntstrcmp=[evntstrcmp stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                  if([evn.title isEqualToString:evntstrcmp])
                  {
                      flageven=NO;
                  }
              }
                
            }
            NSLog(@"is events:"); 
          NSLog(flageven ? @"Yes" : @"No");
                       
          
            
            
           // flageven=YES;
            if(flageven)
            {
            [actionButton setImage:[UIImage imageNamed:@"calenderactive.png"] forState:UIControlStateNormal];
                  [actionButton setEnabled:YES];
            }
            else {
                 [actionButton setImage:[UIImage imageNamed:@"inactivecalender.png"] forState:UIControlStateNormal];
                  [actionButton setEnabled:NO];
            }
       
        }
        else {
            flageven=NO;
            [actionButton setImage:[UIImage imageNamed:@"inactivecalender.png"] forState:UIControlStateNormal];
              [actionButton setEnabled:NO];
        }
		return YES;
    }
    
	else 
	{
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter event detail" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		
		return NO;
	}
	
}
#pragma mark Social NetworkStatus

-(IBAction)buttonFacebooKClicked:(id)sender
{
	//appDel = (KrenMarketingAppDelegate*)[[UIApplication sharedApplication]delegate];
	SHKItem *item = [SHKItem image:imageview.image title:nil];
	[NSClassFromString(@"SHKFacebook") performSelector:@selector(shareItem:) withObject:item];
	
}
-(IBAction) buttonTwitterClicked:(id)sender
{
	appDel.fromTwitter=TRUE;
	appDel = (KrenMarketingAppDelegate*)[[UIApplication sharedApplication]delegate];
	
	SHKItem *item = [SHKItem image:imageview.image title:nil];
	//SHKItem *item = [SHKItem text:text];
	
	[NSClassFromString(@"SHKTwitter") performSelector:@selector(shareItem:) withObject:item];
	
	
}


-(IBAction)emailbtn_click:(id)sender
{		
	/* int w=imageview.image.size.width;
	 int h=imageview.image.size.height;
	 
	 
	 CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	 
	 CGContextRef context = CGBitmapContextCreate(NULL, w, h+155, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
	 
	 // CGContextDrawImage(context, CGRectMake(0, 155, w, h), image.image.CGImage);
	 CGContextDrawImage(context, CGRectMake(0, 155, w, 400), imageview.image.CGImage);
	 
	 CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1);
	 
	 CGContextSelectFont(context, "Arial", 22, kCGEncodingMacRoman);
	 
	 CGContextSetTextDrawingMode(context, kCGTextFill);
	 CGContextSetRGBFillColor(context, 0, 0, 0, 1);
	 
	 UIGraphicsPushContext(context);
	 
	 CGContextSaveGState(context);
	 CGContextTranslateCTM(context, 0.0f, h+155);
	 CGContextScaleCTM(context, 1.0f, -1.0f);
	 
	 CGContextRestoreGState(context);
	 
	 UIGraphicsPopContext();
	 
	 CGImageRef imageMasked = CGBitmapContextCreateImage(context);
	 
	 CGContextRelease(context);
	 
	 CGColorSpaceRelease(colorSpace);
	 
	 UIImage *imgText = [UIImage imageWithCGImage:imageMasked];
	 UIGraphicsBeginImageContext(CGSizeMake(320, 365));
	 [imgText drawInRect:CGRectMake(0, 0, 320, 365)];
	 UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
	 
	 appDel.QRScanText=txtViewDisplay.text;
	 UIGraphicsEndImageContext();
	 SHKItem *item = [SHKItem image:imageview.image title:@"QR CODE"];
	 [NSClassFromString(@"SHKMail") performSelector:@selector(shareItem:) withObject:item];
	 
	 */
	
	
	
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
	picker.mailComposeDelegate = (id<MFMailComposeViewControllerDelegate>)self;
	
	NSData *imgData = UIImagePNGRepresentation(imageview.image);
	[picker addAttachmentData:imgData mimeType:@"image/png" fileName:@"Result"];//[tmpBody release];
	
	
	picker.modalPresentationStyle =UIModalPresentationFormSheet;
	picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[appDel.viewController presentModalViewController:picker animated:YES];
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
	
	[appDel.viewController dismissModalViewControllerAnimated:YES];
}


-(IBAction)Trash_click:(id)sender{
	
	BtnTrash.selected=TRUE;
	
	//NSString *sql = [NSString stringWithFormat:@"select *from library"];
//	NSMutableArray *array=[DAL ExecuteArraySet:sql];
//	
//	NSString  *sql1 =[NSString stringWithFormat:@"delete from library where Image = '%@' ",[NSString stringWithFormat:@"qr%d.png",[array count]]];
	
	NSString *sql = [NSString stringWithFormat:@"select Image from library where Image =(SELECT MAX(Image) from library)"];
	NSMutableArray *array=[DAL ExecuteArraySet:sql];
	
	NSString  *sql1 =[NSString stringWithFormat:@"delete from library where Image = '%@' ",[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"Image"]]];
	
	[DAL ExecuteArraySet:sql1];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString * pdfname = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[[array objectAtIndex:0] valueForKey:@"Image"]]];	
	[[NSFileManager defaultManager] removeItemAtPath:pdfname error:nil];
	
	
	NSMutableArray *array1= [DAL ExecuteArraySet:sql1];
    actionButton.hidden=YES;
    scrolldata.hidden=YES;
	imageBottomBar.hidden=YES;
	imageview.image=nil;
	[MaskView removeFromSuperview];	
	txtViewDisplay.text=@"";
	dateLabel.text=@"";
	TimeLabel.text=@"";
	txtDisplayWEb.text=@"";
	imageBottomBar.hidden=YES;
	BtnFacebook.hidden=YES;
	BtnTwitter.hidden=YES;
	BtnTrash.hidden=YES;
	BtnMail.hidden=YES;
	BtnEncode.hidden=NO;
	if (CounterBtn==0) {
		URLView.hidden=NO;
	}else if (CounterBtn==1) {
		ContactView.hidden=NO;
	}else if (CounterBtn==2) {
		EventView.hidden=NO;
	}else if (CounterBtn==3) {
		Mapview.hidden=NO;
	}else if (CounterBtn==4) {
		SMSView.hidden=NO;
	}else if (CounterBtn==5) {
		PhoneView.hidden=NO;
	}else if (CounterBtn==6) {
		EmailView.hidden=NO;
	}else if (CounterBtn==7) {
		ViewText.hidden=NO;
		btnFont.hidden=NO;
	}
}


#pragma mark TIME & DATE
-(void)TimeandDate{
	dateLabel.hidden=NO;
	TimeLabel.hidden=NO;
	//Date
	NSDate* date = [NSDate date];
	NSDateFormatter *Date1=[[[NSDateFormatter alloc] init] autorelease];
	NSDateFormatter *Time1=[[[NSDateFormatter alloc] init] autorelease];
	[Date1 setDateFormat:@"E MM/dd/yy"];
	[Time1 setDateFormat:@"h:MM aa"];
	[Date1 setDateFormat:@"E MM/dd/yy"];
	[Time1 setDateFormat:@"h:MM aa"];
	[Date1 setDateFormat:@"E MM/dd/yy"];
	[Time1 setDateFormat:@"h:MM aa"];
	/*[Date1 setDateFormat:@"yyyyMMdd"];
	[Date1 setDateFormat:@"MMMM dd, yyyy"];
		
//	NSLog(@"Date: %@", Date12);
	//Time

	[Time1 setDateFormat:@"HH:MM aaa"];*/
	NSString *Date12=[Date1 stringFromDate:date];
	NSString *Time12=[Time1 stringFromDate:date];	
//	NSLog(@"Date: %@",Time12);
	
	dateLabel.text = [NSString stringWithFormat:@"Created and Added to Library on %@",Date12];
	/*Time12 = [Time12 stringByReplacingOccurrencesOfString:@"PM" withString:@"P.M."];
	Time12 = [Time12 stringByReplacingOccurrencesOfString:@"AM" withString:@"A.M."];
	*/[TimeLabel setText:Time12];
}


#pragma mark didRotate
- (void) didRotate:(NSNotification *)notification
{
	appDel.fromTwitter=FALSE;
	if(appDel.ori== UIInterfaceOrientationPortrait ||
	   appDel.ori == UIInterfaceOrientationPortraitUpsideDown)
	{		
		[self setFrameOrientation_Portrait];
	}
	else if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
			appDel.ori == UIInterfaceOrientationLandscapeRight)
	{		
		[self setFrameOrientation_LandScap];
	}
	
}
-(void)Images_Portrait_Text{	
	[BtnUrl2 setBackgroundImage:[UIImage imageNamed:@"Port_Text.png"] forState:UIControlStateNormal];
	ImageEmail1.image=[UIImage imageNamed:@"Port_Text.png"];
	ImageEmail2.image=[UIImage imageNamed:@"Port_Text.png"];
	ImagePhone.image=[UIImage imageNamed:@"Port_Text.png"];
	ImageUrl.image=[UIImage imageNamed:@"Port_Text.png"];
	ImageMap2.image=[UIImage imageNamed:@"Port_Text.png"];
	ImageMap1.image=[UIImage imageNamed:@"Port_Addres.png"];
	Imagesms1.image=[UIImage imageNamed:@"Port_Text.png"];
	Imageevent1.image=[UIImage imageNamed:@"Port_Text.png"];
	ImageEvent4.image=[UIImage imageNamed:@"Port_Text.png"];
	Imageevent3.image=[UIImage imageNamed:@"Port_Addres.png"];
	ImageEventText.image=[UIImage imageNamed:@"Port_Event_Pop.png"];
	
}
-(void)Images_Landscape_Text{
	[BtnUrl2 setBackgroundImage:[UIImage imageNamed:@"Land_Text.png"] forState:UIControlStateNormal];
	ImageEmail1.image=[UIImage imageNamed:@"Land_Text.png"];
	ImageEmail2.image=[UIImage imageNamed:@"Land_Text.png"];
	ImagePhone.image=[UIImage imageNamed:@"Land_Text.png"];
	ImageUrl.image=[UIImage imageNamed:@"Land_Text.png"];
	ImageMap2.image=[UIImage imageNamed:@"Land_Text.png"];
	ImageMap1.image=[UIImage imageNamed:@"Land_Adress.png"];
	Imagesms1.image=[UIImage imageNamed:@"Land_Text.png"];
	Imageevent1.image=[UIImage imageNamed:@"Land_Text.png"];
	ImageEvent4.image=[UIImage imageNamed:@"Land_Text.png"];
	Imageevent3.image=[UIImage imageNamed:@"Land_Adress.png"];
	ImageEventText.image=[UIImage imageNamed:@"Land_Event_1.png"];
}
-(void)setFrameOrientation_Portrait
{	
        
    
	oncePort=TRUE;
	firstTime=FALSE;
	ButonBack.hidden=YES;
	BtnEncode.hidden=NO;
	ImageTop.frame=CGRectMake(0,0,768,48);
	ImageTop.image=[UIImage imageNamed:@"_0009_top-red-band.png"];
	dateLabel.hidden=YES;
	TimeLabel.hidden=YES;
	imageBottomBar.hidden=YES;
	BtnFacebook.hidden=YES;	
	BtnMail.hidden=YES;
	BtnTrash.hidden=YES;
	BtnTwitter.hidden=YES;
	txtDisplayWEb.hidden=YES;
	imageSeperator.hidden=NO;
	
	txtViewDisplay.hidden=YES;
	imageButonBack.image=[UIImage imageNamed:@"VertSEPERATION-Lines.png"];	
	imageButonBack.frame=CGRectMake(33,890,654,117);
	btnFont.hidden=YES;
		
	BtnURL.frame=CGRectMake(34,900, 82,107);
	BtnContact.frame=CGRectMake(115,900,82,107);
	BtnEvent.frame=CGRectMake(197,900,82,107);
	BtnMap.frame=CGRectMake(279,900,82,107);
	BtnSMS.frame=CGRectMake(361,900,82,107);
	BtnPhone.frame=CGRectMake(443,900,82,107);
	BtnEmail.frame=CGRectMake(525,900,82,107);
	BtnText.frame=CGRectMake(607,900,82,107);
	
	BtnFacebook.frame=CGRectMake(131,854, 42,43);
	BtnMail.frame=CGRectMake(389,854, 42,43);
	BtnTrash.frame=CGRectMake(518,854, 42,43);
	BtnTwitter.frame=CGRectMake(260,854, 42,43);
	
	LblTop.frame=CGRectMake(330,4,64,30);
	imageBottomBar.frame=CGRectMake(34, 852, 655, 59);
	BtnEncode.frame=CGRectMake(250,410,223,57);
	btnFont.frame=CGRectMake(100,410,223,57);	
	imageSeperator.frame=CGRectMake(34,500,654,6);	
	dateLabel.frame=CGRectMake(230,530,320,30);
	TimeLabel.frame=CGRectMake(230,550,138,30);
	ScrllLabel.frame=CGRectMake(65,680,690,250);
	btnurlopen.frame=CGRectMake(20,0,500,50);
	
	txtViewDisplay.frame=CGRectMake(0,0,550,200);
	imageview.frame=CGRectMake(65,520, 130,130);
	
	//Images for Textfeild in Portrait
	[self Images_Portrait_Text];
	
	//EMAIL view	
    EmailView.frame=CGRectMake(46,80,595,350);
	LblEmail.frame=CGRectMake(0,0,200,15);
	txtemail1.frame=CGRectMake(10,30,585,44);
	txtemail2.frame=CGRectMake(10,85,585,44);
	txtviewemail3.frame=CGRectMake(4,139,585,134);
	LblMailMessage.frame=CGRectMake(4,100,50,134);
	imgEmail.frame=CGRectMake(0,139,595,134);
	ImageEmail1.frame=CGRectMake(0,30,595,44);
	ImageEmail2.frame=CGRectMake(0,85,595,44);
	
	//VIEWTEXT
	ViewText.frame=CGRectMake(46,80,595,350);
	LblText.frame=CGRectMake(0,0,200,15);
	Ego_Textview.frame=CGRectMake(10,30,580,264);
	imgtxtBack.frame=CGRectMake(0,30,595,264);
	ScrlText.frame=CGRectMake(12, 35, 580, 260);	
	txtDisplayWEb.frame=CGRectMake(10,10, 570, 1000);	
	LblPlaceholder.frame=CGRectMake(14,30,90,40);		
	
	//Phoneview
	PhoneView.frame=CGRectMake(46,80,595,350);
	Lblphone.frame=CGRectMake(0,0,200,15);
	txtPhone.frame=CGRectMake(10,30,585,44);
	ImagePhone.frame=CGRectMake(0,30,595,44);
	
	
	//URLVIEW	
	URLView.frame=CGRectMake(46,80,595,350);
	LblUrl.frame=CGRectMake(0,0,200,15);
    txturl1.frame=CGRectMake(10,30,585,44);
	
	ImageUrl.frame=CGRectMake(0,30,595,44);
	ImageUrl1.frame=CGRectMake(0,85,595,44);
	Imagecheck.frame=CGRectMake(560,100,13,13);	
	BtnUrl2.frame=CGRectMake(10,85,550,44);
	LblUrl2.frame=CGRectMake(10,85,550,44);
	
	//MAPView
	Mapview.frame=CGRectMake(46,80,590,350);
	LblMap.frame=CGRectMake(0,0,200,15);
	
	Sclmap.frame=CGRectMake(0,30,595,280);
    Txtmap1.frame=CGRectMake(10,3,585,34);
	Txtmap2.frame=CGRectMake(10,43,585,34);	
	Txtmap3.frame=CGRectMake(10,83,585,34);
	Txtmap4.frame=CGRectMake(10,123,585,34);
	Txtmap5.frame=CGRectMake(10,163,585,34);	
	Txtmap6.frame=CGRectMake(10,215,585,44);
	ImageMap1.frame=CGRectMake(0,0,595,205);	
	ImageMap2.frame=CGRectMake(0,215,596,44);
	Sclmap.userInteractionEnabled = TRUE;
	Sclmap.delegate = self;
	Sclmap.scrollEnabled = TRUE;
	Sclmap.backgroundColor = [UIColor clearColor];    
    Sclmap.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    Sclmap.contentSize=CGSizeMake(0,280);
	
	//SMSView
	SMSView.frame=CGRectMake(46,80,595,350);
	Lblsms.frame=CGRectMake(0,0,200,15);
    Txtsms.frame=CGRectMake(10,30,583,44);
	txtsmsMessage.frame=CGRectMake(4,85,593,134);
	LblsmsMessage.frame=CGRectMake(4,85,50,134);
	imgsmsBack.frame=CGRectMake(0,85,595,134);
	Imagesms1.frame=CGRectMake(0,30,595,44);
	
	
	//EVENTview
	
	EventView.frame=CGRectMake(46,80,595,350);
	LblEvent.frame=CGRectMake(0,0,200,15);
	SclEvent.frame=CGRectMake(0,30,595,280);
	txtevent1.frame=CGRectMake(10,0,585,44);
	ImageEventText.frame=CGRectMake(0,55,595,82);
	
	
	txtevent3.frame=CGRectMake(10,150,585,34);
	txtevent4.frame=CGRectMake(10,190,585,34);	
	txtevent5.frame=CGRectMake(10,230,585,34);	
	txtevent6.frame=CGRectMake(10,270,585,34);
	txtevent7.frame=CGRectMake(10,310,585,34);
	txtevent8.frame=CGRectMake(10,365,585,44);
	
	BtnStarts.frame=CGRectMake(10,65,583,20);	
	BtnEnds.frame=CGRectMake(10,103,590,20);
	Lblstart.frame=CGRectMake(10,65,583,20);
	LblEnd.frame=CGRectMake(10,103,590,20);
	LblDate1.frame=CGRectMake(100,65,200,20);
	LblDate2.frame=CGRectMake(100,103,200,20);
	LblTime1.frame=CGRectMake(430,65,99,20);
	LblTime2.frame=CGRectMake(430,103,100,20);	
	Imageevent1.frame=CGRectMake(0,0,595,44);
	Imageevent3.frame=CGRectMake(0,147,595,205);
	ImageEvent4.frame=CGRectMake(0,365,595,44);
	SclEvent.userInteractionEnabled = TRUE;
	SclEvent.delegate = self;
	SclEvent.scrollEnabled = TRUE;
	SclEvent.backgroundColor = [UIColor clearColor];    
    SclEvent.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    SclEvent.contentSize=CGSizeMake(0,440);
	
	
	//Pop Coding...	    
    scrollView.userInteractionEnabled = TRUE;
	scrollView.delegate = self;
	scrollView.scrollEnabled = TRUE;
	scrollView.backgroundColor = [UIColor clearColor];    
    //scrollView.scrollsToTop = YES;
    scrollView.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //scrollView.alwaysBounceVertical = TRUE; 
    
	//Contactview
	ContactView.frame=CGRectMake(46,80,595,350);
	LblContact.frame=CGRectMake(0,0,200,15);
	[scrollView setFrame:CGRectMake(0,30,610,280)];
    
	//Bottom Buttons
	[BtnURL setImage:[UIImage imageNamed:@"URL_unselected.png"] forState:UIControlStateNormal];
	[BtnContact setImage:[UIImage imageNamed:@"Connect_unselected.png"] forState:UIControlStateNormal];
	[BtnEvent setImage:[UIImage imageNamed:@"Event_unselected.png"] forState:UIControlStateNormal];
	[BtnMap setImage:[UIImage imageNamed:@"Map_unselected.png"] forState:UIControlStateNormal];
	[BtnSMS setImage:[UIImage imageNamed:@"sms_unselected.png"] forState:UIControlStateNormal];
	[BtnPhone setImage:[UIImage imageNamed:@"Phone_unselected.png"] forState:UIControlStateNormal];	
	[BtnEmail setImage:[UIImage imageNamed:@"Email_unselected.png"] forState:UIControlStateNormal];
	[BtnText setImage:[UIImage imageNamed:@"Text_unselected.png"] forState:UIControlStateNormal];
	
	if (CounterBtn==0) { //URL
		
		txtViewDisplay.hidden=NO;
       // txtViewDisplay.backgroundColor=[[UIColor greenColor] colorWithAlphaComponent:0.5];
		txtDisplayWEb.hidden=YES;		
		EmailView.hidden=YES;
		ViewText.hidden=YES;
		URLView.hidden=NO;
		ContactView.hidden=YES;
		Mapview.hidden=YES;
		SMSView.hidden=YES;
		PhoneView.hidden=YES;
		EventView.hidden=YES;
		
		[BtnURL setImage:[UIImage imageNamed:@"url_selected.png"] forState:UIControlStateNormal];
		
	}else if (CounterBtn==1) {//contact
		
		txtViewDisplay.hidden=YES;
		txtDisplayWEb.hidden=NO;
		[self reloadUI];
		EmailView.hidden=YES;
		ViewText.hidden=YES;
		URLView.hidden=YES;
		ContactView.hidden=NO;
		Mapview.hidden=YES;
		SMSView.hidden=YES;
		PhoneView.hidden=YES;
		EventView.hidden=YES;
		
		[BtnContact setImage:[UIImage imageNamed:@"Connect_selected.png"] forState:UIControlStateNormal];
		
	}else if (CounterBtn==2) {//event
		
		txtDisplayWEb.hidden=NO;
		txtViewDisplay.hidden=YES;
		EmailView.hidden=YES;
		ViewText.hidden=YES;
		URLView.hidden=YES;
		ContactView.hidden=YES;
		Mapview.hidden=YES;
		SMSView.hidden=YES;
		PhoneView.hidden=YES;
		EventView.hidden=NO;
		
		
	    [BtnEvent setImage:[UIImage imageNamed:@"Event_selected.png"] forState:UIControlStateNormal];
		/*[BtnURL setImage:[UIImage imageNamed:@"URL_unselected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Connect_unselected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Map_unselected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"sms_unselected.png"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Phone_unselected.png"] forState:UIControlStateNormal];	
		[BtnEmail setImage:[UIImage imageNamed:@"Email_unselected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Text_unselected.png"] forState:UIControlStateNormal];
		*/
	}else if (CounterBtn==3) {//map
		
		
		txtViewDisplay.hidden=YES;
		txtDisplayWEb.hidden=NO;
		
		EmailView.hidden=YES;
		ViewText.hidden=YES;
		URLView.hidden=YES;
		ContactView.hidden=YES;
		Mapview.hidden=NO;
		SMSView.hidden=YES;
		PhoneView.hidden=YES;
		EventView.hidden=YES;
		
		/*[BtnURL setImage:[UIImage imageNamed:@"URL_unselected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Connect_unselected.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Event_unselected.png"] forState:UIControlStateNormal];
		*/[BtnMap setImage:[UIImage imageNamed:@"Map_selected.png"] forState:UIControlStateNormal];
		/*[BtnSMS setImage:[UIImage imageNamed:@"sms_unselected.png"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Phone_unselected.png"] forState:UIControlStateNormal];	
    	[BtnEmail setImage:[UIImage imageNamed:@"Email_unselected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Text_unselected.png"] forState:UIControlStateNormal];
		*/
	}else if (CounterBtn==4) {//sms		
		
		txtViewDisplay.hidden=YES;
		txtDisplayWEb.hidden=NO;
		
		EmailView.hidden=YES;
		ViewText.hidden=YES;
		URLView.hidden=YES;
		ContactView.hidden=YES;
		Mapview.hidden=YES;
		SMSView.hidden=NO;
		PhoneView.hidden=YES;
		EventView.hidden=YES;
	/*	
		[BtnURL setImage:[UIImage imageNamed:@"URL_unselected.png"] forState:UIControlStateNormal];
    	[BtnContact setImage:[UIImage imageNamed:@"Connect_unselected.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Event_unselected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Map_unselected.png"] forState:UIControlStateNormal];
		*/[BtnSMS setImage:[UIImage imageNamed:@"sms_selected.png"] forState:UIControlStateNormal];
		/*[BtnPhone setImage:[UIImage imageNamed:@"Phone_unselected.png"] forState:UIControlStateNormal];	
		[BtnEmail setImage:[UIImage imageNamed:@"Email_unselected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Text_unselected.png"] forState:UIControlStateNormal];
		*/
	}else if (CounterBtn==5) {//phone
		
		
		txtDisplayWEb.hidden=NO;
		txtViewDisplay.hidden=YES;
		
		EmailView.hidden=YES;
		ViewText.hidden=YES;
		URLView.hidden=YES;
		ContactView.hidden=YES;
		Mapview.hidden=YES;
		SMSView.hidden=YES;
		PhoneView.hidden=NO;
		EventView.hidden=YES;
		
	  /*  [BtnURL setImage:[UIImage imageNamed:@"URL_unselected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Connect_unselected.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Event_unselected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Map_unselected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"sms_unselected.png"] forState:UIControlStateNormal];
		*/[BtnPhone setImage:[UIImage imageNamed:@"Phone_selected.png"] forState:UIControlStateNormal];	
		/*[BtnEmail setImage:[UIImage imageNamed:@"Email_unselected.png"] forState:UIControlStateNormal];
		[BtnText setImage:[UIImage imageNamed:@"Text_unselected.png"] forState:UIControlStateNormal];
		*/
	}else if (CounterBtn==6) {//email
		
		txtDisplayWEb.hidden=NO;
		
		txtViewDisplay.hidden=NO;
		EmailView.hidden=NO;
		ViewText.hidden=YES;
		URLView.hidden=YES;
		ContactView.hidden=YES;
		Mapview.hidden=YES;
		SMSView.hidden=YES;
		PhoneView.hidden=YES;
		EventView.hidden=YES;
		
		/*[BtnURL setImage:[UIImage imageNamed:@"URL_unselected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Connect_unselected.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Event_unselected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Map_unselected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"sms_unselected.png"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Phone_unselected.png"] forState:UIControlStateNormal];	
		*/[BtnEmail setImage:[UIImage imageNamed:@"Email_selected.png"] forState:UIControlStateNormal];
		//[BtnText setImage:[UIImage imageNamed:@"Text_unselected.png"] forState:UIControlStateNormal];
		
	}else if (CounterBtn==7) {//text
		
		txtViewDisplay.hidden=YES;			
		txtDisplayWEb.hidden=NO;		
	
		EmailView.hidden=YES;
		ViewText.hidden=NO;
		URLView.hidden=YES;
		ContactView.hidden=YES;
		Mapview.hidden=YES;
		SMSView.hidden=YES;
		PhoneView.hidden=YES;
		EventView.hidden=YES;
		CGRect containerFrame ;
		containerFrame = CGRectMake(12,36,imgtxtBack.frame.size.width-30,imgtxtBack.frame.size.height-30);
		self.egoTextView.contentOffset = CGPointMake(0,0);
		self.egoTextView.frame = containerFrame;
		if([ResultString length]>0)
		{	[self.egoTextView reloadText:self.egoTextView.attributedString.string];
			[self.egoTextView resignFirstResponder];

		}
		//[self.egoTextView framecontentview];
		//self.egoTextView.frame=CGRectMake(12,35,imgtxtBack.frame.size.width-20,imgtxtBack.frame.size.height-20);
				
		/*
		[BtnURL setImage:[UIImage imageNamed:@"URL_unselected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Connect_unselected.png"] forState:UIControlStateNormal];
		[BtnEvent setImage:[UIImage imageNamed:@"Event_unselected.png"] forState:UIControlStateNormal];
		[BtnMap setImage:[UIImage imageNamed:@"Map_unselected.png"] forState:UIControlStateNormal];
		[BtnSMS setImage:[UIImage imageNamed:@"sms_unselected.png"] forState:UIControlStateNormal];
		[BtnPhone setImage:[UIImage imageNamed:@"Phone_unselected.png"] forState:UIControlStateNormal];	
		[BtnEmail setImage:[UIImage imageNamed:@"Email_unselected.png"] forState:UIControlStateNormal];
		*/
		[BtnText setImage:[UIImage imageNamed:@"Text_selected.png"] forState:UIControlStateNormal];
		BtnEncode.frame=CGRectMake(360,410,223,57);		
		btnFont.hidden=NO;
		
	}
	
	
	if (BtnEncode.selected==TRUE) {
		
		dateLabel.hidden=NO;
		TimeLabel.hidden=NO;	
		imageBottomBar.hidden=NO;
		BtnFacebook.hidden=NO;
		BtnTwitter.hidden=NO;
		BtnMail.hidden=NO;
		BtnTrash.hidden=NO;
		if (BtnTrash.selected==TRUE) {
			imageBottomBar.hidden=YES;
			BtnFacebook.hidden=YES;
			BtnTwitter.hidden=YES;
			BtnMail.hidden=YES;
			BtnTrash.hidden=YES;
		}
	}else{
		
	}
    
    //--*
    
   
    
    
    //scrolldata orientaiton
    scrolldata.frame=CGRectMake(40,505 ,600,350);
    [scrolldata bringSubviewToFront:ScrllLabel];
    scrolldata.contentSize = CGSizeMake(0,CGRectGetHeight(scrolldata.frame)+40); 
    imageview.frame=CGRectMake(40, 10, 110, 110);
    ScrllLabel.frame=CGRectMake(40, 130, 550, 150);
    dateLabel.frame=CGRectMake(180, 35, 350, 20);
    TimeLabel.frame=CGRectMake(180, 60, 350, 20);
      actionButton.frame=CGRectMake(50, 285, 130, 70);
    
    
[activetxt resignFirstResponder];
[activetxtview resignFirstResponder];
	
}

-(void)setFrameOrientation_LandScap
{	
    
       

    
    
	dateLabel.hidden=YES;
	TimeLabel.hidden=YES;
	ScrllLabel.hidden=YES;
	imageBottomBar.hidden=YES;
	BtnFacebook.hidden=YES;	
	BtnMail.hidden=YES;
	BtnTrash.hidden=YES;
	BtnTwitter.hidden=YES;	
	imageSeperator.hidden=YES;
	btnFont.hidden=YES;
	txtDisplayWEb.hidden=YES;
	ButonBack.hidden=YES;
	/*
	 
	 if(firstTime == TRUE)
	{
		firstTime = FALSE;		
		imageButonBack.frame=CGRectMake(35,40,238,709);
		ButonBack.frame=CGRectMake(34,2,40,40);
		BtnURL.frame=CGRectMake(35,78,234,84);
		BtnContact.frame=CGRectMake(35,162,234,84);
		BtnEvent.frame=CGRectMake(35,246,234,84);
		BtnMap.frame=CGRectMake(35,329,234,84);
		BtnSMS.frame=CGRectMake(35,412,234,84);
		BtnPhone.frame=CGRectMake(35,495,234,84);
		BtnEmail.frame=CGRectMake(35,578,234,84);
		BtnText.frame=CGRectMake(35,661, 234,87);
		
		//view frameing
		EmailView.frame=CGRectMake(300,80,630,350);
		ViewText.frame=CGRectMake(300,80,630,300);
		PhoneView.frame=CGRectMake(300,80, 630,300);
		URLView.frame=CGRectMake(300,80, 630,300);	
		Mapview.frame=CGRectMake(300,80,630,300);
		SMSView.frame=CGRectMake(300,80,630,300);
		EventView.frame=CGRectMake(300,80,630,300);
		ContactView.frame=CGRectMake(300,80,630,280);
		
		imageview.frame=CGRectMake(300,90, 130,130);
		ScrllLabel.frame=CGRectMake(290,250,600,300);
		BtnFacebook.frame=CGRectMake(400,702, 42,43);
		BtnTwitter.frame=CGRectMake(530,702, 42,43);
		BtnMail.frame=CGRectMake(660,702, 42,43);
		BtnTrash.frame=CGRectMake(790,702, 42,43);	
		
		LblTop.frame=CGRectMake(436,5,64,30);
		imageBottomBar.frame=CGRectMake(270,700,700,60);
		BtnEncode.frame=CGRectMake(500,500,205,57);		
		
	}
	else {
		
		if(appDel.ori == UIInterfaceOrientationLandscapeLeft ||
		   appDel.ori == UIInterfaceOrientationLandscapeRight)
		{
			ButonBack.frame=CGRectMake(34,2,40,40);
			imageButonBack.frame=CGRectMake(35,40,238,709);
			BtnURL.frame=CGRectMake(35,78,234,84);
			BtnContact.frame=CGRectMake(35,162,234,84);
			BtnEvent.frame=CGRectMake(35,246,234,84);
			BtnMap.frame=CGRectMake(35,329,234,84);
			BtnSMS.frame=CGRectMake(35,412,234,84);
			BtnPhone.frame=CGRectMake(35,495,234,84);
			BtnEmail.frame=CGRectMake(35,578,234,84);
			BtnText.frame=CGRectMake(35,661, 234,87);
			
			//view frameing
			EmailView.frame=CGRectMake(300,80,630,350);
			ViewText.frame=CGRectMake(300,80,630,300);
			PhoneView.frame=CGRectMake(300,80, 630,300);
			URLView.frame=CGRectMake(300,80, 630,300);	
			Mapview.frame=CGRectMake(300,80,630,300);
			SMSView.frame=CGRectMake(300,80,630,300);
			EventView.frame=CGRectMake(300,80,630,300);
			ContactView.frame=CGRectMake(300,80,630,280);
			
			imageview.frame=CGRectMake(300,90, 130,130);
			ScrllLabel.frame=CGRectMake(290,250,600,300);
			BtnFacebook.frame=CGRectMake(400,702, 42,43);
			BtnTwitter.frame=CGRectMake(530,702, 42,43);
			BtnMail.frame=CGRectMake(660,702, 42,43);
			BtnTrash.frame=CGRectMake(790,702, 42,43);	
			
			LblTop.frame=CGRectMake(436,5,64,30);
			imageBottomBar.frame=CGRectMake(270,700,700,60);
			BtnEncode.frame=CGRectMake(500,500,205,57);
		}
		if(oncePort == TRUE)
		{
			ButonBack.frame=CGRectMake(14,2,40,40);
			imageButonBack.frame=CGRectMake(13,40,238,709);
			BtnURL.frame=CGRectMake(13,78,234,84);
			BtnContact.frame=CGRectMake(13,162,234,84);
			BtnEvent.frame=CGRectMake(13,246,234,84);
			BtnMap.frame=CGRectMake(13,329,234,84);
			BtnSMS.frame=CGRectMake(13,412,234,84);
			BtnPhone.frame=CGRectMake(13,495,234,84);
			BtnEmail.frame=CGRectMake(13,578,234,84);
			BtnText.frame=CGRectMake(13,661, 234,87);
			
			//view frameing
			EmailView.frame=CGRectMake(277,80,630,350);
			ViewText.frame=CGRectMake(277,80,630,300);
			PhoneView.frame=CGRectMake(277,80,630,300);
			URLView.frame=CGRectMake(277,80, 630,300);	
			Mapview.frame=CGRectMake(277,80,630,300);
			SMSView.frame=CGRectMake(277,80,630,300);
			EventView.frame=CGRectMake(277,80,630,300);
			ContactView.frame=CGRectMake(277,80,630,280);
			
			imageview.frame=CGRectMake(277,90, 130,130);
			ScrllLabel.frame=CGRectMake(267,250,600,300);
			BtnFacebook.frame=CGRectMake(400,702, 42,43);
			BtnTwitter.frame=CGRectMake(530,702, 42,43);
			BtnMail.frame=CGRectMake(660,702, 42,43);
			BtnTrash.frame=CGRectMake(790,702, 42,43);	
			
			LblTop.frame=CGRectMake(414,5,64,30);
			imageBottomBar.frame=CGRectMake(246,700,700,60);
			BtnEncode.frame=CGRectMake(478,500,205,57);
		}
		else {
			ButonBack.frame=CGRectMake(34,2,40,40);
			imageButonBack.frame=CGRectMake(35,40,238,709);
			BtnURL.frame=CGRectMake(35,78,234,84);
			BtnContact.frame=CGRectMake(35,162,234,84);
			BtnEvent.frame=CGRectMake(35,246,234,84);
			BtnMap.frame=CGRectMake(35,329,234,84);
			BtnSMS.frame=CGRectMake(35,412,234,84);
			BtnPhone.frame=CGRectMake(35,495,234,84);
			BtnEmail.frame=CGRectMake(35,578,234,84);
			BtnText.frame=CGRectMake(35,661, 234,87);
			
			//view frameing
			EmailView.frame=CGRectMake(300,80,630,350);
			ViewText.frame=CGRectMake(300,80,630,300);
			PhoneView.frame=CGRectMake(300,80, 630,300);
			URLView.frame=CGRectMake(300,80, 630,300);	
			Mapview.frame=CGRectMake(300,80,630,300);
			SMSView.frame=CGRectMake(300,80,630,300);
			EventView.frame=CGRectMake(300,80,630,300);
			ContactView.frame=CGRectMake(300,80,630,280);
			
			imageview.frame=CGRectMake(300,90, 130,130);
			ScrllLabel.frame=CGRectMake(290,250,600,300);
			BtnFacebook.frame=CGRectMake(400,702, 42,43);
			BtnTwitter.frame=CGRectMake(530,702, 42,43);
			BtnMail.frame=CGRectMake(660,702, 42,43);
			BtnTrash.frame=CGRectMake(790,702, 42,43);	
			
			LblTop.frame=CGRectMake(436,5,64,30);
			imageBottomBar.frame=CGRectMake(270,700,700,60);
			BtnEncode.frame=CGRectMake(500,500,205,57);
		}		
	}	
	*/
	

	
	ButonBack.frame=CGRectMake(14,2,40,40);
	imageButonBack.frame=CGRectMake(13,40,238,709);
	BtnURL.frame=CGRectMake(13,78,234,84);
	BtnContact.frame=CGRectMake(13,162,234,84);
	BtnEvent.frame=CGRectMake(13,246,234,84);
	BtnMap.frame=CGRectMake(13,329,234,84);
	BtnSMS.frame=CGRectMake(13,412,234,84);
	BtnPhone.frame=CGRectMake(13,495,234,84);
	BtnEmail.frame=CGRectMake(13,578,234,84);
	BtnText.frame=CGRectMake(13,661, 234,87);
	
	//view frameing
	EmailView.frame=CGRectMake(277,80,630,350);
	ViewText.frame=CGRectMake(277,80,630,300);
	PhoneView.frame=CGRectMake(277,80,630,300);
	URLView.frame=CGRectMake(277,80, 630,300);	
	Mapview.frame=CGRectMake(277,80,630,300);
	SMSView.frame=CGRectMake(277,80,630,300);
	EventView.frame=CGRectMake(277,80,630,300);
	ContactView.frame=CGRectMake(277,80,630,280);
	
	imageview.frame=CGRectMake(277,90, 130,130);
	ScrllLabel.frame=CGRectMake(267,250,600,400);
	BtnFacebook.frame=CGRectMake(400,702, 42,43);
	BtnTwitter.frame=CGRectMake(530,702, 42,43);
	BtnMail.frame=CGRectMake(660,702, 42,43);
	BtnTrash.frame=CGRectMake(790,702, 42,43);	
	
	LblTop.frame=CGRectMake(414,5,64,30);
	imageBottomBar.frame=CGRectMake(246,700,700,60);
	BtnEncode.frame=CGRectMake(478,500,205,57);
	
    ImageTop.image=[UIImage imageNamed:@"_0006_top-red-band910.png"];
	ImageTop.frame=CGRectMake(0,0,1004,48);
	
	imageButonBack.image=[UIImage imageNamed:@"Grey-Top.png"];	
	dateLabel.frame=CGRectMake(450,100,320,30);
	TimeLabel.frame=CGRectMake(450,120,138,30);
	
	btnurlopen.frame=CGRectMake(10,5,500,50);
	
	txtViewDisplay.frame=CGRectMake(20,0,500,200);
	txtDisplayWEb.frame=CGRectMake(20,5, 480,1000);
	
	//Images for Textfeild in Landscape
	[self Images_Landscape_Text];
	
	//EMAIL view	
    LblEmail.frame=CGRectMake(0,0,200,15);	
	txtemail1.frame=CGRectMake(7,30,615,44);
	txtemail2.frame=CGRectMake(7,85,615,44);
	txtviewemail3.frame=CGRectMake(2,139,615,134);
	imgEmail.frame=CGRectMake(0,139,620,134);
	ImageEmail1.frame=CGRectMake(0,30,620,44);
	ImageEmail2.frame=CGRectMake(0,85,620,44);
	
	//VIEWTEXT	
	LblText.frame=CGRectMake(0,0,200,15);
	Ego_Textview.frame=CGRectMake(7,30,615,264);
	imgtxtBack.frame=CGRectMake(0,30,620,264);
	ScrlText.frame=CGRectMake(12, 35, 615, 264);
	LblPlaceholder.frame=CGRectMake(14,30,90,40);	
	btnFont.frame=CGRectMake(390,500, 205, 58);
	
	//Phoneview		
	Lblphone.frame=CGRectMake(0,0,200,15);
	txtPhone.frame=CGRectMake(7,30,615,44);
	ImagePhone.frame=CGRectMake(0,30,620,44);
	
	//URLVIEW		
	LblUrl.frame=CGRectMake(0,0,200,15);	
    txturl1.frame=CGRectMake(7,30,615,44);
	ImageUrl.frame=CGRectMake(0,30,620,44);	
	BtnUrl2.frame=CGRectMake(7,85,460,44);
	Imagecheck.frame=CGRectMake(580,100,13,13);
	ImageUrl1.frame=CGRectMake(0,85,620,44);
	LblUrl2.frame=CGRectMake(7,85,600,44);
	
	//MAPVIEW	
	LblMap.frame=CGRectMake(0,0,200,15);
	Sclmap.frame=CGRectMake(0,30,630,270);
    Txtmap1.frame=CGRectMake(7,0,615,34);
	Txtmap2.frame=CGRectMake(7,44,615,34);
	Txtmap3.frame=CGRectMake(7,84,615,34);
	Txtmap4.frame=CGRectMake(7,124,615,34);
	Txtmap5.frame=CGRectMake(7,164,615,34);
	Txtmap6.frame=CGRectMake(7,214,615,44);
	ImageMap1.image=[UIImage imageNamed:@"Land_Adress.png"];
	ImageMap1.frame=CGRectMake(0,0,620,205);
	ImageMap2.frame=CGRectMake(0,215,620,44);
	
	
	//SMSView	
	Lblsms.frame=CGRectMake(0,0,200,15);
    Txtsms.frame=CGRectMake(7,30,615,44);
	txtsmsMessage.frame=CGRectMake(0,85,615,134);
	imgsmsBack.frame=CGRectMake(0,85,620,134);
	Imagesms1.frame=CGRectMake(0,30,620,44);
	
	
	//EVENTview
	LblEvent.frame=CGRectMake(0,0,200,15);
	SclEvent.frame=CGRectMake(0,30,630,280);
	txtevent1.frame=CGRectMake(7, 0,615,44);
	ImageEventText.frame=CGRectMake(3,55,615,82);
	txtevent3.frame=CGRectMake(7,150,615,34);
	txtevent4.frame=CGRectMake(7,192,615,34);
	txtevent5.frame=CGRectMake(7,232,615,34);
	txtevent6.frame=CGRectMake(7,272,615,34);
	txtevent7.frame=CGRectMake(7,312,615,34);
	txtevent8.frame=CGRectMake(7,362,615,44);
	
	BtnStarts.frame=CGRectMake(10,67,479,20);	
	BtnEnds.frame=CGRectMake(10,106,490,20);
	Lblstart.frame=CGRectMake(11,67,479,20);
	LblEnd.frame=CGRectMake(11,106,490,20);
	LblDate1.frame=CGRectMake(100,67,200,20);
	LblDate2.frame=CGRectMake(100,106,200,20);
	LblTime1.frame=CGRectMake(430,67,100,20);
	LblTime2.frame=CGRectMake(430,106,100,20);
	Imageevent1.frame=CGRectMake(0,00,620,44);
	Imageevent3.frame=CGRectMake(0,147,620,205);
	ImageEvent4.frame=CGRectMake(0,362,620,44);
	SclEvent.userInteractionEnabled = TRUE;
	SclEvent.delegate = self;
	SclEvent.scrollEnabled = TRUE;
    SclEvent.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	SclEvent.contentSize=CGSizeMake(0,480);
	
	//Pop Coding...	
    scrollView.userInteractionEnabled = TRUE;
	scrollView.delegate = self;
	scrollView.scrollEnabled = TRUE;
    //scrollView.scrollsToTop = YES;
    scrollView.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //scrollView.alwaysBounceVertical = TRUE; 
    
	//Contactview	
	LblContact.frame=CGRectMake(0,0,200,15);	
	[scrollView setFrame:CGRectMake(0,30,635,280)];
	
	
    //Bottom Buttons
	[BtnURL setImage:[UIImage imageNamed:@"Land_url_unselected.png"] forState:UIControlStateNormal];
	[BtnContact setImage:[UIImage imageNamed:@"Land_Contact_unselectect.png"] forState:UIControlStateNormal];
	[BtnEvent setImage:[UIImage imageNamed:@"Land_Event_unselected.png"] forState:UIControlStateNormal];
	[BtnMap setImage:[UIImage imageNamed:@"Land_Map_unselected.png"] forState:UIControlStateNormal];
	[BtnSMS setImage:[UIImage imageNamed:@"Land_sms_unselected.png"] forState:UIControlStateNormal];
	[BtnPhone setImage:[UIImage imageNamed:@"Land_phone_unselected.png"] forState:UIControlStateNormal];	
	[BtnEmail setImage:[UIImage imageNamed:@"Land_Email_unselected.png"] forState:UIControlStateNormal];
	[BtnText setImage:[UIImage imageNamed:@"Land_Text_unselected-1.png"] forState:UIControlStateNormal];
	
	if (CounterBtn==0) {//URL		
		imageSeperator.hidden=YES;		
		txtViewDisplay.hidden=NO;
       // txtViewDisplay.backgroundColor=[[UIColor greenColor] colorWithAlphaComponent:0.5];
		txtDisplayWEb.hidden=YES;	
		
		[BtnURL setImage:[UIImage imageNamed:@"Land_url_selected.png"] forState:UIControlStateNormal];
		
		/*[BtnContact setImage:[UIImage imageNamed:@"Land_Contact_unselectect.png"] forState:UIControlStateNormal];
		 [BtnEvent setImage:[UIImage imageNamed:@"Land_Event_unselected.png"] forState:UIControlStateNormal];
		 [BtnMap setImage:[UIImage imageNamed:@"Land_Map_unselected.png"] forState:UIControlStateNormal];
		 [BtnSMS setImage:[UIImage imageNamed:@"Land_sms_unselected.png"] forState:UIControlStateNormal];
		 [BtnPhone setImage:[UIImage imageNamed:@"Land_phone_unselected.png"] forState:UIControlStateNormal];	
		 [BtnEmail setImage:[UIImage imageNamed:@"Land_Email_unselected.png"] forState:UIControlStateNormal];
		 [BtnText setImage:[UIImage imageNamed:@"Land_Text_unselected.png"] forState:UIControlStateNormal];
		 */
	}else if (CounterBtn==1) {//contact
		
		[self reloadUI];
		
		txtViewDisplay.hidden=YES;
		txtDisplayWEb.hidden=NO;
		
		//[BtnURL setImage:[UIImage imageNamed:@"Land_url_unselected.png"] forState:UIControlStateNormal];
		[BtnContact setImage:[UIImage imageNamed:@"Land_Contact_selected.png"] forState:UIControlStateNormal];
		/*[BtnEvent setImage:[UIImage imageNamed:@"Land_Event_unselected.png"] forState:UIControlStateNormal];
		 [BtnMap setImage:[UIImage imageNamed:@"Land_Map_unselected.png"] forState:UIControlStateNormal];
		 [BtnSMS setImage:[UIImage imageNamed:@"Land_sms_unselected.png"] forState:UIControlStateNormal];
		 [BtnPhone setImage:[UIImage imageNamed:@"Land_phone_unselected.png"] forState:UIControlStateNormal];	
		 [BtnEmail setImage:[UIImage imageNamed:@"Land_Email_unselected.png"] forState:UIControlStateNormal];
		 [BtnText setImage:[UIImage imageNamed:@"Land_Text_unselected.png"] forState:UIControlStateNormal];
		 */
	}else if (CounterBtn==2) {//event
		txtViewDisplay.hidden=YES;			
		txtDisplayWEb.hidden=NO;
		
		imageSeperator.hidden=YES;
		[BtnEvent setImage:[UIImage imageNamed:@"Land_event_selected.png"] forState:UIControlStateNormal];
		
	}else if (CounterBtn==3) {//map
		
		txtDisplayWEb.hidden=NO;
		txtViewDisplay.hidden=YES;
		
		imageSeperator.hidden=YES;
		[BtnMap setImage:[UIImage imageNamed:@"Land_Map_selected.png"] forState:UIControlStateNormal];
	}else if (CounterBtn==4) {		//sms
		imageSeperator.hidden=YES;
		txtViewDisplay.hidden=YES;
		txtDisplayWEb.hidden=NO;
		[BtnSMS setImage:[UIImage imageNamed:@"Land_sms_selected.png"] forState:UIControlStateNormal];
	}else if (CounterBtn==5) { //phone
		imageSeperator.hidden=YES;
		txtViewDisplay.hidden=YES;
		txtDisplayWEb.hidden=NO;
		[BtnPhone setImage:[UIImage imageNamed:@"Land_PhoneButton_selected.png"] forState:UIControlStateNormal];	
		
	}else if (CounterBtn==6) {//mail
		
		txtViewDisplay.hidden=YES;
		txtDisplayWEb.hidden=NO;
		[BtnEmail setImage:[UIImage imageNamed:@"Land_Email_selected.png"] forState:UIControlStateNormal];
		//[BtnText setImage:[UIImage imageNamed:@"Land_Text_unselected.png"] forState:UIControlStateNormal];
		
	}else if (CounterBtn==7) {//text		
		txtViewDisplay.hidden=YES;			
		txtDisplayWEb.hidden=NO;		
		BtnEncode.frame=CGRectMake(610,500, 205,58);
		CGRect containerFrame1 ;

        containerFrame1 = CGRectMake(12,36,imgtxtBack.frame.size.width-30,imgtxtBack.frame.size.height-30);
        
        self.egoTextView.contentOffset = CGPointMake(0,0);
		self.egoTextView.frame = containerFrame1;
		
		//self.egoTextView.frame=CGRectMake(12,35,imgtxtBack.frame.size.width-20,imgtxtBack.frame.size.height-30);
		if([ResultString length]>0){
			[self.egoTextView reloadText:self.egoTextView.attributedString.string];
			[self.egoTextView resignFirstResponder];
		}
        
		//[self.egoTextView framecontentview];
		[BtnText setImage:[UIImage imageNamed:@"Land_Text_selected.png"] forState:UIControlStateNormal];
		btnFont.hidden=NO;		
	}	
	
	if (BtnEncode.selected==TRUE) {
		ButonBack.hidden=NO;
		ScrllLabel.hidden=NO;
		imageBottomBar.hidden=NO;
		dateLabel.hidden=NO;
		TimeLabel.hidden=NO;
		
		BtnFacebook.hidden=NO;
		BtnTwitter.hidden=NO;
		BtnMail.hidden=NO;
		BtnTrash.hidden=NO;
		BtnEncode.hidden=YES;
		btnFont.hidden=YES;
		if (BtnTrash.selected==TRUE) {
			BtnEncode.hidden=NO;
			
			if (CounterBtn==0) {
				URLView.hidden=NO;
			}else if (CounterBtn==1) {
				ContactView.hidden=NO;
			}else if (CounterBtn==2) {
				EventView.hidden=NO;
			}else if (CounterBtn==3) {
				Mapview.hidden=NO;
			}else if (CounterBtn==4) {
				SMSView.hidden=NO;
			}else if (CounterBtn==5) {
				PhoneView.hidden=NO;
			}else if (CounterBtn==6) {
				EmailView.hidden=NO;
			}else if (CounterBtn==7) {
				ViewText.hidden=NO;	
			}			
			imageBottomBar.hidden=YES;
		}else{
			
			EmailView.hidden=YES;
			ViewText.hidden=YES;		
			URLView.hidden=YES;
			ContactView.hidden=YES;
			Mapview.hidden=YES;
			SMSView.hidden=YES;
			PhoneView.hidden=YES;
			EventView.hidden=YES;
		}
	}else{
		
	}
    
    //--*
    //scroldata orientaon
    scrolldata.frame=CGRectMake(250,40 ,680,600);
    
    [scrolldata bringSubviewToFront:ScrllLabel];
    
    // scrolldata.contentSize = CGSizeMake(0,30); 
    imageview.frame=CGRectMake(40, 30, 120, 120);
    ScrllLabel.frame=CGRectMake(40, 170, 550, 220);
    dateLabel.frame=CGRectMake(180, 35, 350, 20);
    TimeLabel.frame=CGRectMake(180, 60, 350, 20);
    actionButton.frame=CGRectMake(50, 400, 130, 70);
    
    
	[activetxt resignFirstResponder];
	[activetxtview resignFirstResponder];
	
}



#pragma mark BackButtonLandscape
-(IBAction)BackButtonClick:(id) sender{
	
	ButonBack.hidden=YES;
	BtnEncode.selected=FALSE;
	BtnEncode.enabled=YES;
	BtnEncode.hidden=NO;
	
	imageview.hidden=YES;
    //--*
    scrolldata.hidden=YES;
    actionButton.hidden=YES;
	ScrllLabel.hidden=YES;
	dateLabel.hidden=YES;
	TimeLabel.hidden=YES;

	imageBottomBar.hidden=YES;
	BtnFacebook.hidden=YES;
	BtnTrash.hidden=YES;
	BtnTwitter.hidden=YES;
	BtnMail.hidden=YES;
	
	
	
	if (CounterBtn==0) {//URL
		URLView.hidden=NO;
		ContactView.hidden=YES;
		Mapview.hidden=YES;
		SMSView.hidden=YES;
		PhoneView.hidden=YES;
		EventView.hidden=YES;
		EmailView.hidden=YES;
		ViewText.hidden=YES;
	}else if (CounterBtn==1) {//Contact
		URLView.hidden=YES;
		ContactView.hidden=NO;
		Mapview.hidden=YES;
		SMSView.hidden=YES;
		PhoneView.hidden=YES;
		EventView.hidden=YES;
		EmailView.hidden=YES;
		ViewText.hidden=YES;
	}else if (CounterBtn==2) {//Event
		URLView.hidden=YES;
		ContactView.hidden=YES;
		Mapview.hidden=YES;
		SMSView.hidden=YES;
		PhoneView.hidden=YES;
		EventView.hidden=NO;
		EmailView.hidden=YES;
		ViewText.hidden=YES;
	}else if (CounterBtn==3) { //map
		URLView.hidden=YES;
		ContactView.hidden=YES;
		Mapview.hidden=NO;
		SMSView.hidden=YES;
		PhoneView.hidden=YES;
		EventView.hidden=YES;
		EmailView.hidden=YES;
		ViewText.hidden=YES;
	}else if (CounterBtn==4) { //sms
		URLView.hidden=YES;
		ContactView.hidden=YES;
		Mapview.hidden=YES;
		SMSView.hidden=NO;
		PhoneView.hidden=YES;
		EventView.hidden=YES;
		EmailView.hidden=YES;
		ViewText.hidden=YES;
	}else if (CounterBtn==5) { //phone
		URLView.hidden=YES;
		ContactView.hidden=YES;
		Mapview.hidden=YES;
		SMSView.hidden=YES;
		PhoneView.hidden=NO;
		EventView.hidden=YES;
		EmailView.hidden=YES;
		ViewText.hidden=YES;
	}else if (CounterBtn==6) { //email
		URLView.hidden=YES;
		ContactView.hidden=YES;
		Mapview.hidden=YES;
		SMSView.hidden=YES;
		PhoneView.hidden=YES;
		EventView.hidden=YES;
		EmailView.hidden=NO;
		ViewText.hidden=YES;
	}else if (CounterBtn==7) { //text
		btnFont.hidden=NO;
		URLView.hidden=YES;
		ContactView.hidden=YES;
		Mapview.hidden=YES;
		SMSView.hidden=YES;
		PhoneView.hidden=YES;
		EventView.hidden=YES;
		EmailView.hidden=YES;
		ViewText.hidden=NO;
	}
	
	
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
	if(interfaceOrientation == UIInterfaceOrientationPortrait ||
	   interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
	{
		[self setFrameOrientation_Portrait];
		return YES;
	}
	else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation== UIInterfaceOrientationLandscapeRight)
	{
		[self setFrameOrientation_LandScap];
		return YES;
	}
	else {
		
		return NO;
	}
	}
	else 
	{
		return NO;
	}
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
	//[txtViewDisplay resignFirstResponder];
	if([textView isEqual:txtViewDisplay])
		return NO;
	else 
		return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
if (CounterBtn==0) {
	Imagecheck.hidden=YES;
}
    if (buttonIndex == 0 && (alertView.tag==201 || alertView.tag==301) )
    {
        
        ABAddressBookRef addressBook = ABAddressBookCreate(); 
        
        ABRecordRef person = ABPersonCreate();
        
        if(alertView.tag==201)
        ABRecordSetValue(person, kABPersonFirstNameProperty, [[arrField objectAtIndex:0] valueForKey:@"value"]  , nil);
        //ABRecordSetValue(person, kABPersonLastNameProperty, @"hi", nil);
        
        ABMutableMultiValueRef phoneNumberMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        
        if(alertView.tag==201)
        ABMultiValueAddValueAndLabel(phoneNumberMultiValue,[[arrField objectAtIndex:1] valueForKey:@"value"] , kABHomeLabel, nil);
        if(alertView.tag==301)
         ABMultiValueAddValueAndLabel(phoneNumberMultiValue,txtPhone.text , kABHomeLabel, nil);
        // ABMultiValueAddValueAndLabel(phoneNumberMultiValue, @"9876543210", kABPersonPhoneMobileLabel, nil);
        // ABMultiValueAddValueAndLabel(phoneNumberMultiValue, @"04022222222", kABWorkLabel, nil);
        ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumberMultiValue, nil);
        
        //ABMutableMultiValueRef emailMultiValue = ABMultiValueCreateMutable(kABPersonEmailProperty);
        // ABMultiValueAddValueAndLabel(emailMultiValue, @"whatever@gmail.com", kABWorkLabel, nil);
        // ABRecordSetValue(person, kABPersonEmailProperty, emailMultiValue, nil);
        
        // NSDictionary *dictionary = [[NSDictionary alloc] initWithObjects: [NSArray arrayWithObjects:@"1234 Whatever Street", @"Hyderabad", @"AP", @"INDIA", @"500008", nil] forKeys: [NSArray arrayWithObjects: (NSString *)kABPersonAddressStreetKey, (NSString *)kABPersonAddressCityKey, (NSString *)kABPersonAddressStateKey, (NSString *)kABPersonAddressCountryKey, (NSString *)kABPersonAddressZIPKey, nil]];
        // ABMultiValueRef addressMultiValue = ABMultiValueCreateMutable(kABDictionaryPropertyType);
        // ABMultiValueAddValueAndLabel(addressMultiValue, (CFDictionaryRef *)dictionary, kABWorkLabel, nil);
        //  ABRecordSetValue(person, kABPersonAddressProperty, addressMultiValue, nil); ABRecordCopyValue(person, kABPersonAddressProperty);
        
        ABAddressBookAddRecord(addressBook, person, nil);
        ABAddressBookSave(addressBook, nil);
        
        CFRelease(person);
        //  CFRelease(addressMultiValue);
        CFRelease(phoneNumberMultiValue);
        // CFRelease(emailMultiValue);
        //  [dictionary release];
        
        
        
        UIAlertView *alertviewcon=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Contact Added successfully!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertviewcon show];
        [alertviewcon release];

         
    }
	
    if(buttonIndex==0 && alertView.tag==401)
    {
        
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        
        EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
        NSString *evntname=txtevent1.text;
        evntname=[evntname stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        event.title=evntname;
        
        NSString *stdate=LblDate1.text;
        
    stdate=[stdate substringFromIndex:4];
        
        NSString *endate=LblDate2.text;
        
    endate=[endate substringFromIndex:4];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"M/d/y h:mm a";
        
        NSDate *date = [formatter dateFromString:stdate];
        
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        formatter1.dateFormat = @"M/d/y h:mm a";
        
        NSDate *date1 = [formatter dateFromString:endate];
        event.startDate = date;
        event.endDate = date1;
        
     //   NSLog(@"final string:%@",tmpst);
       // event.notes=tmpst;
        
        
        
        
        //NSLog(@"start date is %@,end date is %@",startdate,enddate);
        
        
        
        
        
        
        //[event setAlarms:[NSArray arrayWithObjects:@"At time of event",nil]];
        
        
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        
        [eventStore saveEvent:event span:EKSpanThisEvent error:&err]; 
        if(!err)
        {
            
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:event.title message:@"Event Added successfully!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertview show];
            [alertview release];
            
        }
        else {
            NSLog(@"error is %@",err);  
        }
        
    

    }
    
    
}


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
	if (Imagecheck.hidden==NO) {
		Imagecheck.hidden=YES;
		LblUrl2.font = [UIFont fontWithName:@"Helvetica" size:18];
		LblUrl2.textColor=[UIColor lightGrayColor];
		LblUrl2.text=@"Shorten URL";
	}else{
	BOOL inter;
	inter=[self checkInternetConnection];
			
	if (inter) {
		[txturl1 resignFirstResponder];
		Imagecheck.hidden=NO;
		if ([txturl1.text rangeOfString:@"http://"].location == NSNotFound && [txturl1.text rangeOfString:@"https://"].location == NSNotFound)
		{
			NSString* str=[@"http://" stringByAppendingFormat:txturl1.text];
			txturl1.text=str;
			
		}
		if(![self validateURL:txturl1.text] && CounterBtn==0)
		{
			UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter valid URL" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
			[alert release];
			return;
		}
		[self start];
		
	}
	   
	
	else{	
		
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



#pragma mark XML PARSING FOR Shorten URL
- (void)start
{
	NSString *URLString =[NSString stringWithFormat:@"http://api.bit.ly/v3/shorten?login=krenmarketing&apikey=R_c39f6d58acd30fdfb10b943062aa58b5&longUrl=%@&format=xml",txturl1.text];
	//NSString *URLString = @"http://api.bit.ly/v3/shorten?login=krenmarketing&apikey=R_c39f6d58acd30fdfb10b943062aa58b5&longUrl=http://www.facebook.com&format=xml";
	//URLString = [NSString stringWithFormat:@"http://www.google.com/ig/api?weather=%@", currentLocation];
	NSLog(@"urlstring: %@", URLString);
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (theConnection) {
		
		responseData = [[NSMutableData alloc] retain];
	}
	
	
	
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
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
		LblUrl2.textColor=[UIColor blackColor];
		LblUrl2.text=  currentName;
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


- (void)viewDidUnload
{
	[super viewDidUnload];
}



- (void)dealloc
{
   
	[super dealloc];
   
}


@end
