//
//  HomeViewController.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
		self.title = @"Accueil";
		self.tabBarItem.image = [UIImage imageNamed:@"HomeButton.png"];
        //er = [EventRepository sharedEventRepository];
		[NSThread detachNewThreadSelector:@selector(sharedEventRepository) toTarget:[EventRepository class] withObject:nil];
    }
    return self;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Prochains évènements";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FastView"];
    Event* e = [[er events] objectAtIndex:[indexPath row]];
	cell.textLabel.text = [NSString stringWithFormat:@"%@", [e title]];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[settings facebookURI]]];}

@end
