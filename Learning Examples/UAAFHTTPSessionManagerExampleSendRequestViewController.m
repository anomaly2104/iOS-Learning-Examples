//
//  UAAFHTTPSessionManagerExampleSendRequestViewController.m
//  Learning Examples
//
//  Created by udit.ag on 27/03/14.
//  Copyright (c) 2014 Talk to. All rights reserved.
//

#import "UAAFHTTPSessionManagerExampleSendRequestViewController.h"
#import <AFNetworking.h>

static NSString * const BaseURL = @"http://httpbin.org/";

@interface UAAFHTTPSessionManagerExampleSendRequestViewController ()

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *apiURLLabel;
@property (weak, nonatomic) IBOutlet UITextView *responseTextView;
@property (nonatomic, strong) AFHTTPSessionManager *afHTTPSessionManager;
@end

@implementation UAAFHTTPSessionManagerExampleSendRequestViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self updateStatus:@"View Controller Loaded"];
  self.statusLabel.adjustsFontSizeToFitWidth = YES;
  self.afHTTPSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
  [self sendAppropriateRequest];
}

- (void)sendAppropriateRequest {
  switch (self.requestType) {
    case UAAFHTTPSessionManagerExampleSendRequestTypeGet:
      [self sendGETRequest];
      break;
    case UAAFHTTPSessionManagerExampleSendRequestTypePost:
      [self sendPOSTRequest];
      break;
    case UAAFHTTPSessionManagerExampleSendRequestTypePut:
      [self sendPutRequest];
      break;
    case UAAFHTTPSessionManagerExampleSendRequestTypeDelete:
      [self sendDeleteRequest];
      break;
    default:
      [self updateStatus: [NSString stringWithFormat:@"Invalid HTTP Request Passed: %@", @(self.requestType)]];
      break;
  }
}

- (void)sendGETRequest{
  [self updateStatus:@"Sending GET Request"];
  [self.afHTTPSessionManager GET:@"get"
                      parameters:nil
                         success:^(NSURLSessionDataTask *task, id responseObject) {
                           [self updateStatus:@"GET Response Received"];
                           [self updateResponse:[responseObject description]];
                         }
                         failure:^(NSURLSessionDataTask *task, NSError *error) {
                           NSLog(@"Error from GET request: %@", error);
                           [self updateResponse:[error description]];
                         }];
  [self updateStatus:@"GET Request Sent"];
}

- (void)sendPOSTRequest{
  [self updateStatus:@"Sending POST Request"];
  [self.afHTTPSessionManager POST:@"post"
                       parameters:nil
                          success:^(NSURLSessionDataTask *task, id responseObject) {
                            [self updateStatus:@"POST Response Received"];
                            [self updateResponse:[responseObject description]];

                          }
                          failure:^(NSURLSessionDataTask *task, NSError *error) {
                            NSLog(@"Error from POST request: %@", error);
                            [self updateResponse:[error description]];
                          }];
  [self updateStatus:@"POST Request Sent"];
}

- (void)sendPutRequest {
  [self updateStatus:@"Sending PUT Request"];
  [self.afHTTPSessionManager PUT:@"put"
                       parameters:nil
                          success:^(NSURLSessionDataTask *task, id responseObject) {
                            [self updateStatus:@"PUT Response Received"];
                            [self updateResponse:[responseObject description]];
                            
                          }
                          failure:^(NSURLSessionDataTask *task, NSError *error) {
                            NSLog(@"Error from PUT request: %@", error);
                            [self updateResponse:[error description]];
                          }];
  [self updateStatus:@"PUT Request Sent"];
}

- (void)sendDeleteRequest {
  [self updateStatus:@"Sending DELETE Request"];
  [self.afHTTPSessionManager DELETE:@"delete"
                       parameters:nil
                          success:^(NSURLSessionDataTask *task, id responseObject) {
                            [self updateStatus:@"DELETE Response Received"];
                            [self updateResponse:[responseObject description]];
                            
                          }
                          failure:^(NSURLSessionDataTask *task, NSError *error) {
                            NSLog(@"Error from DELETE request: %@", error);
                            [self updateResponse:[error description]];
                          }];
  [self updateStatus:@"DELETE Request Sent"];
}

- (void)updateResponse:(NSString *)response {
  self.responseTextView.text = response;
}

- (void)updateStatus:(NSString *)status {
  NSLog(@"Status Updated: %@", status);
  self.statusLabel.text = status;
}

@end
