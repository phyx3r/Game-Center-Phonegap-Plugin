//
//  GameCenterPlugin.m
//  Detonate
//
//  Created by Marco Piccardo on 04/02/11.
//  Copyright 2011 Eurotraining Engineering. All rights reserved.
//

#import "GameCenterPlugin.h"
#ifdef CORDOVA_FRAMEWORK
#import <Cordova/CDVViewController.h>
#else
#import "CDVViewController.h"
#endif

@implementation GameCenterPlugin

- (void)authenticateLocalPlayer:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
		if (error == nil)
		{
			NSString* jsCallback = [NSString stringWithFormat:@"GameCenter._userDidLogin();",@""];
			[self.webView stringByEvaluatingJavaScriptFromString:jsCallback];
		}
		else
		{
			NSString* jsCallback = [NSString stringWithFormat:@"GameCenter._userDidFailLogin();",@""];
			[self.webView stringByEvaluatingJavaScriptFromString:jsCallback];
		}
	}];
}

- (void)reportScore:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
	
	NSString *category = (NSString*) [arguments objectAtIndex:0];
	int64_t score = [[arguments objectAtIndex:1] integerValue];
	
    GKScore *scoreReporter = [[[GKScore alloc] initWithCategory:category] autorelease];
    scoreReporter.value = score;
	
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
		if (error != nil)
		{
			NSString* jsCallback = [NSString stringWithFormat:@"GameCenter._userDidSubmitScore();",@""];
			[self.webView stringByEvaluatingJavaScriptFromString:jsCallback];
		} else {
			NSString* jsCallback = [NSString stringWithFormat:@"GameCenter._userDidFailSubmitScore();",@""];
			[self.webView stringByEvaluatingJavaScriptFromString:jsCallback];			
		}
    }];
}

- (void)showLeaderboard:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
    if (leaderboardController != nil)
    {
        leaderboardController.leaderboardDelegate = self;
		leaderboardController.category = (NSString*) [arguments objectAtIndex:0];
		CDVViewController* cont = (CDVViewController*)[super viewController];
        [cont presentModalViewController: leaderboardController animated: YES];
    }
}

- (void)showAchievements:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
    if (achievements != nil)
    {
        achievements.achievementDelegate = self;
        CDVViewController* cont = (CDVViewController*)[super viewController];
		[cont presentModalViewController: achievements animated: YES];
    }
    [achievements release];
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	CDVViewController* cont = (CDVViewController*)[super viewController];
    [cont dismissModalViewControllerAnimated:YES];
}

- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	CDVViewController* cont = (CDVViewController*)[super viewController];
    [cont dismissModalViewControllerAnimated:YES];
}

- (void)reportAchievementIdentifier:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
	NSString *identifier = (NSString*) [arguments objectAtIndex:0];
	float percent = [[arguments objectAtIndex:1] floatValue];
	
    GKAchievement *achievement = [[[GKAchievement alloc] initWithIdentifier: identifier] autorelease];
    if (achievement)
    {
		achievement.percentComplete = percent;
		[achievement reportAchievementWithCompletionHandler:^(NSError *error)
		 {
			 if (error != nil)
			 {
				 // Retain the achievement object and try again later (not shown).
			 }
		 }];
    }
}

@end
