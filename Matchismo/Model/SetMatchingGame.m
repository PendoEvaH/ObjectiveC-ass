//
//  SetMatchingGame.m
//  Created by Eva Hallermeier on 05/01/2022.
//

#import "SetMatchingGame.h"
#import "CardMatchingGame.h"

@interface SetMatchingGame()

@property (nonatomic) NSInteger nbCardsChosen;

@end

@implementation SetMatchingGame

- (instancetype)initWithCardCount:(NSInteger)count usingDeck:(Deck *) deck {
    self.comment = [NSMutableString stringWithFormat:@" "];
    self.nbCardsChosen = 0;
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    self.potentialSet = [[NSMutableArray alloc] init];
    return self;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
    self.nbCardsChosen += 1;
    Card *card = [self cardAtIndex : index];
    [self.potentialSet addObject:card];
    if (self.nbCardsChosen < 3) { //set is not full
        self.comment = [NSMutableString stringWithFormat:@"%@", card.contents];
        self.setContent = [NSMutableString stringWithFormat:@""];
    } else {
        int isSet = [card match:self.potentialSet];
        if (isSet == 1) {
            self.comment = [NSMutableString stringWithFormat:@"You get a set!! you get 10 points!"];
            self.score += 10;
            
        } else {
            self.comment = [NSMutableString stringWithFormat:@"This is not a set :try again! You loose 1 point"];
            self.score -= 1;
           
        }
        self.nbCardsChosen = 0;
        Card *c1 = self.potentialSet[0];
        Card *c2 = self.potentialSet[1];
        Card *c3 = self.potentialSet[2];
        self.setContent = [NSMutableString stringWithFormat:@"%@ %@ %@", c1.contents, c2.contents, c3.contents];
        [self.potentialSet removeAllObjects];
    }
    return;
}

- (void) reinitializePotentialSet {
    [self.potentialSet removeAllObjects];
}



@end
