function GameCenter() {
	if(localStorage.getItem('GameCenterLoggedin')) {
		PhoneGap.exec("GameCenterPlugin.authenticateLocalPlayer");
	}
}

GameCenter.prototype.authenticate = function() {
    PhoneGap.exec("GameCenterPlugin.authenticateLocalPlayer");
};

GameCenter.prototype.showLeaderboard = function(category) {
    PhoneGap.exec("GameCenterPlugin.showLeaderboard",category);	
};

GameCenter.prototype.reportScore = function(category,score) {
    PhoneGap.exec("GameCenterPlugin.reportScore",category,score);		
};

GameCenter.prototype.showAchievements = function() {
    PhoneGap.exec("GameCenterPlugin.showAchievements");			
};

GameCenter.prototype.getAchievement = function(category) {
	PhoneGap.exec("GameCenterPlugin.reportAchievementIdentifier",category,100);
};

GameCenter._userDidLogin = function() {
	localStorage.setItem('GameCenterLoggedin', 'true');
};

GameCenter._userDidSubmitScore = function() {
	alert('score submitted');
};

GameCenter._userDidFailSubmitScore = function() {
	alert('score error');
};

PhoneGap.addConstructor(function() 
{
  if(!window.plugins)
  {
    window.plugins = {};
  }
    window.plugins.gamecenter = new GameCenter();
});