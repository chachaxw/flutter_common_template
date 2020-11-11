#!/usr/bin/env bash

appPath="build/ios/iphoneos/Runner.app"
payloadPath="build/ios/iphoneos/Payload"
zipPath="build/ios/iphoneos/Payload.zip"
dateTime=`date +%Y%m%d-%T`
apkPath="build/app/outputs/apk/release/app-release.apk"

outPutPath="build/all/$dateTime"

if [ ! -d "build/all" ]; then
  mkdir "build/all"
fi
if [ ! -d "$outPutPath" ]; then
  mkdir "$outPutPath"
fi

开始打包iOS
echo '🍺🍺🍺🍺===打包iOS===🍺🍺🍺🍺'

# 判断文件是否存在
echo '正在清除原文件'
if [ -d "$appPath" ]; then
  rm -r "$appPath"
fi
if [ -d "$zipPath" ]; then
  rm -r "$zipPath"
fi
if [ -d "$payloadPath" ]; then
  rm -r "$payloadPath"
fi
# 清除fastlane的打包
rm -rf "app"
mkdir "app"

# iOS打包

if [[ "$1" == "dev" ]]; then
  echo '开发环境开始打包'
  flutter build ios -t lib/main_dev.dart --release
elif [[ "$1" == "test" ]]; then
  echo '测试环境开始打包'
  flutter build ios -t lib/main_test.dart --release
else
  echo '生产环境开始打包'
  flutter build ios --release
fi

if [ -d "$appPath" ]; then
  echo 'build ios 成功'
  echo '正在生成ipa包'
   cd 'ios'
   fastlane make
   cd '..'
   if [ -f "app/消杀App.ipa" ]; then
     mv "app/消杀App.ipa" "$outPutPath"
     echo "生成ipa成功 路径:$outPutPath"
   else
     echo '生成ipa失败'
   fi
else
  echo '打包失败'
fi


#echo '🍺🍺🍺🍺===打包android===🍺🍺🍺🍺'
# 判断文件是否存在
echo '正在清除原文件'
if [ -f "$apkPath" ]; then
  rm "$apkPath"
fi

# 安卓打包

if [[ "$1" == "dev" ]]; then
  echo '开发环境开始打包'
  flutter build apk -t lib/main_dev.dart --target-platform=android-arm64
elif [[ "$1" == "test" ]]; then
  echo '测试环境开始打包'
  flutter build apk -t lib/main_test.dart --target-platform=android-arm64
else
  echo '生产环境开始打包'
  flutter build apk --target-platform=android-arm64
fi

if [ -f "$apkPath" ]; then
  echo 'build akp 成功'
  mv "$apkPath" "$outPutPath/消毒配送通用工具[$dateTime].apk"
else
  echo 'apk 打包失败'
fi

open "$outPutPath"
echo "\033[36;1m打包总用时: ${SECONDS}s \033[0m"
