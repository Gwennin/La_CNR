//
//  HomeViewController.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "HomeViewController.h"
#import "EvenementDetailViewController.h"
#import "EventRepository.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(loadingData)
													 name:@"EventsLoading" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(reloadData)
													 name:@"EventsLoadEnding" object:nil];
		
		self.title = @"Accueil";
		self.tabBarItem.image = [UIImage imageNamed:@"HomeButton.png"];
	}
    return self;
}

-(void)viewDidLoad {
	
	[super viewDidLoad];
	
	[self reloadData];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (([eventsArray count] == 0) ) {
		return @"Aucun évènement";
	}
	else if ([eventsArray count] == 1) {
		return @"Prochain évènement";
	}
	else {
		return @"Prochains évènements";
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [eventsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FastView"];
    Event* e = [eventsArray objectAtIndex:indexPath.row];
    
    NSString* title = ([[e title] length] != 0) ? [e title] : @"Événement sans titre";
	cell.textLabel.text = [NSString stringWithFormat:@"%@", title];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EvenementDetailViewController* edvc = [[EvenementDetailViewController alloc] initWithNibName:@"EvenementDetailViewController" bundle:nil];
	[edvc setEvent:[eventsArray objectAtIndex:indexPath.row]];
	
	[self.navigationController pushViewController:edvc animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)goToTwitter:(id)sender {
	Settings* settings = [Settings sharedSettings];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[settings twitterURI]]];
}

-(void)goToFacebook:(id)sender {
	Settings* settings = [Settings sharedSettings];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[settings facebookURI]]];
}

-(void)loadingData {
	
	if ([eventsArray count] == 0) {
		refreshView.hidden = NO;
	}
}

-(void)reloadData {
		
	refreshView.hidden = YES;
		
	eventsArray = [EventRepository getThreeFutureEvents];
	
	[_tableView reloadData];
}

-(void)viewDidUnload {
	
	refreshView = nil;
	eventsArray = nil;
	_tableView = nil;
}

@end
