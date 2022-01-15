FROM 	 mingc/latex


WORKDIR  /font
RUN      apt-get update && \
         apt-get -y install --no-install-recommends \
         unzip \
         && rm -rf /var/lib/apt/lists/*

RUN 	 wget 'https://dl.dafont.com/dl/?f=bellamy_signature' -O "bellamy_signature.zip"

RUN 	 unzip bellamy_signature.zip -d /usr/share/fonts/

RUN 	 ls /usr/share/fonts/
RUN 	 fc-cache -v
