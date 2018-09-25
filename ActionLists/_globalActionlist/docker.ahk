___your library open|rr||ahk|run,docker.ahk

; #Include ..\_globalWordLists\docker.ahk

SL5net

docker 
spawned|d|hervorgebracht

;<<<<<<<< run <<<< 180312094759 <<<< 12.03.2018 09:47:59 <<<<
run hello-world
runHello-world|r|run hello-world

run -it ubuntu bash
runIt|r|run -it ubuntu bash

run -d -p 80:80 --name webserver nginx
;>>>>>>>> run >>>> 180312094810 >>>> 12.03.2018 09:48:10 >>>>

ps ; while your webserver is running to see details on the container.

stop webserver
start webserver
container rm -f webserver
container rm -f webserver ; stop and remove the running container

container ls
container ls -a -q

images
images ; To see which images are present locally
images ; lokal zwischengespeicherten Images für den Start von Containern
lokal zwischengespeicherten Images für den Start von Containern|r|images

images - f dangling=true ; Liste nicht mehr benötigter Image Fragmente.
Liste nicht mehr benötigter Image Fragmente|r|images - f dangling=true 

container stop <Container NAME or ID>

run phpmentors/symfony-app

boot2docker ip

pull phpmentors/symfony-app


ID of container|r|idOfContainer
idOfContainer ; ID of container
inspect idOfContainer ; get IPAddress and more
IPAddress and more|r|inspect idOfContainer ; get IPAddress and more

crash report diagnostic id: 

Dockerfile

build -t friendlyhello .

; errors:
failed to get default registry endpoint from daemon|r|run dockerd.exe
image operating system "linux" cannot be used on this platform|r|right click and switch to linux containers before you pull your selenium images.
cannot download image with operating system "linux" when requesting "windows"
hv-sock proxy (vsudd) is not reachable

; URLs
Container-Images|r|https://registry.hub.docker.com 
registry.hub.docker.com|d|Container-Images
https://entwickler.de/online/development/docker-einsteiger-tutorial-210720.html