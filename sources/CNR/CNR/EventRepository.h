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

@property (nonatomic) NSMutableArray* events;

+ (EventRepository*) sharedEventRepository;
    
    //Methode retournant les jours où il y a un event

@end
