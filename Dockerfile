FROM python:3.10-slim

WORKDIR /app

COPY app/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app/ ./app

COPY tests/ ./tests/

ENV PYTHONPATH=/app

EXPOSE 5000

CMD ["python", "main.py"]