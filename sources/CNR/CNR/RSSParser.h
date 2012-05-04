//
//  RSSParser.h
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 04/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "ExternalFeed.h"

@interface RSSParser : ExternalFeed {
	NSMutableArray* posts;
}

+(RSSParser*)sharedRSSParser;

@end
