-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.rayleighSetOn_neg
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_rayleighVal_neg
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
theorem solution (R : F →L[ℂ] F) (S : Submodule ℂ F) :
    rayleighSetOn (-R) S = -rayleighSetOn R S := by

  ext t
  rw [Set.mem_neg]
  constructor
  · rintro ⟨x, hx, hx1, rfl⟩
    exact ⟨x, hx, hx1, by rw [rayleighVal_neg, neg_neg]⟩
  · rintro ⟨x, hx, hx1, hval⟩
    exact ⟨x, hx, hx1, by rw [rayleighVal_neg, ← hval, neg_neg]⟩
