require 'pagy/extras/bootstrap' #在页面中可以使用pagy_bootstrap_nav(@pagy)方法使用bootstrap样式
# require 'pagy/extras/i18n' #引入后会使用i18n的gem,而不使用pagy内置的i18n
require 'pagy/extras/trim' #引入后自动取消第一页的page参数，可以通过 Pagy::VARS[:enable_trim_extra] = false 禁用

Pagy::VARS[:items] = 10
Pagy::VARS[:size] = [1, 3, 3, 1]
Pagy::I18n.load(locale: 'zh-CN') #pagy内置的i18n文件，如想自定义需要 require 'pagy/extras/i18n'