FROM rocker/r-ver:4.4.3

WORKDIR /app

COPY src/r/install_packages.R .

RUN Rscript install_packages.R

COPY src/r/main.R src/r/main.R

CMD ["Rscript", "src/r/main.R"]
