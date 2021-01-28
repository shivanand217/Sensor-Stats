# Sensor-Stats
  A sensor stats calculation app.

Write an iOS app, in Objective C, that listens to the accelerometer sensor and GPS to do the followings:

 * Compute basic statistics from accelerometer data.
 * Log the distance the user has traveled in the last 3 minutes using GPS data. Assume the app will be in the foreground at all times.
 * Display the results on the app's user interface.
 * An appropriate level of unit testing: mainly around statistical feature calculations.

 ### Goal
 
The goal of the exercise is to produce readable and correct code. The user interface does not have to be fancy. Make sure to think about the resource (CPU, Memory, Battery, Storage) limits and
efficiency. Through comments will be much appreciated.

Requirements :-
------------
Sensor:
* The app should sample accelerometer at 20 Hz (every 50 ms).

#### The app should calculate the following features:

* Descriptive statistics (max, median, mean, stdev, min, count) since the app start.
* Number of zerocrossings (when a measured value switches from positive to negative and vice versa) since the app start.
* The features should be calculated separately for the X, Y and Z direction of an accelerometer measurement.

GPS:
* Assume that the app will be in the foreground at all times. Unit of measure is in meters. You can make it as accurate as you'd like. Bonus points for more accurate results.
* The computed features should be made visible in the app. It is more important to have readable, working and correct code than it is to have a fancy UI.
