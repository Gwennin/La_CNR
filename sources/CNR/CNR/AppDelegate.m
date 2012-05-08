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

@implementation AppDelegate

@synthesize window = _window;
@synthesize mainController = _mainController;
@synthesize er;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //er = [EventRepository sharedEventRepository];
    
	//[NSThread detachNewThreadSelector:@selector(sharedEventRepository) toTarget:[EventRepository class] withObject:nil];
	
	//[RSSParser sharedRSSParser];
	
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	UIViewController *homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
	UIViewController *actualiteViewController = [[ActualiteViewController alloc] initWithStyle:UITableViewStyleGrouped];
	UIViewController *programationViewController = [[ProgramationViewController alloc] initWithStyle:UITableViewStyleGrouped];
	UIViewController *presentationViewController = [[PresentationViewController alloc] init];
	
	self.mainController = [[TabBarController alloc] init];
	
	[(TabBarController*)self.mainController setViewControllers:[NSArray arrayWithObjects:homeViewController, actualiteViewController, programationViewController, presentationViewController, nil]];
	
	self.window.rootViewController = self.mainController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
