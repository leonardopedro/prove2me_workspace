-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.rayleighInfOn_le_norm
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_rayleighSetOn_bddBelow
import Theorems.Thm_BookProof_RitzMinMax_exists_unit_mem
import Theorems.Thm_BookProof_RitzMinMax_rayleighVal_le_norm_of_unit
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
theorem solution (R : F →L[ℂ] F) {S : Submodule ℂ F}
    (hS : 0 < Module.finrank ℂ S) : rayleighInfOn R S ≤ ‖R‖ := by

  obtain ⟨x, hx, hx1⟩ := exists_unit_mem S hS
  refine csInf_le_of_le (rayleighSetOn_bddBelow R S) (b := rayleighVal R x) ⟨x, hx, hx1, rfl⟩ ?_
  exact rayleighVal_le_norm_of_unit R hx1
