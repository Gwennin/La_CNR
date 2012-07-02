//
//  HomeViewController.h
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventRepository.h"

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    //EventRepository* er;
	
	NSArray* eventsArray;
	
	IBOutlet UIView* refreshView;
	
	IBOutlet UITableView* _tableView;
}

-(IBAction)goToTwitter:(id)sender;
-(IBAction)goToFacebook:(id)sender;

-(void)reloadData;

@end
