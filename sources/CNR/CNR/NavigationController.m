//
//  NavigationController.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 02/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

-(void)setTitleColor:(NSString*)title;

@end

@implementation NavigationController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)viewDidAppear:(BOOL)animated {
	[self setTitleColor:@"Test"];
}

-(void)setTitleColor:(NSString*)title {
	
	for (id subView in self.navigationBar.subviews) {
		if ([subView isKindOfClass:[UIButton class]]) {
			[(UIButton *)subView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
			[(UIButton *)subView setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal];
		}
		else if ([subView isKindOfClass:[UILabel class]]) {
			[(UILabel*)subView setTextColor:[UIColor blackColor]];
			[(UILabel*)subView setShadowColor:[UIColor clearColor]];
		}
	}
	/*self.t*/
	
	UILabel* titleLabel = [[UILabel alloc] init];
	titleLabel.text = title;
	titleLabel.textColor = [UIColor blackColor];
	titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.textAlignment = UITextAlignmentCenter;
	
	self.navigationItem.titleView = titleLabel;

	[titleLabel sizeToFit];
}

-(id)initWithRootViewController:(UIViewController *)rootViewController {
	
	self = [super initWithRootViewController:rootViewController];
	
	if (self) {
		[self setTitleColor:rootViewController.title];
	}
	
	return self;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
	[super pushViewController:viewController animated:animated];
	
	[self setTitleColor:viewController.title];
}

@end
