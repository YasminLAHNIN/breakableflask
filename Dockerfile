FROM python:3.7
WORKDIR /app

# 1. Créer un utilisateur non-root pour corriger l'alerte HIGH (DS-0002)
RUN useradd -m myuser && chown -R myuser:myuser /app

RUN apt-get update && apt-get install -y gcc libpq-dev
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

# 2. Utiliser l'utilisateur non-root
USER myuser

# 3. Ajouter un healthcheck pour corriger l'alerte LOW (DS-0026)
HEALTHCHECK CMD curl --fail http://localhost:5000/ || exit 1

CMD ["python", "app.py"]