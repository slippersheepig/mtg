# mtg
https://github.com/alexbers/mtprotoproxy
`docker-compose.yml`
```bash
services:
  mtprotoproxy:
    image: sheepgreen/mtg
    container_name: mtg
    restart: always
    network_mode: "host"
    volumes:
      - ./config.py:/app/config.py
```
You should edit `config.py` according to the original author's instructions for it. Use `docker logs mtg` for more detail.
