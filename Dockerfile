FROM node:10.14.0-alpine

ARG VERSION=1.35.1

RUN yarn global add serverless@${VERSION}

ARG BUILD_DATE
ARG VCS_REF

LABEL license="MIT" \
    maintainer="developers@graze.com" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vendor="graze" \
    org.label-schema.name="serverless" \
    org.label-schema.description="docker image for the serverless framework" \
    org.label-schema.vcs-url="https://github.com/graze/docker-serverless" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.build-date=$BUILD_DATE

ENTRYPOINT [ "serverless" ]
