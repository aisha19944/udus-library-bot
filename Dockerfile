# Use Python 3.9
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    git \
    build-essential \
    curl \
    libpq-dev \
    libffi-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libjpeg-dev

# Install Rasa dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy rest of the application
COPY . /app

# Expose port used by Rasa
EXPOSE 5005

# Start the Rasa server
CMD ["rasa", "run", "--enable-api", "--port", "5005", "--cors", "*", "--debug"]
