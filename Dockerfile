# Use official Python image
FROM python:3.10-slim

# Set work directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the app code
COPY ./population_api ./population_api

# Run the app
CMD ["uvicorn", "population_api.api:app", "--host", "0.0.0.0", "--port", "80"]
