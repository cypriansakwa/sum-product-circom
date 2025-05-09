# Sum and Product Check Circuit

This repository contains a Circom circuit that verifies whether the sum and product of three private input values match the expected public values. 

## Prerequisites

- Circom 2.0.0 or higher
- Node.js and npm
- SnarkJS for proof generation

## Circuit Description

The `SumAndProductCheck` template takes three private input values and two public inputs (expected sum and expected product). It computes the sum and product of the three values and checks if they match the expected values.

### Inputs

- **Private Inputs:**
  - `values[3]`: An array of three private integers.
- **Public Inputs:**
  - `expected_sum`: The expected sum of the three integers.
  - `expected_product`: The expected product of the three integers.

### Outputs

The circuit ensures that:
- `sum = values[0] + values[1] + values[2]`
- `product = values[0] * values[1] * values[2]`

If both conditions are met, the circuit returns a valid proof.

## Code

```circom
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
```
## Usage
### Clone the repository

```bash
git clone https://github.com/cypriansakwa/sum-product-circom.git
cd sum-product-circom
```
### Compile the circuit:
```bash
circom sum_and_product.circom --r1cs --wasm --sym
```
### Generate witness:
```bash
node sum_and_product_js/generate_witness.js sum_and_product_js/sum_and_product.wasm input.json witness.wtns

```
### Generate proof:
```bash
snarkjs groth16 prove sum_and_product.zkey witness.wtns proof.json public.json

```
### Verify proof:
```bash
snarkjs groth16 prove sum_and_product.zkey witness.wtns proof.json public.json

```
### Example Input
```json
{
  "values": [2, 3, 4],
  "expected_sum": 9,
  "expected_product": 24
}

```
