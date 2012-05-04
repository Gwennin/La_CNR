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

-(id)initWithTitle:(NSString*)t
			  link:(NSString*)l
   publicationDate:(NSDate*)date
	   description:(NSString*)d
		   content:(NSString*)c {
	
	self = [super init];
	
	if (self) {
		readed = NO;
		
		title = t;
		link = l;
		pubDate = date;
		description = d;
		content = c;
	}
	
	return self;
}

@end
