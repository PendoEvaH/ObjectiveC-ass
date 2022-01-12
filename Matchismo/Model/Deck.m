//
//  Deck.m
//  Created by Eva Hallermeier on 03/11/2021.

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;   //arrray of cards

@end
@implementation Deck

- (NSMutableArray *)cards {
    if(!_cards) _cards = [[NSMutableArray alloc]init]; //allocate memory to store the array of cards
    return _cards;
}

- (void)addCard:(Card*)card atTop:(BOOL)atTop {
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (void)addCard:(Card*)card {
    [self addCard: card atTop:NO];
}

- (Card *)drawRandomCard {
    Card *randomCard =nil;
    unsigned index = arc4random() % [self.cards count];
    randomCard = self.cards[index];
    [self.cards removeObjectAtIndex:index];
    return randomCard;
}

@end
