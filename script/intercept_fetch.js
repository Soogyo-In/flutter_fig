const _originalFetch = window.fetch;

window.fetch = (url, options = {}) => new Promise(
    function (resolve, reject) {
        if (url.endsWith('FontManifest.json')) {
            resolve(new Response(
                "[]",
                {
                    status: 200,
                    statusText: 'OK',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                }
            ));
            return;
        }

        _originalFetch(url, options);
    },
);
