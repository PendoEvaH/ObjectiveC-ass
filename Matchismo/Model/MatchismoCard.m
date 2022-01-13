//
//  MatchismoCard.m
//  Created by Eva Hallermeier on 03/11/2021.

#import "MatchismoCard.h"

@implementation MatchismoCard

- (int)match:(NSArray *)otherCards {
    int score = 0;
    MatchismoCard *otherCard = [otherCards firstObject];
    if ([self.suit isEqualToString:otherCard.suit]) {
        score = 2;
    }
    if (self.rank == otherCard.rank) {
        score += 1;
    }
    return score;
}

- (NSString *)contents {
    NSArray *rankStrings = [MatchismoCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *) validSuits {
    return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}

- (void)setSuit:(NSString *)suit {
    if([[MatchismoCard validSuits] containsObject:suit]) {
        _suit=suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit: @"?";
}

+(NSArray *)rankStrings {
    return @[@"?",@"A", @"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}
- (void)setRank:(NSUInteger)rank {
    if(rank <= [MatchismoCard maxRank]) {
        _rank = rank;
    }
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}



@end
