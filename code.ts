figma.showUI(__html__);

figma.ui.onmessage = (msg: { method: string, data: any }) => {
  if (msg.method === 'drawRectangle') {
    const rectangle = figma.createRectangle();
    const src = msg.data;
  
    rectangle.resizeWithoutConstraints(src.width, src.height);
    rectangle.x = src.x;
    rectangle.y = src.y;
    rectangle.fills = src.fills;

    figma.currentPage.appendChild(rectangle);

    // 현재 페이지에 그려진 모든 사각형들이 화면에 들어오도록 화면 이동.
    figma.viewport.scrollAndZoomIntoView(figma.currentPage.children);
  } else if (msg.method === 'getSelection') {
    const selection = figma.currentPage.selection;
    if (selection.length > 0) {
      figma.ui.postMessage({ method: 'getSelection', data: selection });
    }
  }
};
