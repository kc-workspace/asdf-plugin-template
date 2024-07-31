# Changelog

## [2.7.3](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.7.2...v2.7.3) (2024-07-31)


### Bug Fixes

* **script:** support template version when writing commit message ([b31297c](https://github.com/kc-workspace/asdf-plugin-template/commit/b31297cf3dd252109e15ab2f669924f8da8218c6))

## [2.7.2](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.7.1...v2.7.2) (2024-07-31)


### Bug Fixes

* **template:** update linter complain on ci and variable unused ([ff43fd9](https://github.com/kc-workspace/asdf-plugin-template/commit/ff43fd96fb8c38f7a67d8f418afc02e6bf03fb22))

## [2.7.1](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.7.0...v2.7.1) (2024-07-31)


### Performance Improvements

* **template:** add kc_asdf_tags_contains on tag addon to use with if condition to check is version exist or not ([0b0ea3a](https://github.com/kc-workspace/asdf-plugin-template/commit/0b0ea3af2461f8e4f1671c17b8b99715528d3bba))
* **template:** kc_asdf_tags_list_installed now support first args as version filtering ([b5a9a0c](https://github.com/kc-workspace/asdf-plugin-template/commit/b5a9a0c4b45a5e6fe1b742ce03734bc743bdbab6))

## [2.7.0](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.6.3...v2.7.0) (2024-07-31)


### Features

* **template:** add KC_ASDF_PLUGIN_* variables for plugin information ([6187c8c](https://github.com/kc-workspace/asdf-plugin-template/commit/6187c8c3bbebaca3198af8cc7444e7f90a353c5e))
* **template:** add new KC_ASDF_PLUGIN_NAME variable to all scripts ([ee76568](https://github.com/kc-workspace/asdf-plugin-template/commit/ee76568ef2816494ef3c37c27284cb71b3a52b1d))


### Bug Fixes

* **linter:** update linter configs ([8e104f8](https://github.com/kc-workspace/asdf-plugin-template/commit/8e104f81f961076811f2d8c3692170dae19dc88c))


### Performance Improvements

* **plugin:** add opentufu as managed plugin ([ea87b5e](https://github.com/kc-workspace/asdf-plugin-template/commit/ea87b5e994847ebb21e5a06223744283d7f21011))
* **template:** add new KC_ASDF_CORE_PATH variable resolved to where asdf is ([d8ce2e0](https://github.com/kc-workspace/asdf-plugin-template/commit/d8ce2e0595695a23097375fe4a6160346f9779e8))
* **template:** add new kc_asdf_tags_list_installed on tags addon to list installed tags on local machine ([582c9a3](https://github.com/kc-workspace/asdf-plugin-template/commit/582c9a31baffb0c6e8ea86fb5accdc3cc5f4a516))

## [2.6.3](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.6.2...v2.6.3) (2024-07-11)


### Performance Improvements

* **script:** add fast mode to skip all slow actions ([cd8eaf0](https://github.com/kc-workspace/asdf-plugin-template/commit/cd8eaf0b4921d90e41fe5577b432cb2bcb7cb2ba))
* **template:** add debug logs on is_* functions ([994b2a9](https://github.com/kc-workspace/asdf-plugin-template/commit/994b2a9332e167cd02d94bb63f32ad9d180260d1))
* **template:** add new init.sh script for set up custom function ([7ce9b73](https://github.com/kc-workspace/asdf-plugin-template/commit/7ce9b73aea59f54ce57f6473194982d0f68e686b))
* **template:** get system functions will always use latest data ([ac05edc](https://github.com/kc-workspace/asdf-plugin-template/commit/ac05edcdcbb7a7b559256a3a8f793489f30b5ceb))
* **template:** the kc_asdf_is_* function in system.sh will always fetch latest data ([2410835](https://github.com/kc-workspace/asdf-plugin-template/commit/24108359de75c6a649d90eb9069d13fe69211ec5))

## [2.6.2](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.6.1...v2.6.2) (2024-07-11)


### Bug Fixes

* **template:** fix shellcheck warning ([fb3c9ee](https://github.com/kc-workspace/asdf-plugin-template/commit/fb3c9ee60d8366f60a3a34664c6f590ec86f81ac))
* **template:** move utils.sh first because utils needed for common script ([1f6e91e](https://github.com/kc-workspace/asdf-plugin-template/commit/1f6e91e64790781a1c6915152ddf80773b55505d))


### Performance Improvements

* **scripts:** update commit syntax when update from template ([a64ce32](https://github.com/kc-workspace/asdf-plugin-template/commit/a64ce32f4bcf66aaee367369a31be598923fc8c9))

## [2.6.1](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.6.0...v2.6.1) (2024-07-10)


### Bug Fixes

* **lint:** update cspell dict to include pomerium ([b287938](https://github.com/kc-workspace/asdf-plugin-template/commit/b287938a2c79c65d54ad4f7164de46c39fe202e2))
* **templates:** move utils.sh load to after common command so we can load addon file on utils ([b5c4a85](https://github.com/kc-workspace/asdf-plugin-template/commit/b5c4a857f191e30480df7c09ee02423834458e61))
* **templates:** post install always return error when no custom post install function defined ([a3736b1](https://github.com/kc-workspace/asdf-plugin-template/commit/a3736b1c8b818e73175887f6bbad81d87a26d0bc))

## [2.6.0](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.5.1...v2.6.0) (2024-07-10)


### Features

* add new callback `_kc_asdf_custom_post_install` when post install ([5577194](https://github.com/kc-workspace/asdf-plugin-template/commit/55771948318ed2b495f1ed913313b85cfe88efe4))
* add new features called 'github_latest' ([41ddb26](https://github.com/kc-workspace/asdf-plugin-template/commit/41ddb26ca09696b90cf15f3484ed1e04eea6388c))
* **plugin:** add new codecrafter cli plugin ([1e882b0](https://github.com/kc-workspace/asdf-plugin-template/commit/1e882b040a6c0a29d62a1b9545e6037f6650f29d))


### Bug Fixes

* **addons:** when sorting tags we always calculate as number ([1473bf2](https://github.com/kc-workspace/asdf-plugin-template/commit/1473bf27fc82ec312ca13d3d0d0f4f40c9e4eeb0))
* channel didn't resolve correctly ([e7d5f07](https://github.com/kc-workspace/asdf-plugin-template/commit/e7d5f07e6b2cfe8e3ea8d4e6807cac2980b79306))
* **script:** --default-branch didn't works because new created repo didn't have branch yet ([3bc2721](https://github.com/kc-workspace/asdf-plugin-template/commit/3bc2721edb7b9e9721a3a06f5f6ecd083627d38b))
* **script:** disable plugin test on script because it won't works on local development plugin ([a0b8e89](https://github.com/kc-workspace/asdf-plugin-template/commit/a0b8e8907ef3e294f640b5ebb16592f1dc77e6f1))
* **template:** arch should mapping to arch yaml file ([b9642da](https://github.com/kc-workspace/asdf-plugin-template/commit/b9642daa9d37235995a38f34d3119e216f877648))
* **templates:** --strip-components only add when needed ([cdc2525](https://github.com/kc-workspace/asdf-plugin-template/commit/cdc252588d422fcc2d7896dd90c8b1719b9ff354))
* **template:** support xz file ([d7e29d4](https://github.com/kc-workspace/asdf-plugin-template/commit/d7e29d44ad877419622c4451e8719f7e4f45cfd5))
* **template:** tar didn't get correct path ([331df5c](https://github.com/kc-workspace/asdf-plugin-template/commit/331df5cbcb629952045dcdae965881c727778d11))
* update invalid template ([a46ba6f](https://github.com/kc-workspace/asdf-plugin-template/commit/a46ba6fdd4fe34a3c4a95f69ea4896aa1de980dc))
* update linter ([2d50078](https://github.com/kc-workspace/asdf-plugin-template/commit/2d50078fea83e97922c812e43e17338c6717fd56))


### Performance Improvements

* move version channel to download addon instead ([d288c50](https://github.com/kc-workspace/asdf-plugin-template/commit/d288c50c8e6fe5382eafa93d80f19c0f2b25d8e0))
* **plugin:** add pomerium-cli to managed plugin ([097c363](https://github.com/kc-workspace/asdf-plugin-template/commit/097c3639cf9e48a25a7fadfa141df0ad6ca5a68e))
* **scripts:** add --help options to dev.sh script ([d834e22](https://github.com/kc-workspace/asdf-plugin-template/commit/d834e22963fc445af8ccde45ee4bfabb6e1ce37d))
* support version channel (only stable and beta for now) ([a0b1acb](https://github.com/kc-workspace/asdf-plugin-template/commit/a0b1acb497b46c4564b6dd148c3089826f166928))
* **template:** add debug logs when user force download resources ([abf64f9](https://github.com/kc-workspace/asdf-plugin-template/commit/abf64f986903b22bb47ca9721556b5fd3c1f5eb9))
* **template:** os and arch is now always existed even it empty ([ddcf20f](https://github.com/kc-workspace/asdf-plugin-template/commit/ddcf20f9afe3c9ad7f9332970f071bafa1ec30b7))

## [2.5.1](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.5.0...v2.5.1) (2024-03-04)


### Bug Fixes

* missing new dict on all plugins cause ci to fail ([266865c](https://github.com/kc-workspace/asdf-plugin-template/commit/266865c9ee9eff63d1979daa49fbda022fac7df8))

## [2.5.0](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.4.0...v2.5.0) (2024-03-04)


### Features

* **script:** use plugin-test instead of manually test ([5dc170e](https://github.com/kc-workspace/asdf-plugin-template/commit/5dc170e0a1c1a4d4443c4360cb1ca6f1ef3a77b3))
* **template:** add list of possible command with `asdf &lt;plugin&gt; <cmd>` ([f96f99b](https://github.com/kc-workspace/asdf-plugin-template/commit/f96f99b2666ffe8e6f3f9d806f342be8d031df63))
* use gpg url instead of processed file name ([76f333d](https://github.com/kc-workspace/asdf-plugin-template/commit/76f333d95a6175e6c535c8e5e4a52f3e6e2d24c6))


### Bug Fixes

* **script:** plugin test should not hard coded command name ([d772ae9](https://github.com/kc-workspace/asdf-plugin-template/commit/d772ae9d8c7c9f9d29191be8c729f95bae1206ec))
* **template:** kc_asdf_optional didn't silently ignore command if not exist ([bbc7f65](https://github.com/kc-workspace/asdf-plugin-template/commit/bbc7f653a262adb4cde580c0357f967eab9bff18))
* update cspell dict to support cli name ([0befbbb](https://github.com/kc-workspace/asdf-plugin-template/commit/0befbbb70de00d9599135f0d84975554e7909b02))


### Performance Improvements

* improve help with extra commands ([a592f97](https://github.com/kc-workspace/asdf-plugin-template/commit/a592f971be3cd90a216c560f76463326a875a319))
* **templates:** testing version on `asdf &lt;plugin&gt; version` command ([56c209c](https://github.com/kc-workspace/asdf-plugin-template/commit/56c209cbb269654ce27c97643bb11f4d7ff8089f))
* **template:** support get plugin version from custom command (asdf &lt;tool&gt; version) ([f641c71](https://github.com/kc-workspace/asdf-plugin-template/commit/f641c71ef2b8f9e295453259509ab005c04101da))

## [2.4.0](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.3.1...v2.4.0) (2024-02-29)


### Features

* **plugin:** add new gomplate plugin ([4638009](https://github.com/kc-workspace/asdf-plugin-template/commit/4638009f0b5dc8758584a291e14624dfcaab877b))
* **script:** add kubeconform cli to managed by template ([5142377](https://github.com/kc-workspace/asdf-plugin-template/commit/5142377ec2292e3f9e504a9c49b1b6715d605e9f))


### Bug Fixes

* copier config failed on copier version 9+ ([5902bd6](https://github.com/kc-workspace/asdf-plugin-template/commit/5902bd6868e2390094410b720d1f7c2459749b7d))
* **script:** first run always failed because tmp directory is missing ([9ea6eee](https://github.com/kc-workspace/asdf-plugin-template/commit/9ea6eee62c48dafbc19025037dbc7765e4fe9b24))


### Performance Improvements

* **script:** print all enabled features when start dev script ([693776a](https://github.com/kc-workspace/asdf-plugin-template/commit/693776a6670d56ac558792acd2b86215396c93ef))
* **script:** support standalone copier command as well as python module ([f4f83c0](https://github.com/kc-workspace/asdf-plugin-template/commit/f4f83c0b6b2ab14e927471764e1bf8314a8ce292))

## [2.3.1](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.3.0...v2.3.1) (2023-12-06)


### Bug Fixes

* **ci:** release-type need to set for release-please to resolve manifest from config ([a253b94](https://github.com/kc-workspace/asdf-plugin-template/commit/a253b942c28b56c24a712e43f7fa951ed39405ea))
* **ci:** remove manifest json because it seem to cause version not update ([3eacc33](https://github.com/kc-workspace/asdf-plugin-template/commit/3eacc3386ce3fe114efa9d17339a03ca215691a1))


### Performance Improvements

* **ci:** upgrade release-please-action from v3 to v4 ([8e2aced](https://github.com/kc-workspace/asdf-plugin-template/commit/8e2acedbbd45d40cf7fdfb8c5ac2ce98a4779fe4))
* **component:** add operator-sdk as managed plugin ([2121eb1](https://github.com/kc-workspace/asdf-plugin-template/commit/2121eb19bf6b59b7390bfe110a8e5106586afe0e))
* **components:** add asdf-eksctl to managed by template ([2c9c60b](https://github.com/kc-workspace/asdf-plugin-template/commit/2c9c60b863e23a173954155cf11f8f33d1632a52))

## [2.3.0](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.2.7...v2.3.0) (2023-11-20)


### Features

* **script:** add ansible to plugin maintainers ([63592bd](https://github.com/kc-workspace/asdf-plugin-template/commit/63592bdc3936bc8f7b599791bd61b3daca450ef9))


### Improvements

* **components:** add ansible-core as maintaining packages ([a3d2488](https://github.com/kc-workspace/asdf-plugin-template/commit/a3d248880265b8339a30609a71d77ed1393d8d6c))


### Bugfixes

* **script:** dev.sh error '_PATH_TMP: parameter null or not set' on first run ([a67bf84](https://github.com/kc-workspace/asdf-plugin-template/commit/a67bf84dd8b8c0d0d6d6e3ea3b2688b327bf1e17))
* **template:** on python type, python name should be used for install python package ([06045c2](https://github.com/kc-workspace/asdf-plugin-template/commit/06045c2349d01c8c8053e2d5453a58c24e553772))

## [2.2.7](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.2.6...v2.2.7) (2023-11-19)


### Improvements

* **deps:** upgrade cspell-action from v4 to v5 ([5893766](https://github.com/kc-workspace/asdf-plugin-template/commit/5893766bc4c3ad4103da2b4df2c945569eacfbb3))
* **script:** add features message on start info ([5009c7a](https://github.com/kc-workspace/asdf-plugin-template/commit/5009c7af7cbc2a7b408de015c9625cde16680e5b))


### Bugfixes

* **script:** add --set-upstream on git push to set up first time branch publish ([23e195e](https://github.com/kc-workspace/asdf-plugin-template/commit/23e195e3bdd17464b3c710d113630b7bbf4cb6f6))
* **script:** add latest version when completed successfully ([c0aaeae](https://github.com/kc-workspace/asdf-plugin-template/commit/c0aaeaed03a9b9a72021ae1e336d72c8384cb85e))
* **script:** get-latest should not fail on dryrun mode ([03397e5](https://github.com/kc-workspace/asdf-plugin-template/commit/03397e503fbb2931832e545ca67cc69dfb0a43e1))


### Miscellaneous

* **script:** add goreleaser to template maintainer ([b56332b](https://github.com/kc-workspace/asdf-plugin-template/commit/b56332b21423572f1abbf7000dbf51df73676fd5))

## [2.2.6](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.2.5...v2.2.6) (2023-11-06)


### Bugfixes

* **template:** cannot generate because no value mask found ([8521571](https://github.com/kc-workspace/asdf-plugin-template/commit/85215710e45a44899450c74ac52d8ad2d43f07f7))

## [2.2.5](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.2.4...v2.2.5) (2023-11-06)


### Improvements

* **ci:** add GITHUB_TOKEN to report lint results ([3f6cb0f](https://github.com/kc-workspace/asdf-plugin-template/commit/3f6cb0ffcfb2ac7ef718aa85135f0d9af52f0531))
* **ci:** upgrade github actions ([2f7406b](https://github.com/kc-workspace/asdf-plugin-template/commit/2f7406b71ba11169a2296f6caa03263d1b3f1013))
* **script:** testing must depends on install steps ([69d549e](https://github.com/kc-workspace/asdf-plugin-template/commit/69d549e133eda26f058b7748401dce108128d8ac))
* **script:** use tail instead of error message ([1b50558](https://github.com/kc-workspace/asdf-plugin-template/commit/1b50558fc425e55b4f549fd333d29dd9a76f2774))


### Bugfixes

* **script:** dev.sh error on create new plugin ([d60dc58](https://github.com/kc-workspace/asdf-plugin-template/commit/d60dc580cb07cc22f81a2f59466a2df3aa20b0cd))


### Miscellaneous

* **script:** remove unused functions ([166b66c](https://github.com/kc-workspace/asdf-plugin-template/commit/166b66ce3d40fa58e95194557c654672c80b71c3))

## [2.2.4](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.2.3...v2.2.4) (2023-09-17)


### Improvements

* **script:** git add, commit and push now skipping if local git has no change ([e3325c8](https://github.com/kc-workspace/asdf-plugin-template/commit/e3325c8926f8df278157e21a26b2194569136a51))
* **script:** promote dev-v2 to dev.sh ([3affb98](https://github.com/kc-workspace/asdf-plugin-template/commit/3affb98a83a3b6e743867ab92cecec7b5b4b5e2d))
* **script:** refactor dev.sh with easier to extends and possible with list of verifiers ([83134e8](https://github.com/kc-workspace/asdf-plugin-template/commit/83134e897c71cde2ca5a44f6ca58010e7623b10a))
* **script:** remove _func and _args as logging is easier to access ([0e19e4b](https://github.com/kc-workspace/asdf-plugin-template/commit/0e19e4b4c6dd160dd0b986580dd91a10f949889d))


### Bugfixes

* **checksum:** when platform doesn't contains shaXXXsum commands pass --algorithm to shasum command as well ([93729a8](https://github.com/kc-workspace/asdf-plugin-template/commit/93729a8d63ed1cfaa2447b01d7d6140029cbac74))
* **script:** command should use __exec as command executor to use predefine script instead of system script ([7c62e22](https://github.com/kc-workspace/asdf-plugin-template/commit/7c62e22fc211c60c9b38c1919b433a9882b2345e))
* **script:** duplicate code detected ([e8c7d29](https://github.com/kc-workspace/asdf-plugin-template/commit/e8c7d2990a5a895fc08a00bbaeac96a000650e29))
* **script:** testing should depends on get-latest step ([0efa8a5](https://github.com/kc-workspace/asdf-plugin-template/commit/0efa8a5e1af9a814e460ff4e8eaf713926df6149))
* **script:** verifying asdf-install should follow symlink as well ([6163378](https://github.com/kc-workspace/asdf-plugin-template/commit/61633788adf2e3d3d189c62526fc4c34133f6dfc))
* **script:** wait workflow didn't works as expected ([7f927b5](https://github.com/kc-workspace/asdf-plugin-template/commit/7f927b588ffc0db63fb1fe62f670b190a88bca02))


### Miscellaneous

* **dev:** support custom branch name on each component ([27ff80f](https://github.com/kc-workspace/asdf-plugin-template/commit/27ff80fc6ee0bfa2864cad07b4aba7af8d801f00))
* save progress ([cc780ec](https://github.com/kc-workspace/asdf-plugin-template/commit/cc780ec89b12047507a2a5e34d68874ef2816224))
* save progress ([bc34a12](https://github.com/kc-workspace/asdf-plugin-template/commit/bc34a126e57c829c8fd206ce921f9a679603321d))
* **script:** comments check message when expected step is not success ([23601bc](https://github.com/kc-workspace/asdf-plugin-template/commit/23601bc649d688e64d25312894289b7ff9a14217))

## [2.2.3](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.2.2...v2.2.3) (2023-09-15)


### Improvements

* **deps:** upgrade actions/checkout to v4 ([7a71571](https://github.com/kc-workspace/asdf-plugin-template/commit/7a715719ebb767ad2e739152ecbd1278d82fc424))
* **script:** add 2 new packages and add list size per apps configure ([9cb11c8](https://github.com/kc-workspace/asdf-plugin-template/commit/9cb11c8e871ec45f6a8ce21417150ba3ccd5cd67))
* **template:** add 2 new settings: $ASDF_LOG_QUIET and $ASDF_LOG_SILENT ([91dbefa](https://github.com/kc-workspace/asdf-plugin-template/commit/91dbefa54227f7935740349a5a20813e811b8b8e))


### Bugfixes

* **script:** silently ignore if git pull failed because never pushes before ([5a6c1a6](https://github.com/kc-workspace/asdf-plugin-template/commit/5a6c1a6b9b86c6a502e6402c3641aa40047a2f5a))


### Miscellaneous

* **deps:** bump actions/checkout from 3 to 4 ([#26](https://github.com/kc-workspace/asdf-plugin-template/issues/26)) ([2c06801](https://github.com/kc-workspace/asdf-plugin-template/commit/2c068015fad9f9a312a4e322c20cced291ef262b))
* **script:** pull latest before commit new change ([94abdba](https://github.com/kc-workspace/asdf-plugin-template/commit/94abdba5512f8b958f9e4945d2e8bf56f47536e0))

## [2.2.2](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.2.1...v2.2.2) (2023-08-22)


### Bugfixes

* **lint:** update terminology in output README ([8f7d92f](https://github.com/kc-workspace/asdf-plugin-template/commit/8f7d92f568aa1c47881f3f08d95443c541e8b0c0))

## [2.2.1](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.2.0...v2.2.1) (2023-08-22)


### Bugfixes

* **lint:** readme terminology error ([1f06c4b](https://github.com/kc-workspace/asdf-plugin-template/commit/1f06c4b1bfe6129861ad947995395b09f7961138))


### Miscellaneous

* add k6 to component list for development ([74aace9](https://github.com/kc-workspace/asdf-plugin-template/commit/74aace9f5a558822a1f3e31acee41f55198d0166))

## [2.2.0](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.1.1...v2.2.0) (2023-08-22)


### Features

* **download:** support custom how to download source code ([b821ca1](https://github.com/kc-workspace/asdf-plugin-template/commit/b821ca17a5b2e2ccaebe1bcac25569f691c88d0f))


### Improvements

* **script:** increase start  workflow wait time from 5s to 30s ([3e26a87](https://github.com/kc-workspace/asdf-plugin-template/commit/3e26a875ff0aa47cfef84f9ebea4b20642ea7925))
* **template:** support override git repository url when building from source (ref mode) ([ca7d16e](https://github.com/kc-workspace/asdf-plugin-template/commit/ca7d16ecb9b47ced2db5f918b05844ec0653964a))


### Bugfixes

* remove internal require function and use `kc_asdf_commands()` instead ([2ec3988](https://github.com/kc-workspace/asdf-plugin-template/commit/2ec3988586a182f9ac822dc3b218214b4599bb9a))


### Miscellaneous

* manually update cspell action ([3fab968](https://github.com/kc-workspace/asdf-plugin-template/commit/3fab96801673e47bde550cab61e567c957bd12eb))

## [2.1.1](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.1.0...v2.1.1) (2023-07-27)


### Improvements

* **script:** add wait and single mode in dev.sh ([752101a](https://github.com/kc-workspace/asdf-plugin-template/commit/752101a2f9ae4e5db575f4eba9ee1956038aa15d))


### Bugfixes

* **template:** support ignore fingerprint on copier configs ([ebb1de2](https://github.com/kc-workspace/asdf-plugin-template/commit/ebb1de23a3fbbb74576de962cf70dac2683a33f1))

## [2.1.0](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.0.3...v2.1.0) (2023-07-27)


### Features

* **template:** reimplement gpg function with public key registry support ([10a2a21](https://github.com/kc-workspace/asdf-plugin-template/commit/10a2a2142f0d57fef19830b0c8c2dddb0ec5648d))
* **template:** support custom tags version instead of use git list ([76d2119](https://github.com/kc-workspace/asdf-plugin-template/commit/76d211900e9011200492fbfb641ad7b1e1c56d33))
* **template:** support extension as variable template ([52f54ad](https://github.com/kc-workspace/asdf-plugin-template/commit/52f54ad429fe61d76e3f38f13732e883f0d2df33))


### Improvements

* always print session directory and data storage file ([b586bee](https://github.com/kc-workspace/asdf-plugin-template/commit/b586bee6eea8e279afdce06bf1eacd86d0a54884))
* **script:** reuse enabled and disable variable instead in dev.sh ([0d476c0](https://github.com/kc-workspace/asdf-plugin-template/commit/0d476c049571b0b6e80e799d17372a93b358cf39))
* **template:** add application website as help-links ([31c796f](https://github.com/kc-workspace/asdf-plugin-template/commit/31c796f41ee5c2dc5655bd5b354b0ef869f1d136))
* **template:** add default strip components on tar command ([ca336cc](https://github.com/kc-workspace/asdf-plugin-template/commit/ca336cc59e81bbf5f06073d65c3578d799b71132))


### Bugfixes

* **template:** archive and package error if internal is missing ([2137a6c](https://github.com/kc-workspace/asdf-plugin-template/commit/2137a6ca00dcd567855568e602f2de93ffd4a526))
* **template:** variables didn't define correctly ([f917265](https://github.com/kc-workspace/asdf-plugin-template/commit/f91726537ce67ad8c9b183a10f70461cb28ddacc))


### Miscellaneous

* add more spelling whitelist ([d905e36](https://github.com/kc-workspace/asdf-plugin-template/commit/d905e365cfc09d547a3a3dfb9b9340bf5985dea1))
* parse namespace to kc_asdf_main function as first parameters ([425d92f](https://github.com/kc-workspace/asdf-plugin-template/commit/425d92f968c816aac4fd8b0f771db4bb25b922cc))
* **script:** improve skip message ([daf2cc0](https://github.com/kc-workspace/asdf-plugin-template/commit/daf2cc0371b100206669ce1a1446fcafe3a54ea8))
* **script:** update some indent ([0270fd5](https://github.com/kc-workspace/asdf-plugin-template/commit/0270fd5c04766b9dd9f69ff4f437b80a6597161a))

## [2.0.3](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.0.2...v2.0.3) (2023-07-16)


### Bugfixes

* **linter:** ignore same headings content on CHANGELOG file ([2a15816](https://github.com/kc-workspace/asdf-plugin-template/commit/2a158168a596fa41d6d4892955cc7d735ce077a3))

## [2.0.2](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.0.1...v2.0.2) (2023-07-16)


### Improvements

* add gitignore on template output ([fc3688d](https://github.com/kc-workspace/asdf-plugin-template/commit/fc3688da1c2c8d6b49f1b801b1b69fb26a16d7b9))


### Miscellaneous

* **script:** support pulling change before git push ([8b88531](https://github.com/kc-workspace/asdf-plugin-template/commit/8b8853153991fd97df0c7cfbd8067793ee245728))


### Bugfixes

* **lint:** copy-paste detection errors ([f77f346](https://github.com/kc-workspace/asdf-plugin-template/commit/f77f3466ca70de52aa510021cab988b8a792d741))

## [2.0.1](https://github.com/kc-workspace/asdf-plugin-template/compare/v2.0.0...v2.0.1) (2023-07-15)


### Bugfixes

* **docs:** update changelog words ([74fc5dd](https://github.com/kc-workspace/asdf-plugin-template/commit/74fc5dd9da5605b1c0b737fc844b36a892736a83))
* invalid variable ([4b0de94](https://github.com/kc-workspace/asdf-plugin-template/commit/4b0de94a2a85fbfd0c6e681fbd463eaaf86b46a4))
* **script:** dev.sh didn't use github template and all steps will depends on previous steps ([29d3825](https://github.com/kc-workspace/asdf-plugin-template/commit/29d3825156667d24d8c5decde3930ac87863d1da))
* **template:** output cause linter issues ([649bf26](https://github.com/kc-workspace/asdf-plugin-template/commit/649bf261c4322e2d7991a47f0938e3ef5acfa33b))
* **template:** update template to avoid lint error on output ([d2e4e2f](https://github.com/kc-workspace/asdf-plugin-template/commit/d2e4e2f00f488961bdd8ad9011189d19b0e956c4))
* **template:** update template to avoid lint error on output ([4cf56eb](https://github.com/kc-workspace/asdf-plugin-template/commit/4cf56eb1dfb037514c77541682fc153676d85871))


### Improvements

* **github:** support github token on github api call ([06afbcd](https://github.com/kc-workspace/asdf-plugin-template/commit/06afbcd41b8b98a6d83d99853030813f8137a42f))
* **script:** support disable test when run dev.sh ([58996a8](https://github.com/kc-workspace/asdf-plugin-template/commit/58996a80ba4b6baba185af8ecc6db12f9008f3b7))

## [2.0.0](https://github.com/kc-workspace/asdf-plugin-template/compare/v1.3.3...v2.0.0) (2023-07-15)


### ⚠ BREAKING CHANGES

* **checksum:** change custom checksum callback to use $create function instead to ensure consistently
* initiate new major version

### Features

* **addon:** add more addon from default scripts so python type will smaller ([665ad54](https://github.com/kc-workspace/asdf-plugin-template/commit/665ad5468d01295bb02e0fad88898cba9cf12a5c))
* **checksum:** change custom checksum callback to use $create function instead to ensure consistently ([2bd7df6](https://github.com/kc-workspace/asdf-plugin-template/commit/2bd7df6c3b376fa4d83cf3daeb4fbe9fb9182e86))
* **core:** add ability to  disable some feature on some condition ([2db449a](https://github.com/kc-workspace/asdf-plugin-template/commit/2db449a923f3e0853de4d7c16e3346f2a66266b4))
* **core:** applied template [autocommit] ([dc975da](https://github.com/kc-workspace/asdf-plugin-template/commit/dc975dafe6e27d2368fecb05aa0a019555f12a8a))
* **core:** implement kc_asdf_gpg for verify gpg signature ([0401c79](https://github.com/kc-workspace/asdf-plugin-template/commit/0401c79f43ee843bd95e44b09b15bc9ad12bad98))
* implement new template ([dfc7062](https://github.com/kc-workspace/asdf-plugin-template/commit/dfc706224a7d99570b25e398127bbd6a79382891))
* initiate new major version ([66a5927](https://github.com/kc-workspace/asdf-plugin-template/commit/66a5927eca93323045a394c5b5c8d7d1e2097d0a))
* refined a lot of stuff ([6c9eab4](https://github.com/kc-workspace/asdf-plugin-template/commit/6c9eab48bcfe9667449da790483a3715ceb3d9eb))
* separate common/main.sh to several addon instead ([31ed5ea](https://github.com/kc-workspace/asdf-plugin-template/commit/31ed5ea0fcfe0162a50601c08d7476444afd0357))
* **source:** add function to support ref download type ([d7cc2fe](https://github.com/kc-workspace/asdf-plugin-template/commit/d7cc2fe9cfb607f54065a4f812c4be2ed3fae4d2))
* support create python plugin ([47d79fd](https://github.com/kc-workspace/asdf-plugin-template/commit/47d79fd55aea82ff3248765d6b84dc4345053031))
* support download from git repo ([3d91308](https://github.com/kc-workspace/asdf-plugin-template/commit/3d913086c008597b8a72fcf32bb8e6c9259286a3))
* support gpg public key as a link ([79115be](https://github.com/kc-workspace/asdf-plugin-template/commit/79115be78bceeece82bffed6f46ab47f23c344ab))
* support public key link and text ([fcda967](https://github.com/kc-workspace/asdf-plugin-template/commit/fcda96766a61456e24ec240438b3008a7c44694e))
* template new version to support customizable and more easier to debug ([cd0068d](https://github.com/kc-workspace/asdf-plugin-template/commit/cd0068d7a098b481addcf95d1fdd1873ddb226f6))


### Miscellaneous

* add full gitignore set ([11aa38e](https://github.com/kc-workspace/asdf-plugin-template/commit/11aa38e65ad9bcef2a40cc119e782fc63e93b174))
* add kind ([8ce1987](https://github.com/kc-workspace/asdf-plugin-template/commit/8ce198753e35ce1e9196794b3bb32fe72b4b1632))
* add more debug log what transfer input is ([251dfcd](https://github.com/kc-workspace/asdf-plugin-template/commit/251dfcd953d7f0cf1fee0c10e48d0662c60d26af))
* add more debug log when download cached found ([345b439](https://github.com/kc-workspace/asdf-plugin-template/commit/345b439c53d194709d3847ea0a445b79443e79c9))
* add more macro for reuse some code ([25e5185](https://github.com/kc-workspace/asdf-plugin-template/commit/25e5185e231398b77ab8638350b0b4758bee43b5))
* add other variable on help template ([65c1c39](https://github.com/kc-workspace/asdf-plugin-template/commit/65c1c397ea822445b8ec6c556941cc1b05f22b3c))
* **ci:** update filter regex ([552176a](https://github.com/kc-workspace/asdf-plugin-template/commit/552176a0fa3808df7efcc52fb65bae216674e682))
* clean code ([ff7528f](https://github.com/kc-workspace/asdf-plugin-template/commit/ff7528f32f1e2e7aaa39f1fb459d17092730e52a))
* cleanup copier tasks ([4b91b16](https://github.com/kc-workspace/asdf-plugin-template/commit/4b91b162a1226c381171f780d51114e3aa0ffd11))
* cleanup old template from v1 ([9edaaf1](https://github.com/kc-workspace/asdf-plugin-template/commit/9edaaf197114627cd57020267fd0869c7dceb196))
* improve log message for readability ([9f62e39](https://github.com/kc-workspace/asdf-plugin-template/commit/9f62e39c0a482e65652d7c6b7be6e393d8610835))
* md cannot stay on bin directory ([fd1fa7b](https://github.com/kc-workspace/asdf-plugin-template/commit/fd1fa7b30e6c62707052f708b84559d53122f471))
* re-enabled git commit and push ([9ab93d0](https://github.com/kc-workspace/asdf-plugin-template/commit/9ab93d00786752e1a80475e04b90a24e01da7136))
* save progress ([f55eb93](https://github.com/kc-workspace/asdf-plugin-template/commit/f55eb93da7cfd4b3c28efd07c483fe7fada6e28e))
* **script:** add jq to dev ([608b208](https://github.com/kc-workspace/asdf-plugin-template/commit/608b20807bddcfeaccf7aeb7341126c254991c97))
* update commit type ([6d4ccd2](https://github.com/kc-workspace/asdf-plugin-template/commit/6d4ccd241356833bb9371cf0c75cb4b6b7dceaf5))
* use --trust instead of --UNSAFE ([93d2eee](https://github.com/kc-workspace/asdf-plugin-template/commit/93d2eeee5d6a2b3c6f087c412a34029c1a218e41))
* use asdf instead of ASDF ([8e6b202](https://github.com/kc-workspace/asdf-plugin-template/commit/8e6b20240433d88d8f3bede68d75f7a11ce74973))
* use new super-linter repo instead ([da984a2](https://github.com/kc-workspace/asdf-plugin-template/commit/da984a27cab55569be85af4adc5920189dfca145))


### Improvements

* add exec-env and list-bin-paths as default script inside template ([2f531a7](https://github.com/kc-workspace/asdf-plugin-template/commit/2f531a7e0fe441c48c0ce99547876f1fcb62631b))
* add feature to custom version prefix filter ([98933b8](https://github.com/kc-workspace/asdf-plugin-template/commit/98933b8ecd46c3fb786b396d5ca4e18bb5f23dfb))
* add hook to filter list version on latest and list-all command ([5582b76](https://github.com/kc-workspace/asdf-plugin-template/commit/5582b76572f6996b4554d4c5fec7aee8e66fe343))
* add more default deps on help message ([6ba7fce](https://github.com/kc-workspace/asdf-plugin-template/commit/6ba7fce638f6cbd81f69ee6ef73e9e7f38cae414))
* add source code link if build from source enabled ([381532b](https://github.com/kc-workspace/asdf-plugin-template/commit/381532b4d61ff98ab7821749cd9a7a1f528e3290))
* add support major_version, minor_version and patch_version as template variable ([3a52b75](https://github.com/kc-workspace/asdf-plugin-template/commit/3a52b75e6ae42caecd59b8c74bb5dc431e1715f0))
* add warning if custom function return error ([a717871](https://github.com/kc-workspace/asdf-plugin-template/commit/a717871b5b75585b7eae407041662050c9368f45))
* **core:** add new _kc_asdf_custom_checksum hook to custom checksum logic ([d3fd8ba](https://github.com/kc-workspace/asdf-plugin-template/commit/d3fd8ba1ee0397383269346b47a7b421af7d84fe))
* **core:** add version addon for template support ([80251f3](https://github.com/kc-workspace/asdf-plugin-template/commit/80251f3af81d52f570257efb3199ed88b903e468))
* **core:** lib/bin is optional, even load failed it will continue script ([13e57df](https://github.com/kc-workspace/asdf-plugin-template/commit/13e57dfc34bb324fcc59f277e2ac64e2a4e8bc0a))
* **core:** support extract zip using unzip ([7052f0e](https://github.com/kc-workspace/asdf-plugin-template/commit/7052f0edcf301d24b3045e94706d1192e923e63e))
* **custom:** add _kc_asdf_custom_gpg_filepath() to override gpg verify on different files ([bf387c9](https://github.com/kc-workspace/asdf-plugin-template/commit/bf387c984e2e3afae31608e78126714786be96c1))
* **custom:** add custom os and arch for plugin ([cf9a90e](https://github.com/kc-workspace/asdf-plugin-template/commit/cf9a90e6a40a1016ba388163ae0134fca44634f5))
* **download:** support multiple download types ([9abe61a](https://github.com/kc-workspace/asdf-plugin-template/commit/9abe61ae6c63cf3bf06452f639601ad1359e5737))
* enabled arch custom by default ([e4f26a1](https://github.com/kc-workspace/asdf-plugin-template/commit/e4f26a15a9a0fe011eb36e46a118518c345c99ed))
* enforce user to use compatible copier version ([4834d41](https://github.com/kc-workspace/asdf-plugin-template/commit/4834d415669f3833365e6597db1d441ab1f366b7))
* generate local public key only if public key type is text ([a2bb50e](https://github.com/kc-workspace/asdf-plugin-template/commit/a2bb50e0265fe39e9d8e052b2415885cb22e4ba6))
* implement new addons on bin scripts ([4e0c465](https://github.com/kc-workspace/asdf-plugin-template/commit/4e0c465aed4a0b1c48c7b8c3e6058a5bf28b4c34))
* improve readme ([436fecd](https://github.com/kc-workspace/asdf-plugin-template/commit/436fecd711c02f8b14119b30a7e91fca9d43fe34))
* improve wording ([b0b9a35](https://github.com/kc-workspace/asdf-plugin-template/commit/b0b9a3588a80d8e5493a0110b9ce0c958339510e))
* **lint:** separate cspell config to default and custom for easier to override ([5760cb8](https://github.com/kc-workspace/asdf-plugin-template/commit/5760cb8d5643dc76ee2ae19504a50fe2966d3da9))
* move common down so template and use common function ([e307316](https://github.com/kc-workspace/asdf-plugin-template/commit/e307316d3b4d405650801128d6dc61d36619e807))
* move requirement check to start before everything ([f21fe70](https://github.com/kc-workspace/asdf-plugin-template/commit/f21fe70c1a83547ecf1af85a455063ea311c5ef5))
* **prompt:** disable some question when app_type is python ([16eeea3](https://github.com/kc-workspace/asdf-plugin-template/commit/16eeea363632bd32de2005d359029970f81af2d9))
* remove template from internal common script ([1996581](https://github.com/kc-workspace/asdf-plugin-template/commit/19965811049f8461eadc702ef2bf139e93cbe900))
* **script:** add minor change on dev script ([5cab1dc](https://github.com/kc-workspace/asdf-plugin-template/commit/5cab1dc2ebd404fd4dab2bb1c42ff20284e205cb))
* **script:** improve dev.sh for local development ([79a68de](https://github.com/kc-workspace/asdf-plugin-template/commit/79a68de314ee6b51e8f1922bb519d27dd2e22c04))
* **script:** support maven and production template ([1c911ab](https://github.com/kc-workspace/asdf-plugin-template/commit/1c911ab202f029633da85301f489dca6324e9635))
* **script:** support single char on format variable ([82171ce](https://github.com/kc-workspace/asdf-plugin-template/commit/82171cedbd41d639bc75a23c6d6906778e3c3490))


### Bugfixes

* checksum failed and change info log format ([7992afb](https://github.com/kc-workspace/asdf-plugin-template/commit/7992afb77837e68d6f507f9a7cdef0d7bb9654b7))
* copier invalid config ([03f81b8](https://github.com/kc-workspace/asdf-plugin-template/commit/03f81b8e7673572418d44b2c91d4b72973c64f8c))
* copy-paste detection error ([e86a6c1](https://github.com/kc-workspace/asdf-plugin-template/commit/e86a6c198fa7e3a79eb92f1b7c9ec26808d9170c))
* downloading single file will failed to create shim ([ab8cbbe](https://github.com/kc-workspace/asdf-plugin-template/commit/ab8cbbef0165903fa7ae188095aef14595ff6191))
* forget to load utils file ([3cda4d5](https://github.com/kc-workspace/asdf-plugin-template/commit/3cda4d5e97765fe9ab2f0b0b0f8fd8d7fbfa9014))
* gh_latest didn't works ([8bdfced](https://github.com/kc-workspace/asdf-plugin-template/commit/8bdfcedca6777e1fb833c49725228ee4f433aabc))
* **github:** when version prefix change github latest should use that value ([4787244](https://github.com/kc-workspace/asdf-plugin-template/commit/47872449c0d83e40aeaca294278b173e082711c1))
* **help:** support several addon deps on help message ([5d0025e](https://github.com/kc-workspace/asdf-plugin-template/commit/5d0025e8d8dc9bfae458a70e9231c7df8f21b3c6))
* install file didn't chmod correctly ([42600e6](https://github.com/kc-workspace/asdf-plugin-template/commit/42600e6335c6ee5df33c1bc7dd373098b772976a))
* invalid comment code ([3e166a0](https://github.com/kc-workspace/asdf-plugin-template/commit/3e166a08327e0cf9e2135393eb88f8810dec11ef))
* invalid function caller ([e29f990](https://github.com/kc-workspace/asdf-plugin-template/commit/e29f990dfa3dd47c221c5d655d95a37774a87b2c))
* **lib:** custom function on download url didn't access to some config ([d4b276e](https://github.com/kc-workspace/asdf-plugin-template/commit/d4b276efb4aa7b0c6d8e6df8d4808cc49fc4bddc))
* **lib:** when filter with query, we should prefix regex ([28d1415](https://github.com/kc-workspace/asdf-plugin-template/commit/28d1415506cfd23c6d5871e0b9efc2ab4d8ab364))
* **lint:** add checksum and security words ([570c4e5](https://github.com/kc-workspace/asdf-plugin-template/commit/570c4e5a1ef87ce8c85129a1c7bf93a62e458141))
* **lint:** add envops and venv to cspell check ([649c4e8](https://github.com/kc-workspace/asdf-plugin-template/commit/649c4e804b636b9424e351e5635e68f15d1170c0))
* **lint:** adjust spacebar and indent ([d56c40f](https://github.com/kc-workspace/asdf-plugin-template/commit/d56c40f1363648b58f8dd8fab29883bbbae2523f))
* **lint:** superlinter complain ([eb500de](https://github.com/kc-workspace/asdf-plugin-template/commit/eb500dee4020f067437663b4ae7af6fadff1ca93))
* **lint:** update linting of output generated project ([23c368d](https://github.com/kc-workspace/asdf-plugin-template/commit/23c368d8921083630add7475a1863c6dfc00d246))
* **lint:** update terminology ([4e38462](https://github.com/kc-workspace/asdf-plugin-template/commit/4e384622cdf99f97fbef038f0e9bc3d8d55a9aec))
* **list-all:** support disable version prefix ([67c1841](https://github.com/kc-workspace/asdf-plugin-template/commit/67c1841a41f5edcddb1b17c0789dd3e2fdf9ec43))
* normal checksum filename is on the end of file ([a58400b](https://github.com/kc-workspace/asdf-plugin-template/commit/a58400b24745e1a4c9e2a9b2a4c34b4418fb0b02))
* **script:** component use wrong variable ([0a23fd0](https://github.com/kc-workspace/asdf-plugin-template/commit/0a23fd09bdaa8fe0d61a0ed03932df8c5ed2a7c1))
* **script:** missing header on long format dev.sh ([02b862c](https://github.com/kc-workspace/asdf-plugin-template/commit/02b862c8e14d21c1fd2851e4065ef6523825bbd5))
* support shaXXXsum command not found on macOS by default ([3695eb1](https://github.com/kc-workspace/asdf-plugin-template/commit/3695eb17997a77e20cb2adc67b6c3ab112f3b2c9))
* **template:** fingerprint always failed ([fdb26e2](https://github.com/kc-workspace/asdf-plugin-template/commit/fdb26e2ebad6c3164260bfbf97c69d91f4c29a57))
* **template:** support key id as fingerprint as sometime fingerprint is not available ([83b0ff8](https://github.com/kc-workspace/asdf-plugin-template/commit/83b0ff8e6dca1f153d0ae13e85ef3913a6cc6e8c))

## [1.3.3](https://github.com/kc-workspace/asdf-plugin-template/compare/v1.3.2...v1.3.3) (2023-06-13)


### Improvements

* add command argument for testing on CI ([ba10124](https://github.com/kc-workspace/asdf-plugin-template/commit/ba101245b38e5e7a1c4dc041f4b02ee56222bb6e))
* **lib:** don't test command when installed as we tested on CI already ([453aa0c](https://github.com/kc-workspace/asdf-plugin-template/commit/453aa0c6ce62666c35845b5645e141b44252e45b))

## [1.3.2](https://github.com/kc-workspace/asdf-plugin-template/compare/v1.3.1...v1.3.2) (2023-06-13)


### Improvements

* add tgz support for unzip file ([16aa975](https://github.com/kc-workspace/asdf-plugin-template/commit/16aa9755bf8f90cc712da6a26168236dfca54630))
* **utils:** list directory without wrap with debug logs ([c2d98e5](https://github.com/kc-workspace/asdf-plugin-template/commit/c2d98e56964fbc8296ed5c83c0ee1f7b96c5fbf0))

## [1.3.1](https://github.com/kc-workspace/asdf-plugin-template/compare/v1.3.0...v1.3.1) (2023-06-13)


### Improvements

* move utils.sh to common.sh and use utils.sh for user define function ([20e685e](https://github.com/kc-workspace/asdf-plugin-template/commit/20e685ef908906969e9e2ddc77ff8eed51369ec9))
* skip bin/* and utils.sh file if exist as it user define file ([1d62295](https://github.com/kc-workspace/asdf-plugin-template/commit/1d62295e49d7409716b1cfa20949e2d21e123f94))
* support os mapper to new name ([a450d44](https://github.com/kc-workspace/asdf-plugin-template/commit/a450d44f18cff46374718c8270d0eacc8f09a8be))
* **template:** support download and install directory with custom bin path on file type ([978ba46](https://github.com/kc-workspace/asdf-plugin-template/commit/978ba4665f04ad00cd614ee1ffbb897ef0696cd6))
* **template:** support extract zip file using tar cli ([a1d8791](https://github.com/kc-workspace/asdf-plugin-template/commit/a1d8791d6bafea4096d004a7c9c8f586af5fb6f7))


### Bugfixes

* **typo:** update question message ([6e2aa2c](https://github.com/kc-workspace/asdf-plugin-template/commit/6e2aa2c6ff1595e47245ba6c9adbe3caa5d0583b))

## [1.3.0](https://github.com/kc-workspace/asdf-plugin-template/compare/v1.2.4...v1.3.0) (2023-06-13)


### Features

* support strip directory on extract tar.gz file ([75dceb0](https://github.com/kc-workspace/asdf-plugin-template/commit/75dceb01bc9af4deab62aa795685aac3daf56a51))

## [1.2.4](https://github.com/kc-workspace/asdf-plugin-template/compare/v1.2.3...v1.2.4) (2023-06-13)


### Bugfixes

* linters fail ([7fac734](https://github.com/kc-workspace/asdf-plugin-template/commit/7fac7341ea40142976f32d977e44cec77dd6a422))

## [1.2.3](https://github.com/kc-workspace/asdf-plugin-template/compare/v1.2.2...v1.2.3) (2023-06-13)


### Bugfixes

* SC1090 error from project shellcheck ([8e72d34](https://github.com/kc-workspace/asdf-plugin-template/commit/8e72d34b03b4579c3763efb38f83143fb79c34c4))


### Miscellaneous

* ignore linting CHANGELOG file ([74007d1](https://github.com/kc-workspace/asdf-plugin-template/commit/74007d137383974727c15589deb5bc32a9ace984))
* update release CHANGELOG format ([4dcf664](https://github.com/kc-workspace/asdf-plugin-template/commit/4dcf664a17c8c1c602ab12f1925b8c11d25b6d04))

## [1.2.2](https://github.com/kc-workspace/asdf-plugin-template/compare/v1.2.1...v1.2.2) (2023-06-13)


### Bug Fixes

* shellcheck error ([ad7d3b5](https://github.com/kc-workspace/asdf-plugin-template/commit/ad7d3b5c7be6db8a766326d67f1e2d3a744bcaee))

## [1.2.1](https://github.com/kc-workspace/asdf-plugin-template/compare/v1.2.0...v1.2.1) (2023-06-13)


### Performance Improvements

* make log more beautiful ([20ff27d](https://github.com/kc-workspace/asdf-plugin-template/commit/20ff27d305ffa9d9df8a5d7ca8754d7573421661))
* remove duplicate question ([28a79d2](https://github.com/kc-workspace/asdf-plugin-template/commit/28a79d2e74748e9758d8d8fe4d132d1831925f37))
* support post_download function override and fix bugs ([ae765d3](https://github.com/kc-workspace/asdf-plugin-template/commit/ae765d37e9b6e37ef01484a4d88a8f056f8f528e))
* **template:** make list-all bin verbose for easier to modify on each project ([f8ac5bb](https://github.com/kc-workspace/asdf-plugin-template/commit/f8ac5bb1834868b30f3eaa349012c0330b886165))
* **template:** provide solution to override how we do after downloaded ([92e871c](https://github.com/kc-workspace/asdf-plugin-template/commit/92e871c0010bae65ed399d7d518fc3d4b886cbc4))

## [1.2.0](https://github.com/kc-workspace/asdf-plugin-template/compare/v1.1.2...v1.2.0) (2023-06-13)


### Features

* refine template output ([2c20bf5](https://github.com/kc-workspace/asdf-plugin-template/commit/2c20bf5b20e138eba876590bbca70584e1589dc6))


### Bug Fixes

* cspell fail on project generated by this template ([3afcdb0](https://github.com/kc-workspace/asdf-plugin-template/commit/3afcdb0fbbbbf8b70137afe33ff402c3c1a6ff1f))

## [1.1.2](https://github.com/kc-workspace/asdf-plugin-template/compare/v1.1.1...v1.1.2) (2023-06-13)


### Bug Fixes

* github workflow use invalid template format ([46a9935](https://github.com/kc-workspace/asdf-plugin-template/commit/46a993512d39c6b0ff8cfbeda5e10211aa27c541))


### Performance Improvements

* **template:** upgrade super-linter to v5 ([d85615b](https://github.com/kc-workspace/asdf-plugin-template/commit/d85615b69667bc21b5eb4794084d6fef21b741df))

## [1.1.1](https://github.com/kc-workspace/asdf-plugin-template/compare/v1.1.0...v1.1.1) (2023-06-13)


### Bug Fixes

* missing tasks after generate project ([1b563cc](https://github.com/kc-workspace/asdf-plugin-template/commit/1b563ccc2c6cbf70ba84377d99821f13eff2ce7c))

## [1.1.0](https://github.com/kc-workspace/asdf-plugin-template/compare/v1.0.0...v1.1.0) (2023-06-13)


### Features

* add first draft of asdf-plugin template ([8d46cf8](https://github.com/kc-workspace/asdf-plugin-template/commit/8d46cf8f53086ef6d4db1d49737479625fb1b541))
* prepare to next release ([b5db296](https://github.com/kc-workspace/asdf-plugin-template/commit/b5db296b190533bdadbe4c04f2befd65fbab0d20))


### Bug Fixes

* linter failed ([f7f982b](https://github.com/kc-workspace/asdf-plugin-template/commit/f7f982b7bf8d76c940dc248b50fd879e0846b5b6))
* mergify didn't merge dependabot ([b922954](https://github.com/kc-workspace/asdf-plugin-template/commit/b922954c61ace94e5552699e0c10182243a763ce))
* script syntax error ([13873af](https://github.com/kc-workspace/asdf-plugin-template/commit/13873af5d95a3621dba1d20418b05fd3fa543eb9))
* update templates as problem found ([6185f3d](https://github.com/kc-workspace/asdf-plugin-template/commit/6185f3d2ebb5f1eae0328101c81bf7f64c68d76f))

## 1.0.0 (2023-06-02)


### Features

* initiate new project (2nd time) ([a2ba2ed](https://github.com/kc-workspace/asdf-plugin-template/commit/a2ba2ed2b07eb5f75118ec8b2c88f012b70252dc))
* start simple copier config ([cfecba1](https://github.com/kc-workspace/asdf-plugin-template/commit/cfecba1938a48de2592142c9073aaa14e76b44ea))

<!-- @generated -->
