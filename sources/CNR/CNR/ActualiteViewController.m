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
		
	}
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
	
	ManageApp* appManager = [[ManageApp alloc] init];
	[appManager loadRSSPosts];
}

-(void)loadingData {
	
	if (!loadView) {
		loadView = [[ActivityIndicator alloc] initWithFrame:self.view.frame];
		
		[self.view addSubview:loadView];
		[self.tableView setScrollEnabled:NO];
	}
}

-(void)reloadData {
	[loadView removeFromSuperview];
	loadView = nil;
	
	[self.tableView setScrollEnabled:YES];
	
	[self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [NSString stringWithFormat:@"Mardi %i mai 2012", section * 7 + 1];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ActuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
    
	cell.textLabel.text = [NSString stringWithFormat:@"Actualité n°%i", indexPath.row + (indexPath.section * 2) + 1];
	cell.imageView.image = [UIImage imageNamed:@"second.png"];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

	ArticleDetailViewController* advc = [[ArticleDetailViewController alloc] initWithNibName:@"ArticleDetailViewController" bundle:nil];
	
	[self.navigationController pushViewController:advc animated:YES];
}

@end
