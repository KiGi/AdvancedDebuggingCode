// More example details of manipulation on Apple's Automation documentation page:
// http://developer.apple.com/library/mac/#documentation/DeveloperTools/Conceptual/InstrumentsUserGuide/Built-InInstruments/Built-InInstruments.html%23//apple_ref/doc/uid/TP40004652-CH6-SW1

function visitFontPage()
{ 

var target = UIATarget.localTarget();
var appWindow = target.frontMostApp().mainWindow();

UIALogger.logStart("Visiting Font page");
appWindow.navigationBar().buttons()["Change Font"].tap();

// Slow drag down and then flick
UIALogger.logMessage("Scrolling down");
target.dragFromToForDuration({x:160, y:400}, {x:160, y:100}, 1);
target.dragFromToForDuration({x:160, y:400}, {x:160, y:100}, 1);
target.flickFromTo({x:160, y:400}, {x:160, y:200});

// Sneaky delay!!  It really drags nothing but just gives 2 seconds for Flick to complete
target.dragFromToForDuration({x:150, y:20}, {x:150, y:20}, 2);

UIALogger.logMessage("Scrolling back up");

// Flick back to top of table.
//target.flickFromTo({x:160, y:200}, {x:160, y:400});

// Sneaky delay!!  It really drags nothing but just gives 2 seconds for Flick to complete
target.dragFromToForDuration({x:150, y:20}, {x:150, y:20}, 2);

// Alternate scrolling, taps on status bar to go all the way to top
target.dragFromToForDuration({x:160, y:10}, {x:160, y:10}, 2);

UIALogger.logMessage("Leaving Font Page");

// Go back to main font screen
appWindow.navigationBar().buttons()["Cancel"].tap();
// Lazy alternate way to go back, just tap on screen about where Cancel button is
//target.dragFromToForDuration({x:10, y:10}, {x:10, y:10}, 1);

// Ends log tree
UIALogger.logPass();

}
