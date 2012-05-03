//
//  TabBarController.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	CGRect frame = CGRectMake(0.0, 1.0, self.view.bounds.size.width, 48);
    UIImageView *v = [[UIImageView alloc] initWithFrame:frame];
	[v setImage:[UIImage imageNamed:@"BGTabBar.png"]];
    [[self tabBar] addSubview:v];
}


-(void)setViewControllers:(NSArray *)viewControllers {
	
	NSMutableArray* viewControllersWithNavigationBar = [NSMutableArray array];
	
	for (UIViewController* vc in viewControllers) {
		
		NavigationController* navController = [[NavigationController alloc] initWithRootViewController:vc];
		
		
		
		navController.navigationBar.tintColor = [UIColor colorWithRed:253.0/255.0f green:228.0/255.0f blue:0 alpha:1.0];
		
		[viewControllersWithNavigationBar addObject:navController];
	}
	
	[super setViewControllers:viewControllersWithNavigationBar];
}

@end
