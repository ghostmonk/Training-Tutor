package ca.georgebrown.trainingtutor.utils
{
	public class TextFormatting
	{
		public static function removeWhiteSpace( input:String ) : String
		{
			var output:String = input.replace( /\t/g, "" );
			output = output.replace( /\r/, "" );
			output = output.replace( /\n/, "" );
			output = output.replace( new RegExp( "(\r)+$" ), "" );
			output = output.replace( new RegExp( "(\n)+$" ), "" );
			return output;
		}
	}
}