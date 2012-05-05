//
//  EventRepository.h
//  CNR
//
//  Created by Adrien Robert on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Event.h"
#import "ExternalFeed.h"

@interface EventRepository : ExternalFeed
{
    NSMutableString* currentNodeValue;
    NSMutableArray* events;
    Event* event;
    NSArray* uniqueDates;
}

@property (nonatomic) NSMutableArray* events;

+ (EventRepository*) sharedEventRepository;
- (NSString*) titleForHeaderInSection:(NSInteger) section;
- (NSArray*) uniqueDates;
@end
