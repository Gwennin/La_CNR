    //
    //  EventRepository.m
    //  CNR
    //
    //  Created by Adrien Robert on 01/05/12.
    //  Copyright (c) 2012 Supinfo. All rights reserved.
    //

#import "EventRepository.h"
#import "Settings.h"

@implementation EventRepository

@synthesize events;

- (NSArray*) uniqueDates
{
    if(uniqueDates == nil)
        uniqueDates = [self deleteDuplicatedDates];
    
    return uniqueDates;
}

- (id)init
{
	if (!__sharedEventRepository) {
		self = [super init];
		if(self)
		{
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
			Settings* settings = [Settings sharedSettings];
			mcd = [[ManageCoreData alloc] init];
			
            uniqueDates = nil;
			parseURL = [[NSURL alloc] initWithString:[settings eventURI]];
			
			[self parseXMLAtURL:parseURL];
            [self deleteOldEvent];
			[self orderByDateAsc];
			
			[mcd save];
			
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		}
		return self;
	}
    return nil;
}

static EventRepository* __sharedEventRepository = nil;

+ (EventRepository *) sharedEventRepository
{
    @synchronized([EventRepository class])
    {
        if(!__sharedEventRepository)
            __sharedEventRepository =[[self alloc] init];
        
        return __sharedEventRepository;
    }
    
    return nil;
}

- (id)parseXMLAtURL:(NSURL *)url
{
    events = [[NSMutableArray alloc] init];
    
	[super parseXMLAtURL:url];
    
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"entry"])
    {
		event = [[Event alloc] initWithEntity:[mcd getEventEntity] insertIntoManagedObjectContext:[mcd managedObjectContext]];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"id"])
    {
        [event setIdE:currentNodeValue];
    }
    else if([elementName isEqualToString:@"title"])
    {
        [event setTitle:currentNodeValue];
    }
    else if([elementName isEqualToString:@"published"])
    {
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd'T'hh:mm:ss.SSS'Z'"];
        [event setPublishedAt:[df dateFromString:currentNodeValue]];
    }
    else if([elementName isEqualToString:@"updated"])
    {
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd'T'hh:mm:ss.SSS'Z'"];
        [event setPublishedAt:[df dateFromString:currentNodeValue]];
    }
    else if([elementName isEqualToString:@"summary"])
    {
        [event setSummary:currentNodeValue];
		[event setDate:[event dateFromSummary]];
    }
    else if([elementName isEqualToString:@"content"])
    {
        [event setContent:currentNodeValue];
    }
    else if([elementName isEqualToString:@"entry"] && event && ![EventRepository isInCoreData:event])
    {
        [events addObject:event];
        event = nil;
    }
	else if([elementName isEqualToString:@"entry"] && event && [EventRepository isInCoreData:event])
    {
        [[mcd managedObjectContext] deleteObject:event];
        event = nil;
    }
	
    currentNodeValue = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(!currentNodeValue)
    {
        currentNodeValue = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];
    }
    else
    {
        [currentNodeValue appendString: [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    }
}

- (void) orderByDateAsc
{
    NSSortDescriptor* dateDesc = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    
    events = [NSArray arrayWithArray:[events sortedArrayUsingDescriptors:[[NSArray alloc] initWithObjects:dateDesc, nil]]];
}

- (void) deleteOldEvent
{
    NSDate* today = [[NSDate alloc] init];
    BOOL clean = NO;
    while(!clean)
    {
        clean = YES;
        for(int i = 0; i < [events count]; i++)
        {
            if([[[events objectAtIndex:i] date] compare:today] == NSOrderedAscending)
            {
                [events removeObjectAtIndex:i];
                clean = NO;
            }
        }
    }
}

- (NSArray*) deleteDuplicatedDates
{
    NSArray* dates = [events valueForKey:@"date"];
    NSMutableArray* uDates = [[NSMutableArray alloc] initWithArray:dates];
    
    NSInteger index = [dates count] - 1;
    
    if(index < 1)
        return [[NSArray alloc ] init];
    
    for(NSDate* d in dates)
    {
        if([uDates indexOfObject:d inRange:NSMakeRange(0, index)] != NSNotFound)
        {
            [uDates removeObjectAtIndex:index];
        }
        index--;
    }
    return  [NSArray arrayWithArray:uDates];
}

- (NSString*) titleForHeaderInSection:(NSInteger) section
{
    NSDate* date = [uniqueDates objectAtIndex:section];
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"]];
    [df setDateFormat:@"EEEE dd MMMM yyyy"];
    
    NSString* strDate = [df stringFromDate:date];
    
    return  [strDate stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[strDate substringWithRange:NSMakeRange(0, 1)] capitalizedString]];
}

+(NSArray *)loadFromCoreData {
	
	ManageCoreData* mcd = [[ManageCoreData alloc] init];
	NSEntityDescription* entity = [mcd getEventEntity];
	
	NSFetchRequest* request = [[NSFetchRequest alloc] init];
	
	[request setEntity:entity];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"date >= %@", [NSDate date]];
    
    [request setPredicate:predicate];
	
	NSError* error = nil;
	NSMutableArray* result = [[[mcd managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];
	
	NSSortDescriptor* sortDescDate = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES selector:@selector(compare:)];
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
	
	NSLog(@"%@", predicate);
	
	[request setPredicate:predicate];
	
	NSError* error = nil;
	NSMutableArray* result = [[[mcd managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];
	
	NSSortDescriptor* sortDescDate = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES selector:@selector(compare:)];
	NSSortDescriptor* sortDescTitle = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
	
	[result sortUsingDescriptors:[NSArray arrayWithObjects:sortDescDate, sortDescTitle, nil]];
	
	return result;
}
@end
