#
# for use with HTTPie
#
#

# register endpoint (name, email, password)
http POST https://story-api.dicoding.dev/v1/register \
name=pendudukbumi \
email=pendudukbumi2000@gmail.com \
password=password321



# login endpoint (email,password)
http POST https://story-api.dicoding.dev/v1/login \
> email=pendudukbumi2000@gmail.com \
> password=password321

# get alll stories
http GET https://story-api.dicoding.dev/v1/stories
