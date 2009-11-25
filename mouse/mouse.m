
/* This code was originally written by Costantino Pistagna <valvoline@gmail.com> */

#include <unistd.h> 
#import <Foundation/Foundation.h> 
#include <CoreFoundation/CoreFoundation.h> 
#include <ApplicationServices/ApplicationServices.h> 
 
typedef struct { 
float x; 
float y; 
}mtPoint; 

typedef struct { 
mtPoint position; 
mtPoint velocity; 
}mtReadout; 

typedef struct 
{ 
int frame; //the current frame 
double timestamp; //event timestamp 
int identifier; //identifier guaranteed unique for life of touch per device 
int state; //the current state (not sure what the values mean) 
int unknown1; //no idea what this does 
int unknown2; //no idea what this does either 
mtReadout normalized; //the normalized position and vector of the touch (0,0 to 1,1) 
float size; //the size of the touch (the area of your finger being tracked) 
int unknown3; //no idea what this does 
float angle; //the angle of the touch -| 
float majorAxis; //the major axis of the touch -|-- an ellipsoid. you can track the angle of each finger! 
float minorAxis; //the minor axis of the touch -| 
mtReadout unknown4; //not sure what this is for 
int unknown5[2]; //no clue 
float unknown6; //no clue 
}Touch; 

bool isDone = NO;

//a reference pointer for the multitouch device 
typedef void *MTDeviceRef; 

//the prototype for the callback function 
typedef int (*MTContactCallbackFunction)(int,Touch*,int,double,int); 

//returns a pointer to the default device (the trackpad?) 
MTDeviceRef MTDeviceCreateDefault(); 

//returns a CFMutableArrayRef array of all multitouch devices 
CFMutableArrayRef MTDeviceCreateList(void); 

//registers a device's frame callback to your callback function 
void MTRegisterContactFrameCallback(MTDeviceRef, MTContactCallbackFunction); 

//start sending events 
void MTDeviceStart(MTDeviceRef, int); 

//just output debug info. use it to see all the raw infos dumped to screen 
void printDebugInfos(int nFingers, Touch *data) { 
int i; 
for (i=0; i<nFingers; i++) { 
Touch *f = &data[i]; 
printf("Finger: %d, frame: %d, timestamp: %f, ID: %d, state: %d, PosX: %f, PosY: %f, VelX: %f, VelY: %f, Angle: %f, MajorAxis: %f, MinorAxis: %f\n", i, 
f->frame, 
f->timestamp, 
f->identifier, 
f->state, 
f->normalized.position.x, 
f->normalized.position.y, 
f->normalized.velocity.x, 
f->normalized.velocity.y, 
f->angle, 
f->majorAxis, 
f->minorAxis); 
} 
} 

//this's a simple touchCallBack routine. handle your events here 
int touchCallback(int device, Touch *data, int nFingers, double timestamp, int frame) { 
	if (!isDone) {
	Touch *f = &data[0]; 
	// printf("frame: %d, timestamp: %f, ID: %d, state: %d, PosX: %f, PosY: %f, VelX: %f, VelY: %f, Angle: %f, MajorAxis: %f, MinorAxis: %f\n", 
	printf("|%i %d %f %d %d %f %f %f %f %f %f %f\n", 
	nFingers,
	f->frame, 
	f->timestamp, 
	f->identifier, 
	f->state, 
	f->normalized.position.x, 
	f->normalized.position.y, 
	f->normalized.velocity.x, 
	f->normalized.velocity.y, 
	f->angle, 
	f->majorAxis, 
	f->minorAxis);
	isDone = YES;
	} 
} 

int main(void) { 
int i;	
NSMutableArray* deviceList = (NSMutableArray*)MTDeviceCreateList(); //grab our device list 
for(i = 0; i<[deviceList count]; i++) { //iterate available devices 
MTRegisterContactFrameCallback([deviceList objectAtIndex:i], touchCallback); //assign callback for device 
MTDeviceStart([deviceList objectAtIndex:i], 0); //start sending events 
} 
sleep(1); 
return 0; 
}