  ▄   ▄
 ▄██▄▄██▄          ╔╗ ┌─┐┌┐┌┌─┐█
 ███▀██▀██         ╠╩╗├─┤│││├┤ █
 ▀███████▀         ╚═╝┴ ┴┘└┘└─┘█
   ▀███████▄▄      ▀▀▀▀▀▀▀▀▀▀▀▀█▀
    ██████████▄    I look better in monospace
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▀

This is a little weird to use so apologies
in advance.

For the most part, you should be fine
just dragging in the NightVisCam prefab.
However, on that Camera you will need 
to provide a list of lights for it to 
ignore.
In most cases, this will be all lights
in the scene, so you should be fine 
dragging them all in.
On your Main Camera, ensure that the 
same Ignore Lights script is on that 
too. That camera will be ignoring the 
NightVisionLight.

This system can make use of a render
texture as the final output, and a plane
has been provided that should work.
If you need it on another object, there
is also a material provided. 
It's important that the provided material
is used as it should ignore world lighting
properly.

If it's at all confusing, there is also
an example scene provided that I hope
can be of some help.