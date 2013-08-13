//
//  ViewController.m
//  color palette
//
//  Created by Silver Touch on 13/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize colorBtn1, colorBtn2, colorBtn3, colorBtn4, colorBtn5, colorBtn6, colorBtn7, colorBtn8, colorBtn9, colorBtn10;
@synthesize Colordelegate;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	appDel = (KrenMarketingAppDelegate *)[[UIApplication sharedApplication] delegate];
	UIBarButtonItem* cancel=[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelClicked:)];
	self.navigationItem.leftBarButtonItem=cancel;
	
    CGRect frame = CGRectMake(0, 0, 150, 44);
    UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"Background";
    self.navigationItem.titleView = label;

    //self.navigationItem.title = @"Background";
	UIBarButtonItem* done=[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(DoneClicked:)];
	self.navigationItem.rightBarButtonItem=done;
    //[self chk_bgselected];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)chk_bgselected
{
    NSLog(@"color==%@",appDel.bgTempColor);
    NSLog(@"color==%@",colorBtn1.backgroundColor);
    if([appDel.bgTempColor isEqual:colorBtn1.backgroundColor])
    {
        colorBtn1.backgroundColor = [UIColor clearColor];
        [colorBtn1 setImage:[UIImage imageNamed:@"Untitled-1_0009_black.png"] forState:UIControlStateNormal];
    }
    else if([appDel.bgTempColor isEqual:colorBtn2.backgroundColor])
    {
        colorBtn2.backgroundColor = [UIColor clearColor];
        [colorBtn2 setImage:[UIImage imageNamed:@"Untitled-1_0008_gray.png"] forState:UIControlStateNormal];
    }
    else if([appDel.bgTempColor isEqual:colorBtn3.backgroundColor])
    {
        colorBtn3.backgroundColor = [UIColor clearColor];
        [colorBtn3 setImage:[UIImage imageNamed:@"Untitled-1_0007_wht"] forState:UIControlStateNormal];
    }
   else if([appDel.bgTempColor isEqual:colorBtn4.backgroundColor])
    {
        colorBtn4.backgroundColor = [UIColor clearColor];
        [colorBtn4 setImage:[UIImage imageNamed:@"Untitled-1_0006_red.png"] forState:UIControlStateNormal];
    }
    else if([appDel.bgTempColor isEqual:colorBtn5.backgroundColor])
    {
        colorBtn5.backgroundColor = [UIColor clearColor];
        [colorBtn5 setImage:[UIImage imageNamed:@"Untitled-1_0005_org.png"] forState:UIControlStateNormal];
    }
    else if([appDel.bgTempColor isEqual:colorBtn6.backgroundColor])
    {
        colorBtn6.backgroundColor = [UIColor clearColor];
        [colorBtn6 setImage:[UIImage imageNamed:@"Untitled-1_0004_blue.png"] forState:UIControlStateNormal];
    }
    else if([appDel.bgTempColor isEqual:colorBtn7.backgroundColor])
    {
        colorBtn7.backgroundColor = [UIColor clearColor];
        [colorBtn7 setImage:[UIImage imageNamed:@"Untitled-1_0003_sk-blue.png"] forState:UIControlStateNormal];
    }
    else if([appDel.bgTempColor isEqual:colorBtn8.backgroundColor])
    {
        colorBtn8.backgroundColor = [UIColor clearColor];
        [colorBtn8 setImage:[UIImage imageNamed:@"Untitled-1_0002_grn.png"] forState:UIControlStateNormal];
    }
    else if([appDel.bgTempColor isEqual:colorBtn9.backgroundColor])
    {
        colorBtn9.backgroundColor = [UIColor clearColor];
        [colorBtn9 setImage:[UIImage imageNamed:@"Untitled-1_0001_lght-grn.png"] forState:UIControlStateNormal];
    }
    else if([appDel.bgTempColor isEqual:colorBtn10.backgroundColor])
    {
        colorBtn10.backgroundColor = [UIColor clearColor];
        [colorBtn10 setImage:[UIImage imageNamed:@"Untitled-1_0000_ylw.png"] forState:UIControlStateNormal];
    }
   
}
-(void) cancelClicked:(id) sender
{
	[Colordelegate dismissdatePopOver];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


-(IBAction) colorBtnClicked:(id)sender{
	
    
    UIButton *temp = (UIButton*)sender;
    
    if([temp isEqual:appDel.Prevtemp])
    {
    
    }
    else
    {
        appDel.Prevtemp = temp;
    [colorBtn1 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
     [colorBtn2 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    [colorBtn3 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [colorBtn4 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [colorBtn5 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [colorBtn6 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [colorBtn7 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [colorBtn8 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [colorBtn9 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [colorBtn10 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
     
    
	UIColor *bgColor= temp.backgroundColor;
	appDel.bgTempColor = bgColor;
	NSLog(@"color==%@",bgColor);
	
    switch (temp.tag) {
        case 1:
            [temp setImage:[UIImage imageNamed:@"Untitled-1_0009_black.png"] forState:UIControlStateNormal];
            
            colorBtn1.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1];
            colorBtn2.backgroundColor = [UIColor colorWithRed:0.6706 green:0.6706 blue:0.6706 alpha:1];
;
            colorBtn3.backgroundColor = [UIColor colorWithRed:1.0000 green:1.0000 blue:1.0000 alpha:1];
;
            colorBtn4.backgroundColor = [UIColor colorWithRed:0.6706 green:0.0000 blue:0.0000 alpha:1];
;
            colorBtn5.backgroundColor = [UIColor colorWithRed:0.8667 green:0.1882 blue:0.0000 alpha:1];
;
            colorBtn6.backgroundColor = [UIColor colorWithRed:0.1490 green:0.5373 blue:0.7608 alpha:1];
;
            colorBtn7.backgroundColor = [UIColor colorWithRed:0.4157 green:0.7961 blue:0.8784 alpha:1];
;
            colorBtn8.backgroundColor = [UIColor colorWithRed:0.2235 green:0.3922 blue:0.0588 alpha:1];
;
            colorBtn9.backgroundColor = [UIColor colorWithRed:0.2627 green:0.6353 blue:0.1216 alpha:1];
;
            colorBtn10.backgroundColor = [UIColor colorWithRed:0.9804 green:0.7412 blue:0.0000 alpha:1];
;
            //appDel.bgTempColor = colorBtn1.backgroundColor;
            //NSLog(@"color==%@",appDel.bgTempColor);
           // NSLog(@"color==%@",colorBtn1.backgroundColor);
            break;
        case 2:
            [temp setImage:[UIImage imageNamed:@"Untitled-1_0008_gray.png"] forState:UIControlStateNormal];
            colorBtn1.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1];
            colorBtn2.backgroundColor = [UIColor colorWithRed:0.6706 green:0.6706 blue:0.6706 alpha:1];
            ;
            colorBtn3.backgroundColor = [UIColor colorWithRed:1.0000 green:1.0000 blue:1.0000 alpha:1];
            ;
            colorBtn4.backgroundColor = [UIColor colorWithRed:0.6706 green:0.0000 blue:0.0000 alpha:1];
            ;
            colorBtn5.backgroundColor = [UIColor colorWithRed:0.8667 green:0.1882 blue:0.0000 alpha:1];
            ;
            colorBtn6.backgroundColor = [UIColor colorWithRed:0.1490 green:0.5373 blue:0.7608 alpha:1];
            ;
            colorBtn7.backgroundColor = [UIColor colorWithRed:0.4157 green:0.7961 blue:0.8784 alpha:1];
            ;
            colorBtn8.backgroundColor = [UIColor colorWithRed:0.2235 green:0.3922 blue:0.0588 alpha:1];
            ;
            colorBtn9.backgroundColor = [UIColor colorWithRed:0.2627 green:0.6353 blue:0.1216 alpha:1];
            ;
            colorBtn10.backgroundColor = [UIColor colorWithRed:0.9804 green:0.7412 blue:0.0000 alpha:1];
            ;
            //appDel.bgTempColor = colorBtn2.backgroundColor;
            break;
        case 3:
            [temp setImage:[UIImage imageNamed:@"Untitled-1_0007_wht.png"] forState:UIControlStateNormal];
            colorBtn1.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1];
            colorBtn2.backgroundColor = [UIColor colorWithRed:0.6706 green:0.6706 blue:0.6706 alpha:1];
            ;
            colorBtn3.backgroundColor = [UIColor colorWithRed:1.0000 green:1.0000 blue:1.0000 alpha:1];
            ;
            colorBtn4.backgroundColor = [UIColor colorWithRed:0.6706 green:0.0000 blue:0.0000 alpha:1];
            ;
            colorBtn5.backgroundColor = [UIColor colorWithRed:0.8667 green:0.1882 blue:0.0000 alpha:1];
            ;
            colorBtn6.backgroundColor = [UIColor colorWithRed:0.1490 green:0.5373 blue:0.7608 alpha:1];
            ;
            colorBtn7.backgroundColor = [UIColor colorWithRed:0.4157 green:0.7961 blue:0.8784 alpha:1];
            ;
            colorBtn8.backgroundColor = [UIColor colorWithRed:0.2235 green:0.3922 blue:0.0588 alpha:1];
            ;
            colorBtn9.backgroundColor = [UIColor colorWithRed:0.2627 green:0.6353 blue:0.1216 alpha:1];
            ;
            colorBtn10.backgroundColor = [UIColor colorWithRed:0.9804 green:0.7412 blue:0.0000 alpha:1];
            ;
          //  appDel.bgTempColor = colorBtn3.backgroundColor;
            break;
        case 4:
            [temp setImage:[UIImage imageNamed:@"Untitled-1_0006_red.png"] forState:UIControlStateNormal];
            colorBtn1.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1];
            colorBtn2.backgroundColor = [UIColor colorWithRed:0.6706 green:0.6706 blue:0.6706 alpha:1];
            ;
            colorBtn3.backgroundColor = [UIColor colorWithRed:1.0000 green:1.0000 blue:1.0000 alpha:1];
            ;
            colorBtn4.backgroundColor = [UIColor colorWithRed:0.6706 green:0.0000 blue:0.0000 alpha:1];
            ;
            colorBtn5.backgroundColor = [UIColor colorWithRed:0.8667 green:0.1882 blue:0.0000 alpha:1];
            ;
            colorBtn6.backgroundColor = [UIColor colorWithRed:0.1490 green:0.5373 blue:0.7608 alpha:1];
            ;
            colorBtn7.backgroundColor = [UIColor colorWithRed:0.4157 green:0.7961 blue:0.8784 alpha:1];
            ;
            colorBtn8.backgroundColor = [UIColor colorWithRed:0.2235 green:0.3922 blue:0.0588 alpha:1];
            ;
            colorBtn9.backgroundColor = [UIColor colorWithRed:0.2627 green:0.6353 blue:0.1216 alpha:1];
            ;
            colorBtn10.backgroundColor = [UIColor colorWithRed:0.9804 green:0.7412 blue:0.0000 alpha:1];
            ;
           // appDel.bgTempColor = colorBtn4.backgroundColor;
            break;
        case 5:
            [temp setImage:[UIImage imageNamed:@"Untitled-1_0005_org.png"] forState:UIControlStateNormal];
            colorBtn1.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1];
            colorBtn2.backgroundColor = [UIColor colorWithRed:0.6706 green:0.6706 blue:0.6706 alpha:1];
            ;
            colorBtn3.backgroundColor = [UIColor colorWithRed:1.0000 green:1.0000 blue:1.0000 alpha:1];
            ;
            colorBtn4.backgroundColor = [UIColor colorWithRed:0.6706 green:0.0000 blue:0.0000 alpha:1];
            ;
            colorBtn5.backgroundColor = [UIColor colorWithRed:0.8667 green:0.1882 blue:0.0000 alpha:1];
            ;
            colorBtn6.backgroundColor = [UIColor colorWithRed:0.1490 green:0.5373 blue:0.7608 alpha:1];
            ;
            colorBtn7.backgroundColor = [UIColor colorWithRed:0.4157 green:0.7961 blue:0.8784 alpha:1];
            ;
            colorBtn8.backgroundColor = [UIColor colorWithRed:0.2235 green:0.3922 blue:0.0588 alpha:1];
            ;
            colorBtn9.backgroundColor = [UIColor colorWithRed:0.2627 green:0.6353 blue:0.1216 alpha:1];
            ;
            colorBtn10.backgroundColor = [UIColor colorWithRed:0.9804 green:0.7412 blue:0.0000 alpha:1];
            ;
           // appDel.bgTempColor = colorBtn5.backgroundColor;
            break;
        case 6:
            [temp setImage:[UIImage imageNamed:@"Untitled-1_0004_blue.png"] forState:UIControlStateNormal];
            colorBtn1.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1];
            colorBtn2.backgroundColor = [UIColor colorWithRed:0.6706 green:0.6706 blue:0.6706 alpha:1];
            ;
            colorBtn3.backgroundColor = [UIColor colorWithRed:1.0000 green:1.0000 blue:1.0000 alpha:1];
            ;
            colorBtn4.backgroundColor = [UIColor colorWithRed:0.6706 green:0.0000 blue:0.0000 alpha:1];
            ;
            colorBtn5.backgroundColor = [UIColor colorWithRed:0.8667 green:0.1882 blue:0.0000 alpha:1];
            ;
            colorBtn6.backgroundColor = [UIColor colorWithRed:0.1490 green:0.5373 blue:0.7608 alpha:1];
            ;
            colorBtn7.backgroundColor = [UIColor colorWithRed:0.4157 green:0.7961 blue:0.8784 alpha:1];
            ;
            colorBtn8.backgroundColor = [UIColor colorWithRed:0.2235 green:0.3922 blue:0.0588 alpha:1];
            ;
            colorBtn9.backgroundColor = [UIColor colorWithRed:0.2627 green:0.6353 blue:0.1216 alpha:1];
            ;
            colorBtn10.backgroundColor = [UIColor colorWithRed:0.9804 green:0.7412 blue:0.0000 alpha:1];
            ;
           // appDel.bgTempColor = colorBtn6.backgroundColor;
            break;
        case 7:
            [temp setImage:[UIImage imageNamed:@"Untitled-1_0003_sk-blue.png"] forState:UIControlStateNormal];
            colorBtn1.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1];
            colorBtn2.backgroundColor = [UIColor colorWithRed:0.6706 green:0.6706 blue:0.6706 alpha:1];
            ;
            colorBtn3.backgroundColor = [UIColor colorWithRed:1.0000 green:1.0000 blue:1.0000 alpha:1];
            ;
            colorBtn4.backgroundColor = [UIColor colorWithRed:0.6706 green:0.0000 blue:0.0000 alpha:1];
            ;
            colorBtn5.backgroundColor = [UIColor colorWithRed:0.8667 green:0.1882 blue:0.0000 alpha:1];
            ;
            colorBtn6.backgroundColor = [UIColor colorWithRed:0.1490 green:0.5373 blue:0.7608 alpha:1];
            ;
            colorBtn7.backgroundColor = [UIColor colorWithRed:0.4157 green:0.7961 blue:0.8784 alpha:1];
            ;
            colorBtn8.backgroundColor = [UIColor colorWithRed:0.2235 green:0.3922 blue:0.0588 alpha:1];
            ;
            colorBtn9.backgroundColor = [UIColor colorWithRed:0.2627 green:0.6353 blue:0.1216 alpha:1];
            ;
            colorBtn10.backgroundColor = [UIColor colorWithRed:0.9804 green:0.7412 blue:0.0000 alpha:1];
            ;
           // appDel.bgTempColor = colorBtn7.backgroundColor;
            break;
        case 8:
            [temp setImage:[UIImage imageNamed:@"Untitled-1_0002_grn.png"] forState:UIControlStateNormal];
            colorBtn1.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1];
            colorBtn2.backgroundColor = [UIColor colorWithRed:0.6706 green:0.6706 blue:0.6706 alpha:1];
            ;
            colorBtn3.backgroundColor = [UIColor colorWithRed:1.0000 green:1.0000 blue:1.0000 alpha:1];
            ;
            colorBtn4.backgroundColor = [UIColor colorWithRed:0.6706 green:0.0000 blue:0.0000 alpha:1];
            ;
            colorBtn5.backgroundColor = [UIColor colorWithRed:0.8667 green:0.1882 blue:0.0000 alpha:1];
            ;
            colorBtn6.backgroundColor = [UIColor colorWithRed:0.1490 green:0.5373 blue:0.7608 alpha:1];
            ;
            colorBtn7.backgroundColor = [UIColor colorWithRed:0.4157 green:0.7961 blue:0.8784 alpha:1];
            ;
            colorBtn8.backgroundColor = [UIColor colorWithRed:0.2235 green:0.3922 blue:0.0588 alpha:1];
            ;
            colorBtn9.backgroundColor = [UIColor colorWithRed:0.2627 green:0.6353 blue:0.1216 alpha:1];
            ;
            colorBtn10.backgroundColor = [UIColor colorWithRed:0.9804 green:0.7412 blue:0.0000 alpha:1];
            ;
           // appDel.bgTempColor = colorBtn8.backgroundColor;
            break;
        case 9:
            [temp setImage:[UIImage imageNamed:@"Untitled-1_0001_lght-grn.png"] forState:UIControlStateNormal];
            colorBtn1.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1];
            colorBtn2.backgroundColor = [UIColor colorWithRed:0.6706 green:0.6706 blue:0.6706 alpha:1];
            ;
            colorBtn3.backgroundColor = [UIColor colorWithRed:1.0000 green:1.0000 blue:1.0000 alpha:1];
            ;
            colorBtn4.backgroundColor = [UIColor colorWithRed:0.6706 green:0.0000 blue:0.0000 alpha:1];
            ;
            colorBtn5.backgroundColor = [UIColor colorWithRed:0.8667 green:0.1882 blue:0.0000 alpha:1];
            ;
            colorBtn6.backgroundColor = [UIColor colorWithRed:0.1490 green:0.5373 blue:0.7608 alpha:1];
            ;
            colorBtn7.backgroundColor = [UIColor colorWithRed:0.4157 green:0.7961 blue:0.8784 alpha:1];
            ;
            colorBtn8.backgroundColor = [UIColor colorWithRed:0.2235 green:0.3922 blue:0.0588 alpha:1];
            ;
            colorBtn9.backgroundColor = [UIColor colorWithRed:0.2627 green:0.6353 blue:0.1216 alpha:1];
            ;
            colorBtn10.backgroundColor = [UIColor colorWithRed:0.9804 green:0.7412 blue:0.0000 alpha:1];
            ;
           // appDel.bgTempColor = colorBtn9.backgroundColor;
            break;
        case 10:
            [temp setImage:[UIImage imageNamed:@"Untitled-1_0000_ylw.png"] forState:UIControlStateNormal];
            colorBtn1.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1];
            colorBtn2.backgroundColor = [UIColor colorWithRed:0.6706 green:0.6706 blue:0.6706 alpha:1];
            ;
            colorBtn3.backgroundColor = [UIColor colorWithRed:1.0000 green:1.0000 blue:1.0000 alpha:1];
            ;
            colorBtn4.backgroundColor = [UIColor colorWithRed:0.6706 green:0.0000 blue:0.0000 alpha:1];
            ;
            colorBtn5.backgroundColor = [UIColor colorWithRed:0.8667 green:0.1882 blue:0.0000 alpha:1];
            ;
            colorBtn6.backgroundColor = [UIColor colorWithRed:0.1490 green:0.5373 blue:0.7608 alpha:1];
            ;
            colorBtn7.backgroundColor = [UIColor colorWithRed:0.4157 green:0.7961 blue:0.8784 alpha:1];
            ;
            colorBtn8.backgroundColor = [UIColor colorWithRed:0.2235 green:0.3922 blue:0.0588 alpha:1];
            ;
            colorBtn9.backgroundColor = [UIColor colorWithRed:0.2627 green:0.6353 blue:0.1216 alpha:1];
            ;
            colorBtn10.backgroundColor = [UIColor colorWithRed:0.9804 green:0.7412 blue:0.0000 alpha:1];
            ;
          //  appDel.bgTempColor = colorBtn10.backgroundColor;
            break;
        default:
            break;
    }
	temp.backgroundColor = [UIColor clearColor];
	
	}
	
}

-(void)DoneClicked:(id) sender
{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"bg_ChangeTempColor" object:nil];
	[Colordelegate dismissdatePopOver];
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
