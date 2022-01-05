//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Eva Hallermeier on 03/11/2021.
// view controller control the view

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "Card.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMode;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *commentsOnGame;

@property (strong, nonatomic) Deck *deck;
@property (nonatomic,strong) CardMatchingGame *game;
@end

@implementation CardGameViewController

//get
-(CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:30 usingDeck:[self createDeck]];
    return _game;
}

- (IBAction)gameModeChanged:(UISegmentedControl *)sender {
    NSInteger mode = 0; //2 by default
    if (sender.selectedSegmentIndex == 0 ) { //get from UI
            mode =2;
        }
    if (sender.selectedSegmentIndex == 1) {
        mode =3;
}
    [self.game updateMode:mode];
    [self.gameMode setEnabled:NO
           forSegmentAtIndex:(mode-1) %2]; //adapt UI
}

//instantiate property of deck
- (Deck *)deck
{
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCard:(UIButton *)sender {
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender]; //we want to know which card and get his index
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI]; //keep UI sync with model
}
    
- (IBAction)startNewGame:(id)sender {
    NSInteger mode= [self.gameMode selectedSegmentIndex]; //get mode chosen by user
    if(mode==0) {
        [self.gameMode setEnabled:YES forSegmentAtIndex:1];
    }
    else{
        [self.gameMode setEnabled:YES forSegmentAtIndex:0];
    }
    _game = [[CardMatchingGame alloc] initWithCardCount:30 usingDeck:[self createDeck]];
    NSInteger m = [self.gameMode selectedSegmentIndex];
    [self.game updateMode:m + 2];
    [self updateUI];
}

- (void)updateUI {
    NSInteger v = [self.gameMode selectedSegmentIndex] + 2;
    [self.game updateMode: v];
    for (UIButton *cardButton in self.cardButtons) {
        NSInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle: [self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage: [self backgroundImageForCard:card] forState:UIControlStateNormal ];
        cardButton.enabled = !card.matched;
    }
    self.scoreLabel.text  = [NSString stringWithFormat:@"Score: %ld", self.game.score]; //call here set of property text of label
    self.commentsOnGame.text  = [NSString stringWithFormat:@"%@", self.game.comment]; //call here set of property text of labe
}

- (NSString *)titleForCard:(Card *)card {
    return card.chosen? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.chosen ? @"cardfront" : @"cardBack"];
}

@end
