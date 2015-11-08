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
@property NSArray *exercisesArray;

@end

@implementation AddExerciseViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//TODO: save exercise name to users table as relationship to exercise
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self queryParse];
}

- (void)queryParse {
// this method returns all objects on the Exerise table from Parse and will nslog an error if it fails
    PFQuery *query = [PFQuery queryWithClassName:@"Exercise"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"something went wrong with queryParse %@",error);
        }
        else {
            self.exercisesArray = [[NSArray alloc]initWithArray:objects];
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
    CVExerciseCell *cell = (CVExerciseCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

//    UICollectionViewFlowLayout *flowlayout = [UICollectionViewFlowLayout new];
//    flowlayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width);
//
//    self.collectionView.collectionViewLayout = flowlayout;

//make all objects returned from Parse Exercise objects
    Exercise *exercise = [self.exercisesArray objectAtIndex:indexPath.row];
//converts pffile to images that objective c can render, images are stored as pffiles on Parse
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

@end











