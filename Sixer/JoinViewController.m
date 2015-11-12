//
//  JoinViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/12/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "JoinViewController.h"

@interface JoinViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *yourNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *availableGamesLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *quitGameButton;

@property (nonatomic, strong) IBOutlet UIView *waitView;

@property NSMutableArray *availableGamesArray;

@end

@implementation JoinViewController


{
    MatchmakingClient *_matchmakingClient;
}

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"dealloc %@", self);
#endif
}

- (void)viewDidLoad {

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.nameTextField action:@selector(resignFirstResponder)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gestureRecognizer];

}
// need a waitView
- (void)viewDidUnload {
    [super viewDidUnload];
    self.waitView = nil;
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];

    if (_matchmakingClient == nil)
    {
        _matchmakingClient = [[MatchmakingClient alloc] init];
        [_matchmakingClient startSearchingForServersWithSessionID:SESSION_ID];

        self.nameTextField.placeholder = _matchmakingClient.session.displayName;
        [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.availableGamesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GamesCell" forIndexPath:indexPath];

    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
