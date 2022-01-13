//
//  Card.h
//  Created by Eva Hallermeier on 03/11/2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Card : NSObject


@property (strong, nonatomic) NSString *contents;
@property (nonatomic) BOOL chosen;
@property (nonatomic) BOOL matched;
@property (nonatomic) UIColor *color;

- (int)match:(NSArray *) otherCards;


@end

