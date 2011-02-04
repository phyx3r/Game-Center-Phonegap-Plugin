//
//  GameCenterPlugin.m
//  Detonate
//
//  Created by Marco Piccardo on 04/02/11.
//  Copyright 2011 Eurotraining Engineering. All rights reserved.
//

#import "GameCenterPlugin.h"

@implementation GameCenterPlugin
- (void) authenticateLocalPlayer:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
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
@end
