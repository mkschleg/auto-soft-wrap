{CompositeDisposable} = require 'atom'

module.exports = AutoSoftWrap =

  modalPanel: null
  subscriptions: null


  activate: (@state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    didChangeActiveItemInPane(atom.workspace.getActiveTextEditor())
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.workspace.onDidChangeActivePaneItem(didChangeActiveItemInPane)

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()

  serialize: ->
    

	#didChangeActiveItemInPane is a text editor in most cases. Lets make sure we
	# check for otherwise
	didChangeActiveItemInPane = (item) ->
		if item?
			if item.getPath?
				path = item.getPath()
				if path?
					extension = path.substr(path.lastIndexOf("."))
					fileTypes = atom.config.get("auto-soft-wrap.softWrapFileTypes")
					if (extension in fileTypes)
            if item.setSoftWrapped?
              item.setSoftWrapped(true)
