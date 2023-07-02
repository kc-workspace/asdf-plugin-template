# asdf-plugin-template

This is an [asdf-vm plugin][asdf-plugins] template with CI support.

## Usage

1. Install [copier](copier)
2. Run `copier copy gh:kc-workspace/asdf-plugin-template.git ~/.asdf/plugins/xxxx`
3. To develop your plugin further, please read [plugins create section][asdf-create-plugin]

## Update

Once plugin has been created using this template.
later when this template updated, you can update your plugin using below command.

```bash
copier update ~/.asdf/plugins/xxxx
```

## Development

1. Install [copier](copier)
2. Run `copier --vcs-ref HEAD . ./.temp` for local development

<!-- LINKS -->

[asdf-plugins]: https://asdf-vm.com/manage/plugins.html
[asdf-create-plugin]: https://asdf-vm.com/plugins/create.html
[copier]: https://copier.readthedocs.io/en/stable/#installation
