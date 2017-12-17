#!/bin/sh

chown -R chronograf:chronograf /var/lib/chronograf
exec su-exec chronograf chronograf -b /var/lib/chronograf/chronograf.db