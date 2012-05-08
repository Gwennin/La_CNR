//
//  ExternalFeed.h
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 04/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManageCoreData.h"

@interface ExternalFeed : NSObject <NSXMLParserDelegate> {
	
	NSURL* parseURL;
	ManageCoreData* mcd;
}

-(id)parseXMLAtURL:(NSURL *)url;

@end
