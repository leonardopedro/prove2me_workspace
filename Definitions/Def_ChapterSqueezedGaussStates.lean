import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterHermiteProductCore
import Mathlib


/-!
# Squeezed states on the Gauss–polynomial core

The Gauss–polynomial core of `L²(ℝᵈ)` consists of the states `p(x) e^{-‖x‖²/4}`.  In the
coordinate `x_i` the Gaussian factor is fixed, so the "width" of a core state in that
coordinate has to be produced by the polynomial factor.  This chapter constructs the family
that does it: the **truncated Hermite expansion of a Gaussian**,

`squeezeState i v M = ∑_{m ≤ M} (vᵐ / m!) He_{2m}(x_i)`,   `|v| < 1/2`,

whose infinite version is `(1+2β)^{-1/2} e^{-βx_i²}` with `v = −β/(1+2β)`.

Two exact algebraic facts drive everything (`Acoef_rec` and `sum_odd_Acoef_le`), and they are
purely combinatorial consequences of the three-term recurrence:

* multiplying by `x_i`, or differentiating, turns the family into an *odd* Hermite
  combination whose interior coefficients are the old ones scaled by
  `κ = α(1+2v) + 2γv` (`opCoef_of_lt`), with only a boundary term left over;
* the weighted sums of `A_m = (vᵐ/m!)²(2m)!` obey `(1−4v²)∑(2m+1)A_m ≤ ∑A_m`
  (`sum_odd_Acoef_le`).

Consequently `⟨x_i²⟩ → 0` as `v → −1/2` (`exists_position_small`) and `⟨π_i²⟩ → 0` as
`v → 1/2` (`exists_momentum_small`): **the Gauss–polynomial core has neither a position nor a
momentum form gap**, even though every one of its elements carries the same fixed Gaussian.
-/

namespace BookProof.SqueezedGaussStates

open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section

variable {d : ℕ}

/-! ## The coefficient family -/

/-- The coefficients `vᵐ/m!` of the squeezed state, truncated at `M`. -/
def sqCoef (v : ℝ) (M : ℕ) : ℕ → ℝ := fun m => if m ≤ M then v ^ m / (m.factorial : ℝ) else 0





/-- The **squeezed core state** in the coordinate `i`. -/
def squeezeState (i : Fin d) (v : ℝ) (M : ℕ) : MvPolynomial (Fin d) ℂ :=
  coordCombo i (sqCoef v M) 0 M

/-! ## Multiplication by a coordinate and differentiation -/







/-! ## The operator `α x_i + γ ∂_i` on a squeezed state -/

/-- The odd coefficients produced by `α x_i + γ ∂_i` from a squeezed state. -/
def opCoef (α γ v : ℝ) (M : ℕ) : ℕ → ℝ := fun k =>
  α * (sqCoef v M k + 2 * (k + 1) * sqCoef v M (k + 1)) + γ * (2 * (k + 1) * sqCoef v M (k + 1))

/-- The interior scaling factor `κ = α(1+2v) + 2γv`. -/
def kappa (α γ v : ℝ) : ℝ := α * (1 + 2 * v) + 2 * γ * v







/-! ## The exact coefficient sums -/

/-- `A_m = (vᵐ/m!)² (2m)!`, the Gaussian square norm of the `m`-th term. -/
def Acoef (v : ℝ) (m : ℕ) : ℝ := (v ^ m / (m.factorial : ℝ)) ^ 2 * (((2 * m).factorial : ℕ) : ℝ)









