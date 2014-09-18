//
//  JSAppDelegate.m
//  Ukuku
//
//  Created by JuanSe Jativa on 02/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSAppDelegate.h"
#import "JSLogInVC.h"


#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@implementation JSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self initializeParseFacebook];
    [self initializeParseTwitter];
    [self checkExistingUser];
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}

-(void)checkExistingUser {
    
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        [self userDidLogIn];
        
    } else if([PFUser currentUser] && [PFTwitterUtils isLinkedWithUser:[PFUser currentUser]]) {
    
        [self userDidLogIn];
    
    } else if([PFUser currentUser])
        [self userDidLogIn];
    
    else {
    
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController = [[JSLogInVC alloc] initWithNibName:@"JSLogInVC" bundle:nil];
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];

        
    
    }
}


-(void)initializeParseFacebook {
    
    [Parse setApplicationId:@"TEFUIU9H3Z86S5joqPe1W8HyTXWxTFwMOi3tJGuD" clientKey:@"aE3yTVv5xkclzlvqgj6aLHNTc1Bg1D9BN9LzGI81"];
    [PFFacebookUtils initializeFacebook];

}
-(void)initializeParseTwitter {
    
    [PFTwitterUtils initializeWithConsumerKey:@"3EIcERYFIFoj269MWaop71YTU"
                               consumerSecret:@"ZGTqsTlYNTAEaMH51Pq1BAMHB2a3RX729UyVKbEsBvcOVcyeHI"];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

-(void)userDidLogIn {
    
    [self userIsCientific];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *vc = [sb instantiateViewControllerWithIdentifier:@"start"];
    vc.tabBar.tintColor = [UIColor colorWithRed:0.31f green:0.89f blue:0.76f alpha:1];
    //vc.tabBar.alpha=0.5f;
    
    [[vc  tabBar] setBackgroundImage:[UIImage imageNamed:@"tabBarBackground.png"]];
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = vc;
    
    [self.window makeKeyAndVisible];
}

-(void)userDidLogOut {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[JSLogInVC alloc] initWithNibName:@"JSLogInVC" bundle:nil];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

-(void)userIsCientific {

    
    [[PFUser query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            
            PFObject *user = [objects lastObject];
            BOOL isCientific = [[user objectForKey:@"admin"] boolValue];
            [[NSUserDefaults standardUserDefaults] setBool:isCientific forKey:@"Cientific"];
        }
    }];

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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
