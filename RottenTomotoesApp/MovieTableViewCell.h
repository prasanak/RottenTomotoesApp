//
//  MovieTableViewCell.h
//  RottenTomotoesApp
//
//  Created by Prasannakumar Jobigenahally on 1/26/15.
//  Copyright (c) 2015 yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageThumbnail;
@property (weak, nonatomic) IBOutlet UILabel *movieYear;
@property (weak, nonatomic) IBOutlet UILabel *movieCriticRatings;
@property (weak, nonatomic) IBOutlet UILabel *movieAudienceRatings;

@end
