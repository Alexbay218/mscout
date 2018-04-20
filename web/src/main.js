console.log("Loaded");
var state = "notstarted";
var m = document.getElementById("main");
var f = document.getElementById("form");
var t = document.getElementById("top");

var hasStart = false;

var timeleft = 150;
var starttime = 0;

var currstatus = 0;
var cube = 1;
var currcubets = 0;
var climb = 0;
var currclimbts = 0;

var linets = [];

var exchangets = [];
var exchangeint = [];

var switchts = [];
var switchint = [];
var switchsf = [];

var scalets = [];
var scaleint = [];
var scalesf = [];

var opswitchts = [];
var opswitchint = [];
var opswitchsf = [];

var droppedts = [];
var droppedint = [];

var defts = [];

var climbts = [];
var climbint = [];

var log = [];
var logDisplay = "";

var savefunc = function(filename, data) {
    var blob = new Blob([data], {type: 'text/csv'});
    if(window.navigator.msSaveOrOpenBlob) {
        window.navigator.msSaveBlob(blob, filename);
    }
    else{
        var elem = window.document.createElement('a');
        elem.href = window.URL.createObjectURL(blob);
        elem.download = filename;        
        document.body.appendChild(elem);
        elem.click();        
        document.body.removeChild(elem);
    }
};

var resetfunc = function() {
	t.textContent = "Start";
	state = "notstarted";
	m.style.display = "none";
	f.style.display = "block";
	timeleft = 150;
	starttime = 0;
	currstatus = 0;
	cube = 1;
	currcubets = 0;
	climb = 0;
	currclimbts = 0;
	linets = [];
	exchangets = [];
	exchangeint = [];
	exchangesf = [];
	switchts = [];
	switchint = [];
	switchsf = [];
	scalets = [];
	scaleint = [];
	scalesf = [];
	opswitchts = [];
	opswitchint = [];
	opswitchsf = [];
	droppedts = [];
	droppedint = [];
	defts = [];
	climbts = [];
	climbint = [];
	log = [];
	logDisplay = "";
};

