def start_app
  java_import "com.jme3.system.AppSettings"

  app_settings = AppSettings.new(true)
  app_settings.title = "My game"
  app_settings.samples = 4
  # app_settings.fullscreen = true
  app_settings.set_resolution(800, 600) #old school resolution

  app = MyGame.new
  app.settings = app_settings
  app.setShowSettings(false)
  app.start
end
