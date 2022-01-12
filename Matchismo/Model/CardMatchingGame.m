
//  CardMatchingGame.m
//  Created by Eva Hallermeier on 10/11/2021.

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic) NSInteger gameMode;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if(!_cards) { //if _cards not initialize
        _cards = [[NSMutableArray alloc ] init]; //initialize
    }
    return _cards; //_cards created
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void) initScore {
    self.score = 0;
}

- (void) updateMode:(NSUInteger) mode {
    self.gameMode = mode;
}

- (void)chooseCardAtIndex:(NSUInteger)index { }

@end