/-- `V_M = ∑_{m ≤ M} A_m`, the Gaussian square norm of the squeezed state. -/
def Vsum (v : ℝ) (M : ℕ) : ℝ := ∑ m ∈ Finset.range (M + 1), Acoef v m` the Gaussian factor is fixed, so the "width" of a core state in that
coordinate has to be produced by the polynomial factor.  This chapter constructs the family
that does it: the **truncated Hermite expansion of a Gaussian**,

`squeezeState i v M = ∑_{m ≤ M} (vᵐ / m!) He_{2m}(x_i)`,   `|v| < 1/2`,

whose infinite version is `(1+2β)^{-1/2} e^{-βx_i²}` with `v = −β/(1+2β)`.

Two exact algebraic facts drive everything (`Acoef_rec` and `sum_odd_Acoef_le`), and they are
purely combinatorial consequences of the three-term recurrence:

* multiplying by `x_i`, or differentiating, turns the family into an *odd* Hermite
  combination whose interior coefficients are the old ones scaled by
  `κ = α(1+2v) + 2γv` (`opCoef_of_lt`), with only a boundary term left over;
* the weighted sums of `A_m = (vᵐ/m!)²(2m)!` obey `(1−4v²)∑(2m+1)A_m ≤ ∑A_m`
  (`sum_odd_Acoef_le`).

Consequently `⟨x_i²⟩ → 0` as `v → −1/2` (`exists_position_small`) and `⟨π_i²⟩ → 0` as
`v → 1/2` (`exists_momentum_small`): **the Gauss–polynomial core has neither a position nor a
momentum form gap**, even though every one of its elements carries the same fixed Gaussian.
-/

namespace BookProof.SqueezedGaussStates

open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section

variable {d : ℕ}

/-! ## The coefficient family -/

/-- The coefficients `vᵐ/m!` of the squeezed state, truncated at `M`. -/
def sqCoef (v : ℝ) (M : ℕ) : ℕ → ℝ := fun m => if m ≤ M then v ^ m / (m.factorial : ℝ) else 0

theorem sqCoef_of_le {v : ℝ} {M m : ℕ} (h : m ≤ M) :
    sqCoef v M m = v ^ m / (m.factorial : ℝ) := if_pos h

theorem sqCoef_top_succ (v : ℝ) (M : ℕ) : sqCoef v M (M + 1) = 0 := if_neg (by omega)

/-- The **squeezed core state** in the coordinate `i`. -/
def squeezeState (i : Fin d) (v : ℝ) (M : ℕ) : MvPolynomial (Fin d) ℂ :=
  coordCombo i (sqCoef v M) 0 M

/-! ## Multiplication by a coordinate and differentiation -/

theorem coordCombo_smul_add (i : Fin d) (c₁ c₂ : ℕ → ℝ) (α γ : ℝ) (p K : ℕ) :
    ((α : ℝ) : ℂ) • coordCombo i c₁ p K + ((γ : ℝ) : ℂ) • coordCombo i c₂ p K
      = coordCombo i (fun k => α * c₁ k + γ * c₂ k) p K := by
  simp only [coordCombo, Finset.smul_sum, smul_smul, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun k _ => ?_
  push_cast
  module

/-- Multiplying an even Hermite combination by `x_i` gives an odd one. -/
theorem X_mul_coordCombo_even (i : Fin d) (a : ℕ → ℝ) (M : ℕ) (ha : a (M + 1) = 0) :
    X i * coordCombo i a 0 M = coordCombo i (fun k => a k + 2 * (k + 1) * a (k + 1)) 1 M := by
  have hL : X i * coordCombo i a 0 M
      = (∑ m ∈ Finset.range (M + 1), ((a m : ℝ) : ℂ) • hermiteFactor i (2 * m + 1))
        + ∑ m ∈ Finset.range (M + 1),
            ((a m : ℝ) : ℂ) • (((2 * m : ℕ) : ℂ) • hermiteFactor i (2 * m - 1)) := by
    rw [coordCombo, Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun m _ => ?_
    rw [mul_smul_comm, hermiteFactor_X_mul, smul_add]
    push_cast
    ring_nf
  have hsecond : (∑ m ∈ Finset.range (M + 1),
      ((a m : ℝ) : ℂ) • (((2 * m : ℕ) : ℂ) • hermiteFactor i (2 * m - 1)))
      = ∑ k ∈ Finset.range (M + 1), ((2 * (k + 1) * a (k + 1) : ℝ) : ℂ) •
          hermiteFactor i (2 * k + 1) := by
    rw [Finset.sum_range_succ' (fun m => ((a m : ℝ) : ℂ) •
      (((2 * m : ℕ) : ℂ) • hermiteFactor i (2 * m - 1))) M,
      Finset.sum_range_succ (fun k => ((2 * (k + 1) * a (k + 1) : ℝ) : ℂ) •
        hermiteFactor i (2 * k + 1)) M]
    have hzero : ((2 * (M + 1) * a (M + 1) : ℝ) : ℂ) • hermiteFactor i (2 * M + 1) = 0 := by
      rw [ha]
      simp
    rw [hzero, add_zero]
    have hfirst : ((a 0 : ℝ) : ℂ) • (((2 * 0 : ℕ) : ℂ) • hermiteFactor i (2 * 0 - 1)) = 0 := by
      simp
    rw [hfirst, add_zero]
    refine Finset.sum_congr rfl fun k _ => ?_
    have hidx : 2 * (k + 1) - 1 = 2 * k + 1 := by omega
    rw [hidx, smul_smul]
    push_cast
    ring_nf
  rw [hL, hsecond, coordCombo, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun k _ => ?_
  push_cast
  module

/-- Differentiating an even Hermite combination gives an odd one. -/
theorem pderiv_coordCombo_even (i : Fin d) (a : ℕ → ℝ) (M : ℕ) (ha : a (M + 1) = 0) :
    pderiv i (coordCombo i a 0 M) = coordCombo i (fun k => 2 * (k + 1) * a (k + 1)) 1 M := by
  have hL : pderiv i (coordCombo i a 0 M)
      = ∑ m ∈ Finset.range (M + 1),
          ((a m : ℝ) : ℂ) • (((2 * m : ℕ) : ℂ) • hermiteFactor i (2 * m - 1)) := by
    rw [coordCombo, map_sum]
    refine Finset.sum_congr rfl fun m _ => ?_
    rw [Derivation.map_smul]
    congr 1
    cases m with
    | zero => simp [hermiteFactor_zero]
    | succ l =>
        have hidx : 2 * (l + 1) = (2 * l + 1) + 1 := by omega
        have hidx' : 2 * (l + 1) - 1 = 2 * l + 1 := by omega
        rw [hidx, pderiv_hermiteFactor_self]
        norm_num
  rw [hL]
  rw [Finset.sum_range_succ' (fun m => ((a m : ℝ) : ℂ) •
    (((2 * m : ℕ) : ℂ) • hermiteFactor i (2 * m - 1))) M, coordCombo,
    Finset.sum_range_succ (fun k => ((2 * (k + 1) * a (k + 1) : ℝ) : ℂ) •
      hermiteFactor i (2 * k + 1)) M]
  have hzero : ((2 * (M + 1) * a (M + 1) : ℝ) : ℂ) • hermiteFactor i (2 * M + 1) = 0 := by
    rw [ha]; simp
  have hfirst : ((a 0 : ℝ) : ℂ) • (((2 * 0 : ℕ) : ℂ) • hermiteFactor i (2 * 0 - 1)) = 0 := by
    simp
  rw [hzero, add_zero, hfirst, add_zero]
  refine Finset.sum_congr rfl fun k _ => ?_
  have hidx : 2 * (k + 1) - 1 = 2 * k + 1 := by omega
  rw [hidx, smul_smul]
  push_cast
  ring_nf

/-! ## The operator `α x_i + γ ∂_i` on a squeezed state -/

/-- The odd coefficients produced by `α x_i + γ ∂_i` from a squeezed state. -/
def opCoef (α γ v : ℝ) (M : ℕ) : ℕ → ℝ := fun k =>
  α * (sqCoef v M k + 2 * (k + 1) * sqCoef v M (k + 1)) + γ * (2 * (k + 1) * sqCoef v M (k + 1))

/-- The interior scaling factor `κ = α(1+2v) + 2γv`. -/
def kappa (α γ v : ℝ) : ℝ := α * (1 + 2 * v) + 2 * γ * v

theorem opCoef_of_lt (α γ v : ℝ) {M k : ℕ} (hk : k < M) :
    opCoef α γ v M k = kappa α γ v * sqCoef v M k := by
  have h1 : sqCoef v M k = v ^ k / (k.factorial : ℝ) := sqCoef_of_le (by omega)
  have h2 : sqCoef v M (k + 1) = v ^ (k + 1) / ((k + 1).factorial : ℝ) :=
    sqCoef_of_le (by omega)
  have hfac : ((k + 1).factorial : ℝ) = ((k : ℝ) + 1) * (k.factorial : ℝ) := by
    rw [Nat.factorial_succ]
    push_cast
    ring
  have hpos : ((k.factorial : ℝ)) ≠ 0 := Nat.cast_ne_zero.mpr (Nat.factorial_ne_zero k)
  have hk1 : ((k : ℝ) + 1) ≠ 0 := by positivity
  rw [opCoef, kappa, h1, h2, hfac]
  field_simp
  ring

theorem opCoef_top (α γ v : ℝ) (M : ℕ) : opCoef α γ v M M = α * sqCoef v M M := by
  rw [opCoef, sqCoef_top_succ]
  ring

/-- **The action of `α x_i + γ ∂_i` on a squeezed state.** -/
theorem op_squeezeState (i : Fin d) (α γ v : ℝ) (M : ℕ) :
    ((α : ℝ) : ℂ) • (X i * squeezeState i v M)
        + ((γ : ℝ) : ℂ) • pderiv i (squeezeState i v M)
      = coordCombo i (opCoef α γ v M) 1 M := by
  rw [squeezeState, X_mul_coordCombo_even i _ M (sqCoef_top_succ v M),
    pderiv_coordCombo_even i _ M (sqCoef_top_succ v M), coordCombo_smul_add]
  rfl

/-! ## The exact coefficient sums -/

/-- `A_m = (vᵐ/m!)² (2m)!`, the Gaussian square norm of the `m`-th term. -/
def Acoef (v : ℝ) (m : ℕ) : ℝ := (v ^ m / (m.factorial : ℝ)) ^ 2 * (((2 * m).factorial : ℕ) : ℝ)

theorem Acoef_zero (v : ℝ) : Acoef v 0 = 1 := by
  simp [Acoef]

theorem Acoef_nonneg (v : ℝ) (m : ℕ) : 0 ≤ Acoef v m := by
  unfold Acoef
  positivity

/-- **The exact recurrence** `(2m+2) A_{m+1} = 4v²(2m+1) A_m`. -/
theorem Acoef_rec (v : ℝ) (m : ℕ) :
    (2 * (m : ℝ) + 2) * Acoef v (m + 1) = 4 * v ^ 2 * (2 * (m : ℝ) + 1) * Acoef v m := by
  have hfac : (((m + 1).factorial : ℕ) : ℝ) = ((m : ℝ) + 1) * ((m.factorial : ℕ) : ℝ) := by
    rw [Nat.factorial_succ]; push_cast; ring
  have hfac2 : (((2 * (m + 1)).factorial : ℕ) : ℝ)
      = (2 * (m : ℝ) + 2) * (2 * (m : ℝ) + 1) * (((2 * m).factorial : ℕ) : ℝ) := by
    have h : 2 * (m + 1) = (2 * m + 1) + 1 := by omega
    rw [h, Nat.factorial_succ, Nat.factorial_succ]
    push_cast
    ring
  have hne : ((m.factorial : ℕ) : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr (Nat.factorial_ne_zero m)
  have hm1 : ((m : ℝ) + 1) ≠ 0 := by positivity
  unfold Acoef
  rw [hfac, hfac2, pow_succ]
  field_simp
  ring

theorem Acoef_le_pow (v : ℝ) (M : ℕ) : Acoef v M ≤ (4 * v ^ 2) ^ M := by
  induction M with
  | zero => simp [Acoef_zero]
  | succ m ih =>
      have hrec := Acoef_rec v m
      have hpos : (0 : ℝ) < 2 * (m : ℝ) + 2 := by positivity
      have hA := Acoef_nonneg v m
      have hv2 : (0 : ℝ) ≤ 4 * v ^ 2 := by positivity
      have hstep : Acoef v (m + 1) ≤ 4 * v ^ 2 * Acoef v m := by nlinarith
      calc Acoef v (m + 1) ≤ 4 * v ^ 2 * Acoef v m := hstep
        _ ≤ 4 * v ^ 2 * (4 * v ^ 2) ^ m := mul_le_mul_of_nonneg_left ih hv2
        _ = (4 * v ^ 2) ^ (m + 1) := by ring

/-- `V_M = ∑_{m ≤ M} A_m`, the Gaussian square norm of the squeezed state. -/
def Vsum (v : ℝ) (M : ℕ) : ℝ := ∑ m ∈ Finset.range (M + 1), Acoef v m

/-- `U_M = ∑_{m ≤ M} (2m+1) A_m`, the weighted sum controlling the odd combination. -/
def Usum (v : ℝ) (M : ℕ) : ℝ := ∑ m ∈ Finset.range (M + 1), (2 * (m : ℝ) + 1) * Acoef v m



theorem Vsum_nonneg (v : ℝ) (M : ℕ) : 0 ≤ Vsum v M :=
  Finset.sum_nonneg fun m _ => Acoef_nonneg v m







/-! ## The Gaussian square norms of the squeezed state and its images -/





/-! ## The two limits -/







end

end BookProof.SqueezedGaussStates
