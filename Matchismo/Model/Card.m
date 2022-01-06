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




- (UIColor *)color {
    return _color;
}

@end

