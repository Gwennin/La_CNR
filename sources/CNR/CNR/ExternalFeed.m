//
//  ExternalFeed.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 04/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "ExternalFeed.h"

@implementation ExternalFeed

-(id)init {
	
	if ([self superclass] == [ExternalFeed class]) {
		return [super init];
	}
	return nil;
}

- (id)parseXMLAtURL:(NSURL *)url
{
    NSXMLParser* parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser parse];
    
    if([parser parserError])
    {
        NSError* e = [parser parserError];
        NSLog(@"Error %i: %@\n%@", [e code], [e domain], [e debugDescription]);
    }
    
    return self;
}

@end
