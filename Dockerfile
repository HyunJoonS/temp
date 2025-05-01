# 빌드 스테이지
FROM node:20.17.0 AS build

WORKDIR /app

# 최신 npm 설치 (package.json 복사 후 실행)
COPY package.json package-lock.json ./
RUN npm install -g npm@latest

# 패키지 설치
RUN npm install

# 소스 코드 복사
COPY . .

# 빌드 실행
RUN npm run build


# 2단계: 실제 서비스용 Nginx 이미지
FROM nginx:alpine

# Nginx 설정 복사
COPY nginx.conf /etc/nginx/nginx.conf

# 빌드 결과물 복사
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]



# Docker build 명령어
# docker build -t my-react-image .

# 도커 이미지 생성이 정상적으로 되었는지 확인
# docker images

# 정상적으로 생성되었다면 실행까지 되는지 확인
# docker run -d -p 3000:80 --name my-react-container my-react-image

# 실행 로그 확인
# docker logs -f <컨테이너명>



# 도커 허브 로그인
# docker login

# 태그 붙이는법
# docker tag my-react-image:latest username/myrepository:latest

# 도커 허브 푸시
# docker push username/myrepository:latest

# 도커 허브 내려받기
# docker pull username/myrepository:latest



