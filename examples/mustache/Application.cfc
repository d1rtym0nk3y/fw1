component extends=framework.one {

variables.framework.trace = true;

	// use .hbs instead of .cfm templates
    function customizeViewOrLayoutPath( struct pathInfo, string type, string fullPath ) {
    	return '#pathInfo.base##type#s/#pathInfo.path#.mustache'
    }

    private string function internalView( string viewPath, struct args = { } ) {
        var rc = request.context;
        var $ = { };
        // integration point with Mura:
        if ( structKeyExists( rc, '$' ) ) {
            $ = rc.$;
        }
        structAppend( local, args );
        return new Mustache().render(fileRead(viewPath), local);
    }

    private string function internalLayout( string layoutPath, string body ) {
        var rc = request.context;
        var $ = { };
        // integration point with Mura:
        if ( structKeyExists( rc, '$' ) ) {
            $ = rc.$;
        }
        return new Mustache().render(fileRead(layoutPath), local, {body:body});
    }

}
