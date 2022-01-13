
//  MatchismoCard.h
//  Created by Eva Hallermeier on 03/11/2021.

#import "Card.h"

@interface MatchismoCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;


+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;

@end


