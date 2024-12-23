FROM ros:humble

# Install ROS2 dependencies
RUN apt-get update && apt-get install -y \
    git python3.10 python3-pip vim \
    ros-humble-rqt*

# Create the ros2_ws directory
RUN mkdir -p /src/ros2_ws/src

# Copy the source files into the workspace
COPY ./src /src/ros2_ws/src

COPY ./entry_point.sh /entry_point.sh

RUN chmod +x /entry_point.sh

WORKDIR /src/ros2_ws

# Source ROS2 setup and build the workspace
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && colcon build"

ENTRYPOINT ["/entry_point.sh"]