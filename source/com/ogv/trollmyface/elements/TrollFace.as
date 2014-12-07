package com.ogv.trollmyface.elements
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class TrollFace extends Sprite
	{
		private var face:Sprite;
		
		[Embed (source="assets/trollface.png")]
		private var TrollFaceAsset:Class;
		
		public function TrollFace()
		{
			
			face = new Sprite();
			face.addChild(new TrollFaceAsset());
			this.addChild(face);
			
		}
	}
}