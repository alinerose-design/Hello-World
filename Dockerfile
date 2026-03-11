FROM python:3.10-slim

WORKDIR /app

COPY . .

CMD ["python3", "-c", "print('Hello from Docker container')"]
