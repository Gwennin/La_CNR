//
//  EventRepository.h
//  CNR
//
//  Created by Adrien Robert on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Event.h"

@interface EventRepository : NSObject <NSXMLParserDelegate>
{
    NSMutableString* currentNodeValue;
    NSMutableArray* events;
    Event* event;
}

- (id) init;

@property (nonatomic) NSMutableArray* events;

- (id) parseXMLAtURL:(NSURL *) url;

@end
