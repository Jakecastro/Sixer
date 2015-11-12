//
//  HostViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/12/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "HostViewController.h"

@interface HostViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *yourNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *waitingForPlayersLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *QuitGameButton;
@property (weak, nonatomic) IBOutlet UIButton *startGameButton;
@property NSMutableArray *otherPlayersArray;

@end

@implementation HostViewController

{
    MatchmakingServer *_matchmakingServer;
}


//should be able to remove all @synthesize...check before removing
@synthesize yourNameLabel = _yourNameLabel;
@synthesize nameTextField = _nameTextField;
@synthesize waitingForPlayersLabel = _waitingForPlayersLabel;
@synthesize tableView = _tableView;
@synthesize startGameButton = _startGameButton;

//not sure if the following are needed
@synthesize QuitGameButton = _QuitGameButton;
@synthesize otherPlayersArray = _otherPlayersArray;

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (_matchmakingServer == nil)
    {
        _matchmakingServer = [[MatchmakingServer alloc] init];
        _matchmakingServer.maxClients = 3;
        [_matchmakingServer startAcceptingConnectionsForSessionID:SESSION_ID];

        //changes nameTextField to name of device --- need to change this to registered username
        self.nameTextField.placeholder = _matchmakingServer.session.displayName;
        [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.otherPlayersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayersCell" forIndexPath:indexPath];

    return cell;
}

- (IBAction)onNameTextFieldTapped:(UITextField *)sender {
}


- (IBAction)onStartButtonTapped:(UIButton *)sender {
}


- (IBAction)onQuitButtonTapped:(UIButton *)sender {
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}






@end
