# Onshape_To_robotError Summary
Message:
URDFLoader : assets not found in provided package list.

What it means:
The URDF Visualizer is trying to load a mesh file referenced in your URDF file using a path like assets/part_1.stl.
It expects this path to be inside a ROS-style package or to be resolvable relative to the URDF file.

Why it happens:

In ROS, mesh files are often referenced with package:// URIs, which require a ROS package structure (with a package.xml file).
Your URDF uses a relative path (assets/part_1.stl), which is correct for your folder structure, but some tools expect a ROS package or a specific way to resolve asset paths.
If the visualizer is set to look for ROS packages, and your assets folder is not a ROS package, it cannot find it in the "package list".
Your setup:

Your mesh file is at part_1.stl.
Your URDF references it as assets/part_1.stl, which is correct if the URDF is in my-robot.
How to fix:

If using a ROS tool:
Make assets a ROS package (add a package.xml).
Or, use package://my-robot/assets/part_1.stl if my-robot is a package.
If using a standalone visualizer:
Make sure the mesh path is relative to the URDF file (which you already have).
If you still get the error, try using an absolute path or check if the visualizer has a setting for asset search paths.
In your case:
Your URDF is correct for most standalone tools. If you still see the error, it’s likely the visualizer is expecting a ROS package structure.
You can try:

Adding a package.xml to my-robot or assets.
Or, check the visualizer’s documentation for how it resolves mesh paths.
Summary:
The error is about how the visualizer finds mesh files. Your file structure and URDF are correct for relative paths, but the tool may expect a ROS package. Adjust the folder structure or settings as needed.

