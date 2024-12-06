Steps to Use:

1. Create a material with this shader and assign it to the plane or quad displaying your video.

2. Set _KeyColor to match the background color of your video (e.g., blue: (0, 0, 1, 1)). Adjust _Threshold to control the sensitivity of the chroma keying.

3. Place the quad with the video in front of your desired background (image, 3D objects, etc.).

4. Canvas Render Mode:
The Canvas render mode (Screen Space - Overlay, Screen Space - Camera, or World Space) affects how shaders interact with the rendering pipeline.
For Screen Space - Overlay, the video is directly rendered to the screen and does not use a camera. Custom shaders are generally not supported in this mode without additional workarounds.
For Screen Space - Camera or World Space, shaders work normally because the Canvas is rendered by a camera.
