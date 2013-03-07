//
//  AppDelegate.m
//  DropboxSyncSample
//
//  Created by Brandon Satrom on 3/7/13.
//  Copyright (c) 2013 CarrotPants. All rights reserved.
//

#import "AppDelegate.h"
#import <Dropbox/Dropbox.h>
#import "ViewController.h"

@interface AppDelegate ()

@property (nonatomic, retain) UINavigationController *rootController;
@property (nonatomic, retain) ViewController *viewController;
@property (nonatomic, retain) DBAccount *account;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // The account manager stores account info. Create this when your app launches
    DBAccountManager* accountMgr = [[DBAccountManager alloc] initWithAppKey:@"rxy1r66fwi74xjj" secret:@"fb8nvrw2pzend0e"];
    [DBAccountManager setSharedManager:accountMgr];
    _account = accountMgr.linkedAccount;
    
    if (_account) {
        DBFilesystem *filesystem = [[DBFilesystem alloc] initWithAccount:_account];
        [DBFilesystem setSharedFilesystem:filesystem];
    }
    
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    DBAccount *account = [[DBAccountManager sharedManager] handleOpenURL:url];
    if (account) {
        DBFilesystem *filesystem = [[DBFilesystem alloc] initWithAccount:account];
        ViewController *viewController = [[ViewController alloc] initWithFilesystem:filesystem                                                root:[DBPath root]];
        
        [DBFilesystem setSharedFilesystem:filesystem];
        
        UIAlertView *mainAlert = [[UIAlertView alloc] initWithTitle:@"Dropbox Linked!" message:@"Congrats! Don't you feel special?" delegate:nil cancelButtonTitle:@"Yes" otherButtonTitles:@"No", @"Actually, I Feel Cheated...", nil];
        [mainAlert show];
    }
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DBFilesystem *filesystem = [[DBFilesystem alloc] initWithAccount:_account];
    DBPath *newPath = [[DBPath root] childPath:@"telerik.txt"];    
    DBFile *file = [filesystem createFile:newPath error:nil];
    [file writeString:@"DROPBOX, I AM IN YOU!" error:nil];
    
    NSMutableString *filesList = [[NSMutableString alloc] initWithString:@"Looking at your app files... "];
    NSArray *contents = [[DBFilesystem sharedFilesystem] listFolder:[DBPath root] error:nil];
    
    [filesList appendFormat:@"We found %i files created by this app. Check them in Dropbox for a special message", contents.count];
    
    _viewController.msgLabel.text = filesList;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    _viewController = [[ViewController alloc] init];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
