// Script meant to press each of the buttons in the Image Explorer page

var target = UIATarget.localTarget();
var appWindow = target.frontMostApp().mainWindow();

UIALogger.logStart("Pressing Image Buttons");

appWindow.tabBar().buttons()["Image Explorer"].tap();
//  Or can do this
//appWindow.tabBar().buttons()[1].tap();

// Log the element tree
UIATarget.localTarget().logElementTree();

// Take a look at the output from the elemnt tree, then write code here to press each of the buttons in succession

UIALogger.logPass();