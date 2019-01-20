#!/bin/bash

# author: utahkaA
# reference site:
# http://qiita.com/utahkaA/items/126f93c3d73c4f5269e2

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu stretch main" > /etc/apt/sources.list.d/ros-latest.list'
wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y python-pip python-setuptools python-yaml python-distribute python-docutils python-dateutil python-six
sudo pip install rosdep rosinstall_generator wstool rosinstall
sudo rosdep init
rosdep update
mkdir ~/ros_catkin_ws
cd ~/ros_catkin_ws
rosinstall_generator ros_comm —rosdistro kinect —deps —wet-only —exclude roslisp —tar > indigo-ros_comm-wet.rosinstall
wstool init src kinect-ros_comm-wet.rosinstall
rosdep install —from-paths src —ignore-src —rosdistro kinect -y -r —os=debian:stretch
sudo ./src/catkin/bin/catkin_make_isolated —install -DCMAKE_BUILD_TYPE=Release —install-space /opt/ros/kinect -j1
source /opt/ros/kinect/setup.bash
echo "source /opt/ros/kinect/setup.bash" >> ~/.bashrc
echo "ROS setup is done"
exec bash
