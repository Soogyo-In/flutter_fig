globalThis.postMessage = (method, data) => parent.postMessage(
    { pluginMessage: { method, data } }, '*'
);

window.onmessage = (event) => { 
    const message = event.data.pluginMessage;
    globalThis.onMessage({method: message.method, data: message.data}); 
};
