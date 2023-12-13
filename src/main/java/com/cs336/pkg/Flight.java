package com.cs336.pkg;

public class Flight {
	private String flightNumber, companyID, weekday, flightType, fromAirportID, toAirportID, aircraftID;
	private String departureTime, arrivalTime; 
	private double priceEconomy, priceBusiness, priceFirst;
	
	public Flight(String flightNumber, String companyID, String weekday, String flightType, 
			String fromAirportID, String toAirportID, String aircraftID, String departureTime, String arrivalTime,
			double priceEconomy, double priceBusiness, double priceFirst) {
		this.flightNumber = flightNumber;
		this.companyID = companyID;
		this.weekday = weekday;
		this.flightType = flightType;
		this.fromAirportID = fromAirportID;
		this.toAirportID = toAirportID;
		this.aircraftID = aircraftID;
		this.departureTime = departureTime;
		this.arrivalTime = arrivalTime;
		this.priceEconomy = priceEconomy;
		this.priceBusiness = priceBusiness;
		this.priceFirst = priceFirst;
	}
	
	@Override
	public String toString() {
		return String.format("%s, %s, %s, %s, %s, %s, %s, %s, %s, $%.2f, $%.2f, $%.2f", flightNumber, companyID, weekday, flightType, fromAirportID, 
				toAirportID, aircraftID, departureTime, arrivalTime, priceEconomy, priceBusiness, priceFirst);
	}
}