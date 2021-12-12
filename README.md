# quote-service

Part of Cloud and DevOps for JS developers mentoring program.

## Client
### Installation

```bash
cd client/
npm install
npm run build:dev
```

## Server
### Installation

```bash
npm install
npm start
```

## Server Containerization
```bash
docker build . -t <IMAGE_NAME>
docker run --rm -ti -p 8080:8080 <IMAGE_NAME>
```

## Nginx Containerization
```bash
docker build ./nginx-configuration -t <IMAGE_NAME>
docker run --rm -ti -p 80:80 -p 443:443 -p 3000:3000 <IMAGE_NAME>
```

## Run all together
```bash
docker-compose up --build
```

## Scripts
```bash
scripts/build-back-and-publish.sh
scripts/build-client.sh
scripts/create-lifecycle-policies.sh
scripts/create-stage-image.sh <STAGE_NAME>
scripts/db.sh
```