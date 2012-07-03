//
//  EvenementDetailViewController.h
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 04/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Event.h"

@interface EvenementDetailViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate, UIWebViewDelegate> {
	IBOutlet UIScrollView* scrollView;
	
	IBOutlet UIWebView* text;
	IBOutlet UILabel * eventTitle;
	IBOutlet UILabel * date;
}

@property (nonatomic, strong) Event * event;

-(IBAction)actionButtonPressed:(id)sender;

@end
