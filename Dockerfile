FROM ubuntu:20.04 AS builder

WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y python3 && apt-get clean

COPY teste.html /app/index.html


FROM alpine:3.18
# Instalar Python no Alpine
RUN apk add --no-cache python3
WORKDIR /app

COPY --from=builder /app /app

# Expor a porta do servidor
EXPOSE 8080

# Comando para iniciar o servidor
CMD ["python3", "-m", "http.server", "8080"]