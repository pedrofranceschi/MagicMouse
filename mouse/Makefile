all:
	gcc -o mouse mouse.m -F/System/Library/PrivateFrameworks -framework MultitouchSupport -lIOKit -framework CoreFoundation -framework ApplicationServices -lobjc
clean:
	rm mouse
install:
	sudo cp mouse /usr/bin && sudo mv /usr/bin/mouse /usr/bin/magic_mouse_rb && sudo chmod +x /usr/bin/magic_mouse_rb