t.onclick = function() {
	if(state === "notstarted") {
		t.textContent = "Reset";
		state = "started"
		f.style.display = "none";
		m.style.display = "inline-block";
		starttime = Date.now();
		if(hasStart == false) {
			window.setInterval(function() {
				timeleft = (150 - (Date.now() - starttime)/1000).toFixed(2);
				if(cube == 1) {
					document.getElementById("timeleft").innerHTML = "<div style=\"float:left;\">Seconds Left: " + timeleft + "</div><div align=\"right\">Has Cube</div>";
				}
				else {
					document.getElementById("timeleft").textContent = "Seconds Left: " + timeleft;
				}
				if(timeleft < -10) {
					var datastr = "LineTS,ExchangeTS,ExchangeInt,SwitchTS,SwitchInt,SwitchSF,ScaleTS,ScaleInt,ScaleSF,OpSwitchTS,OpSwitchInt,OpSwitchSF,DroppedTS,DroppedInt,DefTS,ClimbTS,ClimbInt\n";
					var i = 0;
					while(i <= linets.length || i <= exchangets.length || i <= switchts.length || i <= scalets.length || i <= opswitchts.length || i <= droppedts.length || i <= climbts.length || i <= climbint.length) {
						if(i < linets.length) {
							datastr += linets[i]
						}
						if(i < exchangets.length) {
							datastr +=  "," + exchangets[i] + "," + exchangeint[i]
						} else {
							datastr +=  ",,"
						}
						if(i < switchts.length) {
							datastr +=  "," + switchts[i] + "," + switchint[i] + "," + switchsf[i]
						} else {
							datastr +=  ",,,"
						}
						if(i < scalets.length) {
							datastr +=  "," + scalets[i] + "," + scaleint[i] + "," + scalesf[i]
						} else {
							datastr +=  ",,,"
						}
						if(i < opswitchts.length) {
							datastr +=  "," + opswitchts[i] + "," + opswitchint[i] + "," + opswitchsf[i]
						} else {
							datastr +=  ",,,"
						}
						if(i < droppedts.length) {
							datastr +=  "," + droppedts[i] + "," + droppedint[i]
						} else {
							datastr +=  ",,"
						}
						if(i < defts.length) {
							datastr +=  "," + defts[i]
						} else {
							datastr +=  ","
						}
						if(i < climbts.length) {
							datastr +=  "," + climbts[i] + "," + climbint[i]
						} else {
							datastr +=  ",,"
						}
						datastr +=  "\n";
						i++;
					}
					if(starttime != 0) {
						savefunc(document.getElementById("teamnumber").value + "_" + document.getElementById("weeknumber").value + "_" + document.getElementById("matchtype").value + document.getElementById("matchnumber").value + ".csv",datastr);
					}
					datastr = "";
					resetfunc();
				}
			}, 10);
			window.setInterval(function() {
				if(log.length > 0) {
					logDisplay = "<b>" + log[log.length - 1] + "</b><br>";
				}
				else {
					logDisplay = "";
				}
				for(var i = log.length - 2;i >= 0;i--) {
					logDisplay += log[i] + "<br>";
				}
				document.getElementById("log").innerHTML = logDisplay;
			}, 500);
			hasStart = true;
		}
		document.getElementById("line").onclick = function() {
			linets.push((150 - timeleft).toFixed(2));
			log.push((150 - timeleft).toFixed(2) + " Auto Line Crossed");
		}
		document.getElementById("def").onclick = function() {
			defts.push((150 - timeleft).toFixed(2));	
			log.push((150 - timeleft).toFixed(2) + " Defense Played");
		}
		document.getElementById("cube").onclick = function() {
			if(cube == 1) {
				cube = 0;
				droppedts.push((150 - timeleft).toFixed(2));
				droppedint.push(((150 - timeleft).toFixed(2)) - currcubets);
				document.getElementById("cube").textContent = "Grabbed Cube";
				log.push((150 - timeleft).toFixed(2) + " Dropped Cube");
			}
			else {
				cube = 1;
				currcubets = (150 - timeleft).toFixed(2);
				document.getElementById("cube").textContent = "Dropped Cube";
				log.push((150 - timeleft).toFixed(2) + " Grabbed Cube");
			}
		}
		document.getElementById("exchange").onclick = function() {
			if(cube == 1) {
				cube = 0;
				exchangets.push((150 - timeleft).toFixed(2));
				exchangeint.push(((150 - timeleft).toFixed(2)) - currcubets);
				document.getElementById("cube").textContent = "Grabbed Cube";
				log.push((150 - timeleft).toFixed(2) + " Placed in Exchange");
			}
		}
		document.getElementById("switchS").onclick = function() {
			if(cube == 1) {
				cube = 0;
				switchts.push((150 - timeleft).toFixed(2));
				switchint.push(((150 - timeleft).toFixed(2)) - currcubets);
				switchsf.push(1);
				document.getElementById("cube").textContent = "Grabbed Cube";
				log.push((150 - timeleft).toFixed(2) + " Placed in Switch");
			}
		}
		document.getElementById("switchF").onclick = function() {
			if(cube == 1) {
				cube = 0;
				switchts.push((150 - timeleft).toFixed(2));
				switchint.push(((150 - timeleft).toFixed(2)) - currcubets);
				switchsf.push(0);
				document.getElementById("cube").textContent = "Grabbed Cube";
				log.push((150 - timeleft).toFixed(2) + " Failed Switch");
			}
		}
		document.getElementById("scaleS").onclick = function() {
			if(cube == 1) {
				cube = 0;
				scalets.push((150 - timeleft).toFixed(2));
				scaleint.push(((150 - timeleft).toFixed(2)) - currcubets);
				scalesf.push(1);
				document.getElementById("cube").textContent = "Grabbed Cube";
				log.push((150 - timeleft).toFixed(2) + " Placed in Scale");
			}
		}
		document.getElementById("scaleF").onclick = function() {
			if(cube == 1) {
				cube = 0;
				scalets.push((150 - timeleft).toFixed(2));
				scaleint.push(((150 - timeleft).toFixed(2)) - currcubets);
				scalesf.push(0);
				document.getElementById("cube").textContent = "Grabbed Cube";
				log.push((150 - timeleft).toFixed(2) + " Failed Scale");
			}
		}
		document.getElementById("opswitchS").onclick = function() {
			if(cube == 1) {
				cube = 0;
				opswitchts.push((150 - timeleft).toFixed(2));
				opswitchint.push(((150 - timeleft).toFixed(2)) - currcubets);
				opswitchsf.push(1);
				document.getElementById("cube").textContent = "Grabbed Cube";
				log.push((150 - timeleft).toFixed(2) + " Placed in Opponent Switch");
			}
		}
		document.getElementById("opswitchF").onclick = function() {
			if(cube == 1) {
				cube = 0;
				opswitchts.push((150 - timeleft).toFixed(2));
				opswitchint.push(((150 - timeleft).toFixed(2)) - currcubets);
				opswitchsf.push(0);
				document.getElementById("cube").textContent = "Grabbed Cube";
				log.push((150 - timeleft).toFixed(2) + " Failed Opponent Switch");
			}
		}
		document.getElementById("climb").onclick = function() {
			if(climb == 1) {
				climb = 0;
				climbts.push((150 - timeleft).toFixed(2));
				climbint.push(((150 - timeleft).toFixed(2)) - currclimbts);
				document.getElementById("climb").textContent = "Climb Attempt";
				log.push((150 - timeleft).toFixed(2) + " Climb Complete");
			}
			else {
				climb = 1;
				currclimbts = (150 - timeleft).toFixed(2);
				document.getElementById("climb").textContent = "Climb Complete";
				log.push((150 - timeleft).toFixed(2) + " Climb Attempted");
			}
		}
	}
	else {
		resetfunc();
	}
}


