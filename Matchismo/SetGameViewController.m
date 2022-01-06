//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Eva Hallermeier on 30/12/2021.
//

#import "SetGameViewController.h"

#import "SetGameCarddeck.h"
#import "CardMatchingGame.h"
#import "ScoresInfoViewController.h"
#import "Card.h"
#import "SetMatchingGame.h"
#import "SetGameCard.h"

@interface SetGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *roundNumberDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *roundButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMode;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *commentsOnGame;
@property (nonatomic) NSArray *set;
@property (strong, nonatomic) Deck *deck;
@property (nonatomic,strong) SetMatchingGame *game;
@property (nonatomic) NSInteger nbRounds;
@property (strong, nonatomic) NSMutableArray *roundsDesciption;
@end

@implementation SetGameViewController
-(SetMatchingGame *)game
{
    if(!_game) _game = [[SetMatchingGame alloc] initWithCardCount:12 usingDeck:[self createDeck]];
    return _game;
}

-(NSInteger )nbRounds
{
    if(!_nbRounds) _nbRounds = 0;
    return _nbRounds;
}

//instantiate property of deck
- (Deck *)deck
{
    if (!_deck) _deck = [self createDeck];
    return _deck;
}






- (Deck *)createDeck
{
    return [[SetGameCarddeck alloc] init];
}


-  (NSMutableArray* ) roundsDesciption {
    if (!_roundsDesciption) _roundsDesciption = [[NSMutableArray alloc] init];
    return _roundsDesciption;
}


- (IBAction)touchCard:(UIButton *)sender {
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender]; //we want to know which card and get his index
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI]; //keep UI sync with model
}
    
- (IBAction)startNewGame:(id)sender {
   
    for (UIButton *cardButton in self.cardButtons) { //to show cards
        cardButton.hidden = NO;
        
    }
    self.nbRounds += 1;
    
    self.game = [[SetMatchingGame alloc] initWithCardCount:12 usingDeck:[self createDeck]];
    
    [self updateUI];
}

- (void)updateUI {
    if (self.nbRounds >0) {
        
        NSString *description = [NSString stringWithFormat:@"Round %ld - score: %ld", self.nbRounds, self.game.score];
        self.roundsDesciption[self.nbRounds - 1] = description;
       
    
    }
    for(UIButton *cardButton in self.cardButtons) {
        NSInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle: [self titleForCard:card] forState:UIControlStateNormal];
        UIColor * colorCard = card.color;
          cardButton.backgroundColor = colorCard;
    }
    self.scoreLabel.text  = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    self.roundNumberDescriptionLabel.text  = [NSString stringWithFormat:@"Round %ld", self.nbRounds];
    self.commentsOnGame.text  = [NSString stringWithFormat:@"%@", self.game.comment];
    if([self.commentsOnGame.text isEqualToString:@"You get a set!! you get 10 points!"]) {
        [self.game reinitializePotentialSet];
    }
    
}

- (NSString *)titleForCard:(Card *)card {
    return card.contents;
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"goToScores"]) {
////    if ([segue.destinationViewController isKindOfClass:[ScoresInfoViewController class]]) {
//        ScoresInfoViewController *svc = (ScoresInfoViewController*)segue.destinationViewController;
////        svc.RoundsDescription.text = self.roundsDesciption;
//    }
//}
//- (IBAction)showScores:(UIButton *)sender {
//    //????
//}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender //send for new view the content of the text for analyze it and get details on the stats
{
    if([segue.identifier isEqualToString:@"toSetGameScores"]) {
        if([segue.destinationViewController isKindOfClass:[ScoresInfoViewController class]]) {
            ScoresInfoViewController *svc = (ScoresInfoViewController *) segue.destinationViewController;
            svc.scoresPerRound = self.roundsDesciption;
            NSLog(@"send to svc : %@", svc.scoresPerRound);
        }
    }
 
}

@end
