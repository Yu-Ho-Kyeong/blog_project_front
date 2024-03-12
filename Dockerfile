FROM node:latest as builder
WORKDIR /blog
COPY package.json ./
RUN yarn install
COPY . .
RUN yarn run build

FROM nginx:latest
COPY --from=builder /blog/dist /app
COPY nginx.conf /etc/nginx/nginx.conf

# 업로드 디렉토리 생성 및 권한 설정
RUN mkdir -p /app/uploads/profile /app/uploads/board \
    && chmod -R 777 /app/uploads
EXPOSE 80