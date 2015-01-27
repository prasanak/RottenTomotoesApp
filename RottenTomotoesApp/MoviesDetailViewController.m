//
//  MoviesDetailViewController.m
//  RottenTomotoesApp
//
//  Created by Prasannakumar Jobigenahally on 1/26/15.
//  Copyright (c) 2015 yahoo. All rights reserved.
//

#import "MoviesDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MoviesDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *movieSynopsis;

@end

@implementation MoviesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = self.movieDetails[@"title"]; // todo: this should be replaced with the actual movie title
    
    self.titleLabel.text = self.movieDetails[@"title"];
    NSString *url = [self.movieDetails valueForKeyPath:@"posters.thumbnail"];
    NSString *high_resolution_url = [url stringByReplacingOccurrencesOfString:@"_tmb" withString:@"_ori"];
    [self.movieImage setImageWithURL:[NSURL URLWithString:high_resolution_url]];
    self.movieSynopsis.text = self.movieDetails[@"synopsis"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
