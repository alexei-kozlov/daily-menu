module ApplicationHelper

	def link_to_add_fields(name, f, association, options = {})
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		objects_name = f.object.class.name.underscore.pluralize
		options_partial = options.delete(:partial)
		infered_partial = association.to_s.singularize + "_fields"
		partial_name = options_partial || infered_partial
		template_name = "#{objects_name}/#{partial_name}"
		fields = f.fields_for(association, new_object, child_index: id) do |builder|
			render(template_name, f: builder)
		end
		data = options[:data] || {}
		options[:data] = data.merge(
		  link_to_add_field_id: id,
		  link_to_add_field: fields.gsub("\n", "")
		)
		link_to name, '#', options
	end

	def link_to_remove_fields(name, target, options = {})
		data = options[:data] || {}
		options[:data] = data.merge(
		  link_to_remove_field: target
		)
		link_to name, '#', options
	end

	def sortable(column, title = nil)
		title ||= column.titleize
		css_class = column == sort_column ? "current #{sort_direction}" : nil
		direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
		link_to title, { :sort => column, :direction => direction }, { :class => css_class }
	end

	def controller?(*controller)
		controller.include?(params[:controller])
	end

	def action?(*action)
		action.include?(params[:action])
	end

	def portion(number)
		reminder = number % 10
		if reminder == 1
			description = 'порцию'
		end

		if reminder >= 2 && reminder <= 4
			description = 'порции'
		end

		if reminder >= 5 && reminder <= 9 || reminder == 0
			description = 'порций'
		end

		if number == nil || !number.is_a?(Numeric)
			number == 0
		end

		return description
	end

end