//
//  ViewController.m
//  Stretch Table Head
//
//  Created by Jian Yao Ang on 11/28/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
{
    //for the scrollView to offset the value
    float defaultY;
}

@property (strong, nonatomic) IBOutlet UITableView *theTableView;
@property (strong, nonatomic) IBOutlet UIImageView *theImageView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingUp];
}

-(void)settingUp
{
    UIImage *theImage = [UIImage imageNamed:@"jlaw"];
    self.theImageView = [[UIImageView alloc] initWithImage:theImage];
    self.theImageView.frame = CGRectMake(0, 0, 320, 480);
    CGRect frame = self.theImageView.frame;
    
    //we want to make the UIImageView to go beyong the y axis. This is to help give the illusion of the image grows bigger
    frame.origin.y = -120;
    
    //set defaultY to reference in the didScroll method
    defaultY = frame.origin.y;
    
    //applying the frame to theImageView's frame
    self.theImageView.frame = frame;
    
    self.theTableView.backgroundColor = [UIColor clearColor];
    
    //setting the header to theTableView
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 170)];
    header.backgroundColor = [UIColor clearColor];
    self.theTableView.tableHeaderView = header;
    
    [self.view addSubview:self.theImageView];

    [self.view addSubview:self.theTableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"TheCell";
    UITableViewCell *cell = [self.theTableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = @"Stretch Me!!";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"I am %ld", (long)indexPath.row];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //this is set the intial scrollView y value
    float offsetY = scrollView.contentOffset.y;
    CGRect frame = self.theImageView.frame;
    
    //stretching action here:
    if (offsetY < 0)
    {
        frame.origin.y = defaultY - offsetY * 0.8;
    }
    //need to reset to original position
    else
    {
        frame.origin.y = defaultY - offsetY;
    }
    
    //set the image's frame
    self.theImageView.frame = frame;
    
}

@end
