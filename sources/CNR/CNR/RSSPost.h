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

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * link;
@property (nonatomic, strong) NSDate * pubDate;
@property (nonatomic, strong) NSString * description;
@property (nonatomic, strong) NSString * content;
@property (nonatomic) BOOL * readed;

@end
