//
//  Settings.h
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 04/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Settings : NSObject

@property (nonatomic, strong, readonly) NSString* cantineURI;
@property (nonatomic, strong, readonly) NSString* facebookURI;
@property (nonatomic, strong, readonly) NSString* twitterURI;
@property (nonatomic, strong, readonly) NSString* eventURI;
@property (nonatomic, strong, readonly) NSString* rssURI;
@property (nonatomic, strong, readonly) NSString* settingsVersion;

+(Settings*)sharedSettings;

-(void)save;
-(void)update;

@end
