# Use the official Python image as the base image
FROM python:3.9-slim
# List packages here
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        file        \
        gcc         \
        libwww-perl && \
    apt-get autoremove -y && \
    apt-get clean

RUN apt-get install python3-dev -y

# Upgrade pip
RUN pip install --upgrade pip


# Set working directory in the container
WORKDIR /app
ADD requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Python files and requirements.txt
COPY . .
WORKDIR /app/src

# Install required dependencies

# Expose the port on which the Flask app runs
EXPOSE 5000

# Start the Flask app when the container starts
CMD ["python", "app.py"]