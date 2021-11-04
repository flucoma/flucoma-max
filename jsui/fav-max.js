'use strict';

function _toConsumableArray(arr) { return _arrayWithoutHoles(arr) || _iterableToArray(arr) || _unsupportedIterableToArray(arr) || _nonIterableSpread(); }

function _nonIterableSpread() { throw new TypeError("Invalid attempt to spread non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); }

function _unsupportedIterableToArray(o, minLen) { if (!o) return; if (typeof o === "string") return _arrayLikeToArray(o, minLen); var n = Object.prototype.toString.call(o).slice(8, -1); if (n === "Object" && o.constructor) n = o.constructor.name; if (n === "Map" || n === "Set") return Array.from(o); if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen); }

function _iterableToArray(iter) { if (typeof Symbol !== "undefined" && iter[Symbol.iterator] != null || iter["@@iterator"] != null) return Array.from(iter); }

function _arrayWithoutHoles(arr) { if (Array.isArray(arr)) return _arrayLikeToArray(arr); }

function _arrayLikeToArray(arr, len) { if (len == null || len > arr.length) len = arr.length; for (var i = 0, arr2 = new Array(len); i < len; i++) { arr2[i] = arr[i]; } return arr2; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

Object.defineProperty(exports, '__esModule', {
  value: true
});

var Signal = /*#__PURE__*/function () {
  function Signal(data, sampleRate) {
    var type = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : 0;
    var min = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : null;
    var max = arguments.length > 4 && arguments[4] !== undefined ? arguments[4] : null;

    _classCallCheck(this, Signal);

    if (data instanceof Array && data[0] instanceof Array) {
      this.rank = 2;
    } else if (data instanceof Array) {
      this.rank = 1;
    } else throw "invalid data type";

    this.data = data;
    this.sampleRate = sampleRate;
    this.type = type;
    if (min === null || max === null) this.computeRange();else {
      this.max = max;
      this.min = min;
    }
  }

  _createClass(Signal, [{
    key: "_computeRange1D",
    value: function _computeRange1D() {
      var max = this.data[0];
      var min = this.data[0];

      for (var i = 1; i < this.data.length; i++) {
        if (this.data[i] > max) {
          max = this.data[i];
        }

        if (this.data[i] < min) {
          min = this.data[i];
        }
      }

      this.max = max;
      this.min = min;
    }
  }, {
    key: "_computeRange2D",
    value: function _computeRange2D() {
      var max = this.data[0][0];
      var min = this.data[0][0];

      for (var i = 1; i < this.data.length; i++) {
        for (var j = 1; j < this.data[i].length; j++) {
          if (this.data[i][j] > max) {
            max = this.data[i][j];
          }

          if (this.data[i][j] < min) {
            min = this.data[i][j];
          }
        }
      }

      this.max = max;
      this.min = min;
    }
  }, {
    key: "computeRange",
    value: function computeRange() {
      if (this.type === Signal.TYPE_BINARY) {
        this.min = 0;
        this.max = 1;
      } else {
        if (this.rank === 1) this._computeRange1D();
        if (this.rank === 2) this._computeRange2D();
      }

      this.range = this.max - this.min;
      return this;
    }
  }, {
    key: "length",
    get: function get() {
      return this.data.length;
    }
  }, {
    key: "nBands",
    get: function get() {
      if (this.rank == 1) return 1;else if (this.rank == 2) return this.data[0].length;else throw "Invalid signal dimensions";
    }
  }, {
    key: "clone",
    value: function clone() {
      return new Signal(this.data.slice(), this.sampleRate, this.type, this.min, this.max);
    }
  }, {
    key: "map",
    value: function map(f) {
      var newType = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : null;
      var newMin = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : null;
      var newMax = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : null;
      return new Signal(this.rank == 2 ? this.data.map(function (x) {
        return x.map(f);
      }) : this.data.map(f), this.sampleRate, newType ? newType : this.type, newMin !== null ? newMin : this.min, newMax !== null ? newMax : this.max);
    } // slice(start, end)
    // {
    //   // post("SDSKDLSKDLSDKLSKDD",start,end,'\n')
    //   throw "HWHQHQHQHQH"
    //   return new Signal(
    //     this.rank == 2 ? this.data.map(s => s.slice(start,end)) : this.data.slice(start,end), 
    //     this.sampleRate, this.type, this.min, this.max
    //   );
    // }

  }, {
    key: "draw",
    value: function draw(target, style) {
      var samplingMethod = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : "mean";
      target.display.draw(this, style, target, samplingMethod);
      return this;
    }
  }]);

  return Signal;
}();

Signal.TYPE_FLOAT = 0;
Signal.TYPE_INT = 1;
Signal.TYPE_BINARY = 2;
var signal = Signal;

var Marker = function Marker(position) {
  var selected = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : false;

  _classCallCheck(this, Marker);

  this.position = position;
  this.selected = selected;
};

Marker.prototype.valueOf = function () {
  return this.position;
};

var Markers = /*#__PURE__*/function () {
  function Markers(data, sampleRate) {
    _classCallCheck(this, Markers);

    this.data = data.map(function (m) {
      return new Marker(m);
    });
    this.sampleRate = sampleRate;
    this.selection = null;
    this.extent = [0, null];
  }

  _createClass(Markers, [{
    key: "length",
    get: function get() {
      return this.extent[1] ? this.extent[1] : this.data[this.data.length - 1].position;
    }
  }, {
    key: "size",
    get: function get() {
      return this.data.length;
    }
  }, {
    key: "draw",
    value: function draw(target, style) {
      target.display.draw_markers(this, style, target, "max");
      return this;
    }
  }, {
    key: "add",
    value: function add(data) {
      this.data = this.data.concat(data instanceof Array ? [data.map(function (pos) {
        return new Marker(pos, false);
      })] : new Marker(data, false));
      this.data.sort();
      return this;
    }
  }, {
    key: "remove",
    value: function remove(data) {
      this.data = this.data.filter(function (x) {
        return x !== data;
      });
      return this;
    }
  }, {
    key: "slice",
    value: function slice(from, to) {
      var newm = new Markers([], this.sampleRate);
      newm.data = this.data.filter(function (m) {
        return m.position >= from && m.position <= to;
      });
      newm.extent = [from, this.extent[1] ? to - from : null];
      return newm;
    }
  }]);

  return Markers;
}();

var marker = Markers;
var stats = {
  "mean": function mean(slice) {
    return slice.reduce(function (a, b) {
      return a + b;
    }) / slice.length;
  },
  "median": function median(slice) {
    var sorted = slice.slice(0).sort(function (a, b) {
      return a - b;
    });
    var mid = Math.floor(slice.length / 2);
    if (slice.length % 2 === 0) return (sorted[mid] + sorted[mid - 1]) / 2;else return sorted[mid];
  },
  "sample": function sample(slice) {
    return slice[Math.floor(slice.length / 2)];
  },
  "std": function std(slice) {
    var mean = slice.reduce(function (a, b) {
      return a + b;
    }) / slice.length;
    var diffs = slice.map(function (x) {
      return Math.pow(x - mean, 2);
    });
    return Math.sqrt(diffs.reduce(function (a, b) {
      return a + b;
    })) / slice.length;
  },
  "max": function max(slice) {
    return slice.reduce(function (a, b) {
      return Math.max(a, b);
    });
  },
  "min": function min(slice) {
    return slice.reduce(function (a, b) {
      return Math.min(a, b);
    });
  }
};
var unaryops = {
  'threshold': function threshold(th) {
    return this.map(function (x) {
      return x > th;
    }, 2, 0, 1);
  },
  'slice': function slice(from, to) {
    var unit = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : 'samples';

    if (unit === 'seconds') {
      from = Math.round(from * this.sampleRate);
      to = Math.round(to * this.sampleRate);
    }

    var clone = this.clone();
    clone.data = clone.rank == 2 ? clone.data.map(function (s) {
      return s.slice(from, to);
    }) : this.data.slice(from, to);
    clone.computeRange();
    return clone;
  },
  'normalize': function normalize() {
    var _this = this;

    var newDesc = this.map(function (x) {
      return (x - _this.min) / _this.range;
    });
    newDesc.min = 0;
    newDesc.max = 1;
    return newDesc;
  },
  'offset': function offset(num) {
    return this.map(function (x) {
      return x + num;
    });
  },
  'log': function log() {
    return this.map(Math.log).computeRange();
  },
  'square': function square() {
    return this.map(function (x) {
      return Math.pow(x, 2);
    });
  },
  'pow': function pow(n) {
    return this.map(function (x) {
      return Math.pow(x, n);
    });
  },
  'exp': function exp() {
    return this.map(Math.exp);
  },
  'sqrt': function sqrt() {
    return this.map(Math.sqrt);
  },
  'abs': function abs() {
    return this.map(Math.abs);
  },
  'scale': function scale(num) {
    return this.map(function (x) {
      return x * num;
    });
  },
  'reflect': function reflect(num) {
    var _this2 = this;

    return this.map(function (x) {
      return _this2.max - x;
    });
  },
  'diff': function diff() {
    var _this3 = this;

    return this.map(function (x, i) {
      return i == 0 ? i : x - _this3.data[i - 1];
    }).computeRange();
  },
  'delay': function delay(n) {
    var _this4 = this;

    return this.map(function (x, i) {
      return i <= n ? 0 : _this4.data[i - n];
    }).computeRange();
  },
  'smooth': function smooth(n) {
    var _this5 = this;

    var stat = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 'mean';
    var nPrev = Math.floor(n / 2);
    var newDesc = this.map(function (x, i) {
      return i <= nPrev ? stats[stat](_this5.data.slice(0, n - i)) : stats[stat](_this5.data.slice(i - nPrev, i + n - nPrev));
    });
    newDesc.computeRange();
    return newDesc;
  },
  'schmitt': function schmitt(th0, th1) {
    this.clone();
    var state = 0;

    for (var i = 0; i < this.length; i++) {
      var newState = state;
      if (state === 0 && this.data[i] > th0) newState = 1;else if (state === 1 && this.data[i] < th1) newState = 0;
      state = newState;
      this.data[i] = state;
    }

    return this;
  },
  'slide': function slide(up, down) {
    up = Math.max(up, 1);
    down = Math.max(down, 1);
    var previous = 0;
    var slide = 1;

    for (var i = 0; i < this.length; i++) {
      var current = this.data[i];

      if (current >= previous) {
        slide = up;
      } else {
        slide = down;
      }

      this.data[i] = previous + (current - previous) / slide;
      previous = this.data[i];
    }

    this.computeRange();
    return this;
  }
};
var unaryops_1 = unaryops;
var binaryops = {
  "checkSizes": function checkSizes(x, y) {
    if (x.data.length != y.data.length) {
      throw "Sizes do not match";
    } else return true;
  },
  "add": function add(desc) {
    if (this.checkSizes(this, desc)) return this.map(function (x, i) {
      return x + desc.data[i];
    });
  },
  "subtract": function subtract(desc) {
    if (this.checkSizes(this, desc)) return this.map(function (x, i) {
      return x - desc.data[i];
    });
  },
  "multiply": function multiply(desc) {
    if (this.checkSizes(this, desc)) return this.map(function (x, i) {
      return x * desc.data[i];
    });
  },
  "over": function over(desc) {
    if (this.checkSizes(this, desc)) return this.map(function (x, i) {
      return x / desc.data[i];
    });
  },
  "and": function and(desc) {
    if (this.checkSizes(this, desc)) return this.map(function (x, i) {
      return x && desc.data[i];
    });
  },
  "or": function or(desc) {
    if (this.checkSizes(this, desc)) return this.map(function (x, i) {
      return x || desc.data[i];
    });
  },
  "xor": function xor(desc) {
    if (this.checkSizes(this, desc)) return this.map(function (x, i) {
      return x == desc.data[i] ? 1 : 0;
    });
  }
};
var samplers = {
  "sample": function sample(step) {
    var method = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : "mean";
    var newSize = Math.ceil(this.data.length / step);
    var newData = new Array(newSize);
    var newRate = this.sampleRate / step;
    this.data.length / step;

    for (var i = 0; i < newSize; i += 1) {
      var bucketStart = Math.floor(i * step);
      var bucketEnd = Math.floor((i + 1) * step);
      if (bucketStart > this.data.length - 1) bucketStart = this.data.length - 1;
      if (bucketEnd > this.data.length - 1) bucketEnd = this.data.length - 1;

      if (bucketStart === bucketEnd) {
        newData[i] = i > 0 ? newData[i - 1] : this.data[i];
      } else newData[i] = stats[method](this.data.slice(bucketStart, bucketEnd));
    }

    var s = new signal(newData, newRate, this.type);
    return s;
  }
}; // Lightest-weight wrapping around MGraphics possible, to allow for layers to draw into sub-regions of an MGrpahics using function calls that match the HTMLContext names

var SubContext = /*#__PURE__*/function () {
  function SubContext(layer, range) {
    _classCallCheck(this, SubContext);

    range = range ? range : [0, 0, layer.jsui.getWidth(), layer.jsui.getHeight()];
    if (!(range instanceof Array) && !range.length === 4) throw 'Invalid range';
    this.range = range;
    this.layer = layer;
    this.fillStyle = [0, 0, 0, 1];
    this.stroke_style = [0, 0, 0, 1];
  }

  _createClass(SubContext, [{
    key: "_translate",
    value: function _translate(x, y) {
      return [x + this.range[0], // + this.layer.margin / 2) | 0,
      y + this.range[1] // + this.layer.margin / 2)| 0
      ];
    }
  }, {
    key: "strokeStyle",
    get: function get() {
      return this.stroke_style;
    },
    set: function set(s) {
      var _this$mg;

      (_this$mg = this.mg).set_source_rgb.apply(_this$mg, _toConsumableArray(s));

      this.stroke_style = s;
    }
  }, {
    key: "width",
    get: function get() {
      return this.range[2] - this.layer.margin | 0;
    }
  }, {
    key: "height",
    get: function get() {
      return this.range[3] - this.layer.margin | 0;
    }
  }, {
    key: "mg",
    get: function get() {
      return this.layer.jsui.getContext();
    }
  }, {
    key: "lineTo",
    value: function lineTo(x, y) {
      var _this$mg2;

      (_this$mg2 = this.mg).line_to.apply(_this$mg2, _toConsumableArray(this._translate(x, y)));
    }
  }, {
    key: "moveTo",
    value: function moveTo(x, y) {
      var _this$mg3;

      (_this$mg3 = this.mg).move_to.apply(_this$mg3, _toConsumableArray(this._translate(x, y)));
    }
  }, {
    key: "rect",
    value: function rect(x, y, w, h) {
      var _this$mg4;

      (_this$mg4 = this.mg).rectangle.apply(_this$mg4, _toConsumableArray(this._translate(x, y)).concat([w, h]));
    }
  }, {
    key: "fillRect",
    value: function fillRect(x, y, w, h) {
      var _this$mg5;

      (_this$mg5 = this.mg).set_source_rgba.apply(_this$mg5, _toConsumableArray(this.fillStyle)); // this.mg.set_source_rgba(0, 0, 0, 1)
      // this.mg.rectangle(x + this.range[0], y + this.range[1], w, h)


      this.rect(x, y, w, h);
      this.mg.fill();
    }
  }, {
    key: "fill",
    value: function fill() {
      var _this$mg6;

      (_this$mg6 = this.mg).set_source_rgba.apply(_this$mg6, _toConsumableArray(this.fillStyle));

      this.mg.fill();
    }
  }, {
    key: "stroke",
    value: function stroke() {
      /*this.mg.set_source_rgba(...this.strokeStyle);*/
      this.mg.stroke();
    }
  }, {
    key: "lineWidth",
    value: function lineWidth(x) {
      this.mg.set_line_width(x);
    } // taken from the C74 Canvas adaptor by Silvio C. Haedrich

  }, {
    key: "scale",
    value: function scale(x, y) {
      this.mg.scale(x, y);
    }
  }, {
    key: "rotate",
    value: function rotate(x) {
      this.mg.rotate(x);
    }
  }, {
    key: "translate",
    value: function translate(x, y) {
      this.mg.translate(x, y);
    }
  }, {
    key: "transform",
    value: function transform(m11, m12, m21, m22, dx, dy) {
      this.mg.transform(m11, m12, m21, m22, dx, dy);
    }
  }, {
    key: "setTransform",
    value: function setTransform(m11, m12, m21, m22, dx, dy) {
      this.mg.set_matrix(m11, m12, m21, m22, dx, dy);
    }
  }, {
    key: "drawImage",
    value: function drawImage(image, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) {
      if (!(image instanceof Image)) {
        post('drawImage: TYPE_MISMATCH_ERR');
        return;
      } else if (image.size[0] <= 0 || image.size[1] <= 0) {
        post('drawImage: INVALID_STATE_ERROR');
        return;
      } else if (arg8) {
        var sx = arg1;
        var sy = arg2;
        var sw = arg3;
        var sh = arg4;

        var pos = this._translate(arg5, arg6);

        var dx = pos[0];
        var dy = pos[1];
        var dw = arg7;
        var dh = arg8;
      } else if (arg4) {
        var _pos = this._translate(arg1, arg2);

        var dx = _pos[0];
        var dy = _pos[1];
        var dw = arg3;
        var dh = arg4;
        var sx = 0;
        var sy = 0;
        var sw = image.size[0];
        var sh = image.size[1];
      } else if (arg2) {
        var _pos2 = this._translate(arg1, arg2);

        var dx = _pos2[0];
        var dy = _pos2[1];
        var dw = image.size[0];
        var dh = image.size[1];
        var sx = 0;
        var sy = 0;
        var sw = image.size[0];
        var sh = image.size[1];
      } else {
        post('drawImage: missing arguments\n');
        return;
      }

      if (sx < 0 || sy < 0 || sw <= 0 || sh <= 0 || sx + sw > image.size[0] || sy + sh > image.size[1]) {
        post('drawImage: INDEX_SIZE_ERR');
        return;
      }

      var matrix = this.mg.get_matrix();

      if (matrix[1] == 0 && matrix[2] == 0) {
        this.mg.set_source_rgba(1.0, 1.0, 1.0, 1.0);
        this.mg.image_surface_draw(image, sx, sy, sw, sh, dx, dy, dw, dh);
      } else {
        var pat = this.mg.pattern_create_for_surface(image);
        this.mg.save();
        this.mg.translate(dx, dy);
        this.mg.scale(dw / image.size[0], dh / image.size[1]);
        this.mg.rectangle(0, 0, image.size[0], image.size[1]);
        this.mg.scale(image.size[0] / sw, image.size[1] / sh);
        this.mg.translate(-sx, -sy);
        this.mg.set_source(pat);
        this.mg.fill_with_alpha(this.globalAlpha);
        this.mg.restore();
      }
    }
  }]);

  return SubContext;
}();

var Layer = /*#__PURE__*/function () {
  function Layer(type, jsui) {
    var _this6 = this;

    var margin = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : 0;
    var range = arguments.length > 3 ? arguments[3] : undefined;

    _classCallCheck(this, Layer);

    var drawFuncs = {
      'line': this.drawLine,
      // 'fill': this.drawFill,
      'wave': this.drawPeaks,
      // 'errorbar': this.drawError,
      'image': this.drawImage // 'marker': this.drawMarker

    };
    var renderFuncs = {
      'line': function line(ctx) {
        ctx.stroke();
      },
      'wave': function wave(ctx) {
        ctx.image_surface_draw(_this6.img);
      },
      'image': function image(ctx) {
        ctx.image_surface_draw(_this6.img);
      }
    };
    if (!range) range = null;
    this.draw = drawFuncs[type];
    this.render = renderFuncs[type];
    this.scale = 1.0;
    this.y = 0;
    this.jsui = jsui;
    this.context = new SubContext(this, range);
    this.canvas = {
      jsui: jsui,
      layer: this,

      get width() {
        return this.layer.context.width;
      },

      get height() {
        return this.layer.context.height;
      }

    };
    this.margin = 0; //margin ? margin : 0

    this.type = type;
  }

  _createClass(Layer, [{
    key: "hslToRgb",
    value: // http://axonflux.com/handy-rgb-to-hsl-and-rgb-to-hsv-color-model-c
    function hslToRgb(h, s, l) {
      var r, g, b;

      if (s == 0) {
        r = g = b = l; // achromatic
      } else {
        var hue2rgb = function hue2rgb(p, q, t) {
          if (t < 0) {
            t += 1;
          }

          if (t > 1) {
            t -= 1;
          }

          if (t < 1 / 6) {
            return p + (q - p) * 6 * t;
          }

          if (t < 1 / 2) {
            return q;
          }

          if (t < 2 / 3) {
            return p + (q - p) * (2 / 3 - t) * 6;
          }

          return p;
        };

        var q = l < 0.5 ? l * (1 + s) : l + s - l * s;
        var p = 2 * l - q;
        r = hue2rgb(p, q, h + 1 / 3);
        g = hue2rgb(p, q, h);
        b = hue2rgb(p, q, h - 1 / 3);
      }

      return [r, g, b];
    }
  }, {
    key: "setRange",
    value: function setRange(range) {
      this.context = new SubContext(this, range);
    }
  }, {
    key: "_mapVal",
    value: function _mapVal(x, min, range, height) {
      return height * (x - min) / range;
    }
  }, {
    key: "clear",
    value: function clear() {// this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
    }
  }, {
    key: "drawLine",
    value: function drawLine(desc, style) {
      if (desc.length !== this.canvas.width) {
        desc = desc.sample(desc.length / this.canvas.width);
      }

      desc.computeRange();
      this.context.lineWidth(2);
      this.context.strokeStyle = style['color'];
      var y0 = this._mapVal(desc.data[0], desc.min, desc.range, this.canvas.height - this.margin) | 0;
      this.context.moveTo(0, this.canvas.height - y0);

      for (var j = 1; j < desc.data.length; j++) {
        var y = this._mapVal(desc.data[j], desc.min, desc.range, this.canvas.height - this.margin) | 0;
        this.context.lineTo(j, this.canvas.height - y);
      }

      this.context.lineTo(desc.data.length, this.canvas.height - y0);
      this.context.stroke();
    }
  }, {
    key: "drawPeaks",
    value: function drawPeaks(desc, style) {
      //ghastly way of seeing if we have cached peaks or not 
      //todo: make less ghastly
      if (!Array.isArray(desc) && desc.length !== 2) desc = [desc, desc];
      var length = desc[0].length;
      var amp = this.canvas.height / 2;
      var ctx = this.context;
      var step = length / this.canvas.width;
      var min = desc[0].sample(step, 'min');
      var max = desc[1].sample(step, 'max');
      ctx.fillStyle = style.color;

      for (var i = 0; i < this.canvas.width; i++) {
        ctx.fillRect(i, (1 - max.data[i]) * amp, 1, Math.max(1, (max.data[i] - min.data[i]) * amp));
      }
    }
  }, {
    key: "drawWave",
    value: function drawWave(desc, style) {
      desc.rank == 1 ? desc.length : desc.nBands;
      this.canvas.height / 2;
      var ctx = this.context;
      ctx.fillStyle = style.color;

      if (desc.rank === 1) {
        var step = desc.length / this.canvas.width;
        var amp = this.canvas.height / 2;
        var min = desc.sample(step, 'min');
        var max = desc.sample(step, 'max');

        for (var i = 0; i < this.canvas.width; i++) {
          ctx.fillRect(i, (1 - max.data[i]) * amp, 1, Math.max(1, (max.data[i] - min.data[i]) * amp));
        }
      } else {
        var _amp = this.canvas.height / (2 * desc.length);

        var vstep = this.canvas.height / desc.length;

        for (var _i = 0; _i < desc.length; _i++) {
          var thisDesc = new signal(desc.data[_i], desc.sampleRate, 'wave');

          var _step = thisDesc.length / this.canvas.width;

          var _max = thisDesc.abs().sample(_step, 'max');

          for (var j = 0; j < this.canvas.width; j++) {
            ctx.fillRect(j, (1 - _max.data[j]) * _amp + vstep * _i, 1, Math.max(1, _max.data[j] * vstep));
          }
        }
      }
    }
  }, {
    key: "drawFill",
    value: function drawFill(desc, style) {
      if (desc.length !== this.canvas.width) {
        desc = desc.sample(desc.length / this.canvas.width);
      }

      this.context.fillStyle = style;

      for (var i = 1; i < desc.data.length; i++) {
        var y = this._mapVal(desc.data[i], desc.min, desc.range, this.canvas.height - this.margin);

        this.context.fillRect(i, this.canvas.height - y, 1, y);
      }
    }
  }, {
    key: "drawError",
    value: function drawError(desc, style) {
      var factor = desc.length / this.canvas.width;
      var desc_mean = desc.sample(factor, 'mean').smooth(10);
      var desc_std = desc.sample(factor, 'std').smooth(10);
      var upper = desc_mean.add(desc_std.scale(2));
      var lower = desc_mean.add(desc_std.scale(-2));
      var min = lower.min;
      var max = upper.max;
      var range = max - min;
      this.context.fillStyle = style;

      for (var i = 0; i < this.canvas.width; i++) {
        var up = this._mapVal(upper.data[i], min, range, this.canvas.height - this.margin);

        var down = this._mapVal(lower.data[i], min, range, this.canvas.height - this.margin);

        this.context.fillRect(i, this.canvas.height - up, 1, this.canvas.height - down);
      }
    }
  }, {
    key: "drawImage",
    value: function drawImage(desc) {
      if (desc.rank !== 2) {
        throw 'Trying to draw 1D signal as image';
      }

      desc = desc.offset(1e-6).log().normalize();
      var imageData = new Image(desc.length, desc.nBands);

      for (var i = 0; i < desc.nBands; i++) {
        desc.nBands - i;

        for (var j = 0; j < desc.length; j++) {
          var val = desc.data[j][i];
          var rgb = this.hslToRgb(val, 0, val);
          imageData.setpixel(j, desc.nBands - i, rgb[0], rgb[1], rgb[2], 1);
        }
      }

      this.context.drawImage(imageData, 0, 0, this.canvas.width, this.canvas.height);
    }
  }]);

  return Layer;
}();

var MarkerLayer = /*#__PURE__*/function () {
  function MarkerLayer(type, jsui, refLayer) {
    var margin = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : 0;
    var range = arguments.length > 4 ? arguments[4] : undefined;

    _classCallCheck(this, MarkerLayer);

    if (!range) range = null;
    this.scale = 1.0;
    this.y = 0;
    this.jsui = jsui;
    this.context = new SubContext(this, range);
    this.canvas = {
      jsui: jsui,
      layer: this,

      get width() {
        return this.layer.context.width;
      },

      get height() {
        return this.layer.context.height;
      }

    };
    this.refLayer = refLayer ? refLayer : null;
    this.margin = margin ? margin : 0;
  }

  _createClass(MarkerLayer, [{
    key: "draw",
    value: function draw(desc, style) {
      var extent = desc.length;
      var factor = extent / this.canvas.width;
      var offset = desc.extent[0];

      for (var i = 0; i < desc.size; i++) {
        var pos = (desc.data[i].position - offset) / factor | 0;
        var color = desc.data[i].selected ? style.selectedcolor : style.color;
        this.context.fillStyle = color; // little triangle

        this.context.moveTo(pos - 10, 0);
        this.context.lineTo(pos + 10, 0);
        this.context.lineTo(pos, 10);
        this.context.lineTo(pos - 10, 0);
        this.context.fill(); // marker line

        this.context.fillStyle = color;
        this.context.fillRect(pos, 0, 1, this.canvas.height);
      }
    }
  }, {
    key: "search",
    value: function search(desc, x) {
      var extent = desc.length;
      var factor = extent / this.canvas.width;
      var offset = desc.extent[0];
      var pos = (x + this.margin / 2) * factor | 0;

      for (var i = 0; i < desc.data.length; i++) {
        var y = desc.data[i].position - offset;
        desc.data[i].selected = pos > y - 10 * factor && pos < y + 10 * factor;

        if (desc.data[i].selected) {
          return desc.data[i];
        }
      }

      return null;
    }
  }]);

  return MarkerLayer;
}();

var Display = /*#__PURE__*/function () {
  function Display(jsui, firstLayerType, width, height) {
    var margin = arguments.length > 4 && arguments[4] !== undefined ? arguments[4] : 10;
    var range = arguments.length > 5 ? arguments[5] : undefined;

    _classCallCheck(this, Display);

    this.layers = [];
    this.markerLayers = [];
    this.margin = margin;
    this.width = width;
    this.height = height;
    this.display = this; // workaround for syntactic sugar

    this.scale = 1;
    this.y = 0;
    this.jsui = jsui;
    this.canvas = {
      width: width,
      height: height
    }; // this.container = document.getElementById(container);
    // this.container.style.height = height+"px";
    // if(width!=null) this.container.style.width = width+"px";
    // while (this.container.hasChildNodes()) {
    //   this.container.removeChild(this.container.lastChild);
    // }

    this.path = null;
    this.addLayer(firstLayerType, margin, range);
  }

  _createClass(Display, [{
    key: "setOffset",
    value: function setOffset(n) {
      this.y = n;
    }
  }, {
    key: "setScale",
    value: function setScale(x) {
      this.scale = x;
    }
  }, {
    key: "addLayer",
    value: function addLayer(type) {
      var margin = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 10;
      var range = arguments.length > 2 ? arguments[2] : undefined;
      // let canvas = document.createElement('canvas');
      // let canvas = new MaxCanvas(this.jsui);
      // canvas.style.position = "absolute";
      // canvas.style.left = "0px";
      // canvas.style.top = "0px";
      // canvas.style.border = "thin dotted black";
      // canvas.style.zIndex = this.layers.length;
      // canvas.height = this.height;
      // this.container.appendChild(canvas);    
      var f = type === 'marker' ? MarkerLayer : Layer;
      var layer = new f(type, this.jsui, this.margin, range);
      layer.display = this;
      this[this.layers.length] = layer; // add array-style syntax sugar

      this.layers.push(layer);
    }
  }, {
    key: "draw",
    value: function draw(desc, style, layer) {
      if (layer === this) {
        layer = this.layers[0];
      } //  if width is not set, all layers will have the width of the first visualized descriptor
      // if (this.width === null){
      //   this.width = desc.length;
      //    this.container.style.width = this.width+"px";
      //   for(let l of this.layers){
      //     l.canvas.width = this.jsui.box.size[0];
      //   }
      // }
      // else {
      //   layer.canvas.width = this.width;
      // }
      // layer.canvas.height = this.height;
      // layer.clear();


      layer.draw(desc, style);
    }
  }]);

  return Display;
}();

var displayJsui = Display; // import "core-js/stable";
// import "regenerator-runtime/runtime";

for (var key in unaryops_1) {
  signal.prototype[key] = unaryops_1[key];
}

for (var key in binaryops) {
  signal.prototype[key] = binaryops[key];
}

for (var key in samplers) {
  signal.prototype[key] = samplers[key];
}

var apiMax = {
  "Signal": signal,
  "Markers": marker,
  "Display": displayJsui
};
exports["default"] = apiMax;
