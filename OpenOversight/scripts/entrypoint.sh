#!/bin/bash
if [ "${HMR:-}" == "1" ]; then
    yarn watch --hmr-port 3001 &
else
    yarn build
fi
gunicorn -w 4 -b 0.0.0.0:3000 app:app
