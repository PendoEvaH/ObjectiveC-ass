//
//  SetGameCard.h
//  Created by Eva Hallermeier on 30/12/2021.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetGameCard : Card

 // 1,2,3

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;


+ (NSArray *)validSuits;
+ (NSArray *)validColors;
+ (NSUInteger)maxRank;

@end

NS_ASSUME_NONNULL_END
