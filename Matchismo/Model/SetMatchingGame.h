//
//  CardMatchingGame.h
//  Created by Eva Hallermeier on 05/01/2022.
//

#import "CardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetMatchingGame : CardMatchingGame


@property (nonatomic) NSMutableArray *potentialSet;
@property (nonatomic) NSString *setContent;

- (void)reinitializePotentialSet;
- (instancetype)initWithCardCount:(NSInteger) count usingDeck:(Deck *) deck;
- (void)chooseCardAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
