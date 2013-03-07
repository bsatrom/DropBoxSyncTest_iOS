//
//  ViewController.h
//  DropboxSyncSample
//
//  Created by Brandon Satrom on 3/7/13.
//  Copyright (c) 2013 CarrotPants. All rights reserved.
//

#import <Dropbox/Dropbox.h>
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (id)initWithFilesystem:(DBFilesystem *)filesystem root:(DBPath *)root;
- (IBAction)pressButton:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *msgLabel;

@end
