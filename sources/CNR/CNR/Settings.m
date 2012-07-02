//
//  Settings.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 04/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "Settings.h"

@implementation Settings

@synthesize cantineURI, facebookURI, twitterURI, eventURI, rssURI, settingsVersion;

static Settings* _singletone = nil;

+(Settings *)sharedSettings {
	
	if (!_singletone) {
		_singletone = [[Settings alloc] init];
	}
	
	return _singletone;
}

-(id)init {
	self = [super init];
	
	if (self) {
			
		 // On récupère le chemin du fichier Settings.plist
		NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		path = [path stringByAppendingPathComponent:@"Settings.plist"];
			
		// Si le fichier Document/Settings.plist n'existe pas on récupère les settings dans le Settings.plist contenu dans le .app
		if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
			path = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
		}
			
		// on recupère le contenu du plist
		NSDictionary* plistSettingsfile = [[NSDictionary alloc] initWithContentsOfFile:path];
		
		cantineURI = [plistSettingsfile objectForKey:@"cantineURI"];
		facebookURI = [plistSettingsfile objectForKey:@"facebookURI"];
		twitterURI = [plistSettingsfile objectForKey:@"twitterURI"];
		eventURI = [plistSettingsfile objectForKey:@"eventURI"];
		rssURI = [plistSettingsfile objectForKey:@"rssURI"];
		settingsVersion = [plistSettingsfile objectForKey:@"settingsVersion"];
		
		[self update];
	}
	
	return self;
}

-(void)save {
	
	// On récupère le chemin du fichier Settings.plist
	NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	path = [path stringByAppendingPathComponent:@"Settings.plist"];
	
	// Si le fichier Document/Settings.plist n'existe pas on crée Settings.plist dans le bon chemin
	if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
		NSError* error;
		[[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"]
												toPath:path error:&error];
	}
	
	NSMutableDictionary* plistSettingsfile = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
	
	// Save Content here
	
	[plistSettingsfile writeToFile:path atomically:YES];
}

-(void)update {
	
	// On récupère le chemin du fichier Settings.plist
	NSString* path = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
		
		// on recupère le contenu du plist
		NSDictionary* plistSettingsfile = [[NSDictionary alloc] initWithContentsOfFile:path];
		
		NSString* bundleAppSettingsVersion = [plistSettingsfile objectForKey:@"settingsVersion"];
		
		if (![bundleAppSettingsVersion isEqualToString:settingsVersion]) {
			
			// on met à jours les settings en readonly seulement
			cantineURI = [plistSettingsfile objectForKey:@"cantineURI"];
			facebookURI = [plistSettingsfile objectForKey:@"facebookURI"];
			twitterURI = [plistSettingsfile objectForKey:@"twitterURI"];
			eventURI = [plistSettingsfile objectForKey:@"eventURI"];
			rssURI = [plistSettingsfile objectForKey:@"rssURI"];
			settingsVersion = [plistSettingsfile objectForKey:@"settingsVersion"];
		}
	}
}

-(void)dealloc {
	[self save];
}

@end
