# ⚙️ 1단계: 빌드용 Node 환경
FROM node:23-alpine as build

WORKDIR /app
COPY . .

# 패키지 설치 및 앱 빌드
RUN yarn install
RUN yarn build

# ⚙️ 2단계: Nginx에 정적 파일 복사
FROM nginx:stable-alpine

# 빌드 결과물을 Nginx 루트로 복사
COPY --from=build /app/dist /usr/share/nginx/html

# 커스텀 nginx 설정 적용
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 포트 오픈
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
