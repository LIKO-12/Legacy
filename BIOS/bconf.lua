--The default configuation
--per ,err = P(peripheral,mountedName,configTable)

--Create a new cpu mounted as "CPU"
local CPU, CPUKit = assert(P("CPU"))

--Create a new gpu mounted as "GPU"
local GPU, GPUKit = assert(P("GPU","GPU",{
  _ColorSet = { --The P8 Pallete
    {0,0,0,255}, --Black 1
    {28,43,83,255}, --Dark Blue 2
    {127,36,84,255}, --Dark Red 3
    {0,135,81,255}, --Dark Green 4
    {171,82,54,255}, --Brown 5
    {96,88,79,255}, --Dark Gray 6
    {195,195,198,255}, --Gray 7
    {255,241,233,255}, --White 8
    {237,27,81,255}, --Red 9
    {250,162,27,255}, --Orange 10
    {247,236,47,255}, --Yellow 11
    {93,187,77,255}, --Green 12
    {81,166,220,255}, --Blue 13
    {131,118,156,255}, --Purple 14
    {241,118,166,255}, --Pink 15
    {252,204,171,255} --Human Skin 16
  },
  _ClearOnRender = true, --Speeds up rendering, but may cause glitches on some devices !
  CPUKit = CPUKit
}))

local LIKO_W, LIKO_H = GPUKit._LIKO_W, GPUKit._LIKO_H
local ScreenSize = (LIKO_W/2)*LIKO_H

--Create Audio peripheral
assert(P("Audio"))

--Create gamepad contols
assert(P("Gamepad","Gamepad",{CPUKit = CPUKit}))

--Create Touch Controls
assert(P("TouchControls","TC",{CPUKit = CPUKit, GPUKit = GPUKit}))

--Create a new keyboard api mounted as "KB"
assert(P("Keyboard","Keyboard",{CPUKit = CPUKit, GPUKit = GPUKit,_Android = (_OS == "Android"),_EXKB = false}))

--Create a new virtual hdd system mounted as "HDD"
assert(P("HDD","HDD",{
  C = 1024*1024 * 25, --Measured in bytes, equals 25 megabytes
  D = 1024*1024 * 25 --Measured in bytes, equals 25 megabytes
}))

local KB = function(v) return v*1024 end

local RAMConfig = {
  layout = {
    {ScreenSize,GPUKit.VRAMHandler}, --0x0 -> 0x2FFF - The Video ram
    {ScreenSize,GPUKit.LIMGHandler}, --0x3000 -> 0x5FFF - The Label image
    {KB(64)}  --0x6000 -> 0x15FFF - The floppy RAM
  }
}

local RAM, RAMKit = assert(P("RAM","RAM",RAMConfig))

assert(P("FDD","FDD",{
  GPUKit = GPUKit,
  RAM = RAM,
  DiskSize = KB(64),
  FRAMAddress = 0x6000
}))

local _, WEB, WEBKit = P("WEB","WEB",{CPUKit = CPUKit})