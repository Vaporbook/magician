assert = require 'assert'

module.exports=
	setup: (test) ->
		test.magician = require '../lib/magician'
	
	'test resizing image': (test) ->
		image = new test.magician __dirname + '/image.jpg', __dirname + '/image_resized.jpg'
		image.resizeTo 100, 100, (err) ->
			resizedImage = new test.magician __dirname + '/image_resized.jpg'
			resizedImage.getDimensions (dimensions) ->
				assert.equal(dimensions.width, 100) && assert.equal(dimensions.height, 100)
				test.done()
	
	'test getting dimensions of an image': (test) ->
		image = new test.magician __dirname + '/image.jpg'
		image.getDimensions (dimensions) ->
			assert.equal(dimensions.width, 500) && assert.equal(dimensions.height, 250)
			test.done()