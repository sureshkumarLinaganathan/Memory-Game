//
//  ViewController.m
//  Memory Game
//
//  Created by Sureshkumar Linganathan on 2/7/18.
//  Copyright © 2018 Impiger Technologies. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"

#define MAX_RAND_VALUE 5
#define NO_OF_ELEMENTS 100

@interface ViewController ()<CollectionViewCellDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *autoGneValues;

@property (strong, nonatomic) NSMutableArray *selectedValues;

@property (assign, nonatomic) BOOL isValueReload;

@property (weak, nonatomic) IBOutlet UILabel *scroeLabel;

@property (weak, nonatomic) IBOutlet UIView *scroeView;

@end

@implementation ViewController


#pragma mark - View life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];

}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self performSelector:@selector(reloadValues) withObject:nil afterDelay:3.0];
}

-(void)setupView{
    _autoGneValues = [[NSMutableArray alloc]init];
    _selectedValues = [[NSMutableArray alloc]init];
    _autoGneValues = [self generateRandomValues];
    [_scroeView setHidden:YES];
}


#pragma mark - Collection view datasource and deletegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return NO_OF_ELEMENTS;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewReuseIdntifier" forIndexPath:indexPath];
    
    NSString *str = [@(indexPath.row) stringValue];
    cell.delegate = self;
    if(_isValueReload){
        
        if(([_selectedValues containsObject:str])&&([_autoGneValues containsObject:str])){
            
            [cell setupView:str withViewBackgroundColor:[UIColor greenColor]];
        }else if(([_selectedValues containsObject:str])){
            
            [cell setupView:str withViewBackgroundColor:[UIColor redColor]];
            
        }else{
        [cell setupView:str withViewBackgroundColor:[UIColor orangeColor]];
        }
        
    }else{
    
    if([_autoGneValues containsObject:str]){
    [cell setupView:str withViewBackgroundColor:[UIColor greenColor]];
    }else{
        
        [cell setupView:str withViewBackgroundColor:[UIColor whiteColor]];
    }
}
    
    return  cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(40,40);
    
}

-(void)reloadValues{
    
    _isValueReload = YES;
    [_collectionView reloadData];
}


#pragma mark - Generate Random values

-(NSMutableArray*)generateRandomValues{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    for(int i=0;i<MAX_RAND_VALUE;i++){
    NSString *value = [NSString stringWithFormat:@"%d",arc4random() % 99 +0];
        if(![array containsObject:value]){
        [array addObject:value];
        }else{
            i--;
        }
    }
    return array;
}

- (IBAction)doneButtonTapped:(id)sender {
    
    [self setupView];
    [_collectionView reloadData];
}

#pragma mark - Collection view Delegate

-(void)cellSelected:(CollectionViewCell *)cell{
    
    NSIndexPath *indexpath = [self.collectionView indexPathForCell:cell];
        [_selectedValues addObject:[@(indexpath.row) stringValue]];
        [_collectionView reloadData];
    if([_selectedValues count] == [_autoGneValues count]){
        _scroeLabel.text = [NSString stringWithFormat:@"Score:%d",[self findCorrectlySelectdValuecount]];
        [_scroeView setHidden:NO];
    }
        
}

-(int)findCorrectlySelectdValuecount{
    
    int count = 0;
    for(int i=0;i<[_autoGneValues count];i++){
        
        for(int j=0;j<[_autoGneValues count];j++){
            
            if([[_autoGneValues objectAtIndex:i] isEqualToString:[_selectedValues objectAtIndex:j] ]){
                
                count++;
            }
        }
    }
    return  count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
