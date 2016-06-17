class AceSsl < Formula
  desc "Auxiliary SSL library for ADAPTIVE Communication Environment: OO network programming in C++"
  homepage "https://www.dre.vanderbilt.edu/~schmidt/ACE.html"
  url "http://download.dre.vanderbilt.edu/previous_versions/ACE-6.3.4.tar.bz2"
  sha256 "9dd3c639fef1e4d3e2483f8cf4b201b2e80b1ffd8dd9c9a7ce57d0ba9e80f789"

  depends_on "ace"
  depends_on "openssl"
  
  def install
    # Figure out the names of the header and makefile for this version
    # of OSX and link those files to the standard names.
    name = MacOS.cat.to_s.delete "_"
    ln_sf "config-macosx-#{name}.h", "ace/config.h"
    ln_sf "platform_macosx_#{name}.GNU", "include/makeinclude/platform_macros.GNU"

    # Set up the environment the way ACE expects during build.
    ENV["ACE_ROOT"] = buildpath
    ENV["DYLD_LIBRARY_PATH"] = "#{buildpath}/ace:#{buildpath}/lib"

    # Done! We go ahead and build.
    system "make", "-C", "ace/SSL", "-f", "GNUmakefile.SSL",
                   "INSTALL_PREFIX=#{prefix}",
                   "LIBCHECK_PREFIX=/usr/local",
                   "LDFLAGS=",
                   "DESTDIR=",
                   "INST_DIR=/ace/SSL",
                   "debug=0",
                   "shared_libs=1",
                   "static_libs=0",
                   "ssl=1",
                   "install"
    
  end

end
