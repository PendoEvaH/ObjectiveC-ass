
//  MatchismoViewController.m
//  Created by Eva Hallermeier on 03/11/2021.

#import "MatchismoViewController.h"
#import "ScoresInfoViewController.h"
#import "MatchismoCardDeck.h"
#import "MatchismoMatchingGame.h"
#import "Deck.h"
#import "Card.h"

@interface MatchismoViewController ()
//related to UI
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel; //show value of score
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMode; //choice between mode 2 or 3 matching cards
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons; //cards
@property (weak, nonatomic) IBOutlet UILabel *commentsOnGame;

@property (strong, nonatomic) NSMutableArray *gameResults; //for showing results of all rounds
@property (nonatomic) NSInteger nbRounds;

@property (strong, nonatomic) Deck *deck; // group of cards
@property (nonatomic,strong) MatchismoMatchingGame *game;
@end

@implementation MatchismoViewController

- (CardMatchingGame *)game {
    if(!_game) _game = [[MatchismoMatchingGame alloc] initWithCardCount:30 usingDeck:[self createDeck]];
    return _game;
}

- (NSInteger)nbRounds {
    if(!_nbRounds) _nbRounds = 0;
    return _nbRounds;
}

- (NSMutableArray *) gameResults {
    if (!_gameResults) _gameResults = [[NSMutableArray alloc] init];
    return _gameResults;
}

- (Deck *)deck {
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck *)createDeck {
    return [[MatchismoCardDeck alloc] init];
}

- (IBAction)gameModeChanged:(UISegmentedControl *)sender {
    NSInteger mode = sender.selectedSegmentIndex + 2;
    [self.game updateMode:mode];
}

- (void)startNewGame {
    self.nbRounds += 1;
    NSInteger mode = [self.gameMode selectedSegmentIndex];
    if (mode == 0) {
        [self.gameMode setEnabled:YES forSegmentAtIndex:1];
    } else {
        [self.gameMode setEnabled:YES forSegmentAtIndex:0];
    }
    _game = [[MatchismoMatchingGame alloc] initWithCardCount:30 usingDeck:[self createDeck]];
    mode = [self.gameMode selectedSegmentIndex];
    [self.game updateMode: mode + 2];
    [self updateUI];
}

- (IBAction)touchCard:(UIButton *)sender {
    if (self.nbRounds < 1) {
        [self startNewGame];
    }
    [self.gameMode setEnabled:NO forSegmentAtIndex:(self.game.gameMode - 1) % 2];
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}
    
- (IBAction)startNewGame:(id)sender {
    self.nbRounds += 1;
    NSInteger mode = [self.gameMode selectedSegmentIndex];
    if (mode == 0) {
        [self.gameMode setEnabled:YES forSegmentAtIndex:1];
    } else {
        [self.gameMode setEnabled:YES forSegmentAtIndex:0];
    }
    _game = [[MatchismoMatchingGame alloc] initWithCardCount:30 usingDeck:[self createDeck]];
    mode = [self.gameMode selectedSegmentIndex];
    [self.game updateMode: mode + 2];
    [self updateUI];
}

- (void)updateUI {
    if (self.nbRounds > 0) {
        NSString *resultOfTheRound = [NSString stringWithFormat:@"Round %ld - score: %ld", self.nbRounds, self.game.score];
        self.gameResults[self.nbRounds - 1] = resultOfTheRound;
    }
    NSInteger gameModeForUpdate = [self.gameMode selectedSegmentIndex] + 2;
    [self.game updateMode: gameModeForUpdate];
    for (UIButton *cardButton in self.cardButtons) {
        NSInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle: [self titleForCard:card]forState:UIControlStateNormal];
        cardButton.enabled = !card.matched;
    }
    self.scoreLabel.text  = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    self.commentsOnGame.text  = [NSString stringWithFormat:@"%@", self.game.comment];
}

- (NSString *)titleForCard:(Card *)card {
    return card.chosen? card.contents : @"";
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toSetGameScores"]) {
        if([segue.destinationViewController isKindOfClass:[ScoresInfoViewController class]]) {
            ScoresInfoViewController *svc = (ScoresInfoViewController *) segue.destinationViewController;
            svc.scoresPerRound = self.gameResults;
        }
    }
}

@end
