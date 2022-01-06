//
//  ScoresInfoViewController.m
//  Matchismo
//
//  Created by Eva Hallermeier on 04/01/2022.
//

#import "ScoresInfoViewController.h"

@interface ScoresInfoViewController ()


@end

@implementation ScoresInfoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSLog(@"received: to svc : %@", self.scoresPerRound);
    NSLog(@"scores!!!!!");
    //[self fetchScoresPerRound];
}


//- (void)fetchScoresPerRound {
//
// //   NSArray *scoresPerRound = INSERT EVERYTGHING IN ARRAY
//   // self.scoresPerRound = scoresPerRound;
//    //self.photos = nil;
//}


-(void)setscoresPerRound: (NSArray *) scoresPerRound
{
    _scoresPerRound = scoresPerRound;
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.scoresPerRound count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Score of round Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // get a string
   // NSString *descriptionOfRound = [NSString stringWithFormat:@"%@", self.scoresPerRound[indexPath]];
   // cell.textLabel.text = descriptionOfRound;
    cell.textLabel.text = [self.scoresPerRound objectAtIndex:indexPath.row];
    return cell;
}


@end
