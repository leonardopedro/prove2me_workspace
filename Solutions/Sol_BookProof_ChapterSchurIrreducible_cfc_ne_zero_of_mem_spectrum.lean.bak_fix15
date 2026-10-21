-- Generated from ChapterSchurIrreducible.lean — solution of BookProof.ChapterSchurIrreducible.cfc_ne_zero_of_mem_spectrum
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
open BookProof.ChapterSchurIrreducible



open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial V] {T : V →L[ℂ] V} (hT : IsSelfAdjoint T)
    {f : ℝ → ℝ} (hf : Continuous f) {p : ℝ} (hp : p ∈ spectrum ℝ T) (hfp : f p ≠ 0) :
    cfc f T ≠ 0 := by

  intro h
  have hs : spectrum ℝ (cfc f T) = f '' spectrum ℝ T := cfc_map_spectrum f T
  rw [h, spectrum.zero_eq] at hs
  have : f p ∈ ({0} : Set ℝ) := by rw [hs]; exact ⟨p, hp, rfl⟩
  exact hfp this
