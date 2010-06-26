package ca.georgebrown.trainingtutor.framework.model
{
	import ca.georgebrown.trainingtutor.components.coreParts.NavigationBar;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.SyncEvent;
	import flash.net.ObjectEncoding;
	import flash.net.SharedObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class LocalDataProxy extends Proxy
	{
		public static const NAME:String = "SOPProgressTracker";
		private static const LOCAL_PATH:String = "/gbc_tutor/";
		
		private static var _soData:SharedObject;
		private static var _topSection:int; 
		
		public function LocalDataProxy()
		{
			_soData = SharedObject.getLocal( NAME );
			_soData.objectEncoding = ObjectEncoding.AMF0;
			_soData.addEventListener( AsyncErrorEvent.ASYNC_ERROR, onAsyncError );
			_soData.addEventListener( SyncEvent.SYNC, onSyncEvent );
			//_soData.data.currentSection = 0;
			//_soData.flush();
			super( NAME, _soData );
		}
		
		public function get currentSection() : int
		{
			_topSection = _soData.data.currentSection || 0; 
			return _topSection;
		}
		
		public static function updateSection( value:int ) : void
		{
			_topSection = Math.max( _topSection, value );
			_soData.data.currentSection = _topSection;
			_soData.flush();
			NavigationBar.instance.sectionAccess( _topSection );
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