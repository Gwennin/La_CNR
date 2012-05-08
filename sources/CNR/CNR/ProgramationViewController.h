//
//  ProgramationViewController.h
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventRepository.h"
#import "ActivityIndicator.h"

@interface ProgramationViewController : UITableViewController
{
    EventRepository* er;
	
	ActivityIndicator* loadView;
}

@end
