FlexToolbar = require '../lib/flex-tool-bar'
path = require 'path'
ToolBarCson = path.join __dirname, './cdetoolbar.cson'

describe "FlexToolBar", ->
  [workspaceElement, flexToolBar, editor, toolBar, jsGrammar] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    atom.config.set 'cde-flex-toolbar.toolBarConfigurationFilePath', ToolBarCson

    waitsForPromise ->
      atom.packages.activatePackage('tool-bar').then (pack) ->
        toolBar = pack.mainModule

    waitsForPromise ->
      atom.packages.activatePackage('cde-flex-toolbar').then (pack) ->
        flexToolBar = pack.mainModule

    waitsForPromise ->
      atom.packages.activatePackage('language-text')

    waitsForPromise ->
      atom.packages.activatePackage('language-javascript')

    waitsForPromise ->
      atom.workspace.open 'sample.js'

    runs ->
      editor = atom.workspace.getActiveTextEditor()
      jsGrammar = atom.grammars.grammarForScopeName('source.js')

  describe "@activate", ->
    it "store grammar", ->
      expect(flexToolBar.currentGrammar).toBe editor.getGrammar().name.toLowerCase()
