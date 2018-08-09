(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["index"],{

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nvar _jquery = _interopRequireDefault(__webpack_require__(/*! jquery */ \"./node_modules/jquery/dist/jquery.js\"));\n\n__webpack_require__(/*! bootstrap */ \"./node_modules/bootstrap/dist/js/npm.js\");\n\n__webpack_require__(/*! bootstrap/dist/css/bootstrap.min.css */ \"./node_modules/bootstrap/dist/css/bootstrap.min.css\");\n\n__webpack_require__(/*! ./css/open-sans.css */ \"./src/css/open-sans.css\");\n\nvar _vue = _interopRequireDefault(__webpack_require__(/*! vue */ \"./node_modules/vue/dist/vue.esm.js\"));\n\nvar _vuex = _interopRequireDefault(__webpack_require__(/*! vuex */ \"./node_modules/vuex/dist/vuex.esm.js\"));\n\nvar _vueMeta = _interopRequireDefault(__webpack_require__(/*! vue-meta */ \"./node_modules/vue-meta/lib/vue-meta.js\"));\n\nvar _vueRouter = _interopRequireDefault(__webpack_require__(/*! vue-router */ \"./node_modules/vue-router/dist/vue-router.esm.js\"));\n\nvar _vueNativeWebsocket = _interopRequireDefault(__webpack_require__(/*! vue-native-websocket */ \"./node_modules/vue-native-websocket/dist/build.js\"));\n\nvar _vueAsyncComputed = _interopRequireDefault(__webpack_require__(/*! vue-async-computed */ \"./node_modules/vue-async-computed/dist/vue-async-computed.js\"));\n\nvar _vueJsToggleButton = _interopRequireDefault(__webpack_require__(/*! vue-js-toggle-button */ \"./node_modules/vue-js-toggle-button/dist/index.js\"));\n\nvar _vueSnotify = _interopRequireDefault(__webpack_require__(/*! vue-snotify */ \"./node_modules/vue-snotify/vue-snotify.esm.js\"));\n\nvar _domready = _interopRequireDefault(__webpack_require__(/*! domready */ \"./node_modules/domready/ready.js\"));\n\nvar _axios = _interopRequireDefault(__webpack_require__(/*! axios */ \"./node_modules/axios/index.js\"));\n\nvar _debounce = _interopRequireDefault(__webpack_require__(/*! lodash/debounce */ \"./node_modules/lodash/debounce.js\"));\n\nvar _store = _interopRequireDefault(__webpack_require__(/*! ./store */ \"./src/store/index.js\"));\n\nvar _router = _interopRequireDefault(__webpack_require__(/*! ./router */ \"./src/router.js\"));\n\nvar _utils = __webpack_require__(/*! ./utils */ \"./src/utils.js\");\n\nvar _api = __webpack_require__(/*! ./api */ \"./src/api.js\");\n\nvar _components = __webpack_require__(/*! ./components */ \"./src/components/index.js\");\n\nfunction _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }\n\n// eslint-disable-line import/no-unassigned-import\n// eslint-disable-line import/no-unassigned-import\n// eslint-disable-line import/no-unassigned-import\nif (window) {\n  window.isDevelopment = _utils.isDevelopment; // Adding libs to window so mako files can use them\n\n  window.$ = _jquery.default;\n  window.jQuery = _jquery.default;\n  window.Vue = _vue.default;\n  window.Vuex = _vuex.default;\n  window.VueMeta = _vueMeta.default;\n  window.VueRouter = _vueRouter.default;\n  window.VueNativeSock = _vueNativeWebsocket.default;\n  window.AsyncComputed = _vueAsyncComputed.default;\n  window.ToggleButton = _vueJsToggleButton.default;\n  window.Snotify = _vueSnotify.default;\n  window.axios = _axios.default;\n  window._ = {\n    debounce: _debounce.default\n  };\n  window.store = _store.default;\n  window.router = _router.default;\n  window.apiRoute = _api.apiRoute;\n  window.apiv1 = _api.apiv1;\n  window.api = _api.api;\n  window.MEDUSA = {\n    common: {},\n    config: {},\n    home: {},\n    manage: {},\n    addShows: {}\n  };\n  window.webRoot = _api.webRoot;\n  window.apiKey = _api.apiKey;\n  window.apiRoot = _api.webRoot + '/api/v2/'; // Push pages that load via a vue file but still use `el` for mounting\n\n  window.components = [];\n  window.components.push(_components.AnidbReleaseGroupUi);\n  window.components.push(_components.AppHeader);\n  window.components.push(_components.AppLink);\n  window.components.push(_components.Asset);\n  window.components.push(_components.Backstretch);\n  window.components.push(_components.DisplayShow);\n  window.components.push(_components.FileBrowser);\n  window.components.push(_components.Home);\n  window.components.push(_components.LanguageSelect);\n  window.components.push(_components.ManualPostProcess);\n  window.components.push(_components.NamePattern);\n  window.components.push(_components.PlotInfo);\n  window.components.push(_components.RootDirs);\n  window.components.push(_components.ScrollButtons);\n  window.components.push(_components.SelectList);\n  window.components.push(_components.ShowSelector);\n  window.components.push(_components.SnatchSelection);\n  window.components.push(_components.Status);\n}\n\nvar UTIL = {\n  exec: function exec(controller, action) {\n    var _window = window,\n        MEDUSA = _window.MEDUSA;\n    var ns = MEDUSA;\n    action = action === undefined ? 'init' : action;\n\n    if (controller !== '' && ns[controller] && typeof ns[controller][action] === 'function') {\n      ns[controller][action]();\n    }\n  },\n  init: function init() {\n    if (typeof startVue === 'function') {\n      // eslint-disable-line no-undef\n      startVue(); // eslint-disable-line no-undef\n    } else {\n      (0, _jquery.default)('[v-cloak]').removeAttr('v-cloak');\n    }\n\n    var _document = document,\n        body = _document.body;\n    var controller = body.getAttribute('data-controller');\n    var action = body.getAttribute('data-action');\n    UTIL.exec('common'); // Load common\n\n    UTIL.exec(controller); // Load MEDUSA[controller]\n\n    UTIL.exec(controller, action); // Load MEDUSA[controller][action]\n\n    window.dispatchEvent(new Event('medusa-loaded'));\n  }\n};\nvar pathname = window.location.pathname;\n\nif (!pathname.includes('/login') && !pathname.includes('/apibuilder')) {\n  _api.api.get('config/main').then(function (response) {\n    var _window2 = window,\n        MEDUSA = _window2.MEDUSA; // @TODO: Remove this hack\n\n    MEDUSA.config = Object.assign(MEDUSA.config, response.data);\n    MEDUSA.config.themeSpinner = MEDUSA.config.themeName === 'dark' ? '-dark' : '';\n    MEDUSA.config.loading = '<img src=\"images/loading16' + MEDUSA.config.themeSpinner + '.gif\" height=\"16\" width=\"16\" />';\n    (0, _domready.default)(UTIL.init);\n\n    MEDUSA.config.indexers.indexerIdToName = function (indexerId) {\n      if (!indexerId) {\n        return '';\n      }\n\n      return Object.keys(MEDUSA.config.indexers.config.indexers).filter(function (indexer) {\n        // eslint-disable-line array-callback-return\n        if (MEDUSA.config.indexers.config.indexers[indexer].id === parseInt(indexerId, 10)) {\n          return MEDUSA.config.indexers.config.indexers[indexer].name;\n        }\n      })[0];\n    };\n  }).catch(function (error) {\n    console.debug(error);\n    alert('Unable to connect to Medusa!'); // eslint-disable-line no-alert\n  });\n}\n\n//# sourceURL=webpack:///./src/index.js?");

/***/ })

},[["./src/index.js","vendors"]]]);