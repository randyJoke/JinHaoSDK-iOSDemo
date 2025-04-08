# JinHaoSDK API Documentation

## Table of Contents
1. [Introduction](#introduction)
2. [Requirements](#equirements)
3. [Initialization](#initialization)
4. [Classes](#classes)
	- [AccessoryManager](AccessoryManager.md)
	- [Accessory](Accessory.md)
	- [JinHaoAccessory](JinHaoAccessory.md)
	- [JinHaoDsp](JinHaoDsp.md)
	- [JinHaoGlobalDsp](JinHaoGlobalDsp.md)
	- [JinHaoProfile](JinHaoProfile.md)
	- [JinHaoRequest](JinHaoRequest.md)
	- [JinHaoResult](JinHaoResult.md)
	- [Enum](Enum.md)
5. [Usage](#api-reference)
    - [scanForDevices](#scanfordevices)
    - [connectToDevice](#connecttodevice)
    - [Volume Control](#volume-control)
        - [getVolumeLevel](#getvolumelevel)
        - [setVolume](#setvolume)
    - [Hearing Mode Control](#hearing-mode-control)
        - [setHearingMode](#sethearingmode)
    - [EQ Control](#eq-control)
        - [getEQSettings](#geteqsettings)
        - [setEQSettings](#seteqsettings)
    - [Noise Cancellation Control](#noise-cancellation-control)
        - [setNoiseCancellation](#setnoisecancellation)
    - [Disconnecting](#disconnecting)


---

## Introduction
The JinHaoSDK provides a set of APIs to communicate with Bluetooth Low Energy (BLE) hearing aids. The SDK allows you to connect to hearing aids, adjust volume, switch hearing modes, and manage sound settings like equalizer (EQ) and noise cancellation.

This guide will walk you through the steps to integrate the SDK into your iOS app and demonstrate how to use the SDK’s key functionalities.

## Requirements
- iOS 11.0+


## Initialization

### 1. Add the `JinHaoSDK.xcframework` to Your Project
- Drag the `JinHaoSDK.xcframework` file into your Xcode project.
- In the "Add to Project" dialog, select "Copy items if needed" and add it to the appropriate targets.

### 2. Configure Framework Search Paths
- Go to **Build Settings** > **Framework Search Paths**.
- Add the path where the `JinHaoSDK.xcframework` is located, e.g., `$(PROJECT_DIR)/Frameworks`.

### 3. Link the Framework
- In **Build Phases** > **Link Binary With Libraries**, click **+** and select your `.xcframework`.

### 4. Embed & Sign the Framework
- In the **General** tab, under **Frameworks, Libraries, and Embedded Content**, find your `.xcframework`.
- Set "Embed" to **Embed & Sign**.


## Usage


### 1. scanForDevices



















