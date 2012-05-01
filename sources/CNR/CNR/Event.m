//
//  Event.m
//  CNR
//
//  Created by Adrien Robert on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "Event.h"

@implementation Event

@synthesize idE, publishedAt, updatedAt, title, summary, content;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#if DEBUG
-(void)show
{
    NSLog(@"%@",[NSString stringWithFormat:@"Event %@", idE]);
    NSLog(@"%@", title);
    NSLog(@"%@", summary);
}
#endif

@end
