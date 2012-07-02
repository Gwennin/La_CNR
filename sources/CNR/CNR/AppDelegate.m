//
//  AppDelegate.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "AppDelegate.h"

#import "TabBarController.h"
#import "HomeViewController.h"
#import "ActualiteViewController.h"
#import "ProgramationViewController.h"
#import "PresentationViewController.h"
#import "EventRepository.h"
#import "RSSParser.h"

#import "ManageApp.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize mainController = _mainController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self managedObjectContext];
	
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	UIViewController *homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
	UIViewController *actualiteViewController = [[ActualiteViewController alloc] initWithStyle:UITableViewStyleGrouped];
	UIViewController *programationViewController = [[ProgramationViewController alloc] initWithStyle:UITableViewStyleGrouped];
	UIViewController *presentationViewController = [[PresentationViewController alloc] init];
	
	self.mainController = [[TabBarController alloc] init];
	
	[(TabBarController*)self.mainController setViewControllers:[NSArray arrayWithObjects:homeViewController, actualiteViewController, programationViewController, presentationViewController, nil]];
	
	self.window.rootViewController = self.mainController;
    [self.window makeKeyAndVisible];
	
	ManageApp* appManager = [[ManageApp alloc] init];
	[appManager loadEvents];
	[appManager loadRSSPosts];
	
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	ManageApp* appManager = [[ManageApp alloc] init];
	[appManager loadEvents];
}

#pragma mark -
#pragma mark Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CNR" withExtension:@"momd"];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel_;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (persistentStoreCoordinator_ != nil)
    {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CNR.sqlite"];
    
    NSMutableDictionary* pragmaOptions = [NSMutableDictionary dictionary];
	[pragmaOptions setObject:@"FULL" forKey:@"synchronous"];
	[pragmaOptions setObject:@"1" forKey:@"fullfsync"];
	
	NSDictionary *storeOptions = [NSDictionary dictionaryWithObject:pragmaOptions forKey:NSSQLitePragmasOption];
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:storeOptions error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}

#pragma mark -
#pragma mark Application's Documents directory

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
