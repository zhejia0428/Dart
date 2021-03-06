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

- (void)awakeFromNib
{
    [self.playerNameLabel setTextColor:[DSAppSkinner scoreBoardTextColor]];
    [self.totalScoreLabel setTextColor:[DSAppSkinner scoreBoardTextColor]];
}

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
    CGFloat cellHeight = [self.cellDelegate parentHeight] / [self.player.playerStatistics count];
    
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DSPlayerScoreValueTableViewCell *scoreCell = (DSPlayerScoreValueTableViewCell *)cell;
    [scoreCell updateScoreValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *PlayerScoreValueCellIdentifier = @"PlayerScoreValueCellIdentifier";
    DSPlayerScoreValueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PlayerScoreValueCellIdentifier];
    
    if (cell == nil) {
        cell = [self loadPlayerScoreValueCellFromNib];
    }
    
    if ([DSGame sharedGame].winner && [DSGame sharedGame].winner.length > 0) {
        if ([[DSGame sharedGame].winner isEqualToString:self.player.playerName]) {
            [self.playerNameLabel setTextColor:[DSAppSkinner globalTextColor]];
            [self.totalScoreLabel setTextColor:[DSAppSkinner globalTextColor]];
        }
        else {
            [self.playerNameLabel setTextColor:[DSAppSkinner scoreBoardClosedColor]];
            [self.totalScoreLabel setTextColor:[DSAppSkinner scoreBoardClosedColor]];
        }
    }
    else {
        [self.playerNameLabel setTextColor:[DSAppSkinner globalTextColor]];
        [self.totalScoreLabel setTextColor:[DSAppSkinner globalTextColor]];
    }
    
    
    cell.playerName = self.player.playerName;
    cell.scoreValue = [DSGame scoreValueForIndex:indexPath.row];
    cell.score = [self.player pointsEarnedForCricketScoreValue:cell.scoreValue];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
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
