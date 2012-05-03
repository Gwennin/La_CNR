//
//  ArticleDetailViewController.h
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 02/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ArticleDetailViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
	IBOutlet UIScrollView* scrollView;
}

-(IBAction)actionButtonPressed:(id)sender;

@end
