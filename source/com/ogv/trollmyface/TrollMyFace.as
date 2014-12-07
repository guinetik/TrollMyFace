package com.ogv.trollmyface
{
	
	import com.greensock.TweenLite;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.guinetik.kinetic.ui.Botao;
	import com.guinetik.kinetic.ui.GenericShape;
	import com.guinetik.kinetic.ui.textmask.TextMask;
	import com.guinetik.kinetic.ui.textmask.TextMaskMultiline;
	import com.guinetik.kinetic.utils.FPSMonitor;
	import com.guinetik.kinetic.utils.FontUtils;
	import com.ogv.trollmyface.elements.NoiseBG;
	import com.ogv.trollmyface.elements.detectors.FaceDetectorCamera;
	import com.ogv.trollmyface.model.IFaceDetector;
	
	import fl.motion.easing.Exponential;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.utils.setTimeout;
	
	[SWF(backgroundColor="#000000", frameRate="30")]
	
	public class TrollMyFace extends Sprite
	{
		
		[Embed(source="assets/coolvetica.ttf", fontName="Coolvetica", mimeType="application/x-font")]
		private var DefaultFont:Class;
		
		[Embed(source="assets/facebook_32.png", mimeType="image/png")]
		private var IconFacebook					:Class;
		
		[Embed(source="assets/twitter_32.png", mimeType="image/png")]
		private var IconTwitter						:Class;
		
		private var txtTitulo						:TextMask;
		private var txtTexto						:TextMaskMultiline;
		
		private var container						:Sprite;
		
		private var btTrollImage					:TextMask;
		private var btTrollCamera					:TextMask;
		
		private var btFacebook						:Botao;
		private var btTwitter						:Botao;
		private var txtCompartilhe					:TextMask;
		
		private var bg								:NoiseBG;
		
		private var trollDetector					:IFaceDetector;
		
		public function TrollMyFace()
		{
			
			TweenPlugin.activate([TintPlugin]);
			
			stage.align 							= "TL";
			stage.scaleMode 						= "noScale";
			stage.addEventListener(Event.RESIZE, onResize);
			
			container								= new Sprite();
			addChild(container);
			
			var bgBranco:GenericShape				= new GenericShape(796, 596, 0xFFFFFF);
			var bgPreto:GenericShape				= new GenericShape(800, 600, 0x333333);
			
			bg										= bgBranco.addChild(new NoiseBG()) as NoiseBG;
			
			bgBranco.x = bgBranco.y					= 2;
			
			container.addChild(bgPreto);
			container.addChild(bgBranco);
			
			FontUtils.registerFont(new DefaultFont(), "default");
			
			txtTitulo								= new TextMask(FontUtils.getFontName("default"), {fundo:0x000000, txt:0xFFFFFF}, null, new TextFormat(FontUtils.getFontName("default"), 30), false, 0.2);
			txtTitulo.text							= "Troll My Face";
			container.addChild(txtTitulo);
			
			txtTexto								= new TextMaskMultiline(140, FontUtils.getFontName("default"), {fundo:0x000000, txt:0xFFFFFFF}, null, new TextFormat(FontUtils.getFontName("default"), 14), 0.2, 16, 0);
			txtTexto.text							= "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum";
			container.addChild(txtTexto);
			
			txtTexto.y								= 50;
			txtTexto.x								= 5;
			
			txtTitulo.x								= 5; 
			txtTitulo.y								= 5;
			
			btTrollImage							= new TextMask(FontUtils.getFontName("default"), {fundo:0x000000, txt:0xFFFFFF}, {fundo:0xFFFFFF, txt:0x000000}, new TextFormat(FontUtils.getFontName("default"), 30), false, 0.2);
			btTrollImage.text						= "Troll Picture";
			container.addChild(btTrollImage);
			btTrollImage.setButton({fundo:0xFFFFFF, txt:0x000000}, 1, Exponential.easeOut, 1, Exponential.easeOut);
			btTrollImage.addEventListener(MouseEvent.CLICK, initTrollImage);
			
			btTrollCamera							= new TextMask(FontUtils.getFontName("default"), {fundo:0x000000, txt:0xFFFFFF}, {fundo:0xFFFFFF, txt:0x000000}, new TextFormat(FontUtils.getFontName("default"), 30), false, 0.2);
			btTrollCamera.text						= "Troll Camera";
			container.addChild(btTrollCamera);
			btTrollCamera.setButton({fundo:0xFFFFFF, txt:0x000000}, 1, Exponential.easeOut, 1, Exponential.easeOut);
			btTrollCamera.addEventListener(MouseEvent.CLICK, initTrollCamera);
			
			btTrollCamera.y							= int((container.height - btTrollCamera.height)/2);
			btTrollImage.y							= btTrollCamera.y;
			
			btTrollCamera.x							= int((container.width - btTrollCamera.width - btTrollImage.width - 10)/2);
			btTrollImage.x							= btTrollCamera.x + btTrollCamera.width + 5;
			
			btFacebook								= new Botao();
			btFacebook.addChild(new IconFacebook());
			container.addChild(btFacebook);
			
			btTwitter								= new Botao();
			btTwitter.addChild(new IconTwitter());
			container.addChild(btTwitter);
			
			txtCompartilhe							= new TextMask(FontUtils.getFontName("default"), {fundo:0x000000, txt:0xFFFFFF}, {fundo:0xFFFFFF, txt:0x000000}, new TextFormat(FontUtils.getFontName("default"), 14), false, 0.2);
			txtCompartilhe.text						= "Compartilhe: ";
			container.addChild(txtCompartilhe);
			
			txtCompartilhe.x						= 10;
			txtCompartilhe.y						= container.height - txtCompartilhe.height - 10;
			
			btTwitter.x								= txtCompartilhe.x + txtCompartilhe.width + 10;
			btTwitter.y								= txtCompartilhe.y - 10;
			
			btFacebook.x							= btTwitter.x + btTwitter.width + 10;
			btFacebook.y							= btTwitter.y;
			
			btTwitter.alpha = btFacebook.alpha		= 0;
			
			onResize();
			init();
			
			addChild(new FPSMonitor());
			
		}

		private function initTrollImage(event:MouseEvent):void
		{
			
			btTrollImage.enabled 					= false;
			moveBts();
			
		}

		private function initTrollCamera(event:MouseEvent):void
		{
			
			btTrollCamera.enabled 					= false;
			moveBts();
			txtTexto.close(1, Exponential.easeInOut);
			bg.stopBG();
			setTimeout(initTrollDetector, 1000);
			
		}

		private function initTrollDetector():void
		{
			trollDetector							= new FaceDetectorCamera();
			container.addChildAt(trollDetector as DisplayObject, 2);
			Sprite(trollDetector).x					= int((container.width - 640)/2);
			Sprite(trollDetector).y					= int((container.height - 480)/2);
		}
		
		public function init():void
		{
			
			txtTitulo.init(1, Exponential.easeInOut, 0);
			txtTexto.init(1, Exponential.easeInOut, 1);
			
			btTrollCamera.init(1, Exponential.easeInOut, 1.5);
			btTrollImage.init(1, Exponential.easeInOut, 1.8);
			
			txtCompartilhe.init(1, Exponential.easeInOut, 2);
			TweenLite.to(btTwitter, 1, 					{alpha:1, ease:Exponential.easeInOut, delay:2.2});
			TweenLite.to(btFacebook, 1, 				{alpha:1, ease:Exponential.easeInOut, delay:2.4});
			
		}
		
		private function moveBts():void
		{
			
			TweenLite.to(btTrollCamera, 1, 				{scaleX:0.5, scaleY:0.5, ease:Exponential.easeInOut, x:btFacebook.x + btFacebook.width + 10, y:txtCompartilhe.y});
			TweenLite.to(btTrollImage, 1, 				{scaleX:0.5, scaleY:0.5, ease:Exponential.easeInOut, x:btFacebook.x + btFacebook.width + 10 + btTrollImage.width/2 + 10, y:txtCompartilhe.y});
			
		}
		
		private function onResize(event:Event = null):void
		{
			
			container.x									= int((stage.stageWidth - 800)/2);
			container.y									= int((stage.stageHeight - 600)/2);
			
		}
	}
}