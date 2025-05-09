pragma circom 2.0.0;
	
template SumAndProductCheck() {
	signal input values[3];         // private input
	signal input expected_sum;      // public input
	signal input expected_product;  // public input
		
	signal sum;
	signal product1;
	signal product;
		
	sum <== values[0] + values[1] + values[2];
		
	product1 <== values[0] * values[1];
	product <== product1 * values[2];
		
	// Ensure computed sum and product match expected
	expected_sum === sum;
	expected_product === product;
}
	
component main = SumAndProductCheck();

