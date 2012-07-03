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

@synthesize idE, publishedAt, updatedAt, title, summary, content;
@synthesize date;

/*- (NSDate*) date
{
    if(!date)
        date = [self dateFromSummary];
    
    return date;
}*/

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

	return nil;
}

+(NSArray *)loadFromCoreData {
	
	ManageCoreData* mcd = [[ManageCoreData alloc] init];
	NSEntityDescription* entity = [mcd getEventEntity];
	
	NSFetchRequest* request = [[NSFetchRequest alloc] init];
	
	[request setEntity:entity];
	
	NSError* error = nil;
	NSMutableArray* result = [[[mcd managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];
	
	NSSortDescriptor* sortDescDate = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO selector:@selector(compare:)];
	NSSortDescriptor* sortDescTitle = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
	
	[result sortUsingDescriptors:[NSArray arrayWithObjects:sortDescDate, sortDescTitle, nil]];
	
	NSMutableArray* events = [NSMutableArray array];
	Event* lastObj = nil;
	if ([result count]) {
		lastObj = [result objectAtIndex:0];
		[events addObject:[NSMutableArray arrayWithObject:lastObj]];
	}
	int currentIndex = 0;
	
	for (int i = 1; i < [result count]; i++) {
		
		Event* currentObj = [result objectAtIndex:i];
		
		NSCalendar *cal = [NSCalendar currentCalendar];
		NSDateComponents* components = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
																	   fromDate:[currentObj date]];
		NSDate* currentObjDate = [cal dateFromComponents:components];
		
		components = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
													 fromDate:[lastObj date]];
		NSDate* lastObjDate = [cal dateFromComponents:components];
		
		if ([currentObjDate isEqualToDate:lastObjDate]) {
			[[events objectAtIndex:currentIndex] addObject:currentObj];
		}
		else {
			[events addObject:[NSMutableArray arrayWithObject:currentObj]];
			currentIndex++;
		}
		
		lastObj = currentObj;
	}
	
	return events;
}

+(BOOL)isInCoreData:(Event*)event {
	
	ManageCoreData* mcd = [[ManageCoreData alloc] init];
	
	NSEntityDescription* entity = [mcd getEventEntity];
	
	NSFetchRequest* request = [[NSFetchRequest alloc] init];
	
	[request setEntity:entity];
	
	NSPredicate* predicate =  [NSPredicate predicateWithFormat:@"(idE == %@)", [event idE]];
	[request setPredicate:predicate];
	
	NSError* error = nil;
	NSUInteger count = [[mcd managedObjectContext] countForFetchRequest:request error:&error];
	
	// Si plus d'un article ayant le même post link c'est qu'il est en doublon
	if (count > 1) {
		return YES;
	}
	return NO;
}

+(NSArray*)getThreeFutureEvents {
	
	ManageCoreData* mcd = [[ManageCoreData alloc] init];
	NSEntityDescription* entity = [mcd getEventEntity];
	
	NSFetchRequest* request = [[NSFetchRequest alloc] init];
	[request setEntity:entity];
	
	[request setFetchLimit:3];
	
	NSDate* today = [NSDate date];
	NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(date >= %@)", today];
		
	[request setPredicate:predicate];
	
	NSError* error = nil;
	NSMutableArray* result = [[[mcd managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];
	
	NSSortDescriptor* sortDescDate = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO selector:@selector(compare:)];
	NSSortDescriptor* sortDescTitle = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
	
	[result sortUsingDescriptors:[NSArray arrayWithObjects:sortDescDate, sortDescTitle, nil]];
	
	return result;
}

@end
