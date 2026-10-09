FROM python:3.7
WORKDIR /app

# Création de l'utilisateur non-root
RUN useradd -m myuser && chown -R myuser:myuser /app

# Ajout de --no-install-recommends
RUN apt-get update && apt-get install -y --no-install-recommends gcc libpq-dev

COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

USER myuser

HEALTHCHECK CMD curl --fail http://localhost:5000/ || exit 1

CMD ["python", "app.py"]