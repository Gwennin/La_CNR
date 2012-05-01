//
//  PresentationViewController.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "PresentationViewController.h"

@interface PresentationViewController ()

@end

@implementation PresentationViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Programation";
		self.tabBarItem.image = [UIImage imageNamed:@"Presentation.png"];
		
		NSURL* url = [[NSURL alloc] initWithString:@"http://gwennin.me"];
        NSURLRequest* req = [NSURLRequest requestWithURL:url];
		
		self.view = [[UIWebView alloc] initWithFrame:self.view.frame];
        [(UIWebView*)self.view loadRequest:req];
		[(UIWebView*)self.view setBackgroundColor:[UIColor whiteColor]];
		
		for (id subview in self.view.subviews)
			if ([[subview class] isSubclassOfClass: [UIScrollView class]])
				((UIScrollView *)subview).bounces = NO;
		
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
