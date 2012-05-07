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
		
		[self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.3]];
		
		CGRect rectForLabel = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
		UILabel* label = [[UILabel alloc] initWithFrame:rectForLabel];
		label.text = @"Actualisation en cours";
		label.backgroundColor = [UIColor clearColor];
		la
		
		CGRect rectForActivityIndicator = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
		UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:rectForActivityIndicator];
		
		[self addSubview:label];
		//[self addSubview:activityIndicator];
    }
    return self;
}

@end
