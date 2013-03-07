//
//  ViewController.m
//  DropboxSyncSample
//
//  Created by Brandon Satrom on 3/7/13.
//  Copyright (c) 2013 CarrotPants. All rights reserved.
//

#import "ViewController.h"
#import <Dropbox/Dropbox.h>

@interface ViewController ()
    @property (nonatomic, retain) DBFilesystem *filesystem;
    @property (nonatomic, retain) DBPath *root;
    @property (nonatomic, retain) DBPath *fromPath;
@end

@implementation ViewController

- (id)initWithFilesystem:(DBFilesystem *)filesystem root:(DBPath *)root {
	if ((self = [super init])) {
		self.filesystem = filesystem;
		self.root = root;
		self.navigationItem.title = [root isEqual:[DBPath root]] ? @"Dropbox" : [root name];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressButton:(id)sender {
    [[DBAccountManager sharedManager] linkFromController:self];
}
@end
