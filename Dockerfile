FROM python:3.7-stretch
RUN mkdir /buildbot && \
      apt-get update && apt-get install --no-install-recommends git dumb-init && \
      rm -rf /var/lib/apt/lists/* && \
      adduser --disabled-password --gecos "" buildbot && \
      pip install --no-cache-dir Twisted==18.9.0 && \
      pip install --no-cache-dir  buildbot-worker==2.1.0 
COPY buildbot.tac /buildbot
RUN chown -R buildbot:buildbot /buildbot
USER buildbot
WORKDIR /buildbot
CMD ["/usr/bin/dumb-init", "twistd", "--pidfile=", "-ny", "buildbot.tac"]
