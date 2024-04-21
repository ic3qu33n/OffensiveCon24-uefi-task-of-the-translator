
helloworld: helloworld.o
	ld -o helloworld hello.o -lSystem -syslibroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX13.3.sdk -e _start -arch arm64

helloworld.o: helloworld.s
	as -arch arm64 -o hello.o helloworld.s
