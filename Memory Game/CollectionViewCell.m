//
//  CollectionViewCell.m
//  Memory Game
//
//  Created by Sureshkumar Linganathan on 2/7/18.
//  Copyright © 2018 Impiger Technologies. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

-(void)setupView:(NSString *)string withViewBackgroundColor:(UIColor *)backgroundColor{
    
    [self.view.layer setMasksToBounds:YES];
    [self.view.layer setCornerRadius:20];
    [self.view setBackgroundColor:backgroundColor];
    [self.label setText:string];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(numberSelected)];
    [self addGestureRecognizer:tapGesture];
}

-(void)numberSelected{
    
    [self.delegate cellSelected:self];
}

@end
