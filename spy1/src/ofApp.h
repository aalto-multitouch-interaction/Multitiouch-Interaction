#pragma once

#include "ofxiOS.h"
#include "ofxiOSCoreMotion.h"
#include "circle.h"
#import <AVFoundation/AVFoundation.h>
#define NUM_TOUCH 2

class ofApp : public ofxiOSApp {
    
public:
    void setup();
    void update();
    void draw();
    void exit();
    
    void touchDown(ofTouchEventArgs & touch);
    void touchMoved(ofTouchEventArgs & touch);
    void touchUp(ofTouchEventArgs & touch);
    void touchDoubleTap(ofTouchEventArgs & touch);
    void touchCancelled(ofTouchEventArgs & touch);
    void lostFocus();
    void gotFocus();
    void gotMemoryWarning();
    void deviceOrientationChanged(int newOrientation);
    
    ofSoundPlayer fastSwipeA, fastSwipeB, pinchInA, pinchInB, pinchOutA, pinchOutB, slowSwipeA, slowSwipeB, tapA, tapB, tiltA, tiltB, touchDownA, touchDownB, hello;
    
    int mode, modeChange;
    
    ofVec2f touchPoints [NUM_TOUCH];
    ofVec2f myTouchDown [NUM_TOUCH];
    ofVec2f myTouchUp [NUM_TOUCH];
    
    float pointDistance, pointDistanceTouchUp, pointDistanceTouchDown;
    
    ofVec2f pointDifference, pointDifferenceTouchDown, pointDifferenceTouchUp, myTouchDifference;
    
    //circle class
    vector <circle> myCircle;
    
    //bool
    bool pinch;
    
    //total touch
    int totalTouch;
    int touchDownNum;
    int touchUpNum;
    
    //pinching
    float pinchRadius;
    
    //tiliting
    ofxiOSCoreMotion myCoreMotion;
    ofVec3f myAngle;
    
    //touch lower part
    ofRectangle touchLowerArea;
    ofRectangle touchUpperArea;
    
    //font
    ofTrueTypeFont myFont;
    string frindlyMode;
    string sneakyMode;
    float centerX;
    float centerY;
    float myWidthFrindly;
    float myWidthSneaky;
    float myHeightFrindly;
    float myHeightSneaky;
    
    //time
    float startTime, timer, touchDownTime, touchUpTime, timeDifference;
    
    float totalTouchZeroTime;
};


