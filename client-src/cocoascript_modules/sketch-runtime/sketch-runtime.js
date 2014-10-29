// sketch-runtime.js
// http://github.com/turbobabr/sketch-runtime
// (c) 2014 Andrey Shakhmin
// May be freely distributed under the MIT license.


(function(){
    var root=this;

    var SketchRuntime = {};

    var isSandboxed=(sketch.scriptPath.indexOf("/Library/Containers/")>-1);
    var bundleID=NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleIdentifier").UTF8String();
    var isBeta = (bundleID=="com.bohemiancoding.sketch3.beta") ? true : false;

    var meta = {
        bundleID: bundleID,
        isSandboxed: isSandboxed
    };

    function exchangeData(obj) {

        var filePath=MSPlugin.pluginsURL().path()+"/sdt-exchange.json";
        var json=NSString.stringWithString(JSON.stringify(obj,null,4));

        [json writeToFile:filePath atomically:true encoding:NSUTF8StringEncoding error:null];
    }

    function notify() {
        var observedObject = "com.turbobabr.sketch.devtools.command";
        var center = [NSDistributedNotificationCenter defaultCenter];

        var notificationName=(isBeta ? "beta" : "release") +"-"+ (isSandboxed ? "sandboxed" : "normal");
        [center postNotificationName:notificationName object: observedObject userInfo:null deliverImmediately: true];
    }

    SketchRuntime.registerAction = function(id,name,origin,filePath) {

        exchangeData({
            command: "RegisterAction",
            data: {
                enabled: true,
                external: true,
                id: id,
                name: name,
                origin: origin,
                trigger: "onLaunch",
                filePath: filePath,
                target: meta.bundleID
            },
            meta: meta
        });

        notify();
    };

    SketchRuntime.registerActionWithSource = function(id,name,origin,scriptSource) {
        exchangeData({
            command: "RegisterAction",
            data: {
                enabled: true,
                external: false,
                id: id,
                name: name,
                origin: origin,
                trigger: "onLaunch",
                source: scriptSource,
                target: meta.bundleID
            },
            meta: meta
        });

        notify();
    };

    SketchRuntime.unregisterAction = function(id) {
        exchangeData({
            command: "RemoveAction",
            data: {
                id: id,
                target: meta.bundleID
            },
            meta: meta
        });

        notify();
    };

    SketchRuntime.enableAction = function(id,enabled) {
        exchangeData({
            command: "EnableAction",
            data: {
                id: id,
                value: enabled,
                target: meta.bundleID
            },
            meta: meta
        });

        notify();
    };

    SketchRuntime.run = function(id,initScriptPath,mainScriptPath) {
        var persistentStorage = [[NSThread mainThread] threadDictionary];

        var runtime=persistentStorage[id];
        if(runtime==null) {

            var initScriptSource = NSString.stringWithContentsOfFile_encoding_error(initScriptPath,NSUTF8StringEncoding,null);
            if(!initScriptSource) {
                throw new Error("Can't load initializer script!");
                return;
            }

            runtime=MSPlugin.alloc().init();
            runtime.logger=ECASLClient.sharedInstance();

            var session=COScript.alloc().init();
            session.printController = runtime;
            session.errorController = runtime;
            session.shouldKeepAround=true;
            runtime.session=session;

            var processedScript=runtime.scriptWithExpandedImports_path(initScriptSource,initScriptPath);
            session.executeString(processedScript);
            [session executeString:processedScript baseURL:NSURL.fileURLWithPath(initScriptPath)];

            persistentStorage[id]=runtime;
        }

        if(mainScriptPath) {

            var mainScriptSource = NSString.stringWithContentsOfFile_encoding_error(mainScriptPath,NSUTF8StringEncoding,null);
            if(!mainScriptSource) {
                throw new Error("Can't load main script!");
                return;
            }

            var session=runtime.session();

            var scriptBooster = ""+
                "var doc=MSDocument.currentDocument();"+
                "var selection=doc.findSelectedLayers();"+
                "var sketch = {"+
                "doc: doc,"+
                "scriptPath: NSString.stringWithString(\""+mainScriptPath+"\"),"+
                "scriptURL: NSURL.fileURLWithPath(\""+mainScriptPath+"\"),"+
                "selection: selection"+
                "};";

            // Boost session with variables.
            [session executeString:scriptBooster baseURL:NSURL.fileURLWithPath(mainScriptPath)];

            var processedScript=runtime.scriptWithExpandedImports_path(mainScriptSource,mainScriptPath);
            [session executeString:processedScript baseURL:NSURL.fileURLWithPath(mainScriptPath)];
        }
    };


    root.SketchRuntime = SketchRuntime;

}).call(this);