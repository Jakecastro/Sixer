//
//  AddExerciseViewController.m
//  Sixer
//
//  Created by Jake Castro on 11/5/15.
//  Copyright © 2015 Jake Castro. All rights reserved.
//

#import "AddExerciseViewController.h"
#import "Exercise.h"

@interface AddExerciseViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *exercisesArray;
@property NSMutableArray *exerciseImagesArray;

@end

@implementation AddExerciseViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//TODO: save exercise name to users table as relationship to exercise
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.exerciseImagesArray = [[NSMutableArray alloc] init];

    PFQuery *exercisesQuery = [PFQuery queryWithClassName:@"Exercise"];
    [exercisesQuery whereKeyExists:@"name"];
    [exercisesQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"You're flabby because %@", error);
        }
        else {
            self.exercisesArray = objects;
            for (Exercise *exercise in self.exercisesArray) {
                PFFile *imageFile = [exercise objectForKey:@"image"];
                [imageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
                    UIImage *image = [UIImage imageWithData:data];
                    [self.exerciseImagesArray addObject:image];
                    if (exercise == [self.exercisesArray lastObject]) {
                        [self.tableView reloadData];
                    }
                }];
            }
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.exercisesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddExerciseCell" forIndexPath:indexPath];
    Exercise *exercise = [self.exercisesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [exercise objectForKey:@"name"];
    cell.imageView.image = [self.exerciseImagesArray objectAtIndex:indexPath.row];

    


    return cell;
}

@end
