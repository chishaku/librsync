#! /bin/sh -pex

# Regression test suite for libhsync.

# OK, this is how we test feeding hsync it's own filth.  Starting
# with an empty signature, we generate the difference from one
# file to another.

if [ "$srcdir" = "" ]
then
    srcdir=`dirname $0`
fi
srcdir=`cd $srcdir; pwd`

PATH=$srcdir:$PATH
cd $srcdir/test-chain

diff=diff.tmp
files=$srcdir/*.c*
newsig=newsig.tmp
out=out.tmp
oldsig=empty-sig
old=/dev/null

for new in $files
do
    hsencode $new $diff $oldsig
    hsdecode $old $newsig $out $diff 

    cmp $out $new
done
