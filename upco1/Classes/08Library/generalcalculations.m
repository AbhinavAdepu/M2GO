//
//  generalcalculations.m
//  KrenMarketing
//
//  Created by Ravi Sethia on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "generalcalculations.h"

@implementation generalcalculations

-(NSString *)strdate:(NSString *)str
{
    
    NSLog(@"String to be formatted:%@",str);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd'T'HHmmss'Z"];
    NSDate *date=[dateFormat dateFromString:str];
    if(date != nil)
    {
        [dateFormat setDateFormat:@"EEE MM/dd/yy hh:mm a"];
        return [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:date]]; 
    }
    else {
        
        NSLog(@"input string date:%@",str);
         NSLog(@"length:%d",str.length);
        str=[str substringToIndex:8];
        NSLog(@"input string date after substring:%@",str);
        [dateFormat setDateFormat:@"yyyyMMdd"];
        NSDate *date=[dateFormat dateFromString:str];
        [dateFormat setDateFormat:@"EEE MM/dd/yy hh:mm a"];
        NSLog(@"returnd string:%@",[dateFormat stringFromDate:date]);
        return [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:date]]; 
    }

}


-(NSString *) dividestring:(NSString *)text:(NSString *)category
{  NSDictionary *keyval;
    NSMutableArray *keysdata=[[NSMutableArray alloc]initWithCapacity:1];
    NSMutableArray *valuedata=[[NSMutableArray alloc]initWithCapacity:1];
    NSString *redundantphoneno;
    redundantphoneno=@"";
    NSString *returnstr;
    returnstr=@"";
    
    int rot=0;
    NSLog(@"tempstr:%@",text);
    
    if([category isEqualToString:@"Phone"])
    {
        NSLog(@"phone number");
         NSArray *words = [text componentsSeparatedByString:@":"];
        returnstr=[returnstr stringByAppendingFormat:@"Phone Number : %@",[words objectAtIndex:1]];
        return returnstr;
        
    }
    
    //framing string for sms
    if([category isEqualToString:@"SMS"])
    {
        
        NSLog(@"into sms");
        NSString *tmpsms=text;
        tmpsms=  [tmpsms stringByReplacingOccurrencesOfString:@"From:" withString:@""];
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
            if([[words objectAtIndex:0] length]>0)
                despho=[words objectAtIndex:0];
            
            
            NSLog(@"length >[words count]");
            for(int i=1;i<[words count];i++)
            {
                mess= [mess stringByAppendingFormat:@"%@",[words objectAtIndex:i]];
            }
        }
        
        NSLog(@"temp geni phon:%@",despho);
        NSLog(@"temp geni msg:%@",mess);
        if([despho length]>0)
        {
            returnstr=[returnstr stringByAppendingFormat:@"Mobile Number : %@\n",despho];
        }
        
        if([mess length]>0)
        {
            NSLog(@"into");
            returnstr=[returnstr stringByAppendingFormat:@"Message : %@",mess];
        }

        
        
              NSLog(@"returing string:%@",returnstr);
        return returnstr;
    }
    
    
    //framing string for email
    if([category isEqualToString:@"Email"])
    {
        
        NSLog(@"into email");
        NSString *tmpemail=text;
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
        
        if([[[keyval objectForKey:@"from"] length]>0?[keyval objectForKey:@"from"]:[[keyval objectForKey:@"From"] length]>0?[keyval objectForKey:@"From"]:[[keyval objectForKey:@"FROM"] length]>0?[keyval objectForKey:@"FROM"]:@"" length ]>0)
        {
            returnstr=[returnstr stringByAppendingFormat:@"From : %@\n",[[keyval objectForKey:@"from"] length]>0?[keyval objectForKey:@"from"]:[[keyval objectForKey:@"From"] length]>0?[keyval objectForKey:@"From"]:[[keyval objectForKey:@"FROM"] length]>0?[keyval objectForKey:@"FROM"]:@""];
        }
        if([[[keyval objectForKey:@"SUBJECT"] length]>0?[keyval objectForKey:@"SUBJECT"]:[[keyval objectForKey:@"SUB"] length]>0?[keyval objectForKey:@"SUB"]:[[keyval objectForKey:@"subject"] length]>0?[keyval objectForKey:@"subject"]:[[keyval objectForKey:@"sub"] length]>0?[keyval objectForKey:@"sub"]:[[keyval objectForKey:@"Subject"] length]>0?[keyval objectForKey:@"Subject"]:@"" length]>0)
        {
            returnstr=[returnstr stringByAppendingFormat:@"Subject : %@\n",[[keyval objectForKey:@"SUBJECT"] length]>0?[keyval objectForKey:@"SUBJECT"]:[[keyval objectForKey:@"SUB"] length]>0?[keyval objectForKey:@"SUB"]:[[keyval objectForKey:@"subject"] length]>0?[keyval objectForKey:@"subject"]:[[keyval objectForKey:@"sub"] length]>0?[keyval objectForKey:@"sub"]:[[keyval objectForKey:@"Subject"] length]>0?[keyval objectForKey:@"Subject"]:@""];
        }
        
        
        if([[[keyval objectForKey:@"body"] length]>0?[keyval objectForKey:@"body"]:[[keyval objectForKey:@"BODY"] length]>0?[keyval objectForKey:@"BODY"]:[[keyval objectForKey:@"Body"] length]>0?[keyval objectForKey:@"Body"]:@"" length]>0)
        {
            NSLog(@"into body");
            returnstr=[returnstr stringByAppendingFormat:@"Message : %@\n",[[keyval objectForKey:@"body"] length]>0?[keyval objectForKey:@"body"]:[[keyval objectForKey:@"BODY"] length]>0?[keyval objectForKey:@"BODY"]:[[keyval objectForKey:@"Body"] length]>0?[keyval objectForKey:@"Body"]:@""];
        }
       
        NSLog(@"return string:%@",returnstr);
        
        return returnstr;
    }
    
    //Framing String for map location
    //location
    if([category isEqualToString:@"Map Location"])
    {
    
            
        text=[text stringByReplacingOccurrencesOfString:@";" withString:@"\n"];
        text=[text stringByReplacingOccurrencesOfString:@"Map URL:" withString:@""];
            NSArray *words=[text componentsSeparatedByString:@"\n"];
            
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
        
        if([[keyval objectForKey:@"Map URL"] length]>0)
        {
            returnstr=[returnstr stringByAppendingFormat:@"%@\n",[keyval objectForKey:@"Map URL"]];
        }
        if([[keyval objectForKey:@"Notes"] length]>0)
        {
            returnstr=[returnstr stringByAppendingFormat:@"Notes : %@\n",[keyval objectForKey:@"Notes"]];
        }
        
        return returnstr;
    }
    
    
    
    
    
    NSArray *words = [text componentsSeparatedByString:@"\n"];
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
    
    NSLog(@"geni method dictonary:%@",keyval);
    
    //string1 = [string1 stringByAppendingString:string2]
    NSString  *add_temp=@"";
    if([category isEqualToString:@"Event"])
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
    
    
    
    NSString* loc_temp=(([[keyval objectForKey:@"CELL"] length]<=0)?(([[keyval objectForKey:@"VOICE"] length]<=0)?(([[keyval objectForKey:@"TEL"] length]==0)?[keyval objectForKey:@"Phone Number"]:[keyval objectForKey:@"TEL"]):([keyval objectForKey:@"VOICE"])):[keyval objectForKey:@"CELL"]);
    
    NSString *temsavdes;
    if([category isEqualToString:@"Event"])
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
    
    if([category isEqualToString:@"Phone"] && [[keyval objectForKey:@"Mobile Number"] length]>0)
    {
        temsavdes=[keyval objectForKey:@"Mobile Number"];
        
    }
    if([temsavdes length]<=0 && [category isEqualToString:@"Phone"])
    {
        temsavdes=redundantphoneno;
    }
    
    //String Framing starts now
    returnstr=@"";
    
    //Framing String for URL
    if([category isEqualToString:@"URL"])
    {
        
    }
    
    
    //Framing string for contact
    if([category isEqualToString:@"Contact"])
    {
        if([temsavdes length]>0)
        {
            returnstr=[returnstr stringByAppendingFormat:@"Name : %@\n",temsavdes];
        }
        if([redundantphoneno length]>0)
        {
            returnstr=[returnstr stringByAppendingFormat:@"Phone Number : %@\n",redundantphoneno];
        }
        if([[[keyval objectForKey:@"TITLE"] length]<=0?[keyval objectForKey:@"JobTitle"]:[keyval objectForKey:@"TITLE"] length]>0)
        {
            returnstr=[returnstr stringByAppendingFormat:@"Job Title : %@\n",[[keyval objectForKey:@"TITLE"] length]<=0?[keyval objectForKey:@"JobTitle"]:[keyval objectForKey:@"TITLE"]];
        }
        if([[[keyval objectForKey:@"ORG"] length]<=0?[keyval objectForKey:@"Department"]:[keyval objectForKey:@"ORG"] length]>0)
        {
             returnstr=[returnstr stringByAppendingFormat:@"Department : %@\n",[[keyval objectForKey:@"ORG"] length]<=0?[keyval objectForKey:@"Department"]:[keyval objectForKey:@"ORG"]];
            
        }
        if([[keyval objectForKey:@"N"] length]>0)
        {
            returnstr=[returnstr stringByAppendingFormat:@"Full Name : %@\n",[keyval objectForKey:@"N"]];
            
        }
    return returnstr;
    }

    //Framing String for Event
   if([category isEqualToString:@"Event"])
    {
       if([temsavdes length]>0)
       { 
           returnstr=[returnstr stringByAppendingFormat:@"Event : %@\n",temsavdes];
       }
        if([[keyval objectForKey:@"Start Date & Time"] length]>0)
        {
            returnstr=[returnstr stringByAppendingFormat:@"Start Date and Time : %@\n",[keyval objectForKey:@"Start Date & Time"]];
        }
        if([[keyval objectForKey:@"End Date & Time"] length]>0)
        {
            returnstr=[returnstr stringByAppendingFormat:@"End Date & Time : %@\n",[keyval objectForKey:@"End Date & Time"]];
        }
        if([add_temp length]>0)
        {
            returnstr=[returnstr stringByAppendingFormat:@"Address : %@\n",add_temp];
        }
        if([([[keyval objectForKey:@"Notes"] length]<=0)?[keyval objectForKey:@"DESCRIPTION"]:[keyval objectForKey:@"Notes"] length]>0)
        {
            returnstr=[returnstr stringByAppendingFormat:@"Notes : %@\n",([[keyval objectForKey:@"Notes"] length]<=0)?[keyval objectForKey:@"DESCRIPTION"]:[keyval objectForKey:@"Notes"]];
        }
        
        
        NSLog(@"returning string event:%@",returnstr);

       return returnstr;
        
    }
    
   
    
}

