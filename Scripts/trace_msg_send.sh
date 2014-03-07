#!/usr/sbin/dtrace -s
#pragma D option quiet

/* from http://chen.do/blog/2013/10/22/reverse-engineering-xcode-with-dtrace/ */

/* usage:  sudo ./trace_msg_send.sh -p <pid of app> <objc class> */

unsigned long long indention;
int indentation_amount;

BEGIN {
  indentation_amount = 4;
}

objc$target:$1::entry
{
    method = (string)&probefunc[1];
    type = probefunc[0];
    class = probemod;
    printf("%*s%s %c[%s %s]\n", indention * indentation_amount, "", "->", type, class, method);
    indention++;
}
objc$target:$1::return
{
    indention--;
    method = (string)&probefunc[1];
    type = probefunc[0];
    class = probemod;
    printf("%*s%s %c[%s %s]\n", indention * indentation_amount, "", "<-", type, class, method);
}
