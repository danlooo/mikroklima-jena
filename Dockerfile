FROM rocker/shiny:latest
LABEL maintainer="Daniel Loos"
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY ./install.R ./install.R
RUN Rscript install.R

COPY *.R ./
COPY data.RData ./
RUN addgroup --system app \
    && adduser --system --ingroup app app
RUN chown app:app -R /app
USER app
EXPOSE 80
CMD ["R", "-e", "shiny::runApp('/app', port = 80, host = '0.0.0.0')"]
