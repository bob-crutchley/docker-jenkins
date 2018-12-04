import jenkins.model.*
import java.util.logging.Logger
def logger = Logger.getLogger("")
def installed = false
def initialized = false

def plugins = new File("${System.getenv("BUILD_RESOURCES")}/jenkins_plugins.txt")
plugins = plugins.readLines().collect {
	return it.trim()
}
logger.info("" + plugins)
def instance = Jenkins.getInstance()
def pm = instance.getPluginManager()
def uc = instance.getUpdateCenter()
plugins.each { 
  logger.info("Checking ${it}")
  if (!pm.getPlugin(it)) {
    logger.info("Looking UpdateCenter for ${it}")
    if (!initialized) {
      uc.updateAllSites()
      initialized = true
    }
    def plugin = uc.getPlugin(it)
    if (plugin) {
      logger.info("Installing ${plugin}")
    	def installFuture = plugin.deploy()
      while(!installFuture.isDone()) {
        logger.info("Waiting for plugin install: ${plugin}")
        sleep(3000)
      }
      installed = true
    }
  }
}
if (installed) {
  logger.info("Plugins installed, initializing a restart!")
  instance.save()
  instance.restart()
}
