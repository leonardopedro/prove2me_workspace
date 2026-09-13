-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.ComparisonData.comparison_inner_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
open BookProof.NavierStokesFlow.FarisLavineLift.ComparisonData
open BookProof.NavierStokesFlow











open FullEsa



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



variable {d : ℕ} (c : ComparisonData F d)

set_option maxHeartbeats 1000000 in
theorem solution (v : c.D) :
    (inner ℂ ((v : F)) ((c.comparison v : c.D) : F) : ℂ).re
      = (∑ i, ‖((c.mom i v : c.D) : F)‖ ^ 2) + (∑ i, ‖((c.drift i v : c.D) : F)‖ ^ 2)
        + ‖(v : F)‖ ^ 2 := by

  have hmom : ∀ i : Fin d,
      (inner ℂ ((v : F)) (((c.mom i).comp (c.mom i) v : c.D) : F) : ℂ)
        = ((‖((c.mom i v : c.D) : F)‖ ^ 2 : ℝ) : ℂ) := by
    intro i
    have h := (c.mom_symm i) v ((c.mom i) v)
    have h2 : (inner ℂ ((v : F)) (((c.mom i) ((c.mom i) v) : c.D) : F) : ℂ)
        = inner ℂ ((c.mom i v : c.D) : F) ((c.mom i v : c.D) : F) := by
      simpa using h.symm
    rw [LinearMap.comp_apply, h2]
    simp
  have hdrift : ∀ i : Fin d,
      (inner ℂ ((v : F)) (((c.drift i).comp (c.drift i) v : c.D) : F) : ℂ)
        = ((‖((c.drift i v : c.D) : F)‖ ^ 2 : ℝ) : ℂ) := by
    intro i
    have h := (c.drift_symm i) v ((c.drift i) v)
    have h2 : (inner ℂ ((v : F)) (((c.drift i) ((c.drift i) v) : c.D) : F) : ℂ)
        = inner ℂ ((c.drift i v : c.D) : F) ((c.drift i v : c.D) : F) := by
      simpa using h.symm
    rw [LinearMap.comp_apply, h2]
    simp
  have hsplit : (inner ℂ ((v : F)) ((c.comparison v : c.D) : F) : ℂ)
      = (∑ i, (inner ℂ ((v : F)) (((c.mom i).comp (c.mom i) v : c.D) : F) : ℂ))
        + (∑ i, (inner ℂ ((v : F)) (((c.drift i).comp (c.drift i) v : c.D) : F) : ℂ))
        + inner ℂ ((v : F)) ((v : F)) := by
    simp only [comparison, LinearMap.add_apply, LinearMap.id_apply, Submodule.coe_add,
      inner_add_right, LinearMap.sum_apply, AddSubmonoidClass.coe_finset_sum, inner_sum]
  rw [hsplit]
  simp only [hmom, hdrift]
  rw [← Complex.ofReal_sum, ← Complex.ofReal_sum]
  have hself : (inner ℂ ((v : F)) ((v : F)) : ℂ) = ((‖(v : F)‖ ^ 2 : ℝ) : ℂ) := by
    simp
  rw [hself]
  have hcast : ∀ r : ℝ, ((r : ℂ) ^ 2).re = r ^ 2 := fun r => by
    rw [← Complex.ofReal_pow, Complex.ofReal_re]
  simp [hcast]
