//
//  ActualiteViewController.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "ActualiteViewController.h"
#import "ArticleDetailViewController.h"
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
												 selector:@selector(loadingData)
													 name:@"RSSLoading" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(reloadData)
													 name:@"RSSLoadEnding" object:nil];
		
		self.title = @"Actualités";
		self.tabBarItem.image = [UIImage imageNamed:@"RSS.png"];
		self.view.backgroundColor = [UIColor whiteColor];
		
		refreshView = [[UIView alloc] initWithFrame:self.view.bounds];
		
		[refreshView setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.25]];
		
		CGRect labelPos = CGRectMake(0, (self.view.bounds.size.height - 44) / 2 - 60, self.view.bounds.size.width, 20);
		UILabel* text = [[UILabel alloc] initWithFrame:labelPos];
		text.text = @"Actualisation en cours";
		text.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
		text.textAlignment = UITextAlignmentCenter;
		
		text.font = [UIFont boldSystemFontOfSize:17.0];
		text.textColor = [UIColor whiteColor];
		text.shadowColor = [UIColor grayColor];
		text.shadowOffset = CGSizeMake(0, -1);
		
		CGRect activityPos = CGRectMake(self.view.frame.size.width / 2 - 37 /2, (self.view.bounds.size.height - 44) / 2 -  37 /2, 37, 37);
		UIActivityIndicatorView* activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		activity.frame = activityPos;
		[activity startAnimating];
		
		[refreshView addSubview:text];
		[refreshView addSubview:activity];
		[self.view addSubview:refreshView];
		
		refreshView.hidden = YES;
		
	}
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
	[self reloadData];
}

-(void)loadingData {
	
	if ([data count] == 0) {
		refreshView.hidden = NO;
		[self.tableView setScrollEnabled:NO];
	}
}

-(void)reloadData {
	
	data = [RSSPost loadFromCoreData];
	
	if ([data count] != 0) {
		refreshView.hidden = YES;
		[self.tableView setScrollEnabled:YES];
	}
	
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

-(void)viewDidUnload {
	refreshView = nil;
	data = nil;
}

@end
