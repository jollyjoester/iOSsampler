//
//  GameCenterViewController.m
//  AppleServiceTest
//
//  Created by jollyjoester_pro on 2014/03/19.
//  Copyright (c) 2014年 jollyjoester. All rights reserved.
//

#import "GameCenterViewController.h"

@interface GameCenterViewController ()

@end

@implementation GameCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //GameCenter認証
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    [localPlayer authenticateWithCompletionHandler:^(NSError *error){
        if (localPlayer.authenticated) {
            
            NSLog(@"localPlayer authenticated");
            
        }else{
            
            NSLog(@"not localPlayer authenticated");
            
        }
    }];
}

- (IBAction)pushedShowGameCenter:(id)sender
{
    
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    if(localPlayer.authenticated){
        
        GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
        
        leaderboardController.timeScope = GKLeaderboardTimeScopeAllTime;
        leaderboardController.leaderboardDelegate = self;
        
        [self presentViewController:leaderboardController animated:YES completion:nil];
    }else{
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Please login to GameCenter" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertView show];
    }
}

- (IBAction)pushedSendScoreToLeaderboard:(id)sender
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    if(localPlayer.authenticated){
        
        NSString *leaderboardID = @"leaderboardtest20140319";
        
        GKScore *gkScore = [[GKScore alloc] initWithCategory:leaderboardID];
        
        NSInteger score = 100;
        
        gkScore.value = score;
        gkScore.context = 0;
        
        [gkScore reportScoreWithCompletionHandler:^(NSError *error){
            if(error){
                NSLog(@"Leaderboard Error:%@", error);
            }else{
                NSLog(@"Sent score to leaderboard:%lld", gkScore.value);
            }
        }];
        
    }else{
        
        NSLog(@"not localPlayer authenticated");
        
    }
}

- (IBAction)pushedSendScoreAchievement:(id)sender
{
    NSString *achievementID = @"acievementtest20130319";
    
    GKAchievement *achievement = [[GKAchievement alloc] initWithIdentifier:achievementID];
    
    if(achievement){
        
        float percent = 100;
        
        achievement.percentComplete = percent;
        
        [achievement reportAchievementWithCompletionHandler:^(NSError *error){
            if(error){
                NSLog(@"Achievement Error:%@", error);
            }else{
                NSLog(@"Sent score to achievement %f", achievement.percentComplete);
            }
        }];
    }
}


- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
