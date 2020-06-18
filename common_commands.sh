This did the trick for me:

docker run -dit ubuntu
After it, I checked for the processes running using:

docker ps -a
For attaching again the container

docker attach CONTAINER_NAME
TIP: For exiting without stopping the container type: ^P^Q


 docker build -t ros:melodic-desktop-full .


docker run \
    -it \
    -v ~/catkin_ws:/root/catkin_ws \
    -v ~/.ssh:/root/.ssh \
    --network host \
    --env ROS_MASTER_URI=http://<your hostname>:11311 \
    --name ros
    ros:melodic[-desktop-full]

docker ps
$ docker ps -a
$ docker image ls
$ docker info
$ docker start <name>
$ docker exec -it <name> bash
$ docker stop <name>
$ docker container rm <name>


docker run -dit --network host --env ROS_MASTER_URI=http://192.168.100.4:11311 -v ~/.ssh:/root/.ssh  -v ~/greyorange_ws:/root/catkin_ws nav_2_0:latest 


docker save -o <path for generated tar file> <image name>
docker load -i <path to image tar file>

sudo docker push repo.labs.greyorange.com/nav_2_0:support
sudo docker login -u "****" -p "*****" repo.labs.greyorange.com


docker buildx --help 
docker run --rm --privileged docker/binfmt:820fdd95a9972a5308930a2bdfb8573dd4447ad3

cat /proc/sys/fs/binfmt_misc/qemu-aarch64

$ docker buildx create --name mybuilder
$ docker buildx use mybuilder
$ docker buildx inspect --bootstrap

sudo docker -D buildx build --platform linux/arm64 -t repo.labs.greyorange.com/nav_2_0:arm_support_image --load .

 docker buildx imagetools inspect alpine
