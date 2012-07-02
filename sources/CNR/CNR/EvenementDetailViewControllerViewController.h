//
//  EvenementDetailViewControllerViewController.h
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 04/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Event.h"

@interface EvenementDetailViewControllerViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
	IBOutlet UIScrollView* scrollView;
}

@property (nonatomic, strong) Event * event;

-(IBAction)actionButtonPressed:(id)sender;

@end
