# Firebase Tools (Docker)

This is a simple Docker image providing the Firebase tools CLI. It's particularly handy for using the emulators (see example below).

The resulting images are published to: https://hub.docker.com/r/crashdump/firebase-tools

## How To

### Firebase Emulation (Docker Compose)

```
firebase:
    image: crashdump/firebase-tools:13.0.1
    args:
    - emulators:start
    - --project demo-local
    restart: on-failure
    volumes:
    - .:/opt:rw
    healthcheck:
        test: curl --fail http://localhost:4000
        interval: 10s
        retries: 5
        start_period: 10s
        timeout: 2s
    ports:
    - "127.0.0.1:4000:4000/tcp" # ui
    - "127.0.0.1:9099:9099/tcp" # fireauth
    - "127.0.0.1:8080:8080/tcp" # firestore
    - "127.0.0.1:9199:9199/tcp" # storage
```

### CLI (Docker)

```
$ docker run --rm -ti crashdump/firebase-tools:13.0.2 help

    Usage: firebase [options] [command]

    Options:
    -V, --version                                                  output the version number
    -P, --project <alias_or_project_id>                            the Firebase project to use for this command
    --account <email>                                              the Google account to use for authorization
    -j, --json                                                     output JSON instead of text, also triggers non-interactive mode
    --token <token>                                                DEPRECATED - will be removed in a future major version - supply an auth token for this command
    --non-interactive                                              error out of the command instead of waiting for prompts
    -i, --interactive                                              force prompts to be displayed
    --debug                                                        print verbose debug output and keep a debug log file
    -c, --config <path>                                            path to the firebase.json file to use for configuration
    -h, --help                                                     output usage information

    Commands:
    appdistribution:distribute [options] <release-binary-file>     upload a release binary
    appdistribution:testers:add [options] [emails...]              add testers to project (and possibly group)
    appdistribution:testers:remove [options] [emails...]           remove testers from a project (or group)

    [...]
```

### Build

All you have to do is push a tag of the Firebase Tools version you'd like.
