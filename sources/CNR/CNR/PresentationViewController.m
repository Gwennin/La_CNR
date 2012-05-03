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
        self.title = @"Présentation";
		self.tabBarItem.image = [UIImage imageNamed:@"Presentation.png"];
		
		NSString* path = [[NSBundle mainBundle] pathForResource:@"presentation" ofType:@"html"];
		NSURL* url = [[NSURL alloc] initFileURLWithPath:path];
        NSURLRequest* req = [NSURLRequest requestWithURL:url];
		
		self.view = [[UIWebView alloc] initWithFrame:self.view.frame];
        [(UIWebView*)self.view loadRequest:req];
		[(UIWebView*)self.view setBackgroundColor:[UIColor whiteColor]];
		
		for (id subview in self.view.subviews)
			if ([[subview class] isSubclassOfClass: [UIScrollView class]]) {
				((UIScrollView *)subview).bounces = NO;
				((UIScrollView *)subview).showsHorizontalScrollIndicator = NO;
			}
		
		[(UIWebView*)self.view setDelegate:self];
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    [[UIApplication sharedApplication] openURL:request.URL];
    return YES;
}

@end
