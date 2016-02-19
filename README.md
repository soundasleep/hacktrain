hacktrain
=========

![Screenshot](https://raw.githubusercontent.com/soundasleep/hacktrain/master/screenshot.png)

Based heavily on [https://github.com/jwoertink/jmonkeyengine-ruby](jmonkeyengine-ruby).

Requires JRuby installed, since we are using JME3 for doing the actual hard rendering work...

# Setting up

```
brew install Caskroom/cask/java
java -version

# OS X and Java do not play nicely together at all
# resolves 'OpenSSL::X509::StoreError: setting default path failed: problem creating X509 Aux certificate: java.io.IOException: problem parsing cert: java.security.cert.CertificateParsingException: java.io.IOException: Duplicate extensions not allowed'
# https://github.com/jruby/jruby/issues/1055

wget http://curl.haxx.se/ca/cacert.pem
export SSL_CERT_FILE=`pwd`/cacert.pem

# we now need to install jruby + gems
rbenv install jruby-9.0.0.0
rbenv local   # should say "jruby-9.0.0.0"

gem install bundler
bundle

# we can finally run things
ruby run.rb
```
