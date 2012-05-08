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

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"item"])
    {
        post = [[RSSPost alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"title"])
    {
        [post setTitle:currentNodeValue];
    }
    else if([elementName isEqualToString:@"link"])
    {
        [post setLink:currentNodeValue];
    }
    else if([elementName isEqualToString:@"pubDate"])
    {
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"eee, dd MMM yyyy HH:mm:ss ZZZZ"];
		[df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
		
        [post setPubDate:[df dateFromString:@"Sun, 03 May 2009 19:58:58 -0700"]];
    }
	else if([elementName isEqualToString:@"description"])
    {
        [post setPostDescription:currentNodeValue];
    }
    else if([elementName isEqualToString:@"content:encoded"])
    {
        [post setContent:currentNodeValue];
    }
    else if([elementName isEqualToString:@"item"] && post)
    {
        [posts addObject:post];
        post = nil;
    }
    currentNodeValue = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(!currentNodeValue)
    {
        currentNodeValue = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];
    }
    else
    {
        [currentNodeValue appendString: [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    }
}

@end
