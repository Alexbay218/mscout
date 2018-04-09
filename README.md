# mscout
New and easy match scouting system for the 2018 FRC game

Data can be found here: https://drive.google.com/drive/folders/16fIlywzSIZ-eCjD4rOBjxwxmg_Tv2XwW?usp=sharing

Feel free to upload your data here to share to everyone

## Features

 - Logs time at which each event happens and duration

 - Easy to use keystroke based system

## How to use

Fill out all the information:
 
 - Team Number  - Self explanatory
 
 - Week Number  - What week the current event (number only please)
 
 - Match Type   - Q for Qual, QF for Quarter Final, SF for Semi Final, and F for Final
 
 - Match Number - Use numbers only (QF2M1 should be QF1, since it is the first QF match for that team in the event)


On match start, press the Enter key

Here, seconds left should start counting down from 150


During operation, press the following keys to record data:

    Space     - Whenever the robot grabs a cube                                                 - "Has Cube" will be printed 
                (Note that on match start, the robot already has a cube)
                
              - Whenever the robot has a cube and dropped it                                    - "Dropped Cube" will be printed

    L         - Whenever the robot completes an auto-run                                        - "Line Crossed" will be printed

    E         - Whenever the robot has a cube and placed it on their own exchange               - "Placed on Exchange" will be printed

    W         - Whenever the robot has a cube and placed it on their own switch                 - "Placed on Switch" will be printed

    Shift + W - Whenever the robot has a cube and failed in placing it on their own switch      - "Failed Switch" will be printed

    S         - Whenever the robot has a cube and placed it on the scale                        - "Placed on Scale" will be printed

    Shift + S - Whenever the robot has a cube and failed in placing it on the scale             - "Failed Scale" will be printed

    O         - Whenever the robot has a cube and placed it on their opponent switch            - "Placed on Op Switch" will be printed

    Shift + O - Whenever the robot has a cube and failed in placing it on their opponent switch - "Failed Op Switch" will be printed

    D         - Whenever the robot mounts a clean defense                                       - "Defense Played" will be printed

## Data
After seconds left reaches -10 (10 second buffer to account for error), all the data collected is saved

data is saved under data\<team number> folder with this format: "<team number>_<week number>_<match type><match number>.csv"

Use compile.ahk to consolidate all the data to compdata\<team number>
<WIP>
