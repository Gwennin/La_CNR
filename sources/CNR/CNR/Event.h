//
//  Event.h
//  CNR
//
//  Created by Adrien Robert on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Event : NSManagedObject
{
    NSString * idE;
    NSDate * publishedAt;
    NSDate * updatedAt;
    NSString * title;
    NSString * summary;
    NSString  * content;
    NSDate* date;
}

@property (atomic, retain) NSString * idE;
@property (atomic, retain) NSDate * publishedAt;
@property (atomic, retain) NSDate * updatedAt;
@property (atomic, retain) NSString * title;
@property (atomic, retain) NSString * summary;
@property (atomic, retain) NSString  * content;
@property (atomic, retain) NSDate* date;

- (NSDate*) dateFromSummary;
- (NSString*) title;
- (void) setTitle:(NSString*)_title;

@end
