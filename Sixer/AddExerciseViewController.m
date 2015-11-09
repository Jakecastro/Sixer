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

@interface AddExerciseViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSIndexPath *selectedItemIndexPath;
@property NSMutableArray *userExercises;
@property NSMutableArray *selectedExercise;
@property NSArray *exercisesArray;

@end

@implementation AddExerciseViewController

CVExerciseCell *cell;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self queryParse];
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
            self.userExercises = [[NSMutableArray alloc] initWithArray:objects];
            [self.collectionView reloadData];
        }
    }];
}

- (void)queryParse {
    //  returns all objects on the Exerise table from Parse and will nslog an error if it fails
    PFQuery *query = [PFQuery queryWithClassName:@"Exercise"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"something went wrong with queryParse %@",error);
        }
        else {
            self.exercisesArray = [[NSArray alloc]initWithArray:objects];
            [self findUserExercises];
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
    cell = (CVExerciseCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    //  make all objects returned from Parse Exercise objects
    Exercise *exercise = [self.exercisesArray objectAtIndex:indexPath.row];

    if ([self.userExercises containsObject:exercise]) {
        exercise.isUserExercise = [NSNumber numberWithBool:true];
        cell.imageView.alpha = 0.2;
    }
    else {
        exercise.isUserExercise = [NSNumber numberWithBool:false];
        cell.imageView.alpha = 1.0;
    }

    //  converts pffile to images that objective c can render, images are stored as pffiles on Parse
    PFFile *imageFile = [exercise objectForKey:@"image"];
    [imageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"something went wrong with cellForItemAtIndexPath %@",error);
        }
        else {
            cell.imageView.image = [UIImage imageWithData:data];
            cell.nameLabel.text = [exercise objectForKey:@"name"];
        }
    }];
    [cell.layer setBorderWidth:2.0f];
    [cell.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [cell.layer setCornerRadius:30.0f];
    [cell.imageView.layer setCornerRadius:30.0f];

    return cell;
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

- (BOOL)isExerciseForUser:(Exercise *)userExercise {
    for (Exercise *exercise in self.exercisesArray) {
        if ([exercise.objectId isEqualToString:userExercise.objectId]) {
            return YES;
        }
    }
    return NO;
}

//-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//
//   Exercise* deselectedExercise= self.userExercises[indexPath.item];
//    [self.selectedExercise removeObject:deselectedExercise];
//    cell.imageView.alpha = 1.0;
//    cell.nameLabel.alpha = 1.0;
//
//    NSLog(@"Selected Exercises: %@", self.selectedExercise);
//}

//-(void)deleteSelectedExercises:(id)sender {
//    // get the selected indexpaths
//    NSArray* selectedIndexPaths = [self.collectionView indexPathsForSelectedItems];
//
//    // delete words from words array
//    NSMutableArray* mutableExercises = [self.userExercises mutableCopy];
//    NSMutableIndexSet* deletionIndexSet = [NSMutableIndexSet indexSet];
//    for (NSIndexPath* indexPath in selectedIndexPaths) {
//        [deletionIndexSet addIndex:indexPath.item];
//    }
//    [mutableExercises removeObjectsAtIndexes:deletionIndexSet];
//
//    self.userExercises = [NSMutableArray arrayWithArray:mutableExercises];
//
//    // tell the collection view to delete cells
//    [self.collectionView performBatchUpdates:^{
//        [self.collectionView deleteItemsAtIndexPaths:selectedIndexPaths];
//    } completion:nil];
//}

@end











