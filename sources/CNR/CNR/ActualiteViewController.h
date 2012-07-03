//
//  ActualiteViewController.h
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityIndicator.h"

@interface ActualiteViewController : UITableViewController {
		
	NSArray* data;
	
	UIView * refreshView;
}

-(void)loadingData;
-(void)reloadData;

@end
