
//  PlayingCard.h
//  Matchismo
//  Created by Eva Hallermeier on 03/11/2021.

#import "Card.h"

@interface PlayingCard : Card // playing card is a card so inheritate from card

@property (strong, nonatomic) NSString *suit; //kind: or symbol heart, diamond, pike, club (trefle)

@property (nonatomic) NSUInteger rank; // 2,3,4,5,7,8,9,10,J,K,Q,A

+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;

@end


