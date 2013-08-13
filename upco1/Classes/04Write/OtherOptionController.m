//
//  OtherOptionController.m
//  New_Task
//
//  Created by Paras Gandhi on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "OtherOptionController.h"
#import "QRGenViewController.h"

@implementation OtherOptionController
@synthesize delegate,tblArr;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}




#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		 tblView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
		nvBar.hidden = TRUE;
	}
	else 
	{
		 tblView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, 320, 430) style:UITableViewStyleGrouped];
		nvBar.hidden = FALSE;
	}
   
   // tblView.backgroundColor = [UIColor redColor];
	[tblView setDelegate:self];
	[tblView setDataSource:self];
    
    UIBarButtonItem *backButton = [[[UIBarButtonItem alloc]
									initWithTitle: @"Cancel"
									style:UIBarButtonItemStyleBordered
									target:self action:@selector(onBackClick)] autorelease];	
	self.navigationItem.leftBarButtonItem = backButton;
    
    UIBarButtonItem *SaveButton = [[[UIBarButtonItem alloc]
									initWithTitle: @"Done"
									style:UIBarButtonItemStyleBordered
									target:self action:@selector(onSaveClick)] autorelease];	
	self.navigationItem.rightBarButtonItem = SaveButton;
    
	
    [[self view] addSubview:tblView];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
	}
	else 
	{
		//UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//		btnDone.frame = CGRectMake(20, 360, 50, 50);
//		[btnDone setTitle:@"Done" forState:UIControlStateNormal];
//		[btnDone addTarget:self action:@selector(DoneBtnClicked) forControlEvents:UIControlEventTouchUpInside];
//		[self.view addSubview:btnDone];
	}
	
}
-(IBAction)DoneBtnClicked
{
	[self dismissModalViewControllerAnimated:TRUE];
	[delegate doneClicked:[tblArr retain]];
}

-(IBAction)CancelBtnClicked
{
	[self dismissModalViewControllerAnimated:TRUE];
}

- (void)viewWillAppear:(BOOL)animated
{
	cnt=0;
    [super viewWillAppear:animated];
    [tblView reloadData];
	
    
}
-(void) onBackClick
{	 
	for(int i=0;i<cnt;i++){
		NSLog(@"selected===>%d       i==%d",selctedrow[i],i);
		if([[[tblArr objectAtIndex:selctedrow[i]]valueForKey:@"isactive"] isEqualToString:@"yes"])
		{
			[[tblArr objectAtIndex:selctedrow[i]] setObject:@"no" forKey:@"isactive"];
		}
		else{
			[[tblArr objectAtIndex:selctedrow[i]] setObject:@"yes" forKey:@"isactive"];
		}
		
	}
	[tblView reloadData];
    [delegate dismissPopOver];
}
-(void)onSaveClick{
    
	// [delegate completeSelection:[tblArr retain]];
    [delegate doneClicked:[tblArr retain]];
    
} 

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - TableView Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if([tblArr count]>0)
    {
		if (section==1) 
			return 2;
		else 
			return 5;
    }
    else 
        return 0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@", tblArr);
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    NSString *cellvalue;
    
    if (indexPath.section == 0) 
	{
        cellvalue = [[tblArr objectAtIndex:indexPath.row+2] valueForKey:@"placeholder"];
        cell.textLabel.text= cellvalue;
		if([[[tblArr objectAtIndex:indexPath.row+2]valueForKey:@"isactive"] isEqualToString:@"yes"])
			cell.accessoryType=UITableViewCellAccessoryCheckmark;
		else 
			cell.accessoryType=UITableViewCellAccessoryNone;
		
    }
	else
	{
        cellvalue = [[tblArr objectAtIndex:indexPath.row+7] valueForKey:@"placeholder"];
        cell.textLabel.text= cellvalue;
		if([[[tblArr objectAtIndex:indexPath.row+7]valueForKey:@"isactive"] isEqualToString:@"yes"])
			cell.accessoryType=UITableViewCellAccessoryCheckmark;
		else 
			cell.accessoryType=UITableViewCellAccessoryNone;
    }
	
    cellSelectedValue = cell.textLabel.text;
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    int newRow = 0;
	
	newRow = [indexPath row];
	
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
    NSLog ( @"You selected row: %@", cell.textLabel.text);
	if (indexPath.section == 0) 
	{
		selctedrow[cnt]=[indexPath row]+2;
		if([[[tblArr objectAtIndex:indexPath.row+2]valueForKey:@"isactive"] isEqualToString:@"yes"])
		{
			[[tblArr objectAtIndex:indexPath.row+2] setObject:@"no" forKey:@"isactive"];
			[[tblArr objectAtIndex:indexPath.row+2] setObject:@"" forKey:@"value"];
			cell.accessoryType=UITableViewCellAccessoryNone;
		}
		else 
		{
			[[tblArr objectAtIndex:indexPath.row+2] setObject:@"yes" forKey:@"isactive"];
			
			cell.accessoryType=UITableViewCellAccessoryCheckmark;
		}
	}
	else
	{
		selctedrow[cnt]=[indexPath row]+7;
		if([[[tblArr objectAtIndex:indexPath.row+7]valueForKey:@"isactive"] isEqualToString:@"yes"])
		{
			[[tblArr objectAtIndex:indexPath.row+7] setObject:@"no" forKey:@"isactive"];
			[[tblArr objectAtIndex:indexPath.row+7] setObject:@"" forKey:@"value"];
			cell.accessoryType=UITableViewCellAccessoryNone;
		}
		else 
		{
			[[tblArr objectAtIndex:indexPath.row+7] setObject:@"yes" forKey:@"isactive"];
			cell.accessoryType=UITableViewCellAccessoryCheckmark;
		}
	}
	[tblView deselectRowAtIndexPath:indexPath animated:NO];
	
	cnt++;
}

@end
