#pragma once

#include "ofxiOS.h"

class circle{
    
public:
    void setup(){
    }
    
    void draw(ofVec2f myPoint){
        ofPushMatrix();
        ofTranslate(circlePoint);
        ofNoFill();
        ofSetColor(255,0,0);
        ofSetLineWidth(3);
        ofDrawEllipse(0,0,50,50);
        ofPopMatrix();
    }
    
    ofVec2f circlePoint;
};


