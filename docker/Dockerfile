# filepath: /c:/Users/prs0131y/Desktop/repos/becse-it-prs0131y/docker/project/Dockerfile
# Koristi zvaničnu Python sliku kao osnovu
FROM python:3.11-slim

# Postavi radni direktorijum u kontejneru
WORKDIR /app

# Kopiraj requirements.txt u radni direktorijum
COPY requirements.txt .

# Instaliraj Python zavisnosti
RUN pip install --no-cache-dir --trusted-host pypi.org --trusted-host files.pythonhosted.org -r requirements.txt

# Kopiraj ostatak aplikacije u radni direktorijum
COPY . .

# Definiši komandu koja će se izvršiti kada se kontejner pokrene
CMD ["python", "app.py"]