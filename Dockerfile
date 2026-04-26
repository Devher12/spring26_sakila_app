FROM python:3.9-slim

LABEL maintainer="Muhammad Moeed Ikram"
LABEL version="1.0.0"
LABEL description="Sakila Flask Application"

WORKDIR /app

RUN groupadd -r sakila && useradd -r -g sakila sakila

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt 
    

COPY . .

ENV MYSQL_HOST=db
ENV MYSQL_USER=root
ENV MYSQL_DB=sakila

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')" || exit 1

USER sakila

CMD ["python", "app.py"]