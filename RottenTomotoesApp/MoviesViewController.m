//
//  MoviesViewController.m
//  RottenTomotoesApp
//
//  Created by Prasannakumar Jobigenahally on 1/26/15.
//  Copyright (c) 2015 yahoo. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieTableViewCell.h"
#import "MoviesDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *moviesTableView;
@property (strong, nonatomic) NSArray *movies;

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIView *networkErrorView;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Movies";
    
    self.networkErrorView.hidden = YES;
    
    [self.moviesTableView registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieTableViewCell"];
    
    self.moviesTableView.dataSource = self;
    self.moviesTableView.delegate = self;
    
    [self onRefresh];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.moviesTableView insertSubview:self.refreshControl atIndex:0];
}

- (void) onRefresh {
    
    [SVProgressHUD show];
    
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=8xsfk7msjscfcxv9xgu35gnk&limit=20&country=us"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // runs when async response comes back
        
        if (connectionError) {
            self.networkErrorView.hidden = NO;
        } else {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.movies = responseDictionary[@"movies"];
            [self.moviesTableView reloadData];
            self.networkErrorView.hidden = YES;

        }
        [self.refreshControl endRefreshing];
        [SVProgressHUD dismiss];
    }];
    
    
    
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieTableViewCell"];
    
    cell.titleLabel.text = [NSString stringWithFormat:@"%@", self.movies[indexPath.row][@"title"]];
    
    [cell.movieImageThumbnail setImageWithURL:[NSURL URLWithString:[self.movies[indexPath.row] valueForKeyPath:@"posters.thumbnail"]]];
    
    cell.movieYear.text = [NSString stringWithFormat:@"%@", self.movies[indexPath.row][@"year"]];
    cell.movieCriticRatings.text = [NSString stringWithFormat:@"%@%%", [self.movies[indexPath.row] valueForKeyPath:@"ratings.critics_score"]];
    cell.movieAudienceRatings.text = [NSString stringWithFormat:@"%@%%", [self.movies[indexPath.row] valueForKeyPath:@"ratings.audience_score"]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    MoviesDetailViewController *vc = [[MoviesDetailViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    vc.movieDetails = self.movies[indexPath.row];

}

@end
