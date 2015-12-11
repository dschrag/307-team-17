module FinanceHelper

	def venmo_link(type, recipients, amount, note)
			if type != "pay" && type != "charge"
				puts "Use pay or charge for the venmo link, please."
				type = "pay"
			end

			url = "http://venmo.com/?"
			url << "txn=" + type
			url << "&recipients=" + recipients
			url << "&amount=" + amount.to_s
			url << "&note=" + CGI.escape(note)

			url << "&audience=private"

			return url
	end
end

