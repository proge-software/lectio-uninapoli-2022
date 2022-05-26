FROM python:3.9

WORKDIR /workspace
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY spectral-biclustering.py .
CMD ["python", "spectral-biclustering.py"]
