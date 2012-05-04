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

- (id)init
{
	if (!__sharedEventRepository) {
		self = [super init];
		if(self)
		{
			
			Settings* settings = [Settings sharedSettings];
			
			parseURL = [[NSURL alloc] initWithString:[settings eventURI]];
			
			[self parseXMLAtURL:parseURL];
			[self orderByDateAsc];
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
        event = [[Event alloc] init];
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
    }
    else if([elementName isEqualToString:@"content"])
    {
        [event setContent:currentNodeValue];
    }
    else if([elementName isEqualToString:@"entry"] && event)
    {
        [events addObject:event];
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
    BOOL enOrdre = NO;
    while(!enOrdre){
        enOrdre = YES;
        for (int i = 0; i+1 < [events count]; i++)
        {
            Event* e1 = [events objectAtIndex:i];
            Event* e2 = [events objectAtIndex:i+1];
            
            if([[e1 date] compare:[e2 date]] != NSOrderedAscending)
            {
                enOrdre = NO;
                [events removeObjectAtIndex:i+1];
                [events insertObject:e1 atIndex:i+1];
                
                [events removeObjectAtIndex:i];
                [events insertObject:e2 atIndex:i];
            }
        }
    }
    
    for (Event* e in events) {
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd/MM/yyyy"];
        NSLog(@"%@", [df stringFromDate:[e date]]);
    }
}

@end
