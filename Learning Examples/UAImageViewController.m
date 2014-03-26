//
//  UAImageViewController.m
//  Learning Examples
//
//  Created by udit.ag on 26/03/14.
//  Copyright (c) 2014 Talk to. All rights reserved.
//

#import "UAImageViewController.h"
#import "AFURLSessionManager.h"

static void *myContext = &myContext;

@interface UAImageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) NSURLSessionDownloadTask *imageDownloadTask;

@end

@implementation UAImageViewController

- (id)init {
  self = [super init];
  if (self) {
    
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self changeStatus:@"Image Load Started"];
  [self deleteCurrentFileWithURL:[self filePathForImageFile]];
  [self startImageLoad];
}

- (void)viewDidDisappear:(BOOL)animated {
  [self.imageDownloadTask cancel];
}

- (void)startImageLoad {
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
  
  NSURL *URL = [NSURL URLWithString:self.remotePath];
  NSURLRequest *request = [NSURLRequest requestWithURL:URL];
  
  NSProgress *imageDownloadProgress = nil;
  
  self.imageDownloadTask = [manager downloadTaskWithRequest:request
                                                                        progress:&imageDownloadProgress
                                                                     destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                                                                       return [self filePathForImageFile];
                                                                     }
                                                               completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                                                                 if (error) {
                                                                   NSLog(@"Error: %@", error);
                                                                   [self changeStatus:@"Error occurred while downloading image"];
                                                                 } else {
                                                                   NSLog(@"File downloaded to: %@", filePath);
                                                                   [self changeStatus:@"Image Downloaded"];
                                                                   self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:filePath]];
                                                                   [self changeStatus:@"Image Shown on UI"];
                                                                 }
                                                                 [imageDownloadProgress removeObserver:self forKeyPath:@"fractionCompleted"];

                                                               }];
  [imageDownloadProgress addObserver:self
                          forKeyPath:@"fractionCompleted"
                             options:NSKeyValueObservingOptionNew
                             context:myContext];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadedImageSaveFailed:) name:AFURLSessionDownloadTaskDidFailToMoveFileNotification object:self.imageDownloadTask];
  [self.imageDownloadTask resume];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  if (context == myContext) {
    [self performSelectorOnMainThread:@selector(updateProgress:)
                           withObject:[NSString stringWithFormat:@"%@", [change valueForKeyPath:@"new"]]
                        waitUntilDone:NO];
  }
}

- (void)updateProgress:(NSString *)status {
  NSURL *filePath = [self filePathForImageFile];
  BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:[filePath absoluteString]];
  if (fileExists) {
    NSLog(@"image file exists");
  } else {
    NSLog(@"image file exists");
  }
  self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:filePath]];
  [self changeStatus:status];
}

- (void)changeStatus:(NSString *)status {
  //NSLog(@"Changing status to %@", status);
  self.statusLabel.text = status;
}

- (void)deleteCurrentFileWithURL:(NSURL *)URL {
  NSError *fileManagerError = nil;
  [[NSFileManager defaultManager] removeItemAtURL:URL error:&fileManagerError];
  if (fileManagerError) {
    NSLog(@"Error while deleting file at URL: %@.", URL);
    NSLog(@"Error: %@.", fileManagerError);
  } else {
    NSLog(@"File at URL: %@ deleted successfully.", URL);
  }
}

- (NSURL *)filePathForImageFile {
  NSURL *documentsDirectoryPath = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
  return [documentsDirectoryPath URLByAppendingPathComponent:@"progressiveImage.jpg"];
}

- (void)downloadedImageSaveFailed:(NSNotification *)notification {
  NSLog(@"Notification received!");
  NSDictionary *userInfo = notification.userInfo;
  NSLog(@"User Info in Notification: %@", userInfo);
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
