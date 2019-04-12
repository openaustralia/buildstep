FROM gliderlabs/herokuish:v0.5.0
MAINTAINER Matthew Landauer <matthew@oaf.org.au>

# Add perl buildpack for morph
RUN /bin/herokuish buildpack install https://github.com/miyagawa/heroku-buildpack-perl.git 2da7480a8339f01968ce3979655555a0ade20564

# Add certificate authority used by mitmproxy
# Also needs to be identical to the cert at mitmproxy/mitmproxy-ca-cert.pem in
# https://github.com/openaustralia/morph
ADD mitmproxy-ca-cert.pem /usr/local/share/ca-certificates/mitmproxy-ca-cert.crt
RUN update-ca-certificates

# Add prerun script which will disable output buffering for ruby
ADD prerun.rb /usr/local/lib/prerun.rb

# poppler-utils has a more recent pdftohtml than the pdftohtml package
# pdftohtml is needed by the python scraperwiki library
# libffi-dev needed by python cffi
# time is needed directly by morph.io for scraper run measurements
RUN apt-get update && apt-get install -y time libblas-dev liblapack-dev gfortran swig protobuf-compiler libprotobuf-dev libsqlite3-dev poppler-utils libffi-dev

# PhantomJS has been deprecated
RUN apt-get install -y phantomjs

# Install chromedriver
RUN wget https://chromedriver.storage.googleapis.com/73.0.3683.68/chromedriver_linux64.zip && \
			unzip chromedriver_linux64.zip && \
			rm chromedriver_linux64.zip && \
			mv chromedriver /usr/local/bin && \
			chmod ugo+x /usr/local/bin/chromedriver

# Install chrome
RUN curl -sSO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb || true && \
    apt --fix-broken install -y && \
    rm google-chrome-stable_current_amd64.deb

# We also need to make chrome trust our CA cert
RUN apt-get -y install libnss3-tools && \
			mkdir -p /app/.pki/nssdb && \
			certutil -d sql:/app/.pki/nssdb -N --empty-password && \
			certutil -d sql:/app/.pki/nssdb -A -t "C,," -n "mitmproxy ca cert" -i /usr/local/share/ca-certificates/mitmproxy-ca-cert.crt

# Make python pip use the new ca certificate. Wouldn't it be great if it used
# the system ca certificates by default? Well, it doesn't.
# Setting the PIP_CERT environment variable didn't work but this does
# TODO Remove this once compiles don't send traffic to mitmproxy
ADD pip.conf /etc/pip.conf
