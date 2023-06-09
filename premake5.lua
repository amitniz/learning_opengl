workspace "GameEngine"
    architecture "x64"

    configurations{
        "Debug",
        "Release",
        "Dist"
    }

outputdir = "%{cfg.buildcfg}--%{cfg.system}-%{cfg.architecture}"

project "GameEngine"
    location "GameEngine"
    kind "SharedLib"
    language "C++"

    targetdir("bin/" .. outputdir .. "/%{prj.name}")
    objdir("bin-int/" .. outputdir .. "/%{prj.name}")

    files{
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.hpp",
        "%{prj.name}/src/**.cpp"
    }

    includedirs{
        "GameEngine/vendor/spdlog/include"
    }

    filter "system:windows"
        cppdialect "c++17"
        staticruntime "On"
        systemversion "10.0"
        
        defines{
            "GE_PLATFORM_WINDOWS",
            "GE_BUILD_DLL"
        }

        postbuildcommands{
            ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
        }

    filter "configurations:Debug"
        defines "GE_DEBUG"
        symbols "On"

    filter "configurations:Release"
    defines "GE_RELEASE"
    symbols "On"

    filter "configurations:Dist"
    defines "GE_DIST"
    symbols "On"

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"

    targetdir("bin/" .. outputdir .. "/%{prj.name}")
    objdir("bin-int/" .. outputdir .. "/%{prj.name}")

    files{
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.hpp",
        "%{prj.name}/src/**.cpp"
    }

    includedirs{
        "GameEngine/vendor/spdlog/include",
        "GameEngine/src"
    }

    links{
        "GameEngine"
    }

    filter "system:windows"
        cppdialect "c++17"
        staticruntime "On"
        systemversion "10.0"
        
        defines{
            "GE_PLATFORM_WINDOWS"
        }


    filter "configurations:Debug"
        defines "GE_DEBUG"
        symbols "On"

    filter "configurations:Release"
    defines "GE_RELEASE"
    symbols "On"

    filter "configurations:Dist"
    defines "GE_DIST"
    symbols "On"