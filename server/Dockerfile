FROM node:16

# 创建目录
WORKDIR /usr/src/app

# 安装依赖
COPY package*.json ./
RUN npm install

# 拷贝项目文件
COPY . .

EXPOSE 3000
CMD [ "node", "express-app.js" ]