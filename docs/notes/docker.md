Docker is for developers and sysadmins to provide an environment to
*develop*, *deploy* and *run* applications with containers.

A container is analogous to Python's virtual environments, it creates
a space so that your code / application only depends on isolated
environment, in docker they call it a container. A container is
instanciated by running an *image* where it is an executable target that
contains all the dependencies required by the code / application to
execute.

Containers differ from virtual machines such as VMWare or VirtualBox that
it does notrun a "guest" operating system with virtual access to host
resources. Instead, containers run natively on the machine and has direct
access to the host machine.

```
docker info
docker version
docker image
docker container
docker build -t <image_name> .
docker run <image_name>
```


## Define a container with a `Dockerfile`

Dockerfile is configuration script that defines the environment you want
your application to run in. Resources such as networking interfaces and
disk drives are virtualized inside this environment.


An example docker file that runs a python app:

		# Use an official Python runtime as a parent image
		FROM python:2.7-slim

		# Set the working directory to /app
		WORKDIR /app

		# Copy the current directory contents into the container at /app
		ADD . /app

		# Install any needed packages specified in requirements.txt
		RUN pip install --trusted-host pypi.python.org -r requirements.txt

		# Make port 80 available to the world outside this container
		EXPOSE 80

		# Define environment variable
		ENV NAME World

		# Run app.py when the container launches
		CMD ["python", "app.py"]
