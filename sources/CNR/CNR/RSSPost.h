//
//  RSSPost.h
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 04/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExternalFeed.h"

@interface RSSPost : NSObject

@property (nonatomic, strong, readonly) NSString * title;
@property (nonatomic, strong, readonly) NSString * link;
@property (nonatomic, strong, readonly) NSDate * pubDate;
@property (nonatomic, strong, readonly) NSString * description;
@property (nonatomic, strong, readonly) NSString * content;
@property (nonatomic) BOOL * readed;

-(id)initWithTitle:(NSString*)t
			  link:(NSString*)l
   publicationDate:(NSDate*)date
	   description:(NSString*)d
		   content:(NSString*)c;

@end
