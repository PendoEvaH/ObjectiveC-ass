//
//  PlayingCardDeck.m
//  Created by Eva Hallermeier on 03/11/2021.
//

#import "MatchismoCardDeck.h"
#import "MatchismoCard.h"

@implementation MatchismoCardDeck

- (instancetype)init {
    self = [super init];
    if (self) {
        for (NSString *suit in [MatchismoCard validSuits]) {
            for(NSUInteger rank = 1; rank <= [MatchismoCard maxRank]; rank++) {
                MatchismoCard *card = [[MatchismoCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
    }
    return self;
}

@end
