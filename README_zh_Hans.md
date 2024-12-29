<!--
注意：此 README 由 <https://github.com/YunoHost/apps/tree/master/tools/readme_generator> 自动生成
请勿手动编辑。
-->

# YunoHost 上的 Restic

[![集成程度](https://dash.yunohost.org/integration/restic.svg)](https://ci-apps.yunohost.org/ci/apps/restic/) ![工作状态](https://ci-apps.yunohost.org/ci/badges/restic.status.svg) ![维护状态](https://ci-apps.yunohost.org/ci/badges/restic.maintain.svg)

[![使用 YunoHost 安装 Restic](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=restic)

*[阅读此 README 的其它语言版本。](./ALL_README.md)*

> *通过此软件包，您可以在 YunoHost 服务器上快速、简单地安装 Restic。*  
> *如果您还没有 YunoHost，请参阅[指南](https://yunohost.org/install)了解如何安装它。*

## 概况

A [Restic](https://restic.net/) integration to backup your YunoHost server to an external location.

### Features

- backup data to remote storages (support for different types of storage: currently SFTP, S3 is planned)
- deduplication and compression of files, which makes it possible to keep many previous copies
- data encryption, which allows to store data at a third party

You can setup the Restic app several times on the same server so you can backup on several server or manage your frequency backup differently for specific part of your server.


**分发版本：** 0.12.0~ynh9
## 文档与资源

- 官方应用网站： <https://restic.net>
- 官方管理文档： <https://restic.readthedocs.io/en/latest/>
- 上游应用代码库： <https://github.com/restic/restic>
- YunoHost 商店： <https://apps.yunohost.org/app/restic>
- 报告 bug： <https://github.com/YunoHost-Apps/restic_ynh/issues>

## 开发者信息

请向 [`testing` 分支](https://github.com/YunoHost-Apps/restic_ynh/tree/testing) 发送拉取请求。

如要尝试 `testing` 分支，请这样操作：

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/restic_ynh/tree/testing --debug
或
sudo yunohost app upgrade restic -u https://github.com/YunoHost-Apps/restic_ynh/tree/testing --debug
```

**有关应用打包的更多信息：** <https://yunohost.org/packaging_apps>
