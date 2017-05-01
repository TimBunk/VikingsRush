package {

	public class Vector2 {
		// ####################################################
		// properties
		// ####################################################
		public var x:Number;
		public var y:Number;

		// ####################################################
		// constructor
		// ####################################################
		public function Vector2(xx:Number = 0, yy:Number = 0) {
			this.x = xx;
			this.y = yy;
		}

		// ####################################################
		// methods
		// ####################################################
		// creators (setters)
		public function setTo(xx:Number, yy:Number):Vector2 {
			this.x = xx;
			this.y = yy;
			return this;
		}

		public function create(begin:Vector2, end:Vector2):Vector2 {
			this.x = end.x - begin.x;
			this.y = end.y - begin.y;
			return this;
		}

		public function fromAngle(angle:Number):Vector2 {
			this.setTo(Math.cos(angle), Math.sin(angle));
			return this;
		}

		public function copy():Vector2 {
			return new Vector2(this.x, this.y);
		}

		// info (getters)
		public function mag():Number {
			return Math.sqrt( magSq() );
		}

		public function magSq():Number {
			return (x*x) + (y*y);
		}

		public function dist(other:Vector2):Number {
			var dx:Number = this.x - other.x;
			var dy:Number = this.y - other.y;
			return Math.sqrt( (dx*dx) + (dy*dy) );
		}

		public function getNormalized():Vector2 {
			return new Vector2( this.x/mag(), this.y/mag() );
		}

		public function normalize():Vector2 {
			var m:Number = mag();
			this.x /= m;
			this.y /= m;
			return this;
		}

		public function limit(max:Number):Vector2 {
			if (mag() > max) {
				this.normalize();
				this.multS(max);
			}
			return this;
		}

		public function setMag(magnitude:Number):Vector2 {
			this.normalize();
			this.multS(magnitude);
			return this;
		}

		public function getAngle():Number {
			return Math.atan2(y,x);//Returns an angle in radians
		}

		public function heading():Number {
			return getAngle();
		}

		public function getAngleToVector(other:Vector2):Number {
			var dot:Number = this.dot(other);
			var l1:Number = this.mag();
			var l2:Number = other.mag();
			return Math.acos(dot/(l1*l2));
		}

		public function dot(other:Vector2):Number {
			return (this.x * other.x) + (this.y * other.y);
		}

		// manipulators
		public function rotate(angle:Number):Vector2 {
			var currAngle:Number = this.getAngle();
			currAngle += angle;
			var xx:Number = Math.cos(currAngle);
			var yy:Number = Math.sin(currAngle);
			var currLength:Number = this.mag();
			this.x = xx * currLength;
			this.y = yy * currLength;
			return this;
		}

		public function add(other:Vector2):Vector2 {
			this.x += other.x;
			this.y += other.y;
			return this;
		}

		public function sub(other:Vector2):Vector2 {
			this.x -= other.x;
			this.y -= other.y;
			return this;
		}

		public function mult(other:Vector2):Vector2 {
			this.x *= other.x;
			this.y *= other.y;
			return this;
		}

		public function multS(scalar:Number):Vector2 {
			this.x *= scalar;
			this.y *= scalar;
			return this;
		}

		public function div(other:Vector2):Vector2 {
			this.x /= other.x;
			this.y /= other.y;
			return this;
		}

		public function divS(scalar:Number):Vector2 {
			this.x /= scalar;
			this.y /= scalar;
			return this;
		}

		public static function rad2deg(a:Number):Number {
			return a * (180 / Math.PI);
		}

		public static function deg2rad(a:Number):Number {
			return a * (Math.PI / 180);
		}

		public function toString():String {
			return new String("["+this.x+", "+this.y+"]");
		}

	}
}
