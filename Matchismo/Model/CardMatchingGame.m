//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Eva Hallermeier on 10/11/2021.
//only logic of the game wih BO UI -WE ARE IN MODEL

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic) NSInteger gameMode;


 
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards {
    if(!_cards)
    { //if _cards not initialize
        _cards = [[NSMutableArray alloc ] init]; //initialize
    }
    return _cards; //_cards created
}


//- (instancetype)init {
//    return nil;
//}


- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}






-(void) initScore {
    self.score = 0;
}


-(void) updateMode:(NSUInteger) mode {
    self.gameMode = mode;
}

- (void)chooseCardAtIndex:(NSUInteger)index { }





@end
