import Mathlib
import BookProof.ChapterHermiteProductCore

/-!
# Coordinate-wise Hermite combinations on the Gauss–polynomial core

This chapter provides the *quantitative* companion of
`BookProof.ChapterHermiteProductCore`.  There the Gauss–polynomial core of
`L²(ℝᵈ)` was identified with the span of the product Hermite functions; here we
compute Gaussian integrals of the concrete states that will be used to test
quadratic forms on that core.

The states are products, over the coordinates, of **one-variable Hermite
combinations**

`coordCombo i c p K = ∑_{k ≤ K} c k · He_{2k+p}(x_i)`,

with real coefficients `c` and a fixed parity `p ∈ {0,1}`.  The two facts we
need are:

* `gaussInt_coordCombo_sq` — a *relative orthogonality* statement: against any
  polynomial `R` that does not involve `x_i`,
  `∫ (coordCombo i c p K)² R e^{-‖x‖²/2} = (∑_k c k² (2k+p)!) ∫ R e^{-‖x‖²/2}`;
* `gaussInt_prod_coordFactor` — the resulting product rule for a product of such
  combinations, one in each coordinate of a finite set.

Everything rests on the `d`-dimensional Gaussian integration by parts
`BookProof.HermiteProductCore.gaussInt_pderiv`; no new analysis is needed.
-/

namespace BookProof.GaussCoordCombo

open MvPolynomial BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

/-! ## Derivatives of the one-coordinate Hermite factors -/

/-- The chain rule for a polynomial in the single coordinate `x_i`. -/
theorem pderiv_aeval_self (i : Fin d) (f : Polynomial ℂ) :
    pderiv i (Polynomial.aeval (X i : MvPolynomial (Fin d) ℂ) f)
      = Polynomial.aeval (X i : MvPolynomial (Fin d) ℂ) (Polynomial.derivative f) := by
  induction f using Polynomial.induction_on' with
  | add p q hp hq => simp [hp, hq]
  | monomial n a =>
      simp only [Polynomial.aeval_monomial, Polynomial.derivative_monomial, map_mul,
        algebraMap_eq]
      rw [MvPolynomial.pderiv_C_mul, Derivation.leibniz_pow, MvPolynomial.pderiv_X]
      simp [MvPolynomial.C_eq_smul_one]

/-- A polynomial in the single coordinate `x_i` has vanishing `x_j`-derivative for `j ≠ i`. -/
theorem pderiv_aeval_of_ne {i j : Fin d} (h : j ≠ i) (f : Polynomial ℂ) :
    pderiv j (Polynomial.aeval (X i : MvPolynomial (Fin d) ℂ) f) = 0 := by
  induction f using Polynomial.induction_on' with
  | add p q hp hq => simp [hp, hq]
  | monomial n a =>
      simp only [Polynomial.aeval_monomial, algebraMap_eq]
      rw [MvPolynomial.pderiv_C_mul, Derivation.leibniz_pow, MvPolynomial.pderiv_X,
        Pi.single_apply, if_neg (Ne.symm h)]
      simp

/-- `∂_i He_{n+1}(x_i) = (n+1) He_n(x_i)`. -/
theorem pderiv_hermiteFactor_self (i : Fin d) (n : ℕ) :
    pderiv i (hermiteFactor i (n + 1)) = ((n : ℂ) + 1) • hermiteFactor i n := by
  have hder : Polynomial.derivative (hermiteCx (n + 1)) = Polynomial.C ((n : ℂ) + 1) *
      hermiteCx n := by
    have h := congrArg (Polynomial.map (Int.castRingHom ℂ)) (derivative_hermiteZ n)
    simpa [hermiteCx, Polynomial.derivative_map] using h
  rw [hermiteFactor, pderiv_aeval_self, hder]
  simp [hermiteFactor, smul_eq_C_mul]

/-- A Hermite factor in the coordinate `i` has vanishing `x_j`-derivative for `j ≠ i`. -/
theorem pderiv_hermiteFactor_of_ne {i j : Fin d} (h : j ≠ i) (n : ℕ) :
    pderiv j (hermiteFactor i n) = 0 :=
  pderiv_aeval_of_ne h _

/-- The **creation form** of the Hermite recurrence: `He_{n+1} = x He_n − He_n'`. -/
theorem hermiteFactor_succ_eq (i : Fin d) (n : ℕ) :
    hermiteFactor i (n + 1) = X i * hermiteFactor i n - pderiv i (hermiteFactor i n) := by
  have h : hermiteCx (n + 1) = Polynomial.X * hermiteCx n
      - Polynomial.derivative (hermiteCx n) := by
    simp [hermiteCx, Polynomial.derivative_map, Polynomial.map_mul, Polynomial.map_sub,
      Polynomial.hermite_succ]
  rw [hermiteFactor, h]
  simp [hermiteFactor]

/-! ## Gaussian integration by parts in the creation form -/

/-- Leibniz rule plus Gaussian integration by parts. -/
theorem gaussInt_leibniz' (i : Fin d) (P Q : MvPolynomial (Fin d) ℂ) :
    gaussInt (pderiv i P * Q) + gaussInt (P * pderiv i Q) = gaussInt (X i * (P * Q)) := by
  rw [← gaussInt_pderiv i (P * Q), ← gaussInt_add]
  congr 1
  rw [Derivation.leibniz]
  simp only [smul_eq_mul]
  ring

theorem gaussInt_zero' : gaussInt (0 : MvPolynomial (Fin d) ℂ) = 0 := by
  simp [gaussInt]

theorem gaussInt_sub' (r s : MvPolynomial (Fin d) ℂ) :
    gaussInt (r - s) = gaussInt r - gaussInt s := by
  have h := gaussInt_add r (-s)
  rw [show (-s) = (-1 : ℂ) • s by module, gaussInt_smul] at h
  rw [show r - s = r + (-1 : ℂ) • s by module, h]
  ring

/-- **The creation operator moves to an annihilation operator under the Gaussian integral**:
`∫ (x_i p − ∂_i p) q e^{-‖x‖²/2} = ∫ p (∂_i q) e^{-‖x‖²/2}`. -/
theorem gaussInt_creation (i : Fin d) (p q : MvPolynomial (Fin d) ℂ) :
    gaussInt ((X i * p - pderiv i p) * q) = gaussInt (p * pderiv i q) := by
  have hleib := gaussInt_leibniz' i p q
  have h1 : (X i * p - pderiv i p) * q = X i * (p * q) - pderiv i p * q := by ring
  rw [h1, gaussInt_sub']
  linear_combination -hleib

/-! ## Relative orthogonality of the Hermite factors -/

/-- **Relative orthogonality**: against a polynomial `R` free of `x_i`, the Hermite factors
in the coordinate `i` are orthogonal with the usual norms `n!`. -/
theorem gaussInt_hermiteFactor_mul (i : Fin d) (m n : ℕ) {R : MvPolynomial (Fin d) ℂ}
    (hR : pderiv i R = 0) :
    gaussInt (hermiteFactor i m * (hermiteFactor i n * R))
      = (if m = n then (n.factorial : ℂ) else 0) * gaussInt R := by
  induction m generalizing n with
  | zero =>
      cases n with
      | zero => simp [hermiteFactor_zero]
      | succ k =>
          have hstep : gaussInt (hermiteFactor i (k + 1) * R)
              = gaussInt (hermiteFactor i k * pderiv i R) := by
            rw [hermiteFactor_succ_eq, gaussInt_creation]
          rw [hermiteFactor_zero, one_mul, hstep, hR, mul_zero, gaussInt_zero']
          simp
  | succ m ih =>
      have hq : pderiv i (hermiteFactor i n * R) = pderiv i (hermiteFactor i n) * R := by
        rw [Derivation.leibniz, hR]
        simp [smul_eq_mul, mul_comm]
      have hstep : gaussInt (hermiteFactor i (m + 1) * (hermiteFactor i n * R))
          = gaussInt (hermiteFactor i m * (pderiv i (hermiteFactor i n) * R)) := by
        rw [hermiteFactor_succ_eq, gaussInt_creation, hq]
      cases n with
      | zero =>
          rw [hstep, hermiteFactor_zero]
          simp [gaussInt_zero']
      | succ k =>
          rw [hstep, pderiv_hermiteFactor_self]
          simp only [smul_mul_assoc, mul_smul_comm, gaussInt_smul, ih k]
          by_cases h : m = k
          · subst h
            rw [if_pos rfl, if_pos rfl, Nat.factorial_succ]
            push_cast
            ring
          · rw [if_neg h, if_neg (by omega)]
            simp

/-! ## Coordinate combinations -/

/-- The one-coordinate Hermite combination `∑_{k ≤ K} c k He_{2k+p}(x_i)`. -/
def coordCombo (i : Fin d) (c : ℕ → ℝ) (p K : ℕ) : MvPolynomial (Fin d) ℂ :=
  ∑ k ∈ Finset.range (K + 1), ((c k : ℝ) : ℂ) • hermiteFactor i (2 * k + p)

/-- The Gaussian square norm of a coordinate combination, `∑_k c k² (2k+p)!`. -/
def coordComboSum (c : ℕ → ℝ) (p K : ℕ) : ℝ :=
  ∑ k ∈ Finset.range (K + 1), (c k) ^ 2 * ((2 * k + p).factorial : ℝ)

theorem coordComboSum_nonneg (c : ℕ → ℝ) (p K : ℕ) : 0 ≤ coordComboSum c p K := by
  refine Finset.sum_nonneg fun k _ => ?_
  positivity

theorem pderiv_coordCombo_of_ne {i j : Fin d} (h : j ≠ i) (c : ℕ → ℝ) (p K : ℕ) :
    pderiv j (coordCombo i c p K) = 0 := by
  rw [coordCombo, map_sum]
  refine Finset.sum_eq_zero fun k _ => ?_
  rw [Derivation.map_smul, pderiv_hermiteFactor_of_ne h, smul_zero]

/-- **The Gaussian square of a coordinate combination**, relative to a polynomial `R` free of
`x_i`. -/
theorem gaussInt_coordCombo_sq (i : Fin d) (c : ℕ → ℝ) (p K : ℕ)
    {R : MvPolynomial (Fin d) ℂ} (hR : pderiv i R = 0) :
    gaussInt (coordCombo i c p K * (coordCombo i c p K * R))
      = ((coordComboSum c p K : ℝ) : ℂ) * gaussInt R := by
  classical
  have hexp : coordCombo i c p K * (coordCombo i c p K * R)
      = ∑ k ∈ Finset.range (K + 1), ∑ l ∈ Finset.range (K + 1),
        (((c k * c l : ℝ) : ℂ)) • (hermiteFactor i (2 * k + p) * (hermiteFactor i (2 * l + p)
          * R)) := by
    simp only [coordCombo, Finset.sum_mul, Finset.mul_sum, smul_mul_assoc, mul_smul_comm,
      Finset.smul_sum, smul_smul]
    refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
    push_cast
    ring_nf
  rw [hexp]
  rw [gaussInt_sum]
  have hinner : ∀ k ∈ Finset.range (K + 1),
      gaussInt (∑ l ∈ Finset.range (K + 1), (((c k * c l : ℝ) : ℂ)) •
        (hermiteFactor i (2 * k + p) * (hermiteFactor i (2 * l + p) * R)))
        = ((c k ^ 2 * ((2 * k + p).factorial : ℝ) : ℝ) : ℂ) * gaussInt R := by
    intro k hk
    rw [gaussInt_sum]
    rw [Finset.sum_eq_single k]
    · rw [gaussInt_smul, gaussInt_hermiteFactor_mul i _ _ hR, if_pos rfl]
      push_cast
      ring
    · intro l _ hl
      rw [gaussInt_smul, gaussInt_hermiteFactor_mul i _ _ hR, if_neg (by omega)]
      simp
    · intro hk'
      exact absurd hk hk'
  rw [Finset.sum_congr rfl hinner, coordComboSum]
  push_cast
  rw [Finset.sum_mul]

/-! ## Products over the coordinates -/

/-- A **coordinate factor**: a polynomial living in the single coordinate `i` whose Gaussian
square, relative to any polynomial free of `x_i`, is the constant `s`. -/
def CoordFactor (i : Fin d) (w : MvPolynomial (Fin d) ℂ) (s : ℝ) : Prop :=
  (∀ j, j ≠ i → pderiv j w = 0) ∧
    ∀ R : MvPolynomial (Fin d) ℂ, pderiv i R = 0 → gaussInt (w * (w * R)) = ((s : ℝ) : ℂ) *
      gaussInt R

theorem coordFactor_coordCombo (i : Fin d) (c : ℕ → ℝ) (p K : ℕ) :
    CoordFactor i (coordCombo i c p K) (coordComboSum c p K) :=
  ⟨fun _ hj => pderiv_coordCombo_of_ne hj c p K, fun _ hR => gaussInt_coordCombo_sq i c p K hR⟩

theorem pderiv_prod_eq_zero {S : Finset (Fin d)} {W : Fin d → MvPolynomial (Fin d) ℂ}
    {i : Fin d} (h : ∀ j ∈ S, pderiv i (W j) = 0) : pderiv i (∏ j ∈ S, W j) = 0 := by
  classical
  induction S using Finset.induction_on with
  | empty => simp
  | insert a S ha ih =>
      rw [Finset.prod_insert ha, Derivation.leibniz,
        h a (Finset.mem_insert_self a S),
        ih (fun j hj => h j (Finset.mem_insert_of_mem hj))]
      simp

/-- **The product rule for coordinate factors.** -/
theorem gaussInt_prod_coordFactor {S : Finset (Fin d)} {W : Fin d → MvPolynomial (Fin d) ℂ}
    {s : Fin d → ℝ} (hW : ∀ j ∈ S, CoordFactor j (W j) (s j))
    {R : MvPolynomial (Fin d) ℂ} (hR : ∀ j ∈ S, pderiv j R = 0) :
    gaussInt ((∏ j ∈ S, W j) * ((∏ j ∈ S, W j) * R))
      = ((∏ j ∈ S, s j : ℝ) : ℂ) * gaussInt R := by
  classical
  induction S using Finset.induction_on with
  | empty => simp
  | insert a S ha ih =>
      have hWa := hW a (Finset.mem_insert_self a S)
      have hWS : ∀ j ∈ S, CoordFactor j (W j) (s j) := fun j hj =>
        hW j (Finset.mem_insert_of_mem hj)
      have hRS : ∀ j ∈ S, pderiv j R = 0 := fun j hj => hR j (Finset.mem_insert_of_mem hj)
      set Q : MvPolynomial (Fin d) ℂ := ∏ j ∈ S, W j with hQ
      have hpQ : pderiv a Q = 0 := by
        refine pderiv_prod_eq_zero (fun j hj => ?_)
        exact (hWS j hj).1 a (fun hja => ha (hja ▸ hj))
      have hpR : pderiv a R = 0 := hR a (Finset.mem_insert_self a S)
      have hpQQR : pderiv a (Q * (Q * R)) = 0 := by
        rw [Derivation.leibniz, hpQ, Derivation.leibniz, hpQ, hpR]
        simp
      have hrw : (∏ j ∈ insert a S, W j) * ((∏ j ∈ insert a S, W j) * R)
          = W a * (W a * (Q * (Q * R))) := by
        rw [Finset.prod_insert ha, ← hQ]
        ring
      rw [hrw, hWa.2 _ hpQQR, ih hWS hRS, Finset.prod_insert ha]
      push_cast
      ring

end

end BookProof.GaussCoordCombo
