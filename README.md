# docker

some files of docker

[Aliyun 容器镜像服务](https://cr.console.aliyun.com/cn-hangzhou/instance/dashboard)

如果在`Aliyun容器镜像服务`上因超限无法构建镜像的话, 可以通过本地构建镜像再上传, 需要翻墙 Clash Pro 开启'增强模式'

```
docker build -f python/Dockerfile-3.13-alpine -t registry.cn-hangzhou.aliyuncs.com/hylinksh/python:3.13.2-alpine .
docker push registry.cn-hangzhou.aliyuncs.com/hylinksh/python:3.13.2-alpine
```
