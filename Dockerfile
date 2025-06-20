FROM python:3.10-slim

# Avoids writing .pyc files
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y build-essential

# Copy all project files
COPY . /app/

# Upgrade pip and install Rasa
RUN pip install --upgrade pip
RUN pip install rasa==3.6.10

# Expose Rasa port
EXPOSE 5005

# Start Rasa server
CMD ["rasa", "run", "--enable-api", "--port", "5005", "--cors", "*", "--debug"]
