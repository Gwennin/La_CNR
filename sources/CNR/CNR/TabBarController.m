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
	
	CGRect frame = CGRectMake(0.0, 1.0, self.view.bounds.size.width, 48);
    UIImageView *v = [[UIImageView alloc] initWithFrame:frame];
	[v setImage:[UIImage imageNamed:@"BGTabBar.png"]];
    //[v setBackgroundColor:[UIColor colorWithRed:253.0/255.0f green:228.0/255.0f blue:0 alpha:1.0]];
    //[v setAlpha:0.95];
    [[self tabBar] addSubview:v];
}


-(void)setViewControllers:(NSArray *)viewControllers {
	
	NSMutableArray* viewControllersWithNavigationBar = [NSMutableArray array];
	
	for (UIViewController* vc in viewControllers) {
		
		UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:vc];
		
		UILabel* titleLabel = [[UILabel alloc] init];
		titleLabel.text = vc.title;
		titleLabel.textColor = [UIColor blackColor];
		titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.textAlignment = UITextAlignmentCenter;
		
		navController.navigationBar.topItem.titleView = titleLabel;
		
		[titleLabel sizeToFit];
		
		navController.navigationBar.tintColor = [UIColor colorWithRed:253.0/255.0f green:228.0/255.0f blue:0 alpha:1.0];
		
		[viewControllersWithNavigationBar addObject:navController];
	}
	
	[super setViewControllers:viewControllersWithNavigationBar];
}

@end