package com.spring.henallux.IG3_EquipementsSportif_PWOO_POZZI.service;

import com.paypal.api.payments.*;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;
import com.spring.henallux.IG3_EquipementsSportif_PWOO_POZZI.configuration.PaypalPaymentIntent;
import com.spring.henallux.IG3_EquipementsSportif_PWOO_POZZI.configuration.PaypalPaymentMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;

//Inspiration du projet GitHub de l'utilisateur Masadani pour payer facilement avec PayPal
//https://github.com/masasdani/paypal-springboot
@Service
public class PaypalService {

	private APIContext apiContext;

	@Autowired
	public PaypalService(APIContext apiContext) {
		this.apiContext = apiContext;
	}

	public Payment createPayment(
			Double total, 
			String currency, 
			PaypalPaymentMethod method,
			PaypalPaymentIntent intent,
			String description, 
			String cancelUrl, 
			String successUrl) throws PayPalRESTException{
		Amount amount = new Amount();
		amount.setCurrency(currency);
		//On arrondit vers le haut à 2 décimales
		total = new BigDecimal(total).setScale(2, RoundingMode.HALF_UP).doubleValue();
		amount.setTotal(total.toString());

		Transaction transaction = new Transaction();
		transaction.setDescription(description);
		transaction.setAmount(amount);

		List<Transaction> transactions = new ArrayList<>();
		transactions.add(transaction);

		Payer payer = new Payer();
		payer.setPaymentMethod(method.toString());

		Payment payment = new Payment();
		payment.setIntent(intent.toString());
		payment.setPayer(payer);
		payment.setTransactions(transactions);
		RedirectUrls redirectUrls = new RedirectUrls();
		redirectUrls.setCancelUrl(cancelUrl);
		redirectUrls.setReturnUrl(successUrl);
		payment.setRedirectUrls(redirectUrls);

		return payment.create(apiContext);
	}
	
	public Payment executePayment(String paymentId, String payerId) throws PayPalRESTException{
		Payment payment = new Payment();
		payment.setId(paymentId);
		PaymentExecution paymentExecute = new PaymentExecution();
		paymentExecute.setPayerId(payerId);
		return payment.execute(apiContext, paymentExecute);
	}
}
