FROM debian:stable-slim

LABEL "com.github.actions.name"="WordPress Pot Generator"
LABEL "com.github.actions.description"="WordPress Pot File Generator"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="blue"

LABEL maintainer="Varun Sridharan <varunsridharan23@gmail.com>"
LABEL version="1.0.0"
LABEL repository="https://github.com/varunsridharan/github-actions-wordpress-pot-generator"

RUN apt-get update \
	&& apt-get install -y subversion rsync git \
	&& apt-get clean -y \
	&& rm -rf /var/lib/apt/lists/* \
	&& git config --global user.email "wppotgenerator+github@gmail.com" \
	&& git config --global user.name "WPPot Generator on GitHub"

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
