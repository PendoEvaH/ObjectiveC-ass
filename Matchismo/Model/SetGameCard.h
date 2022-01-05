//
//  SetGameCard.h
//  Matchismo
//
//  Created by Eva Hallermeier on 30/12/2021.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetGameCard : Card
@property (strong, nonatomic) NSString *suit; //symbol
@property (strong, nonatomic) UIColor *color;
@property (nonatomic) NSUInteger rank; // 1,2,3

+ (NSArray *) validSuits;
+ (NSArray *) validColors;
+ (NSUInteger) maxRank;

@end

NS_ASSUME_NONNULL_END
