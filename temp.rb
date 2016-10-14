<%= form_tag("/checkouts", method: "post", id: "payment-form") do %>
                    
                   
                    <section>
                    <label for="from_date">
                        <span class="input-label">From Date</span>
                        <div class="input-wrapper amount-wrapper">
                        <input id="from_date" name="from_date" type=""  placeholder="Select Start Date" >
                        </div>
                    </label>    
                    <div class="bt-drop-in-wrapper">
                        <div id="bt-dropin"></div>
                    </div>

                    <label for="amount">
                        <span class="input-label">Amount</span>
                        <div class="input-wrapper amount-wrapper">
                        <input id="amount" name="amount" type="tel" min="1" placeholder="Amount" value="10">
                        </div>
                    </label>
                    </section>

                    <button class="button" type="submit"><span>Proceed</span></button>
                <% end %>
                
                <script src="https://js.braintreegateway.com/js/braintree-2.27.0.min.js"></script>
                
                <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
  (function () {
    var checkout = new Demo({
      formID: 'payment-form'
    });

    var client_token = "<%= @client_token %>";
    braintree.setup(client_token, "dropin", {
      container: "bt-dropin"
    });
    
    $( "#from_date" ).datepicker();
  })()
</script>