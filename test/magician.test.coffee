assert = require 'assert'
fs = require 'fs'

module.exports=
	setup: (test) ->
		test.magician = require '../lib/magician'
	
	'test resizing image': (test) ->
		image = new test.magician __dirname + '/image.jpg', __dirname + '/image_resized.jpg'
		image.resizeTo 100, 100, (err) ->
			resizedImage = new test.magician __dirname + '/image_resized.jpg'
			resizedImage.getDimensions (err, dimensions) ->
				assert.equal(dimensions.width, 100) and assert.equal(dimensions.height, 100)
				test.done()
				fs.unlinkSync __dirname + '/image_resized.jpg'
	
	'test cropping image': (test) ->
		image = new test.magician __dirname + '/image.jpg', __dirname + '/image_cropped.jpg'
		image.cropFrom 0, 0, 200, 100, (err) ->
			croppedImage = new test.magician __dirname + '/image_cropped.jpg'
			croppedImage.getDimensions (err, dimensions) ->
				assert.equal(dimensions.width, 200) and assert.equal(dimensions.height, 100)
				test.done()
				fs.unlinkSync __dirname + '/image_cropped.jpg'
	
	'test converting image': (test) ->
		image = new test.magician __dirname + '/image.jpg', __dirname + '/image.png'
		image.convert ->
			assert.ok(true)
			test.done()
			fs.unlinkSync __dirname + '/image.png'
	
	'test getting dimensions of an image': (test) ->
		image = new test.magician __dirname + '/image.jpg'
		image.getDimensions (err, dimensions) ->
			assert.equal(dimensions.width, 500) and assert.equal(dimensions.height, 250)
			test.done()