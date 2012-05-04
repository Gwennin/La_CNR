//
//  RSSPost.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 04/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "RSSPost.h"

@implementation RSSPost

@synthesize title, pubDate, link, description, content, readed;

-(id)init {
	
	self = [super init];
	
	if (self) {
		readed = NO;
	}
	
	return self;
}

@end
