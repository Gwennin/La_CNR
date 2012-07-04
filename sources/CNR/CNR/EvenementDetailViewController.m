//
//  EvenementDetailViewController.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 04/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <Twitter/Twitter.h>
#import "EvenementDetailViewController.h"

@interface EvenementDetailViewController ()

@end

@implementation EvenementDetailViewController

@synthesize event;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Événement";
		
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

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	scrollView.contentSize = CGSizeMake(320, 1050);
	
	UIBarButtonItem* actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionButtonPressed:)];
	self.navigationItem.rightBarButtonItem = actionButton;
	
	if (event) {
		
		eventTitle.text = event.title;
				
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		df.locale = [NSLocale currentLocale];
		df.dateFormat = @"EEEE, dd MMMM yyyy à HH:mm";
		
		date.text = [df stringFromDate:event.date];
		
		[text loadHTMLString:event.content baseURL:nil];
		
		[text setBackgroundColor:[UIColor whiteColor]];
		
		for (id subview in text.subviews)
			if ([[subview class] isSubclassOfClass: [UIScrollView class]]) {
				((UIScrollView *)subview).bounces = NO;
				((UIScrollView *)subview).showsHorizontalScrollIndicator = NO;
			}
		
		[text setDelegate:self];
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)actionButtonPressed:(id)sender {
	
	UIActionSheet* actionSheet;
	
	if ([[[UIDevice currentDevice] systemVersion] intValue] >= 5) {
		actionSheet = [[UIActionSheet alloc] initWithTitle:[self.navigationItem title]
												  delegate:self 
										 cancelButtonTitle:@"Annuler"
									destructiveButtonTitle:nil
										 otherButtonTitles: @"Me rappeler 2h avant", @"Envoyer par e-mail", @"Tweeter l'événement", nil];
	} else {
		actionSheet = [[UIActionSheet alloc] initWithTitle:[self.navigationItem title]
												  delegate:self 
										 cancelButtonTitle:@"Annuler"
									destructiveButtonTitle:nil
										 otherButtonTitles: @"Me rappeler 2h avant", @"Envoyer par e-mail", nil];
	}
	
	
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	
	switch (buttonIndex) {
		case 0:
			//Petit bug de compillation, corrigé avec un if true
			if (TRUE) {	
				// date & heure dans 7200 s (2h)
				// NSDateInterval est exprimé en secondes
				NSDate * theFuture = [[event date] dateByAddingTimeInterval:-7200];
				
				UILocalNotification *localNotification = [[UILocalNotification alloc] init];
				
				// On set la Date de "lancement" de la notification
				localNotification.fireDate = theFuture;
				localNotification.timeZone = [NSTimeZone defaultTimeZone];
				
				
				// On set les messages 
				NSDateFormatter* df = [[NSDateFormatter alloc] init];
				df.locale = [NSLocale currentLocale];
				df.dateFormat = @"EEEE, dd MMMM yyyy à HH:mm";
				
				localNotification.alertBody = [NSString stringWithFormat:@"%@\n%@ à la Cantine numérique rennaise", event.title, [df stringFromDate:event.date]];
				
				// Sons & Application Badge
				
				localNotification.soundName = UILocalNotificationDefaultSoundName;
								
				[[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
			}
			break;
		case 1:
			//Petit bug de compillation, corrigéavec un if true
			if (YES) {
				MFMailComposeViewController* mailComposeController = [[MFMailComposeViewController alloc] init];
				[mailComposeController setMailComposeDelegate:self];
				[mailComposeController setSubject:event.title];
				
				NSDateFormatter* df = [[NSDateFormatter alloc] init];
				df.locale = [NSLocale currentLocale];
				df.dateFormat = @"EEEE, dd MMMM yyyy à HH:mm";
				
				NSString *mail = [NSString stringWithFormat:@"<h1 style=\"font-size:20px;\">%@</h1><br />%@<br /><br />%@<br />",
								  event.title, [df stringFromDate:event.date], event.content];
				
				[mailComposeController setMessageBody:mail isHTML:YES];
				
				[self presentModalViewController:mailComposeController animated:YES];
			}
			break;
		case 2:
			if ([[[UIDevice currentDevice] systemVersion] intValue] >= 5) {
				if ([TWTweetComposeViewController canSendTweet])
				{
					TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
					
					NSDateFormatter* df = [[NSDateFormatter alloc] init];
					df.locale = [NSLocale currentLocale];
					df.dateFormat = @"EEEE, dd MMMM yyyy à HH:mm";
					
					NSString *tweet = [NSString stringWithFormat:@"%@ %@ à la Cantine numérique rennaise via @laCNR", event.title, [df stringFromDate:event.date]];
					
					[tweetSheet setInitialText:tweet];
					[self presentModalViewController:tweetSheet animated:YES];
				}
				break;
			}
			break;
	}
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	
	[controller dismissModalViewControllerAnimated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	
	if (![[request URL] host]) {
		return YES;
	}
	
    [[UIApplication sharedApplication] openURL:request.URL];
    return NO;
}

@end
