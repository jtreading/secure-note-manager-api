FROM node:latest AS api-builder
WORKDIR /app/api
COPY ./package*.json ./
COPY ./prisma .
COPY . .

RUN npm install
RUN npx prisma generate

FROM node:latest
WORKDIR /app
COPY --from=api-builder /app/api /app/api
COPY ./start.sh .

RUN chmod +x ./start.sh

EXPOSE 5000

CMD ["./start.sh"]