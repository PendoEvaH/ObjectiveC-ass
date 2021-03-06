//
//  MatchismoMatchingGame.m
//  Created by Eva Hallermeier on 05/01/2022.
//

#import "MatchismoMatchingGame.h"
#import "CardMatchingGame.h"

@interface MatchismoMatchingGame()

@property (nonatomic) NSInteger nbCardsChosen;

@end

@implementation MatchismoMatchingGame

- (instancetype) initWithCardCount:(NSInteger) count usingDeck:(Deck *) deck {
    self.comment = [NSMutableString stringWithFormat:@" "];
    self.gameMode = 2;
    self.nbCardsChosen = 0;
    self.gameStep = 0;
    self = [super init];
    if (self) {
        for (int i=0; i<count;i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (instancetype)init {
    return nil;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


- (void)chooseCardAtIndexMode2:(NSInteger)index {
    Card *card = [self cardAtIndex:index];
    self.comment = [NSMutableString stringWithFormat:@"%@" ,card.contents];
    if (!card.matched) {
        if (card.chosen) {
            card.chosen = YES;
        } else {
            //match against another card
            for (Card *otherCard in self.cards) {
                if (otherCard.chosen && !otherCard.matched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        NSInteger addedScore = matchScore * MATCH_BONUS * self.gameMode;
                        self.score =  self.score + addedScore;
                        card.matched = YES;
                        self.comment = [NSMutableString stringWithFormat:@"Matched %@ %@ :you get %lu points!" ,card.contents, otherCard.contents, addedScore];
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                        self.comment = [NSMutableString stringWithFormat:@"%@ and %@ don t match! You get a penalty!" ,card.contents, otherCard.contents];
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (void)chooseCardAtIndex:(NSUInteger)index {
    self.gameStep = self.gameStep + 1;
    if (self.gameMode == 2 || self.gameStep < 3) {
        [self chooseCardAtIndexMode2:(NSInteger)index];
    } else { //3 matched card mode
        [self chooseCardAtIndexMode3:index];
    }
    return;
}

- (void)chooseCardAtIndexMode3:(NSUInteger) index {
    Card *card = [self cardAtIndex:index];
    self.comment = [NSMutableString stringWithFormat:@"%@" ,card.contents];
    if (!card.matched) {
        if (card.chosen) {
            card.chosen = YES;
        } else {
            //match against another card
            for (Card *otherCard in self.cards) {
                if (otherCard.chosen && !otherCard.matched) {
                    for (Card *otherCard1 in self.cards) {
                        if (otherCard1.chosen && !otherCard1.matched && ![otherCard.contents isEqualToString: otherCard1.contents]) {
                            int matchScore = [card match:@[otherCard1]] + [card match:@[otherCard]];
                            if (matchScore > 1) {
                                self.comment = [NSMutableString stringWithFormat:@"Matched %@  %@  %@" ,card.contents, otherCard.contents, otherCard1.contents];
                                self.score =  self.score + (3 * MATCH_BONUS);
                                card.matched = YES;
                            } else{
                                self.score -= MISMATCH_PENALTY;
                                otherCard.chosen = YES;
                                self.comment = [NSMutableString stringWithFormat:@"%@  %@  %@ don t match!", card.contents, otherCard.contents, otherCard1.contents];
                            }
                            break;
                        }
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (void) initScore {
    self.score = 0;
}

@end
