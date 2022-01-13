//
//  CardMatchingGame.h
//  Created by Eva Hallermeier on 10/11/2021.

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic) NSInteger score;
@property (nonatomic,) NSMutableString *comment;
@property (nonatomic) NSMutableArray *cards;

- (Card *)cardAtIndex:(NSUInteger) index;
- (void)initScore;
- (void)updateMode:(NSUInteger) mode;
- (instancetype)initWithCardCount:(NSInteger) count usingDeck:(Deck *) deck;
- (void)chooseCardAtIndex:(NSUInteger)index;

@end


