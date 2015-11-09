//
//  SecondViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "ExerciseViewController.h"
#import "ExerciseCell.h"
#import "Exercise.h"

@interface ExerciseViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedController;
@property (weak, nonatomic) IBOutlet UIButton *workoutButton;
@property (weak, nonatomic) IBOutlet UIButton *groupNameButton;
@property  NSMutableArray *userExercisesArray;

// Outlet for profile button
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@end

@implementation ExerciseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self findUserExercises];
    [self.view setBackgroundColor:[UIColor colorWithRed:155.0f/255.0f green:204.0f/255.0f blue:245.0f/255.0f alpha:1.0f]];
    self.collectionView.backgroundColor = [UIColor colorWithRed:17.0f/255.0f green:147.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [self.workoutButton setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:184.0f/255.0f blue:88.0f/255.0f alpha:1.0f]];
    [self.segmentedController setBackgroundColor:[UIColor whiteColor]];
    [self.workoutButton.layer setCornerRadius:75.0f];
    [self.workoutButton.layer setBorderWidth:3.0f];
    [self.workoutButton.layer setBorderColor:[UIColor colorWithRed:167.0f/255.0f green:97.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor];
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


- (IBAction)onProfileButtonTapped:(id)sender {
    
    [self.delegate frontRevealButtonTapped];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.userExercisesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    ExerciseCell *cell = (ExerciseCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"ExerciseCell" forIndexPath:indexPath];
    [cell.layer setBorderWidth:2.0f];
    [cell.layer setBorderColor:[UIColor colorWithRed:0.0f/255.0f green:59.0f/255.0f blue:108.0f/255.0f alpha:1.0f].CGColor];
    [cell.layer setCornerRadius:30.0f];
    [cell.exerciseImage.layer setCornerRadius:30.0f];

    Exercise *exercise = [self.userExercisesArray objectAtIndex:indexPath.row];
    PFFile *imageFile = [exercise objectForKey:@"image"];

    NSData *imageData = [imageFile getData];
    cell.exerciseImage.image = [UIImage imageWithData:imageData];
    cell.exerciseLabel.text = [exercise objectForKey:@"name"];

    return cell;
}


- (IBAction)onAddExerciseButtonTapped:(UIButton *)sender {
}

- (IBAction)onGroupNameButtonTapped:(UIButton *)sender {
}

- (IBAction)onBeginWorkoutButtonTapped:(UIButton *)sender {
}





@end
