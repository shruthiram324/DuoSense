# DuoSense Mobile Application Final Project
This is a team mobile app project done for the creative portion of the class CSE438. 

We have added to our drawing app that we created in lab 3 (the drawing app) to support a functionality that allows the user to create a randomly generated free form drawing and have an algorithmically-outputted song recommendation based off of their “emotions” from their drawing. The algorithm that we created was based off of the top three colors that predominated the user’s free form drawing. We researched the 6 universal emotions that transcend cultures and all people and associated one color to each of those emotions. Whichever color dominates the pictures (which we have determined by creating our own algorithm based off the coordinates of the length of brush stroke associated with that particular color) produces a song based off that color’s “emotion.” We have assigned the emotions as follows:

Red- anger

Orange- fear/disgust

Yellow- happiness

Green- surprise

Blue- sad

Purple-mellow vibe



The user can create a picture using any of the 6 color options available. When they click generate, our algorithm will determine (using the length of the brush strokes for each color using a color count for those strokes) which were the most plotted coordinate points per stroke, and therefore, which were the most used colors. Based off the highest color, the app will generate a song that correlates to that color’s emotion, which you can listen to by hitting the play button (the text of the song will also show up) and you can also pause by hitting the pause button. 
