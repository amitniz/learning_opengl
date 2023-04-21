#pragma once

#include "Core.h"

namespace GameEngine {
	class GE_API Application
	{
	public:
		Application();
		virtual ~Application();
		void Run();
	};

	//defined by the client
	Application* CreateApplication();
}


