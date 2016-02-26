hacktrain
=========

The start of a train game, written in Ruby but using JMonkeyEngine 3 as a 3D game engine.

![Screenshot](https://raw.githubusercontent.com/soundasleep/hacktrain/master/screenshot.png)

Based heavily on [https://github.com/jwoertink/jmonkeyengine-ruby](jmonkeyengine-ruby).

# Setting up

You need to run this with JRuby, because we're using JME3.

### Mac OS X

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

### Windows

There is no `rbenv` on Windows; download [JRuby 9.0+](http://jruby.org/download), install it to `C:\jruby`, and then continue as before:

```
# if `bundle` throws an `OutOfMemoryError: Java heap space`
set JRUBY_OPTS=-J-Xmx1024m

c:\jruby\bin\jruby -v    # should say "jruby 9.0.5.0"
c:\jruby\bin\gem install bundler
c:\jruby\bin\bundle

# we can finally run things
c:\jruby\bin\jruby run.rb
```
