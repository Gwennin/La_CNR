//
//  ArticleDetailViewController.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 02/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "ArticleDetailViewController.h"

@interface ArticleDetailViewController ()

@end

@implementation ArticleDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Actualités";
		
		/*UILabel* titleLabel = [[UILabel alloc] init];
		titleLabel.text = self.title;
		titleLabel.textColor = [UIColor blackColor];
		titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.textAlignment = UITextAlignmentCenter;
		
		self.navigationItem.titleView = titleLabel;
		
		[titleLabel sizeToFit];*/
	
	}
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
