FROM python:3.12-slim AS builder
RUN apt-get update \
    && apt-get install --no-install-recommends -y git \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /src
RUN git clone --depth=1 https://github.com/alexbers/mtprotoproxy .

FROM python:3.12-slim AS final
RUN apt-get update \
    && apt-get install --no-install-recommends -y libcap2-bin ca-certificates \
    && rm -rf /var/lib/apt/lists/*
RUN setcap cap_net_bind_service=+ep /usr/local/bin/python3.12
WORKDIR /app
COPY --from=builder /src/pyaes ./pyaes
COPY --from=builder /src/mtprotoproxy.py ./mtprotoproxy.py
COPY --from=builder /src/config.py ./config.py
RUN pip install --no-cache-dir uvloop cryptography pysocks
RUN useradd -u 10000 -m tgproxy
USER tgproxy
CMD ["python3", "mtprotoproxy.py"]
