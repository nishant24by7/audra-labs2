FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libsm6 libxext6 libxrender-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY backend/requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY . .

# Expose port
EXPOSE 5000

# Set environment
ENV FLASK_APP=backend/api.py
ENV PYTHONUNBUFFERED=1

# Run application
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "backend.api:app"]
