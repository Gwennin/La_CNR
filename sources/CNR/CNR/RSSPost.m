//
//  RSSPost.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 04/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "RSSPost.h"
#import "ManageCoreData.h"

@implementation RSSPost

@synthesize title, pubDate, link, postDescription, content, readed;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context {
	
	self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
	
	if (self) {
		readed = NO;
	}
	
	return self;
}

+(NSArray *)loadFromCoreData {
	
	ManageCoreData* mcd = [[ManageCoreData alloc] init];
	NSEntityDescription* entity = [mcd getRSSPostEntity];
	
	NSFetchRequest* request = [[NSFetchRequest alloc] init];
	
	[request setEntity:entity];
	
	// http://stackoverflow.com/a/7304350
	[request setReturnsObjectsAsFaults:NO];
	
	NSError* error = nil;
	NSMutableArray* result = [[[mcd managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];
	
	NSSortDescriptor* sortDescDate = [[NSSortDescriptor alloc] initWithKey:@"pubDate" ascending:NO selector:@selector(compare:)];
	NSSortDescriptor* sortDescTitle = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];

	[result sortUsingDescriptors:[NSArray arrayWithObjects:sortDescDate, sortDescTitle, nil]];
	
	NSMutableArray* posts = [NSMutableArray array];
	RSSPost* lastObj = nil;
	if ([result count]) {
		lastObj = [result objectAtIndex:0];
		[posts addObject:[NSMutableArray arrayWithObject:lastObj]];
	}
	int currentIndex = 0;
	
	for (int i = 1; i < [result count]; i++) {
		
		RSSPost* currentObj = [result objectAtIndex:i];
		
		NSCalendar *cal = [NSCalendar currentCalendar];
		NSDateComponents* components = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
																		   fromDate:[currentObj pubDate]];
		NSDate* currentObjDate = [cal dateFromComponents:components];
		
		components = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
													 fromDate:[lastObj pubDate]];
		NSDate* lastObjDate = [cal dateFromComponents:components];
		
		if ([currentObjDate isEqualToDate:lastObjDate]) {
			[[posts objectAtIndex:currentIndex] addObject:currentObj];
		}
		else {
			[posts addObject:[NSMutableArray arrayWithObject:currentObj]];
			currentIndex++;
		}
		
		lastObj = currentObj;
	}
	
	return posts;
}

+(BOOL)isInCoreData:(RSSPost*)post {
	
	ManageCoreData* mcd = [[ManageCoreData alloc] init];
	
	NSEntityDescription* entity = [mcd getRSSPostEntity];
	
	NSFetchRequest* request = [[NSFetchRequest alloc] init];
	
	[request setEntity:entity];
	
	NSPredicate* predicate =  [NSPredicate predicateWithFormat:@"(link == %@)", [post link]];
	[request setPredicate:predicate];
	
	NSError* error = nil;
	NSUInteger count = [[mcd managedObjectContext] countForFetchRequest:request error:&error];
	
	// Si plus d'un article ayant le même post link c'est qu'il est en doublon
	if (count > 1) {
		return YES;
	}
	return NO;
}

@end
