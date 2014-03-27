//
//  UAAFHTTPSessionManagerExampleSendRequestViewController.h
//  Learning Examples
//
//  Created by udit.ag on 27/03/14.
//  Copyright (c) 2014 Talk to. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  UAAFHTTPSessionManagerExampleSendRequestTypeGet,
  UAAFHTTPSessionManagerExampleSendRequestTypePost,
  UAAFHTTPSessionManagerExampleSendRequestTypeDelete,
  UAAFHTTPSessionManagerExampleSendRequestTypePut
}UAAFHTTPSessionManagerExampleSendRequestType;

@interface UAAFHTTPSessionManagerExampleSendRequestViewController : UIViewController
@property (nonatomic) UAAFHTTPSessionManagerExampleSendRequestType requestType;
@end
