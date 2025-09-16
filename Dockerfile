# Utiliser Python slim
FROM python:3.11-slim

# Installer les dépendances
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le code Flask
COPY template ./template
COPY templates ./templates

# Exposer le port Flask
EXPOSE 5000

# Lancer Flask
CMD ["python", "-m", "template"]
