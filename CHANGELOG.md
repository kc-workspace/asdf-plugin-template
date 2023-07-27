# Changelog

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
