//
//  ArticleDetailViewController.h
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 02/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "RSSPost.h"

@interface ArticleDetailViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate, UIWebViewDelegate> {
	IBOutlet UILabel* titleView;
	IBOutlet UILabel* dateView;
	
	IBOutlet UIWebView* contentView;
}

@property (nonatomic, strong) RSSPost* post;

-(IBAction)actionButtonPressed:(id)sender;

@end
