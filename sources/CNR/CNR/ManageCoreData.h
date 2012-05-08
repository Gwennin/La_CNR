//
//  ManageCoreData.h
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 08/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ManageCoreData : NSObject {
	NSManagedObjectContext* _threadedContext;
}

@property (atomic, strong, readonly) NSManagedObjectContext* managedObjectContext;


-(id)init;
-(id)initWithThreadName:(NSString*)name;

-(NSEntityDescription*)getEventEntity;
-(NSEntityDescription*)getRSSPostEntity;

-(void)save;
-(void)merge:(NSNotification*)notification;
+(void)removeCurrentThread;

-(void) dealloc;

@end
