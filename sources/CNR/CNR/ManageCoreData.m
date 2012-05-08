//
//  ManageCoreData.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 08/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "ManageCoreData.h"
#import "AppDelegate.h"

@implementation ManageCoreData

@synthesize managedObjectContext = _threadedContext;

static NSMutableDictionary* managedObjectContextThreads = nil;
static NSMutableDictionary* threads = nil;
static NSManagedObjectContext* _mainContext;

static NSString* const EventEntity = @"Event";
static NSString* const RSSPostEntity = @"RSSPost";


-(id)init {
	return [self initWithThreadName:[[NSThread currentThread] name]];
}

-(id)initWithThreadName:(NSString*)name {
	
    self = [super init];
	
	self = [super init];
	
	if (managedObjectContextThreads == nil) {
		
		managedObjectContextThreads = [[NSMutableDictionary alloc] init];
		threads = [[NSMutableDictionary alloc] init];
		
		_mainContext = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
	}
	
	if ([name length] == 0) {
		[(NSThread*)[threads objectForKey:@"Main"] cancel];
		[threads setValue:[NSThread currentThread] forKey:@"Main"];
		_threadedContext = _mainContext;
		
		return self;
	}
	
	// Si un thread possède le même nom, on l'unset et le remplace
	if ([[threads allKeys] containsObject:name] || [[managedObjectContextThreads allKeys] containsObject:name]) {
		
		[(NSThread*)[threads objectForKey:name] cancel];
		[threads setValue:[NSThread currentThread] forKey:name];
		_threadedContext = [managedObjectContextThreads valueForKey:name];
		
	}
	else {
		//sinon on créé l'objet managedObjectContext et on le stoque dans le tableau
		
		_threadedContext = self.managedObjectContext;
		
		[managedObjectContextThreads setValue:_threadedContext forKey:name];
		[threads setValue:[NSThread currentThread] forKey:name];
	}
	
	return self;
}

- (NSManagedObjectContext*)managedObjectContext {
    if (!_threadedContext) {
        _threadedContext = [[NSManagedObjectContext alloc] init];
        [_threadedContext setPersistentStoreCoordinator:[_mainContext persistentStoreCoordinator]];
        [_threadedContext setMergePolicy:NSMergeByPropertyStoreTrumpMergePolicy];
    }
	
    return _threadedContext;
}

-(NSEntityDescription*)getEventEntity {
	return [NSEntityDescription entityForName:EventEntity inManagedObjectContext:self.managedObjectContext];
}
-(NSEntityDescription*)getRSSPostEntity {
	return [NSEntityDescription entityForName:RSSPostEntity inManagedObjectContext:self.managedObjectContext];
}

-(void)save {
	
	NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
	
    [defaultCenter addObserver:self
                      selector:@selector(merge:)
                          name:NSManagedObjectContextDidSaveNotification
                        object:self.managedObjectContext];
	
    if ([[self managedObjectContext] hasChanges]) {
		
        NSError *error;
		
        BOOL contextDidSave = [[self managedObjectContext] save:&error];
		
        if (!contextDidSave) {
			NSLog(@"Failed to save to data store: %@", [error localizedDescription]);
		}
    }
	
    [defaultCenter removeObserver:self name:NSManagedObjectContextDidSaveNotification object:[self managedObjectContext]];
	
}

-(void)merge:(NSNotification *)notification {
	
	[_mainContext performSelectorOnMainThread:@selector(mergeChangesFromContextDidSaveNotification:)
                                   withObject:notification
                                waitUntilDone:YES];
	
}

+(void)removeCurrentThread {
	
	NSString * name = [[NSThread currentThread] name];
	
	if ((name != nil) && [[threads allKeys] containsObject:name]) {
		[threads removeObjectForKey:name];
	}
}

-(void)dealloc {
	
	[self save];
	// on retire le thread courrant du tableau de threads
	[ManageCoreData removeCurrentThread];
}

@end
