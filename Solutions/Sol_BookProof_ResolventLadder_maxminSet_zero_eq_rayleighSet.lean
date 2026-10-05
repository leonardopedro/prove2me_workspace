-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.maxminSet_zero_eq_rayleighSet
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_rayleighInfOn_span_singleton
import Theorems.Thm_BookProof_RitzMinMax_exists_unit_mem
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (R : F →L[ℂ] F) : maxminSet R 0 = rayleighSet R := by

  ext t
  constructor
  · rintro ⟨S, hrank, rfl⟩
    have hfd : FiniteDimensional ℂ S := .of_finrank_pos (by rw [hrank]; omega)
    obtain ⟨x, hx, hx1⟩ := exists_unit_mem S (by rw [hrank]; omega)
    have hx0 : x ≠ 0 := by
      intro h
      rw [h] at hx1
      simp at hx1
    have hspan : Submodule.span ℂ {x} = S :=
      Submodule.eq_of_le_of_finrank_eq (Submodule.span_le.mpr (by simpa using hx))
        (by rw [finrank_span_singleton hx0, hrank])
    rw [← hspan, rayleighInfOn_span_singleton R hx1]
    exact ⟨x, hx1, rfl⟩
  · rintro ⟨x, hx1, rfl⟩
    have hx0 : x ≠ 0 := by
      intro h
      rw [h] at hx1
      simp at hx1
    exact ⟨Submodule.span ℂ {x}, by simpa using finrank_span_singleton hx0,
      (rayleighInfOn_span_singleton R hx1).symm⟩
