FROM python:3.12-slim

WORKDIR /app

COPY src/python/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY src/python/main.py src/python/main.py

CMD ["python", "src/python/main.py"]
