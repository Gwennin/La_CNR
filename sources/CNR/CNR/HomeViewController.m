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
	
	cell.textLabel.text = [NSString stringWithFormat:@"Prochaisn évènements %i", indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)goToTwitter:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://mobile.twitter.com/lacnr"]];
}

-(void)goToFacebook:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.facebook.com/La.cantine.numerique.rennaise"]];
}

@end
