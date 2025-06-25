FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install OS-level dependencies including OpenCV dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirement file and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy entire app
COPY . .

# Expose Flask port
EXPOSE 5001

# Run the app
CMD ["python", "app.py"]