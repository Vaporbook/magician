var Magician, exec;
exec = require("child_process").exec;
Magician = (function() {
  function Magician(sourcePath, destPath) {
    this.sourcePath = sourcePath;
    this.destPath = destPath;
  }
  Magician.prototype.resizeTo = function(width, height, callback) {
    if (!width || width < 0 || !height || height < 0) {
      return callback(new Error("width and height should be bigger than 0"));
    }
    return exec("convert -resize " + width + "x" + height + " " + this.sourcePath + " " + this.destPath, function(err, stdout, stderr) {
      if (callback) {
        return callback(false);
      }
    });
  };
  Magician.prototype.getDimensions = function(callback) {
    var that;
    that = this;
    return exec("identify " + this.sourcePath, function(err, stdout, stderr) {
      var dimensions;
      dimensions = stdout.split(" ")[2].split("x");
      that.width = dimensions[0];
      that.height = dimensions[1];
      if (callback) {
        return callback({
          width: that.width,
          height: that.height
        });
      }
    });
  };
  return Magician;
})();
module.exports = Magician;