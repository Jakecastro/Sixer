//
//  JoinViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/12/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "JoinViewController.h"

@interface JoinViewController () 

@property (weak, nonatomic) IBOutlet UILabel *yourNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *availableGamesLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *quitGameButton;

@property (nonatomic, strong) IBOutlet UIView *waitView;

@property NSMutableArray *availableGamesArray;

@end

@implementation JoinViewController {
    MatchmakingClient *_matchmakingClient;
    QuitReason _quitReason;
}


- (void)dealloc {
#ifdef DEBUG
    NSLog(@"dealloc %@", self);
#endif
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.nameTextField action:@selector(resignFirstResponder)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.waitView = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_matchmakingClient == nil) {
        _quitReason = QuitReasonConnectionDropped;
        
        _matchmakingClient = [[MatchmakingClient alloc] init];
        _matchmakingClient.delegate = self;
        [_matchmakingClient startSearchingForServersWithSessionID:SESSION_ID];
        
        self.nameTextField.placeholder = _matchmakingClient.session.displayName;
        [self.tableView reloadData];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)exitAction:(id)sender {
    _quitReason = QuitReasonUserQuit;
    [_matchmakingClient disconnectFromServer];
    [self.delegate joinViewControllerDidCancel:self];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_matchmakingClient != nil)
        return [_matchmakingClient availableServerCount];
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    NSString *peerID = [_matchmakingClient peerIDForAvailableServerAtIndex:indexPath.row];
    cell.textLabel.text = [_matchmakingClient displayNameForPeerID:peerID];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_matchmakingClient != nil) {
        [self.view addSubview:self.waitView];
        
        NSString *peerID = [_matchmakingClient peerIDForAvailableServerAtIndex:indexPath.row];
        [_matchmakingClient connectToServerWithPeerID:peerID];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - MatchmakingClientDelegate

- (void)matchmakingClient:(MatchmakingClient *)client serverBecameAvailable:(NSString *)peerID {
    [self.tableView reloadData];
}

- (void)matchmakingClient:(MatchmakingClient *)client serverBecameUnavailable:(NSString *)peerID {
    [self.tableView reloadData];
}

- (void)matchmakingClient:(MatchmakingClient *)client didDisconnectFromServer:(NSString *)peerID {
    _matchmakingClient.delegate = nil;
    _matchmakingClient = nil;
    [self.tableView reloadData];
    [self.delegate joinViewController:self didDisconnectWithReason:_quitReason];
}

- (void)matchmakingClientNoNetwork:(MatchmakingClient *)client {
    _quitReason = QuitReasonNoNetwork;
}

@end

