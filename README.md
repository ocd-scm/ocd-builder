# ocd-builder

ocd-builder is a generic heml chart to s2i build your code in git into an container image. It can also add a docker tag to the built image that matches the git tag. This can be triggered by a git webhook configured to push an event to ocd-builder-webook. Together they implement this story for building:

```
Given a developer wants to create a release of an application 
When they create a git release $TAG of the code that matches a regular expression
Then an OCD webhook will catch the git webhook event and run an s2i build
And will apply $TAG to the built container image within the registry
```

Most people are familiar with `push` events that do CI builds. The event that we want to respond to is a `release` event. This is fired on any of:

 1. `hub release -m 'my release' v1.2.3`
 2. Using the web interface to create a release with a tag `v1.2.3`

This will fire a release webhook event and create a tag that you can pull from the server. What we want to do is make a container image of the code at tag `v1.2.3` and give it the docker tag `v1.2.3`. Then we can use the other features of OCD to move that tagged image to different environments. 

Many (if not the majority) of developers won’t be aware of the git release feature. There is a weaker definition of a release which is to push a release tag that matches some pattern (e.g., `/v.*/` or `/.*-RELEASE/`). That will generate a different type of webook event. You might not have noticed that there are three styles of git tags you can use: lightweight, annotated and signed. OCD plans to support all these release defintions. The OCD default has a few advantages so we suggest you create release if those are supported by you git server (e.g., GitHub, Gitea). 

![alt text][ocd-build-components]

[ocd-build-components]: https://github.com/ocd-scm/ocd-meta/blob/master/imgs/ocd-builder.png?raw=true "OCD Builder Components"

## Usage

See `examples/realworld.io/realworld-demo.sh`

## See Also

The [ocd-meta wiki](https://github.com/ocd-scm/ocd-meta/wiki)

The [s2i](https://github.com/openshift/source-to-image/blob/master/README.md) documentation and how to [customise s2i builds](https://docs.openshift.com/container-platform/3.11/using_images/s2i_images/customizing_s2i_images.html) on OKD

https://github.com/ocd-scm/ocd-builder-webhook
