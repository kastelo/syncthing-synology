FROM alpine

RUN apk update && apk upgrade && \
    apk add --no-cache bash git python3 gnupg

WORKDIR /toolkit
RUN git clone https://github.com/SynologyOpenSource/pkgscripts-ng.git

# Representative platforms for x86_64, x86, armv7 and armv8.
RUN ./pkgscripts-ng/EnvDeploy -v 6.1 -p "x64 rtd1296 evansport alpine"
