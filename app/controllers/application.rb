# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include PathFunctions
  include SortHelper
  include Admin

  # To set :host for Mailer
  around_filter :retardase_inhibitor

  before_filter :login_required, :only => [ :new, :create, :edit, :update, :destroy ]

  # Pick a unique cookie name to distinguish our session data from others
  session :session_key => '_engkab_session_id'
  helper_method(:section_first_page_url, :site_page_url)
  helper_method(:sort_ul_id)

  uses_tiny_mce(:options => {
                :theme => 'advanced',
                :mode => 'textareas',
                :browsers => %w{msie gecko},
                :width => "450",
                :inline_styles => true,
                :paste_use_dialog => false,
                :paste_auto_cleanup_on_paste => true,
                :convert_fonts_to_spans => true,
                :convert_urls => false,
                :apply_source_formatting => true,
                :paste_convert_headers_to_strong => false,
                :paste_strip_class_attributes => "all",
                :verify_html => "true",
                :cleanup_callback => "blockElementAlignClean",
                :cleanup => "true",
                :fix_list_elements => "true",
                :invalid_elements => "u,font",
                :valid_elements => "a[accesskey|charset|class|coords|dir<ltr?rtl|href|id|lang|onblur|onclick|ondblclick|onfocus|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|rel|rev|shape<circle?default?poly?rect|style|tabindex|title|type],blockquote[dir|style|cite|class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],br[class|id|style|title],button[accesskey|class|dir<ltr?rtl|disabled<disabled|id|name|onblur|onclick|ondblclick|onfocus|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|tabindex|title|type|value],div[align|class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],em/i[class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],h1[class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],h2[class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],h3[class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],h4[class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],h5[class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],h6[class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],hr[class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],img[rel|alt|class|dir<ltr?rtl|height|id|longdesc|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|src|style|title|width],li[class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],ol[class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],p[align|class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],pre/listing/plaintext/xmp[align|class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],script[charset|defer|src|type],select[class|dir<ltr?rtl|disabled<disabled|id|multiple<multiple|name|onblur|onclick|ondblclick|onfocus|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|size|style|tabindex|title],small[class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],span[class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],strong/b[class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],style[dir<ltr?rtl|media|title|type],sub[class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],sup[class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title],table[border|cellpadding|cellspacing|class|dir<ltr?rtl|frame|height|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|rules|style|summary|title|width],td[abbr|align<center?char?justify?left?right|axis|bgcolor|char|charoff|class|colspan|dir<ltr?rtl|headers|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|rowspan|scope<col?colgroup?row?rowgroup|style|title|valign<baseline?bottom?middle?top],tr[abbr|align<center?char?justify?left?right|char|charoff|class|rowspan|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title|valign<baseline?bottom?middle?top],ul[class|dir<ltr?rtl|id|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|style|title]",
                :editor_deselector => "mceNoEditor",
                :content_css => "http://www.kabbalah.info/engkab/section/what-is-kabbalah/styles/default.css",
                :table_styles => "Clean=clean; Gray=gray; Clean Centered=clean center;  Gray Centered=gray center",
                :theme_advanced_toolbar_location => "top",
                :theme_advanced_toolbar_align => "left",
                :theme_advanced_statusbar_location => "bottom",
                :theme_advanced_resizing => true,
                :theme_advanced_resize_horizontal => true,
                :paste_auto_cleanup_on_paste => true,
                :extended_valid_elements => "a[name|rel|href|target|title|onclick|style],img[rel|alt|class|dir<ltr?rtl|height|id|longdesc|onclick|ondblclick|onkeydown|onkeypress|onkeyup|onmousedown|onmousemove|onmouseout|onmouseover|onmouseup|src|style|title|width]",
                :theme_advanced_buttons1 => %w{ bold italic separator justifyleft justifycenter justifyright indent outdent separator ltr rtl separator bullist numlist },
                :theme_advanced_buttons2 => %w{ code fullscreen separator undo redo separator search separator pastetext pasteword selectall separator anchor link unlink image media table separator removeformat },
                :theme_advanced_buttons3 => [],
                :media_use_script => "true",
                :plugins => %w{contextmenu paste fullscreen inlinepopups directionality searchreplace media advimage table}
              },
              :advimage_styles => 'left_aligned=tinyleft',
              :debug => true,
              :only => [:new, :edit, :show, :index, :update])

    alias_method :orig_redirect_to, :redirect_to
	def redirect_to(options = {}, *parameters_for_method_reference)
		if (options.class == Symbol) && (options == :unauthorized)
            orig_redirect_to login_home_url, :status => 401
		elsif (options.class == Hash) && (options.include? :type)
          if options.include? :resource
            orig_redirect_to self.send(options[:type], options[:resource])
          else
            type = options[:type]
            options.delete :type
            orig_redirect_to self.send(type, options)
          end
		else
			orig_redirect_to options, *parameters_for_method_reference
		end
	end

end
