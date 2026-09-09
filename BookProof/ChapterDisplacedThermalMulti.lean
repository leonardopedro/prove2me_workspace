import Mathlib
import BookProof.ChapterDisplacedThermalOverlap
import BookProof.ChapterCoherentGeometry

/-!
# Multi-mode displaced thermal states: attention at the bath temperature

`ChapterDisplacedThermalOverlap` computed, for a *single* quadrature, the
overlap of two displaced thermal states and showed the induced Born weights are
a Softmax at inverse temperature `β = 1/(4τ)`, `τ = n̄ + ½`.  This module runs
the same computation for `n` independent modes, which is the setting the
attention chapter actually uses: queries and keys are vectors of
`EuclideanSpace ℝ (Fin n)`.

## Deliverables

* `dtOverlapMulti` — the multi-mode overlap, the product of the one-mode
  overlaps, and `dtOverlapMulti_eq_integral` — it *is* the phase-space integral
  of the product of the two `n`-mode Gaussian densities;
* `dtOverlapMulti_eq` — the closed form
  `⟨a|b⟩ = exp(−‖a−b‖²/4τ) / (√(4πτ))ⁿ`: a Gaussian in the phase-space
  *distance*, of width the temperature;
* `dtBornMulti_eq_softmax` — **headline**: the multi-mode Born weights are
  exactly a Softmax over minus the squared distances at inverse temperature
  `β = 1/(4τ)`;
* `dtBornMulti_vacuum_eq_bornWeight` — the **vacuum limit closes the loop with
  the chapter**: at `n̄ = 0` (temperature `τ = ½`) and in the dimensionless
  coherent parameter `α = x/√2`, the thermal Born weights are *exactly* the
  coherent-state Born weights `ChapterSoftmaxBorn.bornWeight` of the attention
  chapter.

The rescaling by `√2` in the last item is the standard change between the
quadrature variable `x` (in which the vacuum has variance `½`) and the
dimensionless coherent parameter `α` (in which the vacuum overlap reads
`exp(−‖q−k‖²)`); it is stated explicitly rather than hidden in a normalization.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal

namespace BookProof.ChapterDisplacedThermalMulti

open BookProof.ChapterDisplacedThermalOverlap

variable {n m : ℕ}

/-- The squared Euclidean norm as a sum of squared coordinates. -/
theorem norm_sq_eq_sum (a b : EuclideanSpace ℝ (Fin n)) :
    ‖a - b‖ ^ 2 = ∑ i, (a i - b i) ^ 2 := by
  rw [EuclideanSpace.norm_eq, Real.sq_sqrt (by positivity)]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [PiLp.sub_apply, Real.norm_eq_abs, sq_abs]

/-- The **multi-mode overlap** of two displaced thermal states: the product of
the one-mode overlaps of the modes. -/
def dtOverlapMulti (nbar : ℝ≥0) (a b : EuclideanSpace ℝ (Fin n)) : ℝ :=
  ∏ i, dtOverlap nbar (a i) (b i)

/-- The multi-mode overlap is the phase-space integral of the product of the two
`n`-mode Gaussian densities. -/
theorem dtOverlapMulti_eq_integral (nbar : ℝ≥0) (a b : EuclideanSpace ℝ (Fin n)) :
    dtOverlapMulti nbar a b
      = ∫ x : Fin n → ℝ, ∏ i, (gaussianPDFReal (a i) (tauNN nbar) (x i)
          * gaussianPDFReal (b i) (tauNN nbar) (x i)) := by
  rw [dtOverlapMulti,
    MeasureTheory.integral_fintype_prod_volume_eq_prod
      (fun i (y : ℝ) => gaussianPDFReal (a i) (tauNN nbar) y
        * gaussianPDFReal (b i) (tauNN nbar) y)]
  rfl

/-- **The multi-mode overlap is a Gaussian of the phase-space distance**, of
width the temperature `τ = n̄ + ½`. -/
theorem dtOverlapMulti_eq (nbar : ℝ≥0) (a b : EuclideanSpace ℝ (Fin n)) :
    dtOverlapMulti nbar a b
      = Real.exp (-‖a - b‖ ^ 2 / (4 * ((nbar : ℝ) + 1 / 2)))
        / (Real.sqrt (4 * π * ((nbar : ℝ) + 1 / 2))) ^ n := by
  have hτ : (0 : ℝ) < 4 * ((nbar : ℝ) + 1 / 2) := by positivity
  simp only [dtOverlapMulti, dtOverlap_eq]
  rw [Finset.prod_div_distrib, ← Real.exp_sum]
  congr 1
  · congr 1
    rw [norm_sq_eq_sum, neg_div, Finset.sum_div, ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    ring
  · simp

theorem dtOverlapMulti_pos (nbar : ℝ≥0) (a b : EuclideanSpace ℝ (Fin n)) :
    0 < dtOverlapMulti nbar a b :=
  Finset.prod_pos fun i _ => dtOverlap_pos nbar (a i) (b i)

/-- The **multi-mode Born attention weight**. -/
def dtBornMulti (nbar : ℝ≥0) (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) : ℝ :=
  dtOverlapMulti nbar q (k j) / ∑ l, dtOverlapMulti nbar q (k l)

/-- **Headline.**  The multi-mode Born weights are exactly a Softmax over minus
the squared phase-space distances, at the inverse temperature `β = 1/(4τ)` set
by the thermal bath. -/
theorem dtBornMulti_eq_softmax (nbar : ℝ≥0) (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) :
    dtBornMulti nbar q k j
      = BookProof.ChapterSoftmaxSharpness.scoreSoftmax (inverseTemperature nbar)
          (fun l => -‖q - k l‖ ^ 2) j := by
  have hc : (0 : ℝ) < (Real.sqrt (4 * π * ((nbar : ℝ) + 1 / 2))) ^ n := by
    have : (0 : ℝ) < Real.sqrt (4 * π * ((nbar : ℝ) + 1 / 2)) :=
      Real.sqrt_pos.mpr (by positivity)
    positivity
  have hval : ∀ l : Fin m, dtOverlapMulti nbar q (k l)
      = ((Real.sqrt (4 * π * ((nbar : ℝ) + 1 / 2))) ^ n)⁻¹
        * Real.exp (inverseTemperature nbar * (-‖q - k l‖ ^ 2)) := by
    intro l
    rw [dtOverlapMulti_eq, inverseTemperature, div_eq_inv_mul]
    congr 2
    field_simp
  simp only [dtBornMulti, BookProof.ChapterSoftmaxSharpness.scoreSoftmax, hval]
  rw [← Finset.mul_sum, mul_div_mul_left _ _ (inv_ne_zero (ne_of_gt hc))]

/-- **The vacuum limit is the chapter's coherent-state Born rule.**  At zero bath
occupation the temperature is the pure zero-point `τ = ½`, and — after the
standard change from the quadrature variable to the dimensionless coherent
parameter, `x = √2·α` — the thermal Born weights coincide with the coherent Born
weights `ChapterSoftmaxBorn.bornWeight` of the attention chapter. -/
theorem dtBornMulti_vacuum_eq_bornWeight (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) :
    dtBornMulti 0 (Real.sqrt 2 • q) (fun l => Real.sqrt 2 • k l) j
      = BookProof.ChapterSoftmaxBorn.bornWeight q k j := by
  have hscale : ∀ l : Fin m,
      -‖Real.sqrt 2 • q - Real.sqrt 2 • k l‖ ^ 2 = 2 * (-‖q - k l‖ ^ 2) := by
    intro l
    rw [← smul_sub, norm_smul, mul_pow, Real.norm_eq_abs,
      abs_of_nonneg (Real.sqrt_nonneg 2), Real.sq_sqrt (by norm_num)]
    ring
  rw [dtBornMulti_eq_softmax,
    BookProof.ChapterCoherentGeometry.bornWeight_eq_scoreSoftmax_neg_dist_sq]
  simp only [BookProof.ChapterSoftmaxSharpness.scoreSoftmax, hscale, inverseTemperature,
    NNReal.coe_zero]
  norm_num
  refine congrArg₂ _ ?_ (Finset.sum_congr rfl fun l _ => ?_) <;> ring_nf

end BookProof.ChapterDisplacedThermalMulti

end
