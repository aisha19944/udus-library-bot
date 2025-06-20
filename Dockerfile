FROM python:3.9-slim

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Set working directory
WORKDIR /app

# Install basic dependencies
RUN apt-get update && \
    apt-get install -y gcc build-essential && \
    pip install --upgrade pip

# Copy project files into container
COPY . /app

# Install Rasa and project dependencies
RUN pip install rasa==3.6.10

# Expose Rasa port
EXPOSE 5005

# Start Rasa server
CMD ["rasa", "run", "--enable-api", "--port", "5005", "--cors", "*", "--debug"]
