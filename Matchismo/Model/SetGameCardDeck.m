//
//  SetGameCarddeck.m
//  Created by Eva Hallermeier on 30/12/2021.
//

#import "SetGameCardDeck.h"
#import "SetGameCard.h"
#import "Deck.h"

@implementation SetGameCardDeck

- (instancetype)init {
    self = [super init];
    if(self) {
        for(NSString *suit in [SetGameCard validSuits]) {
            for(NSUInteger rank = 1; rank <= [SetGameCard maxRank]; rank++) {
                for(UIColor *color in [SetGameCard validColors]) {
                    SetGameCard *card = [[SetGameCard alloc] init];
                    card.rank = rank;
                    card.color = color;
                    card.suit = suit;
                    [self addCard:card];
                }
            }
        }
    }
    return self;
}
@end