-(BOOL)canbeadded:(NSString *)text:(NSString *)category:(int)focus
{
    NSDictionary *keyval;
    NSMutableArray *keysdata=[[NSMutableArray alloc]initWithCapacity:1];
    NSMutableArray *valuedata=[[NSMutableArray alloc]initWithCapacity:1];
    NSString *redundantphoneno;
    redundantphoneno=@"";
    
    int rot=0;
    NSLog(@"tempstr:%@",text);
    NSArray *words = [text componentsSeparatedByString:@"\n"];
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
    if([category isEqualToString:@"Event"])
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
    
    if([[keyval objectForKey:@"LOCATION"] length]>0)
       {
           add_temp=[keyval objectForKey:@"LOCATION"];
       }
    
    if([[keyval objectForKey:@"Address"] length]>0)
    {
        add_temp=[keyval objectForKey:@"Address"];
    }
    
    
 NSString*   loc_temp=(([[keyval objectForKey:@"CELL"] length]<=0)?(([[keyval objectForKey:@"VOICE"] length]<=0)?(([[keyval objectForKey:@"TEL"] length]==0)?[keyval objectForKey:@"Phone Number"]:[keyval objectForKey:@"TEL"]):([keyval objectForKey:@"VOICE"])):[keyval objectForKey:@"CELL"]);
    
     NSString *temsavdes;
    if([category isEqualToString:@"Event"])
    {
        temsavdes=[keyval objectForKey:@"Event"];
    }
    else {
               if([[keyval objectForKey:@"FN"] length]<=0)
        {
            temsavdes=([[keyval objectForKey:@"N"] length]<=0)?([keyval objectForKey:@"Name"]):([keyval objectForKey:@"N"]);
        }else
        {
            temsavdes=[keyval objectForKey:@"FN"];
        }
        
        if([[keyval objectForKey:@" Name"] length]>0)
        {
          
            temsavdes=[keyval objectForKey:@" Name"];
        }
       
        
    }
    
    redundantphoneno=(([[keyval objectForKey:@"CELL"] length]<=0)?(([[keyval objectForKey:@"VOICE"] length]<=0)?(([[keyval objectForKey:@"TEL"] length]==0)?[keyval objectForKey:@"Phone Number"]:[keyval objectForKey:@"TEL"]):([keyval objectForKey:@"VOICE"])):[keyval objectForKey:@"CELL"]);
   
if([[keyval objectForKey:@" Phone Number"] length]>0)
{
    
    redundantphoneno=[keyval objectForKey:@" Phone Number"];
}
    
    if([category isEqualToString:@"Phone"] && [[keyval objectForKey:@"Mobile Number"] length]>0)
    {
        temsavdes=[keyval objectForKey:@"Mobile Number"];
        
    }
    if([temsavdes length]<=0 && [category isEqualToString:@"Phone"])
    {
        temsavdes=redundantphoneno;
    }
    
   
    
//returning status
   if(focus==0)
   {
       NSLog(@"statsu for focus i.e., to add");
  
    if([category isEqualToString:@"Contact"])
    {
        if([redundantphoneno length] > 0 && [temsavdes length] > 0)
        {
            int addcon=1;
            
           
            ABAddressBookRef addressBook = ABAddressBookCreate();
            
            
            CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBook );
            CFIndex nPeople = ABAddressBookGetPersonCount( addressBook );
            
            
            for ( int i = 0; i < nPeople; i++ )
            {
                ABRecordRef ref = CFArrayGetValueAtIndex( allPeople, i );
                NSString *firstName = (NSString *)ABRecordCopyValue(ref, kABPersonFirstNameProperty);
          
                if([firstName isEqualToString:temsavdes])
                {
                    addcon=0; 
                    
                }
                
                
            }
            
            CFRelease(allPeople);
       

            
            if(addcon)
            {
                
                return YES;
                
            }
            else {
                return NO;
            }
            
        }
    }  
    
    if([category isEqualToString:@"Phone"])
    {
        NSLog(@"#%@#",temsavdes);
        if([temsavdes length] > 0)
        {         
            
            ABAddressBookRef addressBook = ABAddressBookCreate();
            
            
            CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBook );
            CFIndex nPeople = ABAddressBookGetPersonCount( addressBook );
            
            int addpho1=1;
            NSString *searchString = nil;
            
            for ( int i = 0; i < nPeople; i++ )
            {
                ABRecordRef ref = CFArrayGetValueAtIndex( allPeople, i );
                ABMultiValueRef phonnumb = (ABMultiValueRef) ABRecordCopyValue(ref,kABPersonPhoneProperty);
                
                
                for (CFIndex i = 0; i < ABMultiValueGetCount(phonnumb); i++) 
                {
                    searchString = (NSString *)ABMultiValueCopyValueAtIndex(phonnumb, i);
                    if([searchString isEqualToString:temsavdes])
                        addpho1=0;
                    
                }
                
                
                
            }
            CFRelease(allPeople);
      
            
            if(addpho1)
            {
                return YES;
            }
            else {
                return NO;
            }
            
        }
        
    }
    
    
    if([category isEqualToString:@"Event"])
    {
        if([category isEqualToString:@"Event"] && [temsavdes length] > 0 && [[keyval objectForKey:@"Start Date & Time"] length] > 0 && [[keyval objectForKey:@"End Date & Time"] length] > 0)
        {
            NSLog(@"STartDate:%@",[keyval objectForKey:@"Start Date & Time"]);
              NSLog(@"STartDate:%@",[keyval objectForKey:@"End Date & Time"]);
            flagevent=YES;
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
                                                              flagevent=NO;
                                                          }
                                                      }
                                                      
                                                  }];       
                currentStart = [NSDate dateWithTimeInterval:(seconds_in_year + 1) sinceDate:currentStart];
                
            }
            
            NSArray *events = [eventsDict allKeys];
            
            
            for(int i=0;i<[events count];i++)
            {
                EKEvent *evn=[eventsDict objectForKey:[events objectAtIndex:i]];
               // NSLog(@"title of event:%@",evn.title);
                if([evn.title length]!= 0)
                {
                    temsavdes=[temsavdes stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                    NSLog(@"-%@-%@-",temsavdes,evn.title);

                    if([evn.title isEqualToString:temsavdes])
                    {
                        flagevent=NO;
                    }
                }
                
            }
            NSLog(@"is events:"); 
            NSLog(flagevent ? @"Yes" : @"No");
            
            return flagevent;
        }
        
        else {
            return  NO;
        }
        
    }
       
   }
   else {
       NSLog(@"saving methoda:-%@-",temsavdes);
       
       if([category isEqualToString:@"Contact"])
       {
           if([category isEqualToString:@"Contact"] && [temsavdes length]>0 && [redundantphoneno length]>0)
           {
               [temsavdes stringByReplacingOccurrencesOfString:@" " withString:@""];
                [redundantphoneno stringByReplacingOccurrencesOfString:@" " withString:@""];
               
               NSLog(@"saving vontact to contact book");
               NSLog(@"name:%@-Phon:%@",temsavdes,redundantphoneno);
               
               ABAddressBookRef addressBook = ABAddressBookCreate();
               ABRecordRef person = ABPersonCreate();
               ABRecordSetValue(person, kABPersonFirstNameProperty, temsavdes, nil);
               ABMutableMultiValueRef phoneNumberMultiValue = ABMultiValueCreateMutable(kABPersonPhoneProperty);
               ABMultiValueAddValueAndLabel(phoneNumberMultiValue, redundantphoneno, kABHomeLabel, nil);
               ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumberMultiValue, nil);
               ABAddressBookAddRecord(addressBook, person, nil);
               ABAddressBookSave(addressBook, nil);
               
               CFRelease(person);
               CFRelease(phoneNumberMultiValue);
               
               
               UIAlertView *alertviewcon=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Contact Added successfully!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
               
               [alertviewcon show];
               [alertviewcon release];
               
               
           }
           
           
           
           
       }
       if([category isEqualToString:@"Event"])
       {
           if([category isEqualToString:@"Event"] && [temsavdes length] > 0 && [[keyval objectForKey:@"Start Date & Time"] length] > 0 && [[keyval objectForKey:@"End Date & Time"] length] > 0)
           {
              // [temsavdes stringByReplacingOccurrencesOfString:@" " withString:@""];
              // [[keyval objectForKey:@"Start Date & Time"] stringByReplacingOccurrencesOfString:@" " withString:@""];
              //  [[keyval objectForKey:@"End Date & Time"] stringByReplacingOccurrencesOfString:@" " withString:@""];
               
               NSLog(@"saving Event to calemder");
               EKEventStore *eventStore = [[EKEventStore alloc] init];
               
               EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
               temsavdes=[temsavdes stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];

               event.title=temsavdes;
               
               
            
               
               
               
               NSString *stdate=[keyval objectForKey:@"Start Date & Time"];
               
               stdate=[stdate substringFromIndex:4];
               
               NSString *endate=[keyval objectForKey:@"Start Date & Time"] ;
               NSLog(@"%@",[keyval objectForKey:@"End Date & Time"]);

               NSLog(@"%@",[keyval objectForKey:@"End Date & Time"]);
               
               endate=[endate substringFromIndex:4];
               
               NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
               formatter.dateFormat = @"MM/dd/yy H:mm a";
               
               NSDate *date = [formatter dateFromString:stdate];
               
               NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
               formatter1.dateFormat = @"MM/dd/yy H:mm a";
               
               NSDate *date1 = [formatter dateFromString:endate];
               event.startDate = date;
               event.endDate = date1;
               event.location=add_temp;
               event.notes=([[keyval objectForKey:@"Notes"] length]<=0)?[keyval objectForKey:@"DESCRIPTION"]:[keyval objectForKey:@"Notes"];
                 NSLog(@"date to save:%@",date);
               NSLog(@"date to save:%@",date1);

               
                          
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
       
       if([category isEqualToString:@"Phone"] && [temsavdes length]>0 )
       {
           [temsavdes stringByReplacingOccurrencesOfString:@" " withString:@""];
           
           NSLog(@"phone to contact book");
           ABAddressBookRef addressBook = ABAddressBookCreate();
           ABRecordRef person = ABPersonCreate();
           ABMutableMultiValueRef phoneNumberMultiValue = ABMultiValueCreateMutable(kABPersonPhoneProperty);
           ABMultiValueAddValueAndLabel(phoneNumberMultiValue,temsavdes , kABHomeLabel, nil);
           ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumberMultiValue, nil);
           ABAddressBookAddRecord(addressBook, person, nil);
           ABAddressBookSave(addressBook, nil);
           
           CFRelease(person);
           //  CFRelease(addressMultiValue);
         ///  CFRelease(phoneNumberMultiValue);
           
           UIAlertView *alertviewcon=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Contact Added successfully!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
           
           [alertviewcon show];
           [alertviewcon release];
           
           
           
       } 
       

       
   }
       
       
    
return NO;
} 
    
    
  

    
    
    



@end
