FROM gliderlabs/registrator:latest
MAINTAINER Dwolla Platform Team
ADD registrator_on_ec2_hostname.sh /usr/local/bin/registrator_on_ec2_hostname.sh
RUN apk-install curl
ENTRYPOINT ["registrator_on_ec2_hostname.sh"]
