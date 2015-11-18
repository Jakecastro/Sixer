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
#import "AppDelegate.h"

@interface ExerciseViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedController;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIButton *teamButton;
@property  NSMutableArray *userExercisesArray;
@property Exercise *selectedExercise;
@property NSMutableArray *defaultArray;    
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
    self.navigationController.navigationBar.barTintColor = [Color flatTurquoiseColor];
    
    self.collectionView.delegate = self;
    self.defaultArray = [NSMutableArray new];
    
    self.teamButton.backgroundColor = [Color flatCloudsColor];
    [self.teamButton.layer setCornerRadius:8.0f];
}

- (void)findUserExercises {

    PFUser *user = [PFUser currentUser];
    PFRelation *relation = [user relationForKey:@"exercise"];
    PFQuery *query = [relation query];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error findUserExercises %@", error);
        }
        else {
            self.userExercisesArray = [[NSMutableArray alloc] initWithArray:objects];
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark - UI Methods
- (void)setColorsAndBordersOnLoad {
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.segmentedController setBackgroundColor:[Color whiteColor]];
}

- (void)resetUnselectedAttributes {
    cell.exerciseLabel.backgroundColor = [Color flatSilverColor];
    cell.exerciseImage.backgroundColor = [Color flatCloudsColor];

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

    cell.exerciseImage.backgroundColor = [Color selectedExerciseColor];
    cell.exerciseLabel.backgroundColor = [Color flatTurquoiseColor];

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
