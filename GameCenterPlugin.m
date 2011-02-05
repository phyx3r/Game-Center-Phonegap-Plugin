//
//  GameCenterPlugin.m
//  Detonate
//
//  Created by Marco Piccardo on 04/02/11.
//  Copyright 2011 Eurotraining Engineering. All rights reserved.
//

#import "GameCenterPlugin.h"
#import "PhoneGapViewController.h"

@implementation GameCenterPlugin

- (void)authenticateLocalPlayer:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
		if (error == nil)
		{
			NSString* jsCallback = [NSString stringWithFormat:@"GameCenter._userDidLogin();",@""];
			[webView stringByEvaluatingJavaScriptFromString:jsCallback];
		}
		else
		{
			NSString* jsCallback = [NSString stringWithFormat:@"GameCenter._userDidFailLogin();",@""];
			[webView stringByEvaluatingJavaScriptFromString:jsCallback];
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
			[webView stringByEvaluatingJavaScriptFromString:jsCallback];
		} else {
			NSString* jsCallback = [NSString stringWithFormat:@"GameCenter._userDidFailSubmitScore();",@""];
			[webView stringByEvaluatingJavaScriptFromString:jsCallback];			
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
		PhoneGapViewController* cont = (PhoneGapViewController*)[super appViewController];
        [cont presentModalViewController: leaderboardController animated: YES];
    }
}

- (void)showAchievements:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
    if (achievements != nil)
    {
        achievements.achievementDelegate = self;
        PhoneGapViewController* cont = (PhoneGapViewController*)[super appViewController];
		[cont presentModalViewController: achievements animated: YES];
    }
    [achievements release];
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	PhoneGapViewController* cont = (PhoneGapViewController*)[super appViewController];
    [cont dismissModalViewControllerAnimated:YES];
}

- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	PhoneGapViewController* cont = (PhoneGapViewController*)[super appViewController];
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
