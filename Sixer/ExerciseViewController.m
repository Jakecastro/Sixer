//
//  SecondViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "ExerciseViewController.h"
#import "StopwatchController.h"
#import "ExerciseCell.h"
#import "Exercise.h"
#import "Group.h"
#import "Color.h"
#import "GroupTableViewCell.h"
#import "GroupViewController.h"

@interface ExerciseViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedController;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@property  NSMutableArray *userExercisesArray;

@property Exercise *selectedExercise;

@end

@implementation ExerciseViewController

ExerciseCell *cell;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self findUserExercises];
    [self setColorsAndBordersOnLoad];
    
    UIImage *titleImage = [UIImage imageNamed:@"Get Active!"];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:titleImage];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:194.0/255.0 green:222.0/255.0 blue:17.0/255.0 alpha:1.0f];
    
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
    self.topView.backgroundColor = [Color chartreuse];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    cell.exerciseImage.backgroundColor = [Color flatCloudsColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.segmentedController setBackgroundColor:[Color whiteColor]];
}

- (void)resetUnselectedAttributes {
    cell.backgroundColor = [Color whiteColor];
    cell.exerciseLabel.backgroundColor = [UIColor grayColor];
    cell.exerciseImage.backgroundColor = [Color flatCloudsColor];
    [cell.layer setBorderColor:[Color hourNormalStateBorderColor].CGColor];
//    [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
    [cell.exerciseLabel.layer setBackgroundColor:[Color whiteColor].CGColor];
    cell.exerciseImage.backgroundColor = [Color flatCloudsColor];

//    self.workoutButton.hidden = true;
//    self.workoutButton.titleLabel.text = @"select exercise above";
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
    cell.exerciseImage.backgroundColor = [Color flatCloudsColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    cell = (ExerciseCell *) [collectionView cellForItemAtIndexPath:indexPath];
    self.selectedExercise = [self.userExercisesArray objectAtIndex:indexPath.row];

    cell.exerciseImage.backgroundColor = [Color chartreuse];
    cell.exerciseLabel.backgroundColor = [UIColor grayColor];
    cell.backgroundColor = [UIColor whiteColor];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self resetUnselectedAttributes];
}

#pragma mark - onButtonTapped Methods
- (IBAction)onGroupNameButtonTapped:(UIButton *)sender {
}


#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"%ld", (long)self.segmentedController.selectedSegmentIndex);

    if ([segue.identifier isEqualToString:@"SwipeUp"]) {
        StopwatchController *vc = segue.destinationViewController;
        vc.selectedExercise = self.selectedExercise;
        vc.groupActivity = self.segmentedController.selectedSegmentIndex;

        if (self.segmentedController.selectedSegmentIndex == 0) {
            vc.groupName = [[Group alloc] initWithGroupName:@"solo"];
        }
        else if (self.segmentedController.selectedSegmentIndex == 1) {
            vc.groupName = self.groupCurrentlyIn;
        }
    }

    if ([segue.identifier isEqualToString:@"toGroupSegue"]) {
        GroupViewController *gVC = segue.destinationViewController;
        gVC.senderEVC = self;
    }


}


@end
