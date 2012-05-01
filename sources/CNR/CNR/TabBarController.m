//
//  TabBarController.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	CGRect frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, 48);
    UIView *v = [[UIView alloc] initWithFrame:frame];
    [v setBackgroundColor:[UIColor yellowColor]];
    [v setAlpha:0.5];
    [[self tabBar] addSubview:v];
}


-(void)setViewControllers:(NSArray *)viewControllers {
	
	NSMutableArray* viewControllersWithNavigationBar = [NSMutableArray array];
	
	for (UIViewController* vc in viewControllers) {
		
		UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:vc];
		navController.navigationBar.tintColor = [UIColor yellowColor];
		[viewControllersWithNavigationBar addObject:navController];
	}
	
	[super setViewControllers:viewControllersWithNavigationBar];
}

@end
