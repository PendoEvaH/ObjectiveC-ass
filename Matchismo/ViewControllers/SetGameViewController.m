//
//  SetGameViewController.m
//  Created by Eva Hallermeier on 30/12/2021.
//

#import "SetGameViewController.h"
#import "ScoresInfoViewController.h"

#import "SetGameCardDeck.h"
#import "CardMatchingGame.h"
#import "SetMatchingGame.h"
#import "Card.h"
#import "SetGameCard.h"

@interface SetGameViewController ()

//property in UI
@property (weak, nonatomic) IBOutlet UILabel *roundNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *getNewRoundButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *setContent;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *commentsOnGame;
@property (strong, nonatomic) Deck *deck;
@property (nonatomic,strong) SetMatchingGame *game;
@property (nonatomic) NSInteger nbRounds;
@property (strong, nonatomic) NSMutableArray *roundsResults; //for scores page
@end

@implementation SetGameViewController

- (SetMatchingGame *)game {
    if(!_game) _game = [[SetMatchingGame alloc] initWithCardCount:12 usingDeck:[self createDeck]];
    return _game;
}

- (NSInteger)nbRounds {
    if(!_nbRounds) _nbRounds = 0;
    return _nbRounds;
}

- (Deck *)deck {
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck *)createDeck {
    return [[SetGameCardDeck alloc] init];
}

- (NSMutableArray*)roundsResults {
    if (!_roundsResults) _roundsResults = [[NSMutableArray alloc] init];
    return _roundsResults;
}

- (IBAction)touchCard:(UIButton *)sender {
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}
    
- (IBAction)startNewRound:(id)sender {
    for (UIButton *cardButton in self.cardButtons) {
        cardButton.hidden = NO;
    }
    self.nbRounds += 1;
    self.game = [[SetMatchingGame alloc] initWithCardCount:12 usingDeck:[self createDeck]];
    [self updateUI];
}

- (void)updateUI {
    if (self.game.setContent) {
        self.setContent.text = [NSString stringWithFormat:@"%@", self.game.setContent];
    }
    if (self.nbRounds > 0) {
        NSString *description = [NSString stringWithFormat:@"Round %ld - score: %ld", self.nbRounds, self.game.score];
        self.roundsResults[self.nbRounds - 1] = description;
    }
    for(UIButton *cardButton in self.cardButtons) {
        NSInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle: [self titleForCard:card] forState:UIControlStateNormal];
        UIColor * colorCard = card.color;
        cardButton.backgroundColor = colorCard;
    }
    self.scoreLabel.text  = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    self.roundNumberLabel.text  = [NSString stringWithFormat:@"Round %ld", self.nbRounds];
    self.commentsOnGame.text  = [NSString stringWithFormat:@"%@", self.game.comment];
    if([self.commentsOnGame.text isEqualToString:@"You get a set!! you get 10 points!"]) {
        [self.game reinitializePotentialSet];
    }
}

- (NSString *)titleForCard:(Card *)card {
    return card.contents;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toSetGameScores"]) {
        if([segue.destinationViewController isKindOfClass:[ScoresInfoViewController class]]) {
            ScoresInfoViewController *svc = (ScoresInfoViewController *) segue.destinationViewController;
            svc.scoresPerRound = self.roundsResults;
        }
    }
}

@end
