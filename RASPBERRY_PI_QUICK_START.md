# Raspberry Pi Quick Start Guide

## 라즈베리파이 빠른 시작 가이드

### 1. 저장소 클론
```bash
git clone https://github.com/grandbelly/reflex-ksys-lite.git
cd reflex-ksys-lite
```

### 2. 환경 설정
```bash
# .env 파일 생성
cp .env.example .env

# .env 파일 편집 (데이터베이스 연결 정보 설정)
nano .env
```

필수 설정:
```
DB_HOST_TYPE=local
DB_HOST=192.168.100.29  # 실제 데이터베이스 서버 IP
TS_DSN=postgresql://postgres:admin@192.168.100.29:5432/EcoAnP?sslmode=disable
INFLUX_HOST=192.168.100.29
INFLUX_PORT=8086
```

### 3. Docker로 실행 (권장)
```bash
# Docker Compose로 실행
docker-compose -f docker-compose.part.yml up -d

# 로그 확인
docker-compose -f docker-compose.part.yml logs -f
```

### 4. Python으로 직접 실행 (대안)
```bash
# Python 가상환경 생성
python3 -m venv venv
source venv/bin/activate

# 의존성 설치
pip install -r requirements.txt

# Reflex 초기화
reflex init

# 애플리케이션 실행
reflex run --host 0.0.0.0 --port 13000
```

### 5. 접속
브라우저에서 접속:
- `http://[라즈베리파이_IP]:13000`

### 특징
- AI/ML 기능 제거된 경량화 버전
- 낮은 메모리 사용량 (512MB RAM에서도 실행 가능)
- 기본 대시보드 및 모니터링 기능 포함
- TimescaleDB 연동 지원

### 문제 해결
- **메모리 부족**: Docker 메모리 제한 설정 확인
- **연결 오류**: 방화벽 및 네트워크 설정 확인
- **느린 성능**: swap 메모리 활성화 권장