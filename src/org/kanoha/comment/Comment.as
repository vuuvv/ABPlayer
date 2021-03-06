package org.kanoha.comment
{
	/**
	 * Comment Object
	 * Author: CQZ
	 * This is a combo of MukioPlayerPlus and PAD
	 * Version 2 - This now uses a different approach as we should support
	 *  Image Based comments too.
	 * This object represents the specialties of both systems
	 **/
	import flash.text.TextFormat;
	
	import spark.components.RichText;
	import spark.effects.Animate;
	import spark.primitives.Rect;

	public class Comment extends RichText
	{
		protected var _data:Object;
		protected var borderBox:Rect;
		protected var _index:int;//tracking
		protected var _bottom:int;//tracking
		protected var _effect:Animate;
		protected var _duration:Number=0;
		protected var _containerWidth:int=0;
		protected var config:CommentConfig = new CommentConfig();//default configurations?!
		public function Comment(d:Object){
			super();
			_data = {};
			for (var key:String in d){
				_data[key] = d[key];
			}
			//init();
		}
		public function setY(py:int,idx:int,trans:Function):void{
			this.y = trans(py,this);
			this._index = idx;
			this._bottom = py + this.height;
		}
		public function get index():int{
			return this._index;
		}
		override public function get bottom():Object{
			return this._bottom;
		}
		override public function get right():Object{
			return this.x + this.width;
		}
		public function set duration(dur:Number):void{
			this._duration = dur;
		}
		public function get duration():Number{
			return this._duration;
		}
		public function get stime():Number{
			return this._data['stime'];
		}
		public function validateEX():void{
			this.validateNow();
			this.height = this.measuredHeight;
			this.width = this.measuredWidth;
		}
		public function init():void{
			this.visible = true;
			if(config.bold){
				this.setStyle("fontWeight","bold");
			}
			//this.textField.defaultTextFormat = new TextFormat(config.font,config.relsize * _data.size, _data.color,config.bold);
			this.setStyle("fontSize",config.relsize * _data.size);
			this.setStyle("fontFamily",config.font);
			this.setStyle("color",_data.color);
			this.toolTip="";
			if(_data.mode<6){
				this.alpha = config.alpha;
			}
			this.text = _data.text;
			if(_data.border){
				trace("Border");
			}
			/*
			if(_data.borderColor!=null){
				this.textField.borderColor = _data.borderColor;
			}else{
				this.textField.borderColor = 0x66FFFF;//hmmm
			}*/
			if(this._data.mode>=7){
				this.x = this._data.x;
				this.y = this._data.y;
				this.rotationZ = this._data.rZ;
				this.rotationY = this._data.rY;
				//this.rotation = _data.rZ;
				//this.rotationZ = _data.rZ;
			}
			this.filters = config.filter;
			if(int(_data.color /65536)<10 && int((_data.color%65536)/256)<10 && (_data.color%256)<10 && (_data.mode == 4 || _data.mode==5)){
				this.filters = config.whiteFilter;
			}
			this.validateEX();
		}
		public function set borderColor(c:uint):void{
			//this.textField.borderColor = c;
		}
		public function set effect(effect:Animate):void{
			this._effect = effect;
		}
		public function get effect():Animate{
			return this._effect;
		}
		public function get dataObject():Object{
			return this._data;
		}
		public function set defaults(def:CommentConfig):void{
			this.config = def;
		}
	}
}