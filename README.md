# dcss-webtiles

Docker image for [Dungeon Crawl Stone Soup](https://crawl.develz.org/) webtiles server.

## Quick Start

```bash
docker run -d -p 8080:8080 -v dcss-data:/data ghcr.io/nkhoit/dcss-webtiles:0.34.0
```

Then open `http://localhost:8080` in your browser.

## Tags

- `0.34.0`, `latest` — DCSS 0.34.0
- New releases are built automatically via GitHub Actions

## Data Persistence

Mount `/data` to persist saves, user accounts, and settings:

```bash
docker run -d \
  -p 8080:8080 \
  -v dcss-data:/data \
  ghcr.io/nkhoit/dcss-webtiles:latest
```

## Game Modes

The image includes four game modes out of the box:
- **DCSS** — Standard game
- **Custom seed** — Play with a specific seed
- **Tutorial** — Learn the basics
- **Sprint** — Short-form games

## Custom Configuration

Override the default configs by mounting your own:

```bash
docker run -d \
  -p 8080:8080 \
  -v dcss-data:/data \
  -v ./my-config.py:/app/webserver/config.py \
  ghcr.io/nkhoit/dcss-webtiles:latest
```

## Building a Specific Version

```bash
docker build --build-arg CRAWL_VERSION=0.33.0 -t dcss-webtiles:0.33.0 .
```

## Building Locally

```bash
git clone https://github.com/nkhoit/dcss-webtiles.git
cd dcss-webtiles
docker build -t dcss-webtiles .
```

## License

DCSS is licensed under [GPLv2](https://github.com/crawl/crawl/blob/master/LICENSE). This Docker packaging is MIT.
