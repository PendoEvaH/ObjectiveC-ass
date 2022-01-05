//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Eva Hallermeier on 10/11/2021.
//
//contain public API of the class

#import <Foundation/Foundation.h>
#import "Deck.h"


@interface CardMatchingGame : NSObject

- (instancetype) initWithCardCount:(NSInteger) count usingDeck:(Deck *) deck;

-(void) chooseCardAtIndex:(NSUInteger) index;
- (void)chooseCardForSetAtIndex:(NSUInteger)index; //SET GAME
-(Card *) cardAtIndex:(NSUInteger) index;
-(void) initScore;
-(void) updateMode:(NSUInteger) mode;
-(void) reinitializePotentialSet;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic,) NSMutableString *comment;
@property (nonatomic) NSInteger gameMode;
@property (nonatomic) NSInteger gameStep;
@end


