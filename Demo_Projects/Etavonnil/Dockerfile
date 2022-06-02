# our base image
FROM nginx
LABEL maintainer="Mr. Jeck"
ENV cont /usr/share/nginx/html/

# copy our application code
COPY ./content/ $cont
WORKDIR ${cont}