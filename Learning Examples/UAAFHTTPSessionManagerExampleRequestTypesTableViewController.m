//
//  UAAFHTTPSessionManagerExampleRequestTypesTableViewController.m
//  Learning Examples
//
//  Created by udit.ag on 27/03/14.
//  Copyright (c) 2014 Talk to. All rights reserved.
//

#import "UAAFHTTPSessionManagerExampleRequestTypesTableViewController.h"
#import "UAAFHTTPSessionManagerExampleSendRequestViewController.h"

@interface UAAFHTTPSessionManagerExampleRequestTypesTableViewController ()

@end

@implementation UAAFHTTPSessionManagerExampleRequestTypesTableViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"Selected row: %@", @(indexPath.row));
  switch (indexPath.row) {
    case 0:
      [self performSegueWithIdentifier:@"ExamplesToAFHttpSessionManagerRequest"
                                sender:UAAFHTTPSessionManagerExampleSendRequestTypeGet];
      break;
    case 1:
      [self performSegueWithIdentifier:@"ExamplesToAFHttpSessionManagerRequest"
                                sender:@(UAAFHTTPSessionManagerExampleSendRequestTypePost)];
      break;
    case 2:
      [self performSegueWithIdentifier:@"ExamplesToAFHttpSessionManagerRequest"
                                sender:@(UAAFHTTPSessionManagerExampleSendRequestTypePut)];
      break;
    case 3:
      [self performSegueWithIdentifier:@"ExamplesToAFHttpSessionManagerRequest"
                                sender:@(UAAFHTTPSessionManagerExampleSendRequestTypeDelete)];
      break;
    default:
      break;
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([[segue identifier] isEqualToString:@"ExamplesToAFHttpSessionManagerRequest"]) {
    UAAFHTTPSessionManagerExampleSendRequestViewController *dest = segue.destinationViewController;
    if ([sender respondsToSelector:@selector(intValue)]) {
      dest.requestType = [sender intValue];
      NSLog(@"Dest req: %@", @(dest.requestType));
    }
  }
}

@end
