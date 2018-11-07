FROM google/dart:2.0

ADD models /models

WORKDIR /api

ADD api/pubspec.* /api/
RUN pub get
ADD api /api
RUN pub get --offline

EXPOSE 3333

CMD []
ENTRYPOINT ["/usr/bin/dart", "bin/main.dart"]