import Mathlib
import BookProof.ChapterA3h
import BookProof.ChapterA4c

/-!
# Chapter A, §A.4 — Prop 79: the massless little group is `SE(2)`

This file continues work-package **N4** of `FORMALIZATION_ROADMAP.md`
(book §A.4, line 5636), formalizing the concrete **massless little group** of
**Proposition 79**, the companion of the massive `SU(2)` case in
`ChapterA4c.lean`.

For a **massless** particle the standard 4-momentum is the null vector
`n = e₀ + e₃ = (1,0,0,1)` (the book's `i l̸ = iγ⁰ + iγ³`), and the little
group `G_l := {T ∈ SL(2,ℂ) | T l̸ = l̸ T}` is exactly the stabiliser of `n`
under the covering map `Υ : SL(2,ℂ) → O(1,3)` of §A.3 (Note 47, see
`ChapterA3h.lean`).  The book records this as `G_l = SE(2)`.

Working on the concrete `2×2` Pauli model of `ChapterA3h.lean`
(`n·σ = σ⁰ + σ³ = diag(2,0)`), we prove:

* `upsilonC_nullCol` — the null-column sum of `Υ(T)` is
  `Υ(T)^μ_0 + Υ(T)^μ_3 = ½ tr(σ^μ T†(σ⁰+σ³)T)`, because `n·σ = σ⁰ + σ³`.
* `fixesNullAxis_iff_conj` — `Υ(T)` fixes `n` **iff** `T†(σ⁰+σ³)T = σ⁰+σ³`.
* `nullConj_iff_form` — that matrix identity holds **iff** `T` is lower
  triangular with unit-modulus top-left entry (`T 0 1 = 0 ∧ |T 0 0| = 1`).
* `massless_little_group` — the headline: the massless little group
  `{T ∈ SL(2,ℂ) | Υ(T) fixes n}` equals `SEtwo`, the lower-triangular
  unimodular subgroup with unit-modulus diagonal — the standard realization of
  (the double cover of) `SE(2) = ℝ² ⋊ SO(2)`.
* `SEtwo_lower_triangular` — the explicit `SE(2)` shape `T = !![a,0;c,a⁻¹]`
  with `|a| = 1` (angle `∈ SO(2)`, translation `c ∈ ℂ ≅ ℝ²`).
* `upsilon_massless_lorentz` — each such `Υ(T)` is a genuine Lorentz
  transformation fixing the null axis.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis is used.
-/

open Matrix
open scoped ComplexConjugate

namespace BookProof.ChapterA3

/-- A real `4×4` matrix **fixes the null axis** `n = e₀ + e₃ = (1,0,0,1)`,
i.e. the sum of its `0`-th and `3`-rd columns is `n`. -/
def FixesNullAxis (Λ : Matrix (Fin 4) (Fin 4) ℝ) : Prop :=
  ∀ μ, Λ μ 0 + Λ μ 3 = (if μ = 0 then 1 else 0) + (if μ = 3 then 1 else 0)

/-- `SE(2)`, the massless little group, realized as the lower-triangular
unimodular `2×2` complex matrices with unit-modulus top-left entry.  Together
with `det = 1` this forces `T = !![a,0;c,a⁻¹]` with `|a| = 1`. -/
def SEtwo : Set (Matrix (Fin 2) (Fin 2) ℂ) :=
  {T | T.det = 1 ∧ T 0 1 = 0 ∧ Complex.normSq (T 0 0) = 1}

/-- `pauliCoeff` is additive in its matrix argument. -/
theorem pauliCoeff_add (A B : Matrix (Fin 2) (Fin 2) ℂ) (μ : Fin 4) :
    pauliCoeff (A + B) μ = pauliCoeff A μ + pauliCoeff B μ := by
  simp [pauliCoeff, Matrix.trace_add, mul_add]

/-- The Pauli coefficients of `σ⁰ + σ³`: `δ_{μ0} + δ_{μ3}`. -/
theorem pauliCoeff_null (μ : Fin 4) :
    pauliCoeff (pauliσ 0 + pauliσ 3) μ =
      (if μ = 0 then 1 else 0) + (if μ = 3 then 1 else 0) := by
  fin_cases μ <;>
    simp [pauliCoeff, pauliσ, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_two,
      Matrix.diag] <;> norm_num

/-- The null-column sum of `Υ(T)`, over the complex Pauli model:
`Υ(T)^μ_0 + Υ(T)^μ_3 = ½ tr(σ^μ T†(σ⁰+σ³)T)`. -/
theorem upsilonC_nullCol (T : Matrix (Fin 2) (Fin 2) ℂ) (μ : Fin 4) :
    UpsilonC T μ 0 + UpsilonC T μ 3 = pauliCoeff (Tᴴ * (pauliσ 0 + pauliσ 3) * T) μ := by
  unfold UpsilonC
  simp only [Matrix.of_apply]
  rw [← pauliCoeff_add]
  congr 1
  simp [Matrix.mul_add, Matrix.add_mul]

/-- **Massless little-group characterization (matrix form).**  `Υ(T)` fixes the
null axis `n` iff `T†(σ⁰+σ³)T = σ⁰+σ³`. -/
theorem fixesNullAxis_iff_conj (T : Matrix (Fin 2) (Fin 2) ℂ) :
    FixesNullAxis (Upsilon T) ↔ Tᴴ * (pauliσ 0 + pauliσ 3) * T = pauliσ 0 + pauliσ 3 := by
  constructor
  · intro h
    have hcoeff : ∀ μ, pauliCoeff (Tᴴ * (pauliσ 0 + pauliσ 3) * T) μ =
        (if μ = 0 then (1:ℂ) else 0) + (if μ = 3 then 1 else 0) := by
      intro μ
      rw [← upsilonC_nullCol]
      have h0 := (upsilon_re T μ 0).symm
      have h3 := (upsilon_re T μ 3).symm
      rw [h0, h3, ← Complex.ofReal_add, h μ]
      split_ifs <;> push_cast <;> ring
    calc Tᴴ * (pauliσ 0 + pauliσ 3) * T
          = ∑ μ, pauliCoeff (Tᴴ * (pauliσ 0 + pauliσ 3) * T) μ • pauliσ μ :=
            pauli_expand _
      _ = ∑ μ, pauliCoeff (pauliσ 0 + pauliσ 3) μ • pauliσ μ := by
            apply Finset.sum_congr rfl; intro μ _; rw [hcoeff μ, pauliCoeff_null μ]
      _ = pauliσ 0 + pauliσ 3 := (pauli_expand _).symm
  · intro h μ
    have hval : (Upsilon T μ 0 : ℂ) + (Upsilon T μ 3 : ℂ) =
        (if μ = 0 then (1:ℂ) else 0) + (if μ = 3 then 1 else 0) := by
      rw [upsilon_re, upsilon_re, upsilonC_nullCol, h, pauliCoeff_null]
    have hre := congrArg Complex.re hval
    simp only [Complex.add_re, Complex.ofReal_re] at hre
    rw [hre]
    split <;> split <;> norm_num

/-
The matrix identity `T†(σ⁰+σ³)T = σ⁰+σ³` holds iff `T` is lower triangular
with unit-modulus top-left entry.
-/
theorem nullConj_iff_form (T : Matrix (Fin 2) (Fin 2) ℂ) :
    Tᴴ * (pauliσ 0 + pauliσ 3) * T = pauliσ 0 + pauliσ 3 ↔
      T 0 1 = 0 ∧ Complex.normSq (T 0 0) = 1 := by
  constructor <;> intro h
  · simp_all [← Matrix.ext_iff, Fin.forall_fin_two, Matrix.mul_apply,
      Matrix.conjTranspose_apply, Complex.normSq]
    simp_all [Complex.ext_iff, pauliσ]
    linarith
  · ext i j
    fin_cases i <;> fin_cases j <;>
      simp_all only [Fin.isValue, Fin.zero_eta, mul_apply, conjTranspose_apply, RCLike.star_def,
          add_apply, Fin.sum_univ_succ, Finset.univ_unique, Fin.default_eq_zero,
              Finset.sum_singleton, Fin.succ_zero_eq_one, Fin.mk_one, mul_zero, zero_add, map_zero,
                  zero_mul] <;> ring
    · simp_all [Complex.ext_iff, pauliσ]
      norm_num [Complex.normSq] at h; constructor <;> linarith
    · simp_all [pauliσ]
    · simp_all [pauliσ]
    · unfold pauliσ; norm_num

/-- **Proposition 79 (massless little group).**  The little group of a massless
standard momentum — the elements of `SL(2,ℂ)` whose Lorentz image `Υ(T)` fixes
the null axis `n = e₀ + e₃` — is exactly `SE(2)` (the lower-triangular
unimodular subgroup with unit-modulus diagonal). -/
theorem massless_little_group :
    {T : Matrix (Fin 2) (Fin 2) ℂ | T.det = 1 ∧ FixesNullAxis (Upsilon T)} = SEtwo := by
  ext T
  simp only [Set.mem_setOf_eq, SEtwo]
  constructor
  · rintro ⟨hd, hf⟩
    obtain ⟨hb, ha⟩ := (nullConj_iff_form T).mp ((fixesNullAxis_iff_conj T).mp hf)
    exact ⟨hd, hb, ha⟩
  · rintro ⟨hd, hb, ha⟩
    exact ⟨hd, (fixesNullAxis_iff_conj T).mpr ((nullConj_iff_form T).mpr ⟨hb, ha⟩)⟩

/-- The explicit `SE(2)` shape: an element of the massless little group is
`T = !![a,0;c,a⁻¹]` with `|a| = 1` — a rotation angle (`a` on the unit circle,
i.e. `SO(2)`) together with a translation `c ∈ ℂ ≅ ℝ²`. -/
theorem SEtwo_lower_triangular (T : Matrix (Fin 2) (Fin 2) ℂ) (hT : T ∈ SEtwo) :
    T 0 1 = 0 ∧ T 1 1 = (T 0 0)⁻¹ ∧ Complex.normSq (T 0 0) = 1 := by
  obtain ⟨hd, hb, ha⟩ := hT
  refine ⟨hb, ?_, ha⟩
  have ha0 : T 0 0 ≠ 0 := by
    intro h; rw [h] at ha; simp at ha
  rw [Matrix.det_fin_two] at hd
  rw [hb] at hd
  field_simp at hd ⊢
  linear_combination hd

/-- Each element of the massless little group maps to a genuine Lorentz
transformation that fixes the null axis. -/
theorem upsilon_massless_lorentz (T : Matrix (Fin 2) (Fin 2) ℂ) (hT : T ∈ SEtwo) :
    Upsilon T ∈ LorentzO ∧ FixesNullAxis (Upsilon T) := by
  obtain ⟨hd, hb, ha⟩ := hT
  exact ⟨upsilon_mem_lorentz T hd,
    (fixesNullAxis_iff_conj T).mpr ((nullConj_iff_form T).mpr ⟨hb, ha⟩)⟩

end BookProof.ChapterA3
