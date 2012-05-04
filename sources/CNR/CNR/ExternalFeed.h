//
//  ExternalFeed.h
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 04/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExternalFeed : NSObject <NSXMLParserDelegate> {
	
	NSURL* parseURL;
}

-(id)parseXMLAtURL:(NSURL *)url;

@end
