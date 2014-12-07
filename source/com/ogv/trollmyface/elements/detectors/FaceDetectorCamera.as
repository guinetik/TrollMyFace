package com.ogv.trollmyface.elements.detectors
{
	import com.greensock.TweenLite;
	import com.ogv.trollmyface.elements.TrollFace;
	import com.ogv.trollmyface.model.IFaceDetector;
	import com.quasimondo.bitmapdata.CameraBitmap;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import jp.maaash.ObjectDetection.ObjectDetector;
	import jp.maaash.ObjectDetection.ObjectDetectorEvent;
	import jp.maaash.ObjectDetection.ObjectDetectorOptions;
	
	public class FaceDetectorCamera extends Sprite implements IFaceDetector
	{
		
		private var detector    :ObjectDetector;
		private var options     :ObjectDetectorOptions;
		
		private var view :Sprite;
		private var faceRectContainer :Sprite;
		private var tf :TextField;
		
		private var camera:CameraBitmap;
		private var detectionMap:BitmapData;
		private var drawMatrix:Matrix;
		private var scaleFactor:int = 4;
		private var w:int = 640;
		private var h:int = 480;
		
		private var lastTimer:int = 0;
		
		private var face:Bitmap;
		private var borda:Sprite;
		
		[Embed (source="assets/trollface.png")]
		private var TrollFaceAsset:Class;
		
		public function FaceDetectorCamera() 
		{
			
			borda = new Sprite();
			borda.graphics.lineStyle(1, 0xFFFFFF);
			borda.graphics.drawRect(0, 0, 640, 480);
			
			init();
			initDetector();
			
		}
		
		public function init():void
		{
			
			view = new Sprite;
			addChild(view);
			
			camera = new CameraBitmap( w, h, 15 );
			camera.addEventListener(Event.INIT, initCamera);
			view.addChild( new Bitmap( camera.bitmapData ) );
			
			faceRectContainer = new Sprite;
			view.addChild( faceRectContainer );
			addChild(borda);
			
		}

		private function initCamera(event:Event):void
		{
			
			trace("FaceDetectorCamera.initCamera(event)");
			
			initDetector();
			camera.addEventListener( Event.RENDER, cameraReadyHandler );
			
		}
		
		private function cameraReadyHandler( event:Event ):void
		{
			
			trace("FaceDetectorCamera.cameraReadyHandler(event)");
			
			if(detectionMap != null)
			{
				
				detectionMap.draw(camera.bitmapData,drawMatrix,null,"normal",null,true);
				detector.detect( detectionMap );
				
			}
		}
		
		public function initDetector():void
		{
			
			trace("FaceDetectorCamera.initDetector()");
			
			detectionMap = new BitmapData( w / scaleFactor, h / scaleFactor, false, 0 );
			drawMatrix = new Matrix( 1/ scaleFactor, 0, 0, 1 / scaleFactor );
			
			detector = new ObjectDetector();
			var options:ObjectDetectorOptions = new ObjectDetectorOptions();
			options.min_size  = 30;
			detector.options = options;
			detector.addEventListener(ObjectDetectorEvent.DETECTION_COMPLETE, detectionHandler );
			
		}
		
		
		
		private function detectionHandler( e :ObjectDetectorEvent ):void
		{
			
			trace("FaceDetectorCamera.detectionHandler(e)");
			
			var g :Graphics = faceRectContainer.graphics;
			g.clear();
			if( e.rects.length > 0 )
			{
				g.lineStyle( 2, 0, 0.5 );	// black 2pix
				e.rects.forEach( function( r :Rectangle, idx :int, arr :Array ) :void
				{
					if(face == null)
					{
						face = new TrollFaceAsset();
						addChild(face);
						
					}
					
					face.x = (r.x * scaleFactor);
					face.y = (r.y * scaleFactor);
					face.width = (r.width * scaleFactor);
					face.height = (r.height * scaleFactor);
					
//					TweenLite.to(face, 1, {x:(r.x * scaleFactor) - 70, y:(r.y * scaleFactor) - 40, width:(r.width * scaleFactor) + 60, height:(r.height * scaleFactor) + 60});
					
					g.drawRect( r.x * scaleFactor, r.y * scaleFactor, r.width * scaleFactor, r.height * scaleFactor );
				});
			} else 
			{
				
				if(face != null)
				{
					
					removeChild(face);
					face = null;
					
				}
				
			}
			
		}
		
		
	}
}