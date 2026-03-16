# Software Information:

The tennis robot consists of two main parts in software. The tennis robot itself is controlled by an Orange Pi 5 Pro. On this runs Linux Ubuntu, with the Framework ROS2 Jazzy on top. Then, to control the robot, we use a Flutter programmed mobile and desktop app. Currently only for mobile, but we will soon create a Windows optimized app. Via Bluetooth you can control the robot. 

# Features of the Software
All programs are started by the mobile/Windows app. Programmes are: Ball collecting, Clean court, Manuel driving via mobile app joy-sticks.
## Computer Vision: We have a built in computer vision which detects first the tennis balls on the court and detects the size of the map. 
## Mapping
After all tennis balls are detected and the court is also detected, the robot calculates the most efficient route (less way as possible). 
## Ball Store
The robot counts the balls that he collects and tells then when the ball store is full and should be cleared.
## Court Cleaning
The robot calculates and maps the map that he cleans the whole court.

# Disclaimer
Until now, we haven't tried out our software and hardware. We will, as soon as we get funding, build and source our project. 