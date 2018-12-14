#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofSetBackgroundColor(0);
    ofSetCircleResolution(100);
    
    ofNoFill();
    ofSetColor(255,0,0);
    ofSetLineWidth(3);
    
    startTime = ofGetElapsedTimeMillis();
    
    //sound sources
    fastSwipeA.load("fastSwipeA.mp3");
    fastSwipeB.load("fastSwipeB.mp3");
    pinchInA.load("pinchInA.mp3");
    pinchInB.load("pinchInB.mp3");
    pinchOutA.load("pinchOutA.mp3");
    pinchOutB.load("pinchOutB.mp3");
    slowSwipeA.load("slowSwipeA.mp3");
    slowSwipeB.load("slowSwipeB.mp3");
    tapA.load("tapA.mp3");
    tapB.load("tapB.mp3");
    tiltA.load("tiltA.mp3");
    tiltB.load("tiltB.mp3");
    touchDownA.load("touchDownA.mp3");
    touchDownB.load("touchDownB.mp3");
    hello.load("hello.mp3");
    
    //ofSetOrientation(OF_ORIENTATION_90_LEFT);
    
    //tilting
    myCoreMotion.setupAccelerometer();
    myAngle.set(0,0,0);
    
    //touch lower part
    touchLowerArea.set(0, 1071, 750, 263);
    touchUpperArea.set(0, 0, 750, 1071);
    
    //mode change
    mode = 0;
    cout << "mode: "<< mode << endl;
    
    //text
    myFont.load("AppleSDGothicNeo.ttc", 30);
    frindlyMode = "Hello, My Friend";
    sneakyMode = "Shhh... This Is About My Friend";
    myWidthFrindly = myFont.stringWidth(frindlyMode);
    myWidthSneaky = myFont.stringWidth(sneakyMode);
    centerX = ofGetWidth()/2;
    centerY = ofGetHeight()/2;
    
    //bool
    pinch = false;
    
    //total touch
    totalTouch = 0;
}
//--------------------------------------------------------------
void ofApp::update(){
    //tiliting
    myCoreMotion.update();
    ofVec3f myAccel = myCoreMotion.getAccelerometerData();
    
    //    cout << "myAccel.x" << myAccel.x << endl;
    //    cout << "myAccel.y" << myAccel.y << endl;
    //-------------------------------
    
    modeChange = mode % 2;
    
    //tilting
    if(myAccel.x > 0.9 || myAccel.x < -0.9 )
    {
        if(modeChange == 0)
        {
            tiltA.play();
        }
        
        else
        {
            tiltB.play();
        }
        //cout << "tilt" << endl;
    }
    
}

//--------------------------------------------------------------
void ofApp::draw(){
    timer = ofGetElapsedTimeMillis() - startTime;
    
    //    if(_)
    //    {
    for(int i=0; i<NUM_TOUCH; i++)
    {
        //        ofDrawCircle(touchPoints[i], 50);
    }
    //    }
    
    ofPushMatrix();
    ofSetColor(255);
    ofTranslate(centerX, centerY);
    if(modeChange == 0)
    {
        myFont.drawString(frindlyMode, 0-myWidthFrindly/2, 0);
    }
    else
    {
        myFont.drawString(sneakyMode, 0-myWidthSneaky/2, 0);
    }
    ofPopMatrix();
    
    //    if(ofGetElapsedTimeMillis()-totalTouchZeroTime>300)
    //    {
    //        pinch = false;
    //    }
    
    //    cout << "ofGetElapsedTimeMillis(): " <<ofGetElapsedTimeMillis() <<endl;
    //    cout << "totalTouchZeroTime: " <<totalTouchZeroTime <<endl;
    //
    //    cout << "pinch: " << pinch << endl;
}

//--------------------------------------------------------------
void ofApp::exit(){
    
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    touchDownTime = timer;
    //    cout << "touchDownTime: " << touchDownTime <<endl;
    
    //swipe
    for(int i=0; i<NUM_TOUCH; i++)
    {
        if(touch.id == 0)
        {
            myTouchDown[0].set(touch.x, touch.y);
            pinch = false;
        }
        
        if(touch.id == 1)
        {
            myTouchDown[1].set(touch.x, touch.y);
            pointDistanceTouchDown = myTouchDown[1].distance(myTouchDown[0]);
            pinch = true;
        }
        
        //cout << "pointDistanceTouchDown: " <<pointDistanceTouchDown <<endl;
    }
    
    touchDownNum = touch.id + 1;
    cout << "touchDownNum: " <<touchDownNum <<endl;
    
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    //pinching
    for(int i=0; i<NUM_TOUCH; i++)
    {
        if(touch.id == 0)
        {
            touchPoints[0].set(touch.x, touch.y);
        }
        
        if(touch.id == 1)
        {
            touchPoints[1].set(touch.x, touch.y);
        }
    }
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    touchUpTime = timer;
    timeDifference = touchUpTime - touchDownTime;
    //    cout << "touchUpTime: " << touchUpTime <<endl;
    cout << "timeDifference: " << timeDifference <<endl;
    
    for(int i=0; i<NUM_TOUCH; i++)
    {
        //myTouchUp[i] = touch;
        
        if(touch.id == 0)
        {
            myTouchUp[0].set(touch.x, touch.y);
        }
        
        if(touch.id == 1)
        {
            pinch = true;
            
            myTouchUp[1].set(touch.x, touch.y);
            pointDistanceTouchUp = myTouchUp[1].distance(myTouchUp[0]);
            
            //pinch in
            if(pointDistanceTouchUp<350 && pointDistanceTouchUp>0)
            {
                if(modeChange == 0)
                {
                    pinchInA.play();
                }
                
                else
                {
                    pinchInB.play();
                }
                cout << "pinch in" << endl;
            }
            //pinch out
            else if(pointDistanceTouchUp>350)
            {
                if(modeChange == 0)
                {
                    pinchOutA.play();
                }
                
                else
                {
                    pinchOutB.play();
                }
                cout << "pinch out" << endl;
            }
        }
        
        //        pointDifferenceTouchUp = myTouchUp[1] - myTouchUp[0];
        //        pointDistanceTouchUp = pointDifferenceTouchUp.length();
        
        //cout << "pointDistanceTouchUp" <<pointDistanceTouchUp <<endl;
    }
    
    //-------------------------------
    //long touch
    if(timeDifference> 1500 /*&& pointDistance<=20*/)
    {
        cout<<"mode change"<<endl;
        mode ++;
        
        if(modeChange == 1)
        {
            hello.play();
        }
    }
    
    //-------------------------------
    if(!(touch.id == 1) && pinch == false)
    {
        //tap
        if(timeDifference<80 && timeDifference>0)
        {
            if(touchUpperArea.inside(touch))
            {
                if(modeChange == 0)
                {
                    tapA.play();
                }
                
                else
                {
                    tapB.play();
                    
                }
                cout<< "tap" << endl;
            }
        }
        else if(timeDifference>80 && timeDifference<500)
        {
            if(pointDistance>20)
            {
                if(modeChange == 0)
                {
                    fastSwipeA.play();
                }
                
                else{
                    fastSwipeB.play();
                    
                }
                
                timeDifference = 0;
            }
        }
        else if(timeDifference>500 && timeDifference<1500)
        {
            if(modeChange == 0)
            {
                slowSwipeA.play();
            }
            
            else
            {
                slowSwipeB.play();
                
            }
            timeDifference = 0;
        }
    }
    
    //touch lower part
    if(touchLowerArea.inside(touch) && pointDistance < 20)
    {
        if(modeChange == 0)
        {
            touchDownA.play();
        }
        
        else
        {
            touchDownB.play();
            
        }
        //cout << "touch lower part" << endl;
    }
    
    //distance
    pointDistance= myTouchUp[0].distance(myTouchDown[0]);
    //200,570,1100
    
    //cout << "pointDistance: " << pointDistance <<endl;
    
    touchUpNum = touch.id + 1;
    //    cout << "touchUpNum: " << touchUpNum <<endl;
    
    
    totalTouch = touchUpNum - touchDownNum;
    cout << "totalTouch: " << totalTouch << endl;
    
    //    if(totalTouch <= 0)
    //    {
    //        totalTouchZeroTime = ofGetElapsedTimeMillis();
    //    }
}
//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){
    
}
