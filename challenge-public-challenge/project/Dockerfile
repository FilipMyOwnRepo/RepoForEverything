FROM python:3.11.5-slim

# Set the working directory
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY source/ ./source

# Expose the port the app runs on
EXPOSE 80

# Command to run the application
CMD ["python", "source/app_flask.py"]
#CMD ["python", "source/app_oop.py"]
#CMD ["python", "-c", '"import os; print(os.getlogin())"']