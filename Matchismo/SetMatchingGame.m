//
//  SetMatchingGame.m
//  Matchismo
//
//  Created by Eva Hallermeier on 05/01/2022.
//

#import "SetMatchingGame.h"
#import "CardMatchingGame.h"



@interface SetMatchingGame()



@property (nonatomic) NSInteger nbSetsRemaining;
@property (nonatomic) NSInteger nbSetsFounded;
@property (nonatomic) NSInteger nbCardsChosen;
@property (nonatomic) NSMutableArray *sets;
@property (nonatomic) NSMutableArray *potentialSet;
@end

@implementation SetMatchingGame

- (instancetype) initWithCardCount:(NSInteger) count usingDeck:(Deck *) deck {
    self.comment = [NSMutableString stringWithFormat:@" "];
    self.nbSetsFounded = 0;
    self.nbCardsChosen = 0;
   // self = [super init];
    if (self) {
        for (int i=0; i<count;i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
        }//end of for
    }
    
    self.potentialSet = [[NSMutableArray alloc ] init];
    return self;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
    self.nbCardsChosen += 1;
    Card *card = [self cardAtIndex : index];
    if (self.nbCardsChosen < 3) {
        self.comment = [NSMutableString stringWithFormat:@"%@", card.contents];
        [self.potentialSet addObject:card];
        
    }
    else {
        int isSet = [card match:self.potentialSet];
        if (isSet == 1) {
            self.comment = [NSMutableString stringWithFormat:@"You get a set!! you get 10 points!"];
            self.score += 10;
            [self.potentialSet removeAllObjects];
        }
        else {
            self.comment = [NSMutableString stringWithFormat:@"This is not a set :try again! You loose 1 point"];
            self.score -= 1;
            [self.potentialSet removeAllObjects];
        }
        self.nbCardsChosen = 0;
    }
    return;
}

-(void) reinitializePotentialSet {
    [self.potentialSet removeAllObjects];
}

@end
