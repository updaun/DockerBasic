### Docker

### Docker Image
- 컨테이너를 실행할 때 사용할 수 있는 템플릿
- read only

### Docker Container
- Docker Image를 활용해 실행된 인스턴스
- write 가능

### Docker Command

#### docker image 설치

- docker pull "이미지 이름:태그"
```
docker pull mysql:8
```

#### 다운받은 docker image 확인
```
docker images
```

#### docker image로 컨테이너 실행
- docker run "이미지 이름:태그"
- 다운받은 mysql 이미지를 기반으로 docker container를 만들고 실행
```
docker run --name mysql-tutorial -e MYSQL_ROOT_PASSWORD=1234 -d -p 3306:3306 mysql:8

--name : 컨테이너의 이름 지정하지 않을 시 랜덤 생성
-e : 환경변수 설정
-d : 데몬 모드 (백그라운드)
-p : 포트 지정
```

#### 실행중인 컨테이너 확인
```
docker ps
```
#### 컨테이너 접속(SSH와 비슷)
- docker exec -it "컨테이너 이름(혹은 ID)" /bin/bash
```
docker exec -it mysql-tutorial /bin/bash
```

#### 컨테이너 접속 후 mysql 실행
- mysql 실행
```
mysql -u root -p
```

#### 컨테이너 중지
- docker stop "컨테이너 이름(ID)"
```
docker stop mysql-tutorial
```

#### 작동을 멈춘 컨테이너 확인
```
docker ps -a
```

#### 컨테이너 삭제
- docker rm "컨테이너 이름(ID)"
- 멈춘 컨테이너만 삭제 가능
- docker rm "컨테이너 이름(ID)" -f 실행중인 컨테이너도 삭제 가능

#### volume mount
- -v Host_Folder:Container_Folder
```
docker run -it -p 8888:8888 -v /some/host/folder/for/work/:/home/jovyan/workspace/jupyter/minimal-notebook
```

#### 설치 모듈 저장

- 설치된 모든 모듈 확인
```
pip freeze
```
- 의존성에 따라 설치된 라이브러리는 보이지 않음
```
pip list --not-requried --format=freeze
```
- requirements.txt로 저장
```
pip list --not-requried --format=freeze >> requirements.txt
```



### Dockerfile Grammar

#### 이미지 빌드에 사용할 베이스 이미지를 지정
- FORM "이미지 이름:태그"
- python:3.8.7-slim-buster (dockerhub에 존재)
```
FROM python:3.8.7-slim-buster
```

#### Dockerfile이 존재하는 경로 기준 로컬 디렉토리를 컨테이너 내부의 디렉토리로 복사
- COPY "로컬 디렉토리(파일)" "컨테이너 내 디렉토리(파일)"
 
```
COPY . /app
```

#### Dorckerfile의 RUN, CMD, ENTRYPOINT 등의 명령어를  실행할 컨테이너 경로 지정
- WORKDIR "컨테이너 내 디렉토리"
```
WORKDIR /app
```



#### 컨테이너 내 환경변수 지정
- ENV "환경변수 이름=값"
```
ENV PYTHONPATH=/app
ENV PYTHONUNBUFFERED=1
```


#### 이미지 빌드시 실행하는 명령어
- RUN "실핼할 리눅스 명령어"
```
RUN pip install pip==21.2.4 && \
    pip install -r requirements.txt
```

#### docker run으로 이 이미지를 기반으로 컨테이너를 만들 때, 실행할 명령어(쉘커멘드)
- CMD ["실행할 명령어", "인자", ...]
```
CMD ["python", "main.py"]
```

#### 이미지 빌드
- docker build "Dockerfile이 위치한 경로"
```
docker build . -t my-fastapi-app
```

#### 빌드가 끝나고 이미지 확인
```
docker images
```

#### 이미지로 컨테니어 실행
- docker run "이미지 이름:태그"
```
docker run -p 8000:8000 my-fastapi-app
```

#### 이미지 작동 확인
- curl로 애플리케이션 작동상태 확인
```
curl localhost:8000/hello
```