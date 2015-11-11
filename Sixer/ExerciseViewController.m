//
//  SecondViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "ExerciseViewController.h"
#import "TimerViewController.h"
#import "ExerciseCell.h"
#import "Exercise.h"
#import "Color.h"
#import "GroupTableViewCell.h"
#import "GroupViewController.h"

@interface ExerciseViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedController;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *groupNameButton;
@property (weak, nonatomic) IBOutlet UIButton *workoutButton;

@property  NSMutableArray *userExercisesArray;

// Outlet for profile button
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property NSMutableArray *userExercisesArray;
@property Exercise *selectedExercise;

@end

@implementation ExerciseViewController

ExerciseCell *cell;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self findUserExercises];
    [self setColorsAndBordersOnLoad];
    self.workoutButton.titleLabel.text = @"select exercise above";
    [self.view setBackgroundColor:[UIColor colorWithRed:155.0f/255.0f green:204.0f/255.0f blue:245.0f/255.0f alpha:1.0f]];
    self.collectionView.backgroundColor = [UIColor colorWithRed:155.0f/255.0f green:204.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
    [self.workoutButton setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:184.0f/255.0f blue:88.0f/255.0f alpha:1.0f]];
    [self.segmentedController setBackgroundColor:[UIColor whiteColor]];
    [self.workoutButton.layer setCornerRadius:75.0f];
    [self.workoutButton.layer setBorderWidth:3.0f];
    [self.workoutButton.layer setBorderColor:[UIColor colorWithRed:167.0f/255.0f green:97.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor];
    self.topView.backgroundColor = [UIColor colorWithRed:17.0f/255.0f green:147.0f/255.0f blue:255.0f/255.0f alpha:1.0f];


}

- (void)findUserExercises {

    PFUser *user = [PFUser currentUser];
    PFRelation *relation = [user relationForKey:@"exercise"];
    PFQuery *query = [relation query];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"something went wrong findUserExercises %@", error);
        }
        else {
            self.userExercisesArray = [[NSMutableArray alloc] initWithArray:objects];
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark - UI Methods
- (void)setColorsAndBordersOnLoad {
    self.topView.backgroundColor = [Color hourDarkBlueColor];
    [self.view setBackgroundColor:[Color hourBackgroundBlueColor]];

    self.collectionView.backgroundColor = [Color hourBackgroundBlueColor];

    [self.workoutButton.layer setBorderWidth:3.0f];
    [self.workoutButton.layer setCornerRadius:10.0f];
    [self.workoutButton setBackgroundColor:[Color hourOrangeColor]];
    [self.workoutButton.layer setBorderColor:[Color hourHighlightBorderOrangeColor].CGColor];

    [self.segmentedController setBackgroundColor:[Color whiteColor]];
}

- (void)resetUnselectedAttributes {
    cell.backgroundColor = [Color whiteColor];
    cell.exerciseLabel.textColor = [Color blackColor];
    cell.exerciseImage.backgroundColor = [Color whiteColor];
    [cell.layer setBorderColor:[Color hourNormalStateBorderColor].CGColor];
    [cell.exerciseLabel.layer setBackgroundColor:[Color whiteColor].CGColor];

    self.workoutButton.hidden = true;
    self.groupNameButton.hidden = true;
    self.segmentedController.hidden = true;
    self.workoutButton.titleLabel.text = @"select exercise above";
}

#pragma mark - UICollectionView Methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.userExercisesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    ExerciseCell *cell = (ExerciseCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"ExerciseCell" forIndexPath:indexPath];
    Exercise *exercise = [self.userExercisesArray objectAtIndex:indexPath.row];
    PFFile *imageFile = [exercise objectForKey:@"image"];

    NSData *imageData = [imageFile getData];
    cell.exerciseImage.image = [UIImage imageWithData:imageData];
    cell.exerciseLabel.text = [exercise objectForKey:@"name"];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    cell = (ExerciseCell *) [collectionView cellForItemAtIndexPath:indexPath];
    self.selectedExercise = [self.userExercisesArray objectAtIndex:indexPath.row];

    [self.workoutButton setTitle:[NSString stringWithFormat:@"Start %@", self.selectedExercise.name] forState:UIControlStateNormal];

    [cell.exerciseLabel.layer setBackgroundColor:[Color hourOrangeColor].CGColor];
    [cell.layer setBorderColor:[Color hourHighlightBorderOrangeColor].CGColor];
    cell.exerciseImage.backgroundColor = [Color hourOrangeColor];
    cell.exerciseLabel.textColor = [Color whiteColor];
    cell.backgroundColor = [Color hourOrangeColor];

    self.workoutButton.hidden = false;
    self.groupNameButton.hidden = false;
    self.segmentedController.hidden = false;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self resetUnselectedAttributes];
}

#pragma mark - onButtonTapped Methods
- (IBAction)onProfileButtonTapped:(id)sender {
    [self.delegate frontRevealButtonTapped];
}

- (IBAction)onAddExerciseButtonTapped:(UIButton *)sender {
}

- (IBAction)onGroupNameButtonTapped:(UIButton *)sender {
}

- (IBAction)onBeginWorkoutButtonTapped:(UIButton *)sender {
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier  isEqual:@"StartTimer"]) {
        TimerViewController *vc = segue.destinationViewController;
        vc.selectedExercise = self.selectedExercise;
    }
-(void)groupTableViewCell:(id)cell didTapButton:(UIButton *)button {
//    self.groupNameButton.titleLabel = but
}

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toGroupSegue"]) {
        GroupViewController *gVC = segue.destinationViewController;
        gVC.senderEVC = self;
    }
}



@end
