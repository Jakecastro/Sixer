//
//  HostViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/12/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "HostViewController.h"

@interface HostViewController ()
@property (weak, nonatomic) IBOutlet UILabel *yourNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *waitingForPlayersLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *QuitGameButton;
@property (weak, nonatomic) IBOutlet UIButton *startGameButton;
@property NSMutableArray *otherPlayersArray;

@end

@implementation HostViewController {
    MatchmakingServer *_matchmakingServer;
    QuitReason _quitReason;
}


@synthesize yourNameLabel = _yourNameLabel;
@synthesize nameTextField = _nameTextField;
@synthesize waitingForPlayersLabel = _waitingForPlayersLabel;
@synthesize tableView = _tableView;
@synthesize startGameButton = _startGameButton;

//not sure if the following are needed
@synthesize QuitGameButton = _QuitGameButton;
@synthesize otherPlayersArray = _otherPlayersArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.nameTextField action:@selector(resignFirstResponder)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_matchmakingServer == nil) {
        _matchmakingServer = [[MatchmakingServer alloc] init];
        _matchmakingServer.maxClients = 3;
        _matchmakingServer.delegate = self;
        [_matchmakingServer startAcceptingConnectionsForSessionID:SESSION_ID];
        
        self.nameTextField.placeholder = _matchmakingServer.session.displayName;
        [self.tableView reloadData];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)onNameTextFieldTapped:(UITextField *)sender {
}


- (IBAction)onStartButtonTapped:(UIButton *)sender {
}


- (IBAction)onQuitButtonTapped:(UIButton *)sender {
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_matchmakingServer != nil)
        return [_matchmakingServer connectedClientCount];
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    NSString *peerID = [_matchmakingServer peerIDForConnectedClientAtIndex:indexPath.row];
    cell.textLabel.text = [_matchmakingServer displayNameForPeerID:peerID];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - MatchmakingServerDelegate

- (void)matchmakingServer:(MatchmakingServer *)server clientDidConnect:(NSString *)peerID {
    [self.tableView reloadData];
}

- (void)matchmakingServer:(MatchmakingServer *)server clientDidDisconnect:(NSString *)peerID {
    [self.tableView reloadData];
}

- (void)matchmakingServerSessionDidEnd:(MatchmakingServer *)server {
    _matchmakingServer.delegate = nil;
    _matchmakingServer = nil;
    [self.tableView reloadData];
    [self.delegate hostViewController:self didEndSessionWithReason:_quitReason];
}

- (void)matchmakingServerNoNetwork:(MatchmakingServer *)session {
    _quitReason = QuitReasonNoNetwork;
}

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"dealloc %@", self);
#endif
}

@end
