//
//  EvenementDetailViewControllerViewController.m
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
        self.title = @"Évènement";
		
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
										 otherButtonTitles: @"Me rappeler 2h avant", @"Envoyer par e-mail", @"Tweeter l'évènement", @"Ouvrir Dans Safari", nil];
	} else {
		actionSheet = [[UIActionSheet alloc] initWithTitle:[self.navigationItem title]
												  delegate:self 
										 cancelButtonTitle:@"Annuler"
									destructiveButtonTitle:nil
										 otherButtonTitles: @"Me rappeler 2h avant", @"Envoyer par e-mail", @"Ouvrir Dans Safari", nil];
	}
	
	
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	
	switch (buttonIndex) {
		case 0:
			//Petit bug de compillation, corrigé avec un if true
			if (TRUE) {
				NSDate * now = [NSDate date];	
				// date & heure dans 5 s
				// NSDateInterval est exprimé en secondes
				NSDate * theFuture = [now dateByAddingTimeInterval:5];
				
				UILocalNotification *localNotification = [[UILocalNotification alloc] init];
				
				// On set la Date de "lancement" de la notification
				localNotification.fireDate = theFuture;
				localNotification.timeZone = [NSTimeZone defaultTimeZone];
				
				// On set les messages 
				localNotification.alertBody = @"Ceci est un super message!\n Apple est génial!\nAchetez Apple!";
				
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
				[mailComposeController setSubject:@"Intitulé de l'évènement"];
				[mailComposeController setMessageBody:@"SuperContenu" isHTML:NO];
				
				[self presentModalViewController:mailComposeController animated:YES];
			}
			break;
		case 2:
			if ([[[UIDevice currentDevice] systemVersion] intValue] >= 5) {
				if ([TWTweetComposeViewController canSendTweet])
				{
					TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
					[tweetSheet setInitialText:@"Testing Tweets With iOS"];
					[self presentModalViewController:tweetSheet animated:YES];
				}
				break;
			}
		case 3:
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://github.com/Gwennin/CNR_iOS_app"]];
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
