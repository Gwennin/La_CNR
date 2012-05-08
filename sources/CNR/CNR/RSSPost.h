//
//  RSSPost.h
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 04/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "ExternalFeed.h"

@interface RSSPost : NSManagedObject

@property (atomic, strong) NSString * title;
@property (atomic, strong) NSString * link;
@property (atomic, strong) NSDate * pubDate;
@property (atomic, strong) NSString * postDescription;
@property (atomic, strong) NSString * content;
@property (atomic) BOOL * readed;

+(NSArray*)loadFromCoreData;
+(BOOL)isInCoreData:(RSSPost*)post;

@end
