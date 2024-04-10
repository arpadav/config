export SSL_CERT_FILE=<PATH_TO_CERTIFICATE>

pip config set global.cert $SSL_CERT_FILE
conda config --set ssl_verify $SSL_CERT_FILE
git config --global http.sslVerify true
git config --global http.sslCAInfo $SSL_CERT_FILE
npm config set cafile $SSL_CERT_FILE
