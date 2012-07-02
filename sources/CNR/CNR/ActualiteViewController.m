//
//  ActualiteViewController.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "ActualiteViewController.h"
#import "ArticleDetailViewController.h"
#import "ActivityIndicator.h"
#import "ManageApp.h"
#import "RSSPost.h"

@interface ActualiteViewController ()

@end

@implementation ActualiteViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
				
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(reloadData)
													 name:@"RSSLoadEnding" object:nil];
		
		self.title = @"Actualités";
		self.tabBarItem.image = [UIImage imageNamed:@"RSS.png"];
		self.view.backgroundColor = [UIColor whiteColor];
		
	}
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
	[self reloadData];
	
	ManageApp* appManager = [[ManageApp alloc] init];
	[appManager loadRSSPosts];
}

-(void)reloadData {	
	data = [RSSPost loadFromCoreData];
	[self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[data objectAtIndex:section] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	df.locale = [NSLocale currentLocale];
	df.dateFormat = @"EEEE, dd MMMM yyyy";
	
	return [df stringFromDate:[[[data objectAtIndex:section] objectAtIndex:0] pubDate]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ActuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
    
	if ([[[[data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] title] length] != 0) {
		cell.textLabel.text = [[[data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] title];
	}
	else {
		cell.textLabel.text = @"Aucun titre";
	}
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

	ArticleDetailViewController* advc = [[ArticleDetailViewController alloc] initWithNibName:@"ArticleDetailViewController" bundle:nil];
	[advc setPost:[[data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
	
	[self.navigationController pushViewController:advc animated:YES];
}

@end
