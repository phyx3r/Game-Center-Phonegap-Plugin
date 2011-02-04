function GameCenter() {
	if(localStorage.getItem('GameCenterLoggedin')) {
		PhoneGap.exec("GameCenterPlugin.authenticateLocalPlayer");
	}
}

GameCenter.prototype.authenticate = function() {
    PhoneGap.exec("GameCenterPlugin.authenticateLocalPlayer");
};

GameCenter._userDidLogin = function() {
	localStorage.setItem('GameCenterLoggedin', 'true');
};

PhoneGap.addConstructor(function() 
{
  if(!window.plugins)
  {
    window.plugins = {};
  }
    window.plugins.gamecenter = new GameCenter();
});