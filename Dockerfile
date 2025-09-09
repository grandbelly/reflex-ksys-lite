# Reflex 앱을 위한 Dockerfile
FROM python:3.11-slim

# 작업 디렉터리 설정
WORKDIR /app

# 시스템 패키지 업데이트 및 필수 패키지 설치
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Node.js 설치 (Reflex 프론트엔드용)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Python 의존성 복사 및 설치
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 프로젝트 파일 복사
COPY . .

# Reflex 초기화
RUN reflex init --loglevel debug || true

# 포트 노출 (13000: 프론트엔드, 13001: 백엔드)
EXPOSE 13000 13001

# 앱 실행
CMD ["reflex", "run", "--env", "prod", "--backend-host", "0.0.0.0"]
