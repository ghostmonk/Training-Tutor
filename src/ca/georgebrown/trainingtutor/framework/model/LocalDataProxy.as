package ca.georgebrown.trainingtutor.framework.model
{
	import flash.events.AsyncErrorEvent;
	import flash.events.SyncEvent;
	import flash.net.ObjectEncoding;
	import flash.net.SharedObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class LocalDataProxy extends Proxy
	{
		public static const NAME:String = "SOPProgressTracker";
		private static const LOCAL_PATH:String = "/gbc_tutor/";
		
		private var _soData:SharedObject; 
		
		public function LocalDataProxy()
		{
			_soData = SharedObject.getLocal( NAME );
			_soData.objectEncoding = ObjectEncoding.AMF0;
			_soData.addEventListener( AsyncErrorEvent.ASYNC_ERROR, onAsyncError );
			_soData.addEventListener( SyncEvent.SYNC, onSyncEvent );
			super( NAME, _soData );
		}
		
		public function get currentSection() : int
		{
			return _soData.data.currentSection || 0;
		}
		
		public function updateSection( value:int ) : void
		{
			_soData.data.currentSection = value;
			_soData.flush();
		}
		
		private function onAsyncError( e:AsyncErrorEvent )  : void
		{
			trace( NAME, e.error.message );
		}
		
		private function onSyncEvent( e:SyncEvent ) : void
		{
			trace( NAME, e.changeList );
		}
	}
}