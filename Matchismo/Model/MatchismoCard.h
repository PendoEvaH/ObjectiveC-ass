
//  MatchismoCard.h
//  Created by Eva Hallermeier on 03/11/2021.

#import "Card.h"

@interface MatchismoCard : Card // playing card is a card so inheritate from card

 //kind: or symbol heart, diamond, pike, club (trefle)


@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;


+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;

@end


