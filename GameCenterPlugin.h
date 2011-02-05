//
//  GameCenterPlugin.h
//  Detonate
//
//  Created by Marco Piccardo on 04/02/11.
//  Copyright 2011 Eurotraining Engineering. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "PhoneGapCommand.h"

@interface GameCenterPlugin : PhoneGapCommand <GKLeaderboardViewControllerDelegate,GKAchievementViewControllerDelegate> {

}

- (void)authenticateLocalPlayer:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
- (void)reportScore:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
- (void)showLeaderboard:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
- (void)showAchievements:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
- (void)reportAchievementIdentifier:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

@end
