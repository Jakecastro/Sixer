//
//  AddExerciseViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "AddExerciseViewController.h"
#import "CVExerciseCell.h"
#import "Exercise.h"
#import "Color.h"

@interface AddExerciseViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSIndexPath *selectedItemIndexPath;
@property NSMutableArray *selectedExercise;
@property NSMutableArray *userExercises;
@property NSArray *exercisesArray;

@end

@implementation AddExerciseViewController

CVExerciseCell *addExerciseCell;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self queryExercisesFromParse];

    [self.view setBackgroundColor:[Color hourDarkBlueColor]];
    [self.collectionView setBackgroundColor:[Color hourDarkBlueColor]];
}

#pragma mark - Query Parse Methods
- (void)queryExercisesFromParse {
    //  returns all objects on the Exerise table from Parse and will nslog an error if it fails
    PFQuery *query = [PFQuery queryWithClassName:@"Exercise"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"something went wrong with queryParse %@",error);
        }
        else {
            self.exercisesArray = [[NSArray alloc]initWithArray:objects];
            [self findUserExercisesFromParse];
        }
    }];
}
- (void)findUserExercisesFromParse {

    PFUser *user = [PFUser currentUser];
    PFRelation *relation = [user relationForKey:@"exercise"];
    PFQuery *query = [relation query];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"something went wrong findUserExercises %@", error);
        }
        else {
            self.userExercises = [[NSMutableArray alloc] initWithArray:objects];
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark collecitonview methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.exercisesArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    addExerciseCell = (CVExerciseCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    //  make all objects returned from Parse Exercise objects
    Exercise *exercise = [self.exercisesArray objectAtIndex:indexPath.row];

    if ([self.userExercises containsObject:exercise]) {
        exercise.isUserExercise = [NSNumber numberWithBool:true];
    }
    else {
        exercise.isUserExercise = [NSNumber numberWithBool:false];
    }

    //  converts pffile to images that objective c can render, images are stored as pffiles on Parse
    PFFile *imageFile = [exercise objectForKey:@"image"];
    [imageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"something went wrong with cellForItemAtIndexPath %@",error);
        }
        else {
            addExerciseCell.imageView.image = [UIImage imageWithData:data];
            addExerciseCell.nameLabel.text = [exercise objectForKey:@"name"];
        }
    }];


    return addExerciseCell;
}


#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    PFUser *user = [PFUser currentUser];
    Exercise *seletedExercise = self.exercisesArray[indexPath.item];
    PFRelation *userExerciseRelation = [user relationForKey:@"exercise"];

    if ([seletedExercise.isUserExercise boolValue] == true) {
        seletedExercise.isUserExercise = [NSNumber numberWithBool:false];
        [userExerciseRelation removeObject:seletedExercise];
    }
    else if ([seletedExercise.isUserExercise boolValue] == false) {
        seletedExercise.isUserExercise = [NSNumber numberWithBool:true];
        [userExerciseRelation addObject:seletedExercise];
    }

    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error with saving didSelectItemAtIndexPath %@", error);
        }
    }];

}

@end
