package com.ogv.trollmyface.elements.detectors
{
	import bs.Button;
	
	import com.ogv.trollmyface.model.IFaceDetector;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import jp.maaash.ObjectDetection.ObjectDetector;
	import jp.maaash.ObjectDetection.ObjectDetectorEvent;
	import jp.maaash.ObjectDetection.ObjectDetectorOptions;
	
	public class FaceDetectorImage extends Sprite implements IFaceDetector
	{
		
		private var debug :Boolean = true;
		
		private var detector    			:ObjectDetector;
		private var options     			:ObjectDetectorOptions;
		private var faceImage   			:Sprite;
		private var bmpTarget   			:Bitmap;
		
		private var view 					:Sprite;
		private var faceRectContainer 		:Sprite;
		
		private var lastTimer				:int = 0;
		
		public function FaceDetectorImage()
		{
			init();
		}

		public function startDetection():void
		{
			// TODO Auto-generated method stub
		}

		public function init():void
		{
			
			view 							= new Sprite();
			addChild(view);
			
		}

		public function initDetector():void
		{
			// TODO Auto-generated method stub
		}
	}
}