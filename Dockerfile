FROM crystallang/crystal:1.5

ADD . /app
WORKDIR /app
RUN shards install
RUN crystal build --release src/app.cr

EXPOSE 3000
CMD [ "./app" ]
