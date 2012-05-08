//
//  Settings.h
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 04/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Settings : NSObject

@property (atomic, strong, readonly) NSString* cantineURI;
@property (atomic, strong, readonly) NSString* facebookURI;
@property (atomic, strong, readonly) NSString* twitterURI;
@property (atomic, strong, readonly) NSString* eventURI;
@property (atomic, strong, readonly) NSString* rssURI;
@property (atomic, strong, readonly) NSString* settingsVersion;

+(Settings*)sharedSettings;

-(void)save;
-(void)update;

@end
