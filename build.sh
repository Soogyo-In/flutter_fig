#!/bin/bash

# Flutter 웹 앱 빌드
cd app && flutter build web --web-renderer=html

# Figma plugin 빌드
cd .. && npm run build

# 파일 경로 설정
UI_HTML="ui.html"
JS_FILES=(
    "script/intercept_fetch.js"
    "script/polyfill_history.js"
    "script/messenger.js"
    "app/build/web/main.dart.js"
    "app/build/web/flutter.js"
)

# ui.html 파일 비우기
> "$UI_HTML"

# JavaScript 파일의 내용을 <script> 태그로 감싸서 ui.html에 추가
for JS_FILE in "${JS_FILES[@]}"; do
    echo "<script>" >> "$UI_HTML"
    cat "$JS_FILE" >> "$UI_HTML"
    echo "</script>" >> "$UI_HTML"
done
