module LeadFormsHelper
  def lead_form_type_as_string(lead_form)
    lead_form.type.titleize
  end
end
