package com.example.flutter_plugin_old;

import android.util.Log;

import androidx.annotation.NonNull;

import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterPluginOldPlugin */
public class FlutterPluginOldPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  //事件派发对象
  private EventChannel.EventSink eventSink = null;
  //事件派发流
  private EventChannel.StreamHandler streamHandler = new EventChannel.StreamHandler() {
    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
      //监听时进项赋值
      eventSink = events;
    }

    @Override
    public void onCancel(Object arguments) {
      //取消监听时进行
      eventSink =null;
    }
  };



  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_plugin_old");
    channel.setMethodCallHandler(this);
    //初始化事件  跟着上面的方法  学 就行了
    EventChannel eventChannel = new EventChannel(
            flutterPluginBinding.getBinaryMessenger(),
            "flutter_plugin_old_event");
    eventChannel.setStreamHandler( streamHandler);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("changePageTitle")) {
      result.success("我想干你");
    } else if (call.method.equals("getAndPushValue")) {
      String message=call.argument("message");
      String info=call.argument("info");
      System.out.println("Java层--->message:"+message);
      System.out.println("Java层--->info:"+info);
//      System.out.println("安卓打印的数据:  "+message);
      ConstraintsMap map =  new ConstraintsMap();
      map.putString("message","姜贞羽吃了我的鸡儿");
      map.putString("info","姜贞羽吃了我的精子");
      System.out.printf("安卓Map传递:  "+info);
      ///传递字典
//      result.success(message);
//      result.success(map.toMap());

      //开始派发事件
      if(eventSink != null){
        System.out.println("安卓-----发现有监听派发对象");
        System.out.println("开始延时10秒发送消息");
        try
        {
          Thread.sleep(10000);//单位：毫秒
        } catch (Exception e) {
          
        }
        ConstraintsMap params = new ConstraintsMap();
        params.putString("event" , "姜贞羽开始舔我鸡儿");
        params.putString("value","姜贞羽给我舔射");
        System.out.println("android-----延时十秒结束,安卓开始派发消息");
        eventSink.success(params.toMap());
      }


    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
