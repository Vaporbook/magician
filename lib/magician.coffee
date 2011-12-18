exec = require("child_process").exec

class Magician
	
	constructor: (@sourcePath, @destPath) ->
	
	resizeTo: (width, height, callback) ->
		if not width or width < 0 or not height or height < 0
			return callback new Error "width and height should be bigger than 0"
		
		exec "convert -resize #{ width }x#{ height } #{ @sourcePath } #{ @destPath }", (err, stdout, stderr) ->
			callback no if callback
	
	getDimensions: (callback) ->
		that = @
		exec "identify #{ @sourcePath }", (err, stdout, stderr) ->
			dimensions = stdout.split(" ")[2].split "x"
			that.width = dimensions[0]
			that.height = dimensions[1]
			callback {
				width: that.width,
				height: that.height
			} if callback
			
			
module.exports = Magician