-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.rayleighSet_neg
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
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
theorem solution (R : F →L[ℂ] F) : rayleighSet (-R) = -rayleighSet R := by

  ext t
  rw [Set.mem_neg]
  constructor
  · rintro ⟨x, hx1, rfl⟩
    refine ⟨x, hx1, ?_⟩
    simp
  · rintro ⟨x, hx1, hx⟩
    refine ⟨x, hx1, ?_⟩
    have : (inner ℂ x ((-R) x) : ℂ).re = -(inner ℂ x (R x) : ℂ).re := by simp
    rw [this, ← hx, neg_neg]
