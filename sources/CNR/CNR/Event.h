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

@property (nonatomic, retain) NSString * idE;
@property (nonatomic, retain) NSDate * publishedAt;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString  * content;
@property (nonatomic, retain) NSDate* date;

- (id) init;

@end
