//
//  Event.m
//  CNR
//
//  Created by Adrien Robert on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "Event.h"
#import "ManageCoreData.h"

@implementation Event

@synthesize idE, publishedAt, updatedAt, summary, content, date,title;

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSDate*) dateFromSummary
{   
    //Suppression du superflu 
    NSString* removeUnused = @"([0-9]{1,2})[:space:]([:alpha:]+.)[:space:]([0-9]{4})[:space:]([0-9]{1,2}:[0-9]{1,2}) au ([0-9]{1,2}:[0-9]{1,2})";
	
    NSRegularExpression* regex = [NSRegularExpression 
                                  regularExpressionWithPattern:removeUnused
                                  options:0
                                  error:nil];
    
    NSRange range = [regex rangeOfFirstMatchInString:summary options:0 range:NSMakeRange(0, [summary length])];
	
	if (range.location != NSNotFound) {
		NSString* preStrDate = [summary substringWithRange:range];
		
		NSArray* components = [preStrDate componentsSeparatedByString:@" "];
		NSString* strDate =[NSString stringWithFormat:@"%@ %@ %@ %@", [components objectAtIndex:0],
							[components objectAtIndex:1],
							[components objectAtIndex:2],
							[components objectAtIndex:3]];
		
		//Conversion en date
		
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"d MMM yyyy HH:mm"];
		[df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"]];
		
		NSDate* d = [df dateFromString:strDate];
		
		
		strDate =[NSString stringWithFormat:@"%@ %@ %@ %@", [components objectAtIndex:0],
				  [components objectAtIndex:1],
				  [components objectAtIndex:2],
				  [components objectAtIndex:5]];
		
		NSDate* d2 = [df dateFromString:strDate];
		
		NSArray* result = [NSArray arrayWithObjects:d, d2, nil];
        
		return [result objectAtIndex:0];
	}
    else
    {
        removeUnused = @"([0-9]{1,2})[:space:]([:alpha:]+.)[:space:]([0-9]{4}) au ([:alpha:]+.)[:space:]([0-9]{1,2})[:space:]([:alpha:]+.)[:space:]([0-9]{4})";
        
        regex = [NSRegularExpression 
                 regularExpressionWithPattern:removeUnused
                 options:0
                 error:nil];
        
        range = [regex rangeOfFirstMatchInString:summary options:0 range:NSMakeRange(0, [summary length])];
        
        NSString* preStrDate = [summary substringWithRange:range];
        
        NSArray* components = [preStrDate componentsSeparatedByString:@" "];
		NSString* strDate =[NSString stringWithFormat:@"%@ %@ %@", [components objectAtIndex:0],
							[components objectAtIndex:1],
							[components objectAtIndex:2]];
        
        //Conversion en date
		
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"d MMM yyyy"];
		[df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"]];
		
		NSDate* d = [df dateFromString:strDate];
		
		
		strDate =[NSString stringWithFormat:@"%@ %@ %@", [components objectAtIndex:0],
				  [components objectAtIndex:1],
				  [components objectAtIndex:2]];
		
		NSDate* d2 = [df dateFromString:strDate];
		
		NSArray* result = [NSArray arrayWithObjects:d, d2, nil];
        
		return [result objectAtIndex:0];
    }
	return nil;
}
@end
