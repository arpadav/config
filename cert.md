SSL_CERT_FILE=<PATH_TO_CERTIFICATE>
pip config set global.cert <PATH_TO_CERTIFICATE>
conda config --set ssl_verify <PATH_TO_CERTIFICATE>
git config --global http.sslVerify true
git config --global http.sslCAInfo <PATH_TO_CERTIFICATE>
