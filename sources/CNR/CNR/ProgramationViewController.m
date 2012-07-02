//
//  ProgramationViewController.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "ProgramationViewController.h"
#import "EvenementDetailViewControllerViewController.h"

@interface ProgramationViewController ()

@end

@implementation ProgramationViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(loadingData)
													 name:@"EventLoading" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(reloadData)
													 name:@"EventLoadEnding" object:nil];
		
		self.title = @"Programmation";
		self.tabBarItem.image = [UIImage imageNamed:@"programation.png"];
		self.view.backgroundColor = [UIColor whiteColor];
		
		[self reloadData];
	}
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)loadingData {
	
	/*if (!loadView) {
		loadView = [[ActivityIndicator alloc] initWithFrame:self.view.frame];
		
		[self.view addSubview:loadView];
		[self.tableView setScrollEnabled:NO];
	}*/
}

-(void)reloadData {	
	data = [Event loadFromCoreData];
	[self.tableView reloadData];
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
	
	return [df stringFromDate:[[[data objectAtIndex:section] objectAtIndex:0] date]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PrograCell";
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
	EvenementDetailViewControllerViewController* edvc = [[EvenementDetailViewControllerViewController alloc] initWithNibName:@"EvenementDetailViewControllerViewController" bundle:nil];
	[edvc setEvent:[[data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];

	[self.navigationController pushViewController:edvc animated:YES];
}

@end
