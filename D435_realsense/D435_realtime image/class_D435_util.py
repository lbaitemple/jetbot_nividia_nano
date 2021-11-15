from IPython.display import display
import ipywidgets.widgets as widgets
from jetbot import bgr8_to_jpeg
import traitlets
import ipywidgets

import cv2
import threading
import time

import numpy as np
import time  
import threading
import cv2


import sys
sys.path.append('/usr/local/lib/python3.6/pyrealsense2')
import pyrealsense2 as rs  

class Camera:
    
    def __init__(self):
        print("Environment is Ready")
        #create a pineline for streaming and processing frames, abstracting camera configurations
        self.pipeline = rs.pipeline()                      # Create a pipeline
        self.config = rs.config()                         # Create a default configuration
        print("Pipeline is created")
        #Find RealSense Devices
        print("Searching Devices..")
        selected_devices = []                     # Store connected device(s)
        for d in rs.context().devices:
            selected_devices.append(d)
            print(d.get_info(rs.camera_info.name))
        if not selected_devices:
            print("No RealSense device is connected!")    
        #Find Depth and RGB Sensors
        rgb_sensor = depth_sensor = None
        for device in selected_devices:                         
            print("Required sensors for device:", device.get_info(rs.camera_info.name))
            for s in device.sensors:                              # Show available sensors in each device
                if s.get_info(rs.camera_info.name) == 'RGB Camera':
                    print(" - RGB sensor found")
                    rgb_sensor = s                                # Set RGB sensor
                if s.get_info(rs.camera_info.name) == 'Stereo Module':
                    depth_sensor = s                              # Set Depth sensor
                    print(" - Depth sensor found")

                    
                    
    def display(self,width,height):
        #setup the box for display
        self.depth_realsense_image = ipywidgets.Image(format='jpeg', width=width, height=height)
        self.RGB_realsense_image = ipywidgets.Image(format='jpeg', width=width, height=height)
        display(widgets.VBox([widgets.HBox([self.depth_realsense_image, self.RGB_realsense_image]),]))
    #Displaying Depth and Color Frames


    def doit(self):
        t = threading.currentThread()
        colorizer = rs.colorizer()                                # Mapping depth data into RGB color space
        profile = self.pipeline.start(self.config)                                 # Configure and start the pipeline


        try:
            while getattr(t, "do_run", True):
     #           print ("working on %s" % arg)
                frameset = self.pipeline.wait_for_frames()                     # Read frames from the file, packaged as a frameset
               # frameset = pipe.poll_frames()
                depth_frame = frameset.get_depth_frame()              # Get depth frame
                color_frame = frameset.get_color_frame()              # Get RGB frame
                colorized_streams = []                                # This is what we'll actually display

                if depth_frame:
                    colorized_streams.append(np.asanyarray(colorizer.colorize(depth_frame).get_data()))
                if color_frame:
                    colorized_streams.append(np.asanyarray(color_frame.get_data()))

                self.depth_realsense_image.value = bgr8_to_jpeg(colorized_streams[0])
                #convert the color array
                colorized_streams[1] = cv2.cvtColor(colorized_streams[1], cv2.COLOR_RGB2BGR)
                self.RGB_realsense_image.value = bgr8_to_jpeg(colorized_streams[1])
        except KeyboardInterrupt:
            print("The program was interupted by the user. Closing the program...")
    #    finally:
    #        frameset.disable_streams()
    #        pipe.stop()    
    
    def run(self):
        self.t = threading.Thread(target=self.doit)
        self.t.start()
        
    def stop_thread(self):  
        self.t.do_run = False # stop threading
        
    def restart_thread(self):
        self.pipeline.stop()
        self.t = threading.Thread(target=self.doit)
        self.t.start()
    
    def stop_camera(self): 
        self.t.do_run = False # stop threading
        self.pipeline.stop() #stop pineline    
