##############################################################################
##                                                                          ##
##                              AXMPP Project                               ##
##                                                                          ##
##                           XMPP Library for Ada                           ##
##                                                                          ##
##############################################################################
##                                                                          ##
## Copyright © 2011, Alexander Basov <coopht@gmail.com>                     ##
## All rights reserved.                                                     ##
##                                                                          ##
## Redistribution and use in source and binary forms, with or without       ##
## modification, are permitted provided that the following conditions       ##
## are met:                                                                 ##
##                                                                          ##
##  * Redistributions of source code must retain the above copyright        ##
##    notice, this list of conditions and the following disclaimer.         ##
##                                                                          ##
##  * Redistributions in binary form must reproduce the above copyright     ##
##    notice, this list of conditions and the following disclaimer in the   ##
##    documentation and/or other materials provided with the distribution.  ##
##                                                                          ##
##  * Neither the name of the Alexander Basov, IE nor the names of its      ##
##    contributors may be used to endorse or promote products derived from  ##
##    this software without specific prior written permission.              ##
##                                                                          ##
## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      ##
## "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        ##
## LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    ##
## A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT     ##
## HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,   ##
## SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED ##
## TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR   ##
## PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF   ##
## LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     ##
## NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS       ##
## SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.             ##
##                                                                          ##
##############################################################################
##  $Revision$ $Date$
##############################################################################

PREFIX = /usr/local/

all: compile install

compile:
	gprbuild -p -Pgnat/agnutls.gpr
	gprbuild -p -Pgnat/axmpp.gpr
	gprbuild -p -Pgnat/con_cli.gpr

install: uninstall
	gprinstall --prefix=$(PREFIX) -p gnat/agnutls.gpr
	gprinstall --prefix=$(PREFIX) -p gnat/axmpp.gpr
	gprinstall --prefix=$(PREFIX) -p gnat/con_cli.gpr

clean:
	gprclean -Pgnat/agnutls.gpr
	gprclean -Pgnat/axmpp.gpr
	gprclean -Pgnat/con_cli.gpr

.IGNORE: uninstall
uninstall: 
	gprinstall --uninstall --prefix=$(PREFIX) -p gnat/agnutls.gpr
	gprinstall --uninstall --prefix=$(PREFIX) -p gnat/axmpp.gpr
	gprinstall --uninstall --prefix=$(PREFIX) -p gnat/con_cli.gpr
