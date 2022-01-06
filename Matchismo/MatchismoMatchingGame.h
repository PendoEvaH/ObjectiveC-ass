//
//  MatchismoMatchingGame.h
//  Matchismo
//
//  Created by Eva Hallermeier on 05/01/2022.
//

#import "CardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN




@interface MatchismoMatchingGame : CardMatchingGame

- (instancetype) initWithCardCount:(NSInteger) count usingDeck:(Deck *) deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
@property (nonatomic) NSInteger gameMode;
@property (nonatomic) NSInteger gameStep;
@end

NS_ASSUME_NONNULL_END
