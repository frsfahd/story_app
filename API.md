# API Docs

> use [httpie](https://httpie.io/) !

### Register
```bash
https POST story-api.dicoding.dev/v1/register \
    name=username \
    email=user@email.com \
    password=password
```


### Login
```bash
https POST story-api.dicoding.dev/v1/login \
    email=user@email.com \
    password=password
```

### List All Stories
```bash
https -A bearer -a <token> GET story-api.dicoding.dev/v1/stories 
```

### Detail Story
```bash
https POST story-api.dicoding.dev/v1/stories/<:id>
```

### Add New Story
```bash
https -A bearer -a <token> --multipart POST story-api.dicoding.dev/v1/stories \
    description=string \
    photo@file \
    lat=12.3 \
    lon=12.3
```

### Add New Story (Guest)
```bash
https --multipart POST story-api.dicoding.dev/v1/stories/guest \
    description=string \
    photo@file \
    lat=12.3 \
    lon=12.3
```