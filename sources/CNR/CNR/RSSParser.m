//
//  RSSParser.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 04/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "RSSParser.h"
#import "Settings.h"

@implementation RSSParser

static RSSParser* _singletone = nil;

- (id)init
{
	if (!_singletone) {
		self = [super init];
		if(self)
		{
			Settings* settings = [Settings sharedSettings];
			
			parseURL = [[NSURL alloc] initWithString:[settings rssURI]];
			
			[self parseXMLAtURL:parseURL];
		}
		return self;
	}
    return nil;
}

+(RSSParser*)sharedRSSParser {
	
	if (!_singletone) {
		_singletone = [[RSSParser alloc] init];
	}
	
	return _singletone;
}

-(id)parseXMLAtURL:(NSURL *)url {
	
	posts = [[NSMutableArray alloc] init];
	
	[super parseXMLAtURL:url];
	
	return self;
}

@end
