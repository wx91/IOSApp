//
//  AppDelegate.m
//  MyLocation
//
//  Created by wangx on 15/5/2.
//  Copyright (c) 2015年 wxiang1991. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "CurrentLocationViewController.h"
@interface AppDelegate ()<UIAlertViewDelegate>
@property(nonatomic,strong)NSManagedObjectContext *managerObjectContext;
@property(nonatomic,strong)NSManagedObjectModel *managedObjectModel;
@property(nonatomic,strong)NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation AppDelegate
NSString *const ManagedObjectContextSaveDidFailNotification = @"ManagedObjectContextSaveDidFailNotification";
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UITabBarController *tabBarController=(UITabBarController *)self.window.rootViewController;
    CurrentLocationViewController *currentLocationViewController=(CurrentLocationViewController*)tabBarController.viewControllers[0];
    currentLocationViewController.managedObjectContext=self.managerObjectContext;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fatalCoreDataError) name:ManagedObjectContextSaveDidFailNotification object:nil];
    return YES;
}
-(void)fatalCoreDataError:(NSNotificationCenter *)notification{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Internal Error", nil) message:NSLocalizedString(@"There was a fatal error in the app and it cannot contine.\n\n Press OK to terminate the app. Sorry for the inconvenience", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil, nil];
    [alertView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    abort();
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma  mark -Core Data
-(NSManagedObjectModel *)managedObjectModel{
    if (_managedObjectModel==nil) {
        NSString *modelPath=[[NSBundle mainBundle]pathForResource:@"DataModel" ofType:@"momd"];
        NSURL *modelURL=[NSURL fileURLWithPath:modelPath];
        _managedObjectModel=[[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

-(NSString *)documentDirectory{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[paths lastObject];
    return documentDirectory;
}
-(NSString *)dataStorePath{
    return [[self documentDirectory]stringByAppendingPathComponent:@"DataStore.sqlite"];
}
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (_persistentStoreCoordinator==nil) {
        NSURL *storeURL=[NSURL fileURLWithPath:[self dataStorePath]];
        _persistentStoreCoordinator=[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.managedObjectModel];
        NSError *error;
        if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
            NSLog(@"Error adding persistent store %@,%@",error,[error userInfo]);
            abort();
        }
    }
    return _persistentStoreCoordinator;
}
-(NSManagedObjectContext *)managerObjectContext{
    if (_managedObjectModel==nil) {
        NSPersistentStoreCoordinator *coordinator=self.persistentStoreCoordinator;
        if (coordinator!=nil) {
            _managerObjectContext=[[NSManagedObjectContext alloc]init];
            [_managerObjectContext setPersistentStoreCoordinator:coordinator];
        }
    }
    return _managerObjectContext;
}

@end
