//
//  Deck.h
//  Matchismo
//
//  Created by Eva Hallermeier on 03/11/2021.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card*)card atTop:(BOOL)atTop;
- (void)addCard:(Card*)card;
- (Card *)drawRandomCard;

@end

