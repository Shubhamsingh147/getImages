//
//  ViewController.m
//  getImages
//
//  Created by Shubham Singh on 26/05/15.
//  Copyright (c) 2015 Shubham Singh. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell"bundle:nil] forCellReuseIdentifier:@"Cell"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
dispatch_async(myQueue, ^{
    
    NSString *myString = @"http://placehold.it/320x320&text=";
    NSString *test = [myString stringByAppendingString:[NSString stringWithFormat:@"%ld" , [indexPath row]]];
    NSURL *url = [NSURL URLWithString:test];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        cell.myImageView.image = image;
    });
});
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
