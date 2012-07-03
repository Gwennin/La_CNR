//
//  ArticleDetailViewController.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 02/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "ArticleDetailViewController.h"
#import <Twitter/Twitter.h>

@interface ArticleDetailViewController ()

@end

@implementation ArticleDetailViewController

@synthesize post;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Actualité";
		
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

-(void)viewDidLoad {
	[super viewDidLoad];
	
	titleView.text = [post title];
	
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	df.locale = [NSLocale currentLocale];
	df.dateFormat = @"EEEE, dd MMMM yyyy à HH:mm";
	
	dateView.text = [df stringFromDate:[post pubDate]];
	
	[contentView loadHTMLString:[post content] baseURL:nil];
	
	[contentView setBackgroundColor:[UIColor whiteColor]];
	
	for (id subview in contentView.subviews)
		if ([[subview class] isSubclassOfClass: [UIScrollView class]]) {
			((UIScrollView *)subview).bounces = NO;
			((UIScrollView *)subview).showsHorizontalScrollIndicator = NO;
		}
	
	[contentView setDelegate:self];
	
	UIBarButtonItem* actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionButtonPressed:)];
	self.navigationItem.rightBarButtonItem = actionButton;
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
														otherButtonTitles:@"Envoyer par e-mail", @"Tweeter l'article", @"Ouvrir dans Safari", nil];
	} else {
		actionSheet = [[UIActionSheet alloc] initWithTitle:[self.navigationItem title]
																 delegate:self 
														cancelButtonTitle:@"Annuler"
												   destructiveButtonTitle:nil
														otherButtonTitles:@"Envoyer par e-mail", @"Ouvrir dans Safari", nil];
	}
	
    	
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	
	switch (buttonIndex) {
		case 0:
			//Petit bug de compillation, corrigéavec un if true
		if (YES) {
			MFMailComposeViewController* mailComposeController = [[MFMailComposeViewController alloc] init];
			[mailComposeController setMailComposeDelegate:self];
			[mailComposeController setSubject:post.title];
			
			NSDateFormatter* df = [[NSDateFormatter alloc] init];
			df.locale = [NSLocale currentLocale];
			df.dateFormat = @"EEEE, dd MMMM yyyy à HH:mm";
			
			NSString *mail = [NSString stringWithFormat:@"<h1 style=\"font-size:20px;\">%@</h1><br />%@<br /><br />%@<br /><br /><a href=\"%@\">%@</a>",
							  post.title, [df stringFromDate:[post pubDate]], post.content, post.link, post.link];

			[mailComposeController setMessageBody:mail isHTML:YES];
			
			[self presentModalViewController:mailComposeController animated:YES];
		}
			break;
		case 1:
			if ([[[UIDevice currentDevice] systemVersion] intValue] >= 5) {
				if ([TWTweetComposeViewController canSendTweet])
				{
					TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
					
					NSString *tweet = [NSString stringWithFormat:@"%@ %@ via @laCNR", post.title, post.link];
					[tweetSheet setInitialText:tweet];
					[self presentModalViewController:tweetSheet animated:YES];
				}
				break;
			}
		case 2:
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:post.link]];
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
