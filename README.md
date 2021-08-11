# quote-service

Part of Cloud and DevOps for JS developers mentoring program.

## Client
### Installation

```bash
cd /client
npm install
npm run build
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