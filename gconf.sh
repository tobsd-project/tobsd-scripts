#!/usr/bin/env bash
cp 20_my-settings.gschema.override /usr/local/share/glib-2.0/schemas/
glib-compile-schemas /usr/local/share/glib-2.0/schemas/
