//
//  DSScoreBoardCollectionViewCell.m
//  DartScoreBoard
//
//  Created by Michael Place on 11/29/13.
//  Copyright (c) 2013 Zheike. All rights reserved.
//

#import "DSScoreBoardCollectionViewCell.h"
#import "DSPlayerScoreValueTableViewCell.h"

@implementation DSScoreBoardCollectionViewCell

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.player.playerStatistics count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = [self loadPlayerScoreValueCellFromNib].frame.size.height;
    return cellHeight;
}

//UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Blah"];
//return cell;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *PlayerScoreValueCellIdentifier = @"PlayerScoreValueCellIdentifier";
    DSPlayerScoreValueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PlayerScoreValueCellIdentifier];
    
    if (cell == nil) {
        cell = [self loadPlayerScoreValueCellFromNib];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected cell %li", (long)indexPath.row);
}

- (DSPlayerScoreValueTableViewCell *)loadPlayerScoreValueCellFromNib
{
    NSArray *playerScoreValueNib = [[NSBundle mainBundle] loadNibNamed:@"DSPlayerScoreValueTableViewCell" owner:self options:nil];
    DSPlayerScoreValueTableViewCell *playerScoreValueCell = [playerScoreValueNib objectAtIndex:0];
    return playerScoreValueCell;
}

@end
