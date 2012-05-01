//
//  Event.h
//  CNR
//
//  Created by Adrien Robert on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject
{
    NSString * idE;
    NSDate * publishedAt;
    NSDate * updatedAt;
    NSString * title;
    NSString * summary;
    NSString  * content;
}

@property (nonatomic, retain) NSString * idE;
@property (nonatomic, retain) NSDate * publishedAt;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString  * content;

- (id) init;
#if DEBUG
- (void) show;
#endif
@end
