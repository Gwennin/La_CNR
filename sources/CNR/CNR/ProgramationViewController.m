//
//  ProgramationViewController.m
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import "ProgramationViewController.h"

@interface ProgramationViewController ()

@end

@implementation ProgramationViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
		
		self.title = @"Programmation";
		self.tabBarItem.image = [UIImage imageNamed:@"programation.png"];
		self.view.backgroundColor = [UIColor whiteColor];
	}
    return self;
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
    static NSString *CellIdentifier = @"PrograCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
    
	cell.textLabel.text = [NSString stringWithFormat:@"Programation n°%i", indexPath.row + (indexPath.section * 2) + 1];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

@end
