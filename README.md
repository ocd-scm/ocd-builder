# ocd-builder

ocd-builder is a generic heml chart to s2i build your code in git into an container image. It can also add a docker tag to the built image that matches the git tag. This can be triggered by a git release webhook configured to push an event to ocd-builder-webook. 

![alt text][ocd-build-components]

[ocd-build-components]: https://github.com/ocd-scm/ocd-meta/blob/master/imgs/ocd-builder.png?raw=true "OCD Builder Components"

## Usage

See `examples/realworld.io/realworld-demo.sh`

## See Also

The [ocd-meta wiki](https://github.com/ocd-scm/ocd-meta/wiki)

The [s2i](https://github.com/openshift/source-to-image/blob/master/README.md) documentation and how to [customise s2i builds](https://docs.openshift.com/container-platform/3.11/using_images/s2i_images/customizing_s2i_images.html) on OKD

https://github.com/ocd-scm/ocd-builder-webhook
