import Mathlib

/-!
# Chapter "Wave-function collapse versus Euler's formula", §"Euler's formula for
the probability clock" — stochastic transformations vs. the invertible rotation

Source: `book.tex`, chapter *"Wave-function collapse versus Euler's formula"*,
§*"Euler's formula for the probability clock"* (`book.tex` line ~3320).

After exhibiting the wave-function `Ψ(t) = (cos t, sin t)` and its rotation
`Ψ(t+a) = exp(J a) Ψ(t)`, the book contrasts the *wave-function* picture with a
*direct* linear action on **probability distributions**:

> *"Note that the rotation is an invertible linear transformation that
> preserves the space of wave-functions. This does not happen with probability
> distributions: the most general linear transformation of a probability
> distribution that preserves the space of probability distributions is*
> `M(a,b) = [[cos²a, cos²b], [sin²a, sin²b]]` *… because if we apply `M` to a
> deterministic distribution `[1,0]` or `[0,1]` we must obtain probability
> distributions … the matrix `M` such that `M·(1/2)[1,1]ᵀ = [1,0]ᵀ` is
> necessarily singular and so it is not suitable to represent a symmetry group."*

This file formalizes that self-contained linear-algebra content for the 2-state
phase space.

## Deliverables

* **General form / column-stochastic matrices.**
  * `Mab a b` — the book's matrix `[[cos²a, cos²b], [sin²a, sin²b]]`;
    `Mab_isColumnStochastic` — its columns are probability vectors.
  * `IsColumnStochastic.mulVec_isProbabilityVector` — a column-stochastic matrix
    maps probability vectors to probability vectors.
  * `preserves_prob_iff_isColumnStochastic` — a `2×2` real matrix maps *every*
    probability vector to a probability vector **iff** it is column-stochastic
    (the honest form of "the most general linear transformation preserving the
    space of probability distributions").
  * `isColumnStochastic_eq_Mab` — every column-stochastic `2×2` matrix is
    `Mab a b` for some real `a, b` (so `M(a,b)` really is the general form).

* **The book's singularity point (headline).**
  * `stochastic_uniform_to_deterministic_singular` — if a column-stochastic
    matrix `M` sends the uniform distribution `(1/2, 1/2)` to a deterministic
    distribution `(1, 0)`, then `det M = 0`.
  * `stochastic_uniform_to_deterministic_not_isUnit` — consequently `M` is not
    invertible, hence "not suitable to represent a symmetry group".

* **Contrast: the rotation is a genuine (invertible) symmetry.**
  * `rotMat a` — the rotation `[[cos a, -sin a], [sin a, cos a]]`;
    `rotMat_det` (`= 1`, invertible), `rotMat_isUnit`.
  * `clockPsi` `= (cos t, sin t)` and `rotMat_mulVec_clockPsi`
    (`Ψ(t+a) = rotMat a · Ψ(t)`) — the rotation preserves the wave-function
    circle.
  * `rotMat_eq_exp` — `rotMat a = exp(a·J)` with `J = [[0,-1],[1,0]]`, the
    matrix Euler's formula, and `clockPsi_eq_exp` — `Ψ(t) = exp(t·J)·(1,0)`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ProbabilityClockStochastic

open Matrix
open scoped Norms.Operator

/-! ## Probability vectors and column-stochastic matrices -/

/-- A `2`-vector is a probability vector: nonnegative entries summing to `1`. -/
def IsProbabilityVector (v : Fin 2 → ℝ) : Prop :=
  (∀ i, 0 ≤ v i) ∧ ∑ i, v i = 1

/-- A `2×2` matrix is column-stochastic: nonnegative entries, each column
summing to `1` (columns are probability vectors). -/
def IsColumnStochastic (M : Matrix (Fin 2) (Fin 2) ℝ) : Prop :=
  (∀ i j, 0 ≤ M i j) ∧ ∀ j, ∑ i, M i j = 1

/-- The book's general matrix `M(a,b) = [[cos²a, cos²b], [sin²a, sin²b]]`. -/
noncomputable def Mab (a b : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos a ^ 2, Real.cos b ^ 2; Real.sin a ^ 2, Real.sin b ^ 2]

/-- `M(a,b)` is column-stochastic: each column `(cos²·, sin²·)` is a probability
vector. -/
theorem Mab_isColumnStochastic (a b : ℝ) : IsColumnStochastic (Mab a b) := by
  refine ⟨?_, ?_⟩
  · intro i j; fin_cases i <;> fin_cases j <;> simp only [Mab, Fin.zero_eta, Fin.isValue, of_apply,
      cons_val', cons_val_zero, cons_val_fin_one, Fin.mk_one, cons_val_one] <;> positivity
  · intro j; fin_cases j <;>
      simp [Mab, Fin.sum_univ_two, Real.cos_sq_add_sin_sq]

/-- A column-stochastic matrix maps a probability vector to a probability
vector. -/
theorem IsColumnStochastic.mulVec_isProbabilityVector
    {M : Matrix (Fin 2) (Fin 2) ℝ} (hM : IsColumnStochastic M)
    {v : Fin 2 → ℝ} (hv : IsProbabilityVector v) :
    IsProbabilityVector (M.mulVec v) := by
  obtain ⟨hnn, hcol⟩ := hM
  obtain ⟨hvnn, hvsum⟩ := hv
  refine ⟨?_, ?_⟩
  · intro i
    simp only [Matrix.mulVec, dotProduct]
    exact Finset.sum_nonneg (fun j _ => mul_nonneg (hnn i j) (hvnn j))
  · have hc0 := hcol 0
    have hc1 := hcol 1
    simp only [Fin.sum_univ_two] at hc0 hc1
    have hv2 : v 0 + v 1 = 1 := by simpa [Fin.sum_univ_two] using hvsum
    simp only [Matrix.mulVec, dotProduct, Fin.sum_univ_two]
    linear_combination v 0 * hc0 + v 1 * hc1 + hv2

/-- **The general probability-preserving transformation.** A `2×2` real matrix
maps every probability vector to a probability vector *iff* it is
column-stochastic — i.e. exactly the matrices `M(a,b)` of the book (see
`isColumnStochastic_eq_Mab`). -/
theorem preserves_prob_iff_isColumnStochastic (M : Matrix (Fin 2) (Fin 2) ℝ) :
    (∀ v, IsProbabilityVector v → IsProbabilityVector (M.mulVec v))
      ↔ IsColumnStochastic M := by
  constructor
  · intro h
    have hb : ∀ j : Fin 2, IsProbabilityVector (Pi.single j 1) := fun j =>
      ⟨fun k => by rw [Pi.single_apply]; split <;> norm_num, by simp⟩
    refine ⟨?_, ?_⟩
    · intro i j
      have := (h _ (hb j)).1 i
      simpa [Matrix.mulVec, dotProduct, Pi.single_apply, Finset.sum_ite_eq] using this
    · intro j
      have := (h _ (hb j)).2
      simpa [Matrix.mulVec, dotProduct, Pi.single_apply, Finset.sum_ite_eq,
        Finset.sum_comm] using this
  · intro hM v hv; exact hM.mulVec_isProbabilityVector hv

/-- For `p ∈ [0,1]` there is an angle `a` with `cos²a = p` (used to realize an
arbitrary column of a column-stochastic matrix as `(cos²·, sin²·)`). -/
private theorem exists_cos_sq {p : ℝ} (h0 : 0 ≤ p) (h1 : p ≤ 1) :
    ∃ a : ℝ, Real.cos a ^ 2 = p := by
  refine ⟨Real.arccos (Real.sqrt p), ?_⟩
  rw [Real.cos_arccos (by linarith [Real.sqrt_nonneg p]) (by
    rw [show (1 : ℝ) = Real.sqrt 1 by simp]; exact Real.sqrt_le_sqrt h1)]
  rw [Real.sq_sqrt h0]

/-- Every column-stochastic `2×2` matrix has the book's form `M(a,b)` for some
real `a, b`. -/
theorem isColumnStochastic_eq_Mab {M : Matrix (Fin 2) (Fin 2) ℝ}
    (hM : IsColumnStochastic M) : ∃ a b, M = Mab a b := by
  obtain ⟨hnn, hcol⟩ := hM
  have hc0 := hcol 0
  have hc1 := hcol 1
  simp only [Fin.sum_univ_two] at hc0 hc1
  obtain ⟨a, ha⟩ := exists_cos_sq (hnn 0 0) (by linarith [hnn 1 0])
  obtain ⟨b, hb⟩ := exists_cos_sq (hnn 0 1) (by linarith [hnn 1 1])
  refine ⟨a, b, ?_⟩
  have hsa : Real.sin a ^ 2 = M 1 0 := by
    have := Real.cos_sq_add_sin_sq a; nlinarith [this, ha, hc0]
  have hsb : Real.sin b ^ 2 = M 1 1 := by
    have := Real.cos_sq_add_sin_sq b; nlinarith [this, hb, hc1]
  ext i j; fin_cases i <;> fin_cases j <;> simp [Mab, ha, hb, hsa, hsb]

/-! ## The book's singularity point -/

/-- **Headline.** If a column-stochastic matrix `M` maps the uniform
distribution `(1/2, 1/2)` to the deterministic distribution `(1, 0)`, then `M`
is singular: `det M = 0`. Hence the transformation cannot represent a symmetry
group element. -/
theorem stochastic_uniform_to_deterministic_singular
    {M : Matrix (Fin 2) (Fin 2) ℝ} (hM : IsColumnStochastic M)
    (hMap : M.mulVec ![1 / 2, 1 / 2] = ![1, 0]) : M.det = 0 := by
  obtain ⟨hnn, _⟩ := hM
  have e1 : M 1 0 * (1 / 2) + M 1 1 * (1 / 2) = 0 := by
    have h := congrFun hMap 1
    simp [Matrix.mulVec, Matrix.vecHead, Matrix.vecTail] at h
    linarith [h]
  have h10 : M 1 0 = 0 := by linarith [hnn 1 0, hnn 1 1]
  have h11 : M 1 1 = 0 := by linarith [hnn 1 0, hnn 1 1]
  rw [Matrix.det_fin_two, h10, h11]; ring

/-- Consequently such an `M` is not invertible. -/
theorem stochastic_uniform_to_deterministic_not_isUnit
    {M : Matrix (Fin 2) (Fin 2) ℝ} (hM : IsColumnStochastic M)
    (hMap : M.mulVec ![1 / 2, 1 / 2] = ![1, 0]) : ¬ IsUnit M := by
  rw [Matrix.isUnit_iff_isUnit_det, stochastic_uniform_to_deterministic_singular hM hMap]
  simp

/-! ## Contrast: the rotation is a genuine invertible symmetry -/

/-- The clock wave-function `Ψ(t) = (cos t, sin t)`. -/
noncomputable def clockPsi (t : ℝ) : Fin 2 → ℝ := ![Real.cos t, Real.sin t]

/-- The generator `J = [[0,-1],[1,0]]` (the "imaginary unit" of the clock). -/
def Jgen : Matrix (Fin 2) (Fin 2) ℝ := !![0, -1; 1, 0]

/-- The rotation matrix `[[cos a, -sin a], [sin a, cos a]]`. -/
noncomputable def rotMat (a : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos a, -Real.sin a; Real.sin a, Real.cos a]

/-- The rotation is invertible: `det (rotMat a) = 1`. -/
theorem rotMat_det (a : ℝ) : (rotMat a).det = 1 := by
  simp only [rotMat, Matrix.det_fin_two_of]
  nlinarith [Real.cos_sq_add_sin_sq a]

/-- Hence the rotation is a unit (an invertible symmetry) — unlike the singular
stochastic matrix above. -/
theorem rotMat_isUnit (a : ℝ) : IsUnit (rotMat a) := by
  rw [Matrix.isUnit_iff_isUnit_det, rotMat_det]; exact isUnit_one

/-- The rotation acts on the wave-function circle as the time translation
`Ψ(t+a) = rotMat a · Ψ(t)`. -/
theorem rotMat_mulVec_clockPsi (t a : ℝ) :
    (rotMat a).mulVec (clockPsi t) = clockPsi (t + a) := by
  funext i
  fin_cases i <;>
    simp [rotMat, clockPsi, Matrix.mulVec, dotProduct, Fin.sum_univ_two,
      Real.cos_add, Real.sin_add] <;> ring

/-- `J² = -1`: the generator squares to `-1`, the defining property of the
"imaginary unit" of the two-state clock. -/
theorem Jgen_sq : Jgen * Jgen = -1 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [Jgen]

/-- **Matrix Euler's formula.** The rotation is the exponential of `a·J`:
`rotMat a = exp(a • J)`.

Proof via `Complex.liftAux J Jgen_sq`, the `ℝ`-algebra embedding `ℂ → M₂(ℝ)`
sending `i ↦ J`: it is continuous (finite-dimensional), so it commutes with the
exponential (`NormedSpace.map_exp`); the claim then reduces to Euler's formula
`exp(a i) = cos a + i sin a` in `ℂ`. -/
theorem rotMat_eq_exp (a : ℝ) :
    NormedSpace.exp (a • Jgen) = rotMat a := by
  have hcont : Continuous ⇑(Complex.liftAux Jgen Jgen_sq) := by
    have := (Complex.liftAux Jgen Jgen_sq).toLinearMap.continuous_of_finiteDimensional
    simpa [AlgHom.coe_toLinearMap] using this
  have hfI : (Complex.liftAux Jgen Jgen_sq) (a • Complex.I) = a • Jgen := by
    rw [Complex.liftAux_apply]; simp [Complex.real_smul]
  have hval : NormedSpace.exp (a • Complex.I)
      = ((Real.cos a : ℂ)) + (Real.sin a : ℂ) * Complex.I := by
    rw [← Complex.exp_eq_exp_ℂ, Complex.real_smul, Complex.exp_mul_I,
      ← Complex.ofReal_cos, ← Complex.ofReal_sin]
  rw [← hfI, ← NormedSpace.map_exp _ hcont, hval, Complex.liftAux_apply]
  simp only [Complex.add_re, Complex.add_im, Complex.ofReal_re, Complex.ofReal_im,
    Complex.mul_re, Complex.mul_im, Complex.I_re, Complex.I_im, mul_zero, mul_one,
    sub_zero, add_zero, zero_add]
  rw [Algebra.algebraMap_eq_smul_one]
  ext i j; fin_cases i <;> fin_cases j <;> simp [Jgen, rotMat]

/-- The clock wave-function is `Ψ(t) = exp(t·J)·(1,0)`, exactly the book's
`Ψ(t) = exp([[0,-1],[1,0]] t) [1,0]ᵀ`. -/
theorem clockPsi_eq_exp (t : ℝ) :
    (NormedSpace.exp (t • Jgen)).mulVec ![1, 0] = clockPsi t := by
  rw [rotMat_eq_exp]
  funext i
  fin_cases i <;>
    simp [rotMat, clockPsi, Matrix.mulVec, dotProduct, Fin.sum_univ_two]

end BookProof.ProbabilityClockStochastic
