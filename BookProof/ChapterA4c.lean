import Mathlib
import BookProof.ChapterA3h

/-!
# Chapter A, §A.4 — Prop 79: the massive little group is `SU(2)`

This file continues work-package **N4** of `FORMALIZATION_ROADMAP.md`
(book §A.4, line 5636), formalizing the concrete **massive little group** of
**Proposition 79**.

The little group `G_l := {T ∈ SL(2,ℂ) | T l̸ = l̸ T}` of a standard 4-momentum
`l` is realized in the `SL(2,ℂ)` covering picture of §A.3 (Note 47, the map
`Υ : SL(2,ℂ) → O(1,3)`, see `ChapterA3h.lean`).  For a **massive** particle the
standard momentum points along the time axis `e₀ = (1,0,0,0)`, and the little
group is exactly the stabiliser of `e₀` under `Υ`.  The book records this as
`i l̸ = iγ⁰ ⇒ G_l = SU(2)`.

Working on the concrete `2×2` Pauli model of `ChapterA3h.lean`, we prove:

* `upsilonC_timeCol` — the time column of the Lorentz matrix `Υ(T)` is
  `Υ(T)^μ_0 = ½ tr(σ^μ T† T)`, because `σ⁰ = 1` (so `T† σ⁰ T = T† T`).
* `fixesTimeAxis_iff_unitary` — `Υ(T)` fixes the time axis `e₀` **iff** `T` is
  unitary (`T† T = 1`).  (This needs no `det T = 1` hypothesis: the reconstruction
  identity for the Pauli basis already forces `T† T = 1`.)
* `massive_little_group` — the headline: the massive little group
  `{T ∈ SL(2,ℂ) | Υ(T) e₀ = e₀}` equals `SU(2) = {T | det T = 1 ∧ T† T = 1}`.
* `upsilon_little_group_lorentz` — each such `Υ(T)` is a genuine Lorentz
  transformation fixing the time axis, i.e. a spatial rotation.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis is used.
-/

open Matrix
open scoped ComplexConjugate

namespace BookProof.ChapterA3

/-- A real `4×4` matrix **fixes the time axis** `e₀ = (1,0,0,0)`, i.e. its
`0`-th column is `e₀`. -/
def FixesTimeAxis (Λ : Matrix (Fin 4) (Fin 4) ℝ) : Prop :=
  ∀ μ, Λ μ 0 = if μ = 0 then 1 else 0

/-- `SU(2)`, the special unitary group, as `2×2` complex matrices:
unimodular (`det = 1`) and unitary (`T† T = 1`). -/
def SUtwo : Set (Matrix (Fin 2) (Fin 2) ℂ) :=
  {T | T.det = 1 ∧ Tᴴ * T = 1}

/-- The Pauli coefficients of the identity: `½ tr σ^μ = δ_{μ0}`. -/
theorem pauliCoeff_one (μ : Fin 4) :
    pauliCoeff (1 : Matrix (Fin 2) (Fin 2) ℂ) μ = if μ = 0 then 1 else 0 := by
  fin_cases μ <;>
    simp [pauliCoeff, pauliσ, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_two, Matrix.diag]
  norm_num

/-- The time column of `Υ(T)` is `Υ(T)^μ_0 = ½ tr(σ^μ T† T)`, since `σ⁰ = 1`. -/
theorem upsilonC_timeCol (T : Matrix (Fin 2) (Fin 2) ℂ) (μ : Fin 4) :
    UpsilonC T μ 0 = pauliCoeff (Tᴴ * T) μ := by
  unfold UpsilonC
  have h0 : pauliσ 0 = (1 : Matrix (Fin 2) (Fin 2) ℂ) := by
    ext i j; fin_cases i <;> fin_cases j <;> simp [pauliσ]
  simp [h0]

/-- The real matrix `Υ(T)` complexifies entrywise to `UpsilonC T` (its entries
are real). -/
theorem upsilon_re (T : Matrix (Fin 2) (Fin 2) ℂ) (μ ν : Fin 4) :
    ((Upsilon T μ ν : ℝ) : ℂ) = UpsilonC T μ ν := by
  unfold Upsilon
  simp only [Matrix.of_apply]
  exact (Complex.conj_eq_iff_re.mp (upsilonC_real T μ ν)) ▸ rfl

/-- **Massive little-group characterization.**  `Υ(T)` fixes the time axis `e₀`
iff `T` is unitary. -/
theorem fixesTimeAxis_iff_unitary (T : Matrix (Fin 2) (Fin 2) ℂ) :
    FixesTimeAxis (Upsilon T) ↔ Tᴴ * T = 1 := by
  constructor
  · intro h
    have hcoeff : ∀ μ, pauliCoeff (Tᴴ * T) μ = if μ = 0 then 1 else 0 := by
      intro μ
      rw [← upsilonC_timeCol, ← upsilon_re]
      have := h μ
      rw [this]
      split <;> norm_num
    calc Tᴴ * T = ∑ μ, pauliCoeff (Tᴴ * T) μ • pauliσ μ := pauli_expand _
      _ = ∑ μ, (if μ = 0 then (1 : ℂ) else 0) • pauliσ μ := by
            apply Finset.sum_congr rfl; intro μ _; rw [hcoeff μ]
      _ = 1 := by
            simp only [ite_smul, one_smul, zero_smul]
            rw [Finset.sum_ite_eq' Finset.univ (0 : Fin 4) (fun μ => pauliσ μ)]
            simp only [Finset.mem_univ, if_true]
            ext i j; fin_cases i <;> fin_cases j <;> simp [pauliσ]
  · intro h μ
    have hval : (Upsilon T μ 0 : ℂ) = if μ = 0 then 1 else 0 := by
      rw [upsilon_re, upsilonC_timeCol, h, pauliCoeff_one]
    have hre := congrArg Complex.re hval
    simp only [Complex.ofReal_re] at hre
    rw [hre]
    split <;> simp

/-- **Proposition 79 (massive little group).**  The little group of a massive
standard momentum — the elements of `SL(2,ℂ)` whose Lorentz image `Υ(T)` fixes
the time axis `e₀` — is exactly `SU(2)`. -/
theorem massive_little_group :
    {T : Matrix (Fin 2) (Fin 2) ℂ | T.det = 1 ∧ FixesTimeAxis (Upsilon T)} = SUtwo := by
  ext T
  simp only [Set.mem_setOf_eq, SUtwo]
  constructor
  · rintro ⟨hd, hf⟩; exact ⟨hd, (fixesTimeAxis_iff_unitary T).mp hf⟩
  · rintro ⟨hd, hu⟩; exact ⟨hd, (fixesTimeAxis_iff_unitary T).mpr hu⟩

/-- Each element of the massive little group maps to a genuine Lorentz
transformation that fixes the time axis, i.e. a spatial rotation. -/
theorem upsilon_little_group_lorentz (T : Matrix (Fin 2) (Fin 2) ℂ) (hT : T ∈ SUtwo) :
    Upsilon T ∈ LorentzO ∧ FixesTimeAxis (Upsilon T) := by
  obtain ⟨hd, hu⟩ := hT
  exact ⟨upsilon_mem_lorentz T hd, (fixesTimeAxis_iff_unitary T).mpr hu⟩

end BookProof.ChapterA3
