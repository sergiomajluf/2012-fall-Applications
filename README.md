What is this?
===============
These files are part of Kristen, Ju Young, Peter and my response to Nathan Shedroff's talk on his recent book release, "Make It So", for Applications class fall2012, at ITP.

Our work focused on showcasing a collective experience, where +100 students could create, perform, even if that rendered a chaotic experience in the auditorium. In that equation, free creation and experimenting out-weighted control.

We structured our project around sound manipulation through the use of flashlights. The physical movement from the audience would be captured by a webcam, processed for brightness detection, and then generated feedback through three distinct channels: the physical sound, light and movement of household appliances; real-time manipulation of a prerecorded soundtrack; and the interactive visualisation of sound, all three of them backdropped by Sci-Fi movies being tossed at the screen.

I coded the brightness detection part (thanks Dan for the advice!), and interfaced it to output serial data into an Arduino, so we could control the appliances through it. Peter built the hardware interface to control anything electric form the arduino. On top of that, Ju added a sound control layer, in which each bright/dark cell morphed the sound, and all the Sci-Fi visuals were done by Kristen, using Max MSP.

You can download the Processing and Arduino sketches. Please use them as you wish.