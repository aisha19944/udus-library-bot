# Use official Python image compatible with Rasa
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory
WORKDIR /app

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy project files into the container
COPY . /app

# Install Rasa and project requirements
RUN pip install --upgrade pip
RUN pip install rasa==3.6.10

# Expose Rasa port
EXPOSE 5005

# Run Rasa server with API and CORS enabled
CMD ["rasa", "run", "--enable-api", "--port", "5005", "--cors", "*", "--debug"]
