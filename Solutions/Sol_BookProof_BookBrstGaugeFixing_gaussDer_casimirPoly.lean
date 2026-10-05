-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.gaussDer_casimirPoly
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Theorems.Thm_BookProof_BookBrstYangMills_gaussDer_X
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β : Fin n → R}

set_option maxHeartbeats 1000000 in
theorem solution (hD : ∀ μ c a, G.D μ c a = 0) (c : Fin N) :
    gaussDer G c (casimirPoly (N := N)) = 0 := by

  have hvec : ∀ i : Fin 4 × Fin N,
      gaussVec G c i = ∑ g, ((G.f i.2 g c : ℝ) : ℂ) • (X (i.1, g) : FieldPoly N) := by
    intro i
    simp [gaussVec, vecComb, hD]
  have hterm : ∀ i : Fin 4 × Fin N, gaussDer G c (X i * X i)
      = ∑ g, ((2 * G.f i.2 g c : ℝ) : ℂ) • (X i * X (i.1, g) : FieldPoly N) := by
    intro i
    rw [Derivation.leibniz, gaussDer_X, hvec i]
    simp only [smul_eq_mul, Finset.mul_sum, ← Finset.sum_add_distrib,
      Complex.ofReal_mul, Complex.ofReal_ofNat]
    refine Finset.sum_congr rfl fun g _ => ?_
    rw [mul_smul_comm, ← two_smul ℂ, smul_smul]
  rw [casimirPoly, map_sum, Finset.sum_congr rfl fun i _ => hterm i]
  rw [Fintype.sum_prod_type]
  refine Finset.sum_eq_zero fun μ _ => ?_
  set S : FieldPoly N := ∑ a, ∑ g, ((2 * G.f a g c : ℝ) : ℂ) • (X (μ, a) * X (μ, g) : FieldPoly N)
    with hS
  have hswap : S = -S := by
    rw [hS]
    nth_rewrite 1 [Finset.sum_comm]
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun g _ => ?_
    rw [← neg_smul]
    congr 1
    · norm_cast
      rw [G.antisymm a g c]
      ring
    · ring
  have h2 : (2 : ℂ) • S = 0 := by
    rw [two_smul]
    nth_rewrite 2 [hswap]
    ring_nf
  have := smul_eq_zero.mp h2
  rcases this with h | h
  · exact absurd h (by norm_num)
  · exact h
