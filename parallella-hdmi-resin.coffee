deviceTypesCommon = require 'resin-device-types/common'
{ networkOptions, commonImg, instructions } = deviceTypesCommon

module.exports =
	# TODO: why HDMI if it's broken?
	slug: 'parallella'
	aliases: [ 'parallella-hdmi-resin' ]
	name: 'Parallella'
	arch: 'armv7hf'
	state: 'experimental'

	instructions: commonImg.instructions
	gettingStartedLink:
		windows: 'http://docs.resin.io/#/pages/installing/gettingStarted-Parallella.md#windows'
		osx: 'http://docs.resin.io/#/pages/installing/gettingStarted-Parallella.md#on-mac-and-linux'
		linux: 'http://docs.resin.io/#/pages/installing/gettingStarted-Parallella.md#on-mac-and-linux'
	supportsBlink: true

	options: [
		networkOptions.group
	,
		message: 'Processor'
		name: 'processorType'
		type: 'list'
		choices: [ 'Z7010', 'Z7020' ]
	,
		message: 'Coprocessor cores'
		name: 'coprocessorCore'
		type: 'list'
		choices: [ '16', '64' ]
	]

	yocto:
		machine: 'parallella-hdmi-resin'
		image: 'resin-image'
		fstype: 'resin-sdcard'
		version: 'yocto-fido'
		deployArtifact: 'resin-image-parallella-hdmi-resin.resin-sdcard'

	configuration:
		config:
			partition:
				primary: 4
				logical: 1
			path: '/config.json'

		operations: [
			command: 'copy'
			from:
				partition:
					primary: 1
				path: '/bitstreams/parallella_e16_headless_gpiose_7010.bit.bin'
			to:
				partition:
					primary: 1
				path: '/parallella.bit.bin'
			when:
				coprocessorCore: '16'
				processorType: 'Z7010'
		,
			command: 'copy'
			from:
				partition:
					primary: 1
				path: '/bitstreams/parallella_e16_headless_gpiose_7020.bit.bin'
			to:
				partition:
					primary: 1
				path: '/parallella.bit.bin'
			when:
				coprocessorCore: '16'
				processorType: 'Z7020'
		,
			command: 'copy'
			from:
				partition:
					primary: 1
				path: '/device-trees/parallella-mmc-boot.dtb'
			to:
				partition:
					primary: 1
				path: '/devicetree.dtb'
		]

	initialization: commonImg.initialization
