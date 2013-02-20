window.cocoa = {

        // js -> cocoa
        send: function(cmd, args) {
            args = args || {};
            var json = encodeURIComponent(JSON.stringify(args));
            window.location.href = 'cocoa://'+cmd+'?json='+json;
        },

        // cocoa -> js
        receive: function(cmd, args) {
            try {
                this[cmd](args);
            } catch (e) {
                console.debug('JS ERROR', e);
                return false;
            }
            return true;
        }
}
