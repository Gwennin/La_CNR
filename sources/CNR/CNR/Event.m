    //
    //  Event.m
    //  CNR
    //
    //  Created by Adrien Robert on 01/05/12.
    //  Copyright (c) 2012 Supinfo. All rights reserved.
    //

#import "Event.h"

@implementation Event

@synthesize idE, publishedAt, updatedAt, title, summary, content, date;

- (NSDate*) date
{
    if(!date)
        date = [self dateFromSummary];
    
    return date;
}

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
    NSString* removeUnused = @"([0-9]{1,2})[:space:]([:alpha:]+.)[:space:]([0-9]{4})[:space:]([0-9]{1,2}:[0-9]{1,2})";
    
    NSRegularExpression* regex = [NSRegularExpression 
                                  regularExpressionWithPattern:removeUnused
                                  options:0
                                  error:nil];
    
    NSRange range = [regex rangeOfFirstMatchInString:summary options:0 range:NSMakeRange(0, [summary length])];
    NSString* strDate = [[summary substringWithRange:range] stringByReplacingOccurrencesOfString:@"au " withString:@""];
    
        //Extraction du mois en lettres
    NSString* getMonth = @"([a-z .]+)";
    
    regex = [NSRegularExpression 
             regularExpressionWithPattern:getMonth
             options:0
             error:nil];
    
    range = [regex rangeOfFirstMatchInString:strDate options:0 range:NSMakeRange(0, [strDate length])];
    
    NSString* mois = [[strDate substringWithRange:range]  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
        //Conversion du mois en chiffres
    NSString* moisNbr = nil;
    
    if([mois isEqualToString:@"jan."])
        moisNbr = [[NSString alloc] initWithString:@"01"];
    else if([mois isEqualToString:@"fev."])
        moisNbr = [[NSString alloc] initWithString:@"02"];
    else if([mois isEqualToString:@"mars"])
        moisNbr = [[NSString alloc] initWithString:@"03"];
    else if([mois isEqualToString:@"avr."])
        moisNbr = [[NSString alloc] initWithString:@"04"];
    else if([mois isEqualToString:@"mai"])
        moisNbr = [[NSString alloc] initWithString:@"05"];
    else if([mois isEqualToString:@"juin"])
        moisNbr = [[NSString alloc] initWithString:@"06"];
    else if([mois isEqualToString:@"jul."])
        moisNbr = [[NSString alloc] initWithString:@"07"];
    else if([mois isEqualToString:@"aou."])
        moisNbr = [[NSString alloc] initWithString:@"08"];
    else if([mois isEqualToString:@"sep."])
        moisNbr = [[NSString alloc] initWithString:@"09"];
    else if([mois isEqualToString:@"oct."])
        moisNbr = [[NSString alloc] initWithString:@"10"];
    else if([mois isEqualToString:@"nov."])
        moisNbr = [[NSString alloc] initWithString:@"11"];
    else if([mois isEqualToString:@"dec."])
        moisNbr = [[NSString alloc] initWithString:@"12"];
    
    strDate = [strDate stringByReplacingOccurrencesOfString:mois withString:moisNbr];
    
        //Conversion en date
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"d MM yyyy HH:mm"];
    NSDate* d = [df dateFromString:strDate];
    
    return d;
}

#if DEBUG
-(void)show
{
    NSLog(@"%@",[NSString stringWithFormat:@"Event %@", idE]);
    NSLog(@"%@", title);
    NSLog(@"%@", summary);
}
#endif

@end
