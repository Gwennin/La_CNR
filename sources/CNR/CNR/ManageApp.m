//
//  ManageApp.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 08/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "ManageApp.h"

#import "EventRepository.h"
#import "RSSParser.h"

@interface ManageApp()

-(void)performLoadEvents;
-(void)performLoadRSSPosts;

@end

@implementation ManageApp

-(void)loadEvents {
	[NSThread detachNewThreadSelector:@selector(performLoadEvents) toTarget:self withObject:nil];
}

-(void)loadRSSPosts {
	[NSThread detachNewThreadSelector:@selector(performLoadRSSPosts) toTarget:self withObject:nil];
}

-(void)performLoadEvents {
	
	@autoreleasepool {
		if (![[NSThread currentThread] isMainThread]) {
			[[NSThread currentThread] setName:@"Events"];
			
			[[NSNotificationCenter defaultCenter] postNotificationName:@"EventsLoading" object:nil];

			[EventRepository sharedEventRepository];

			[[NSNotificationCenter defaultCenter] postNotificationName:@"EventsLoadEnding" object:nil];
		}
	}
	
}

-(void)performLoadRSSPosts {
	
	@autoreleasepool {
		if (![[NSThread currentThread] isMainThread]) {
			[[NSThread currentThread] setName:@"RSS"];
			
			[[NSNotificationCenter defaultCenter] postNotificationName:@"RSSLoading" object:nil];
			
			[RSSParser sharedRSSParser];
			
			[[NSNotificationCenter defaultCenter] postNotificationName:@"RSSLoadEnding" object:nil];
		}
	}
}

@end
