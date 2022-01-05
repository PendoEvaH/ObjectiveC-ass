//
//  Card.m
//  Matchismo
//  Created by Eva Hallermeier on 03/11/2021.

#import "Card.h"

@interface Card()

@end

@implementation Card

@synthesize matched = _matched;
@synthesize chosen = _chosen;
@synthesize contents = _contents;
@synthesize color = _color;

- (int)match:(NSArray *) otherCards
{
    int score=0;
    for (Card *card in otherCards) {
        if([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}


- (UIColor *)color {
    return _color;
}

@end

