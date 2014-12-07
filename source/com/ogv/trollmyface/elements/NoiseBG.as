package com.ogv.trollmyface.elements
{
	import com.flashandmath.dg.display.RetroTV;
	import com.guinetik.kinetic.utils.Mascara;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class NoiseBG extends Sprite
	{
		
		private var noise:RetroTV;
		
		public function NoiseBG()
		{
			
			noise = new RetroTV(266, 199, 1);
			addChild(noise);
			
			noise.redOffsetX = 1.5;
			noise.redOffsetY = 0.75;
			noise.greenOffsetX = -0.5;
			noise.greenOffsetY = 0;
			noise.blueOffsetX = -0.25;
			noise.blueOffsetY = 0;
			noise.warping = true;
			
			var msk:Mascara = new Mascara(this, 796, 596, 0, 0);
			addChild(msk);
			
			this.addEventListener(Event.ENTER_FRAME, loop);
			
		}
		
		public function stopBG():void
		{
			
			this.removeEventListener(Event.ENTER_FRAME, loop);
			
		}

		private function loop(event:Event):void
		{
			
			noise.update();
			
		}
	}
}