FROM hawkeye

RUN usermod -a -G dialout root
RUN apt-get remove modemmanager -y
RUN apt install gstreamer1.0-plugins-bad gstreamer1.0-libav gstreamer1.0-gl -y
RUN apt install libqt5gui5 -y

COPY ./QGroundControl.AppImage /root/QGroundControl.AppImage

RUN useradd user 
RUN echo "123" > password
RUN echo "123" >> password
RUN passwd user < password
RUN usermod -a -G dialout user
RUN chmod 777 /root/QGroundControl.AppImage
RUN chmod 777 /root
RUN mkdir /home/user
RUN chmod 777 /home/user

USER user

ENV APPIMAGE_EXTRACT_AND_RUN=1


RUN echo "/root/QGroundControl.AppImage" > ~/.xinitrc && chmod +x ~/.xinitrc
ENTRYPOINT unset FD_SESS && x11vnc -forever -create

EXPOSE 5900
