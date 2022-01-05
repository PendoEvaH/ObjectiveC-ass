//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Eva Hallermeier on 10/11/2021.
//only logic of the game wih BO UI -WE ARE IN MODEL

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic) NSMutableArray *cards;
@property (nonatomic) NSInteger nbSetsRemaining;
@property (nonatomic) NSInteger nbSetsFounded;
@property (nonatomic) NSInteger nbCardsChosen;
@property (nonatomic) NSMutableArray *sets;
@property (nonatomic) NSMutableArray *potentialSet;

 
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards {
    if(!_cards)
    { //if _cards not initialize
        _cards = [[NSMutableArray alloc ] init]; //initialize
    }
    return _cards; //_cards created
}

- (instancetype) initWithCardCount:(NSInteger) count usingDeck:(Deck *) deck {
    self.comment = [NSMutableString stringWithFormat:@" "];
    self.gameMode = 2;
    self.nbSetsFounded = 0;
    self.nbCardsChosen = 0;
    self.gameStep = 0;
    self = [super init];
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
    
    _potentialSet = [[NSMutableArray alloc ] init];
    return self;
}

- (instancetype)init {
    return nil;
}


- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2 ;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    //NSLog(@"in choose card at index, mode is %lu", self.gameMode);
    self.gameStep = self.gameStep +1;
    if (self.gameMode == 2 || self.gameStep < 3) {
        NSLog(@"mode game is 2");
        Card *card = [self cardAtIndex : index];
        self.comment = [NSMutableString stringWithFormat:@"%@" ,card.contents];
        if (!card.matched) {
            NSLog(@"card not matched");
            if (card.chosen) {
                card.chosen = NO;
            } else {
                //match against another card
                for (Card *otherCard in self.cards) {
                    if (otherCard.chosen && !otherCard.matched) {
                        int matchScore = [card match:@[otherCard]]; //call mactch method in Card
                        //in case 0 - not match
                        //not 0 -we have match : hight score will be high match
                        if (matchScore) {
                            NSLog(@"match");
                            NSInteger addedScore = matchScore * MATCH_BONUS * self.gameMode;
                            self.score =  self.score + addedScore;
                            card.matched = YES;
                            self.comment = [NSMutableString stringWithFormat:@"Matched %@ %@ :you get %lu points!" ,card.contents, otherCard.contents, addedScore];
                        } else{
                            NSLog(@"no match");
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                            self.comment = [NSMutableString stringWithFormat:@"%@ and %@ don t match! You get a penalty!" ,card.contents, otherCard.contents];
                        }
                        break;
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES; //call set
            }
        }
    } else { //3 matched card mode
        [self matchmode3:index];
    }
    return;
}

-(void) matchmode3:(NSUInteger) index {
    //NSLog(@"mode 3 matchmode3");
    Card *card = [self cardAtIndex:index];
    self.comment = [NSMutableString stringWithFormat:@"%@" ,card.contents];
    if (!card.matched) {
        if (card.chosen) {
            card.chosen = NO;
        }
        else{
            //match against another card
            for (Card *otherCard in self.cards) {
                if (otherCard.chosen && !otherCard.matched) {
                    for (Card *otherCard1 in self.cards) {
                        if (otherCard1.chosen && !otherCard1.matched && ![otherCard.contents isEqualToString: otherCard1.contents]) {
                            int matchScore = [card match:@[otherCard1]] + [card match:@[otherCard]]; //call match method in Card
                    //in case 0 - not match
                    //not 0 -we have match : hight score will be high match
                            if (matchScore>1) {
                                self.comment = [NSMutableString stringWithFormat:@"Matched %@  %@  %@" ,card.contents, otherCard.contents, otherCard1.contents];
                                self.score =  self.score + ( 3 * MATCH_BONUS);
                                card.matched = YES;
                            }
                            else{
                                self.score -= MISMATCH_PENALTY;
                                otherCard.chosen = NO;
                                self.comment = [NSMutableString stringWithFormat:@"%@  %@  %@ don t match!", card.contents, otherCard.contents, otherCard1.contents];
                                }
                            break;
                        }
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES; //call set
        }
    }
}

-(void) initScore {
    self.score = 0;
}

-(void) updateMode:(NSUInteger) mode {
    self.gameMode = mode;
}


- (void)chooseCardForSetAtIndex:(NSUInteger)index {
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
