//
//  UALeaningExamplesTableViewController.m
//  Learning Examples
//
//  Created by udit.ag on 26/03/14.
//  Copyright (c) 2014 Talk to. All rights reserved.
//

#import "UALeaningExamplesTableViewController.h"
#import "UAImageViewController.h"

@interface UALeaningExamplesTableViewController ()

@end

@implementation UALeaningExamplesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([[segue identifier] isEqualToString:@"ExamplesToProgressiveImageLoad"]) {
    UAImageViewController *dest = [segue destinationViewController];
    dest.remotePath = @"http://media.idownloadblog.com/wp-content/uploads/2013/10/Water-Lily-Mario-Britten-iPhone-5.jpg";
//    dest.remotePath = @"http://ipv4.download.thinkbroadband.com/10MB.zip";
  }
}

@end
