//
//  SetGameCard.m
//  Created by Eva Hallermeier on 30/12/2021.
//

#import "SetGameCard.h"

@implementation SetGameCard

- (int)match:(NSArray *)otherCards {
    SetGameCard *card2 = otherCards[0];
    SetGameCard *card3 = otherCards[1];
    BOOL suitCondition = NO;
    BOOL colorCondition = NO;
    BOOL rankCondition = NO;
    if(([self.color isEqual:card2.color] && [card2.color isEqual:card3.color])
        || (![self.color isEqual:card2.color] && ![card2.color isEqual:card3.color])) {
        colorCondition = YES;
    }
    if(([self.suit isEqualToString:card2.suit] && [card2.suit isEqualToString:card3.suit])
        || (![self.suit isEqualToString:card2.suit] && ![card2.suit isEqualToString:card3.suit])) {
        suitCondition = YES;
    }
    if(((self.rank == card2.rank) && (card2.rank == card3.rank))   ||
        (!(self.rank == card2.rank) && !(card2.rank == card3.rank))) {
        rankCondition = YES;
    }
    int score = 0;
    if(rankCondition && suitCondition && colorCondition) {
        score = 1;
    }
    return score;
}

- (NSString *)contents {
    NSArray *rankStrings = [SetGameCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;
@synthesize color = _color;

+ (NSArray *)validSuits {
    return @[@"🍋", @"🍉", @"🍏"];
}

+ (NSArray *)validColors {
    return @[[UIColor systemTealColor], [UIColor systemOrangeColor], [UIColor systemPurpleColor]];
}

- (void)setSuit:(NSString *)suit {
    if([[SetGameCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (void)setColor:(UIColor *)color {
    if([[SetGameCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (NSString *)suit {
    return _suit ? _suit: @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?",@"1", @"2",@"3"];
}


- (void)setRank:(NSUInteger)rank {
    if(rank <= [SetGameCard maxRank]) {
        _rank = rank;
    }
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

@end
