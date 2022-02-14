# 이미지 빌드에 사용할 베이스 이미지를 지정
FROM python:3.8.7-slim-buster

# Dockerfile이 존재하는 경로 기준 로컬 디렉토리를 컨테이너 내부의 디렉토리로 복사
COPY . /app

# Dorckerfile의 RUN, CMD, ENTRYPOINT 등의 명령어를  실행할 컨테이너 경로 지정
WORKDIR /app

# 컨테이너 내 환경변수 지정
ENV PYTHONPATH=/app
ENV PYTHONUNBUFFERED=1

# 실행할 리눅스 명령어
RUN pip install pip==21.2.4 && \
    pip install -r requirements.txt

# docker run으로 이 이미지를 기반으로 컨테이너를 만들 때, 실행할 명령어(쉘커멘드)
CMD ["python", "main.py"]