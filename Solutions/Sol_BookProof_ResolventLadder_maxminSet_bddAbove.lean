-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.maxminSet_bddAbove
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_rayleighInfOn_le_norm
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
theorem solution (R : F →L[ℂ] F) (k : ℕ) : BddAbove (maxminSet R k) := by

  refine ⟨‖R‖, ?_⟩
  rintro t ⟨S, hrank, rfl⟩
  exact rayleighInfOn_le_norm R (by rw [hrank]; omega)
