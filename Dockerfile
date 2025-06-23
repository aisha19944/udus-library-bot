# Use Python 3.9
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy all project files
COPY . /app

# Install dependencies
RUN pip install --upgrade pip
RUN pip install rasa

# Expose port 5005
EXPOSE 5005

# Run Rasa
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "5005"]
