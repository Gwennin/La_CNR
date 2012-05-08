//
//  ActivityIndicator.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 04/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "ActivityIndicator.h"

@implementation ActivityIndicator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		
		[self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.6]];
		
		CGSize labelSize = [@"Actualisation en cours" sizeWithFont:[UIFont systemFontOfSize:17]];
		CGRect rectForLabel = CGRectMake((self.frame.size.width / 2) - (labelSize.width / 2),
										 (self.frame.size.height / 2) - (labelSize.height / 2) - 20,
										 labelSize.width,
										 labelSize.height);
		
		UILabel* label = [[UILabel alloc] initWithFrame:rectForLabel];
		label.text = @"Actualisation en cours";
		label.textColor = [UIColor whiteColor];
		label.backgroundColor = [UIColor clearColor];
		label.shadowColor = [UIColor lightGrayColor];
		label.shadowOffset = CGSizeMake(0, -1);
		
		//la
		
		CGRect rectForActivityIndicator = CGRectMake((self.frame.size.width / 2) - 18.5,
															(self.frame.size.height / 2) + 1.5,
															37,
															37);
		UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[activityIndicator setFrame:rectForActivityIndicator];
		[activityIndicator startAnimating];
		[activityIndicator setHidden:NO];
		
		[self addSubview:label];
		[self addSubview:activityIndicator];
    }
    return self;
}

@end
