var c = document.getElementById("main");
c.width = Math.floor(document.body.scrollWidth);
c.height = Math.floor(document.body.scrollHeight);
var ctx = c.getContext("2d");
var originx = c.width/2;
var originy = c.height/2;

var mousex = 0;
var mousey = 0;

var timeleft = 150;
var starttimeint = 0;

var currstatus = 0;

var clickfunc = function (e) {
	if(starttimeint == 0) {
		starttimeint = Date.now();
	}
	else {
		
	}
}

window.addEventListener('touchend', function (e) {
    mousex = e.touches[0].screenX;
    mousey = e.touches[0].screenY;
	clickfunc();
});

