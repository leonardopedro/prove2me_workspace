-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.res_eq_of_mem
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_eq_of_mem
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
theorem solution (hT : IsNonnegSelfAdjoint T) {y z : F} (hyz : (y, z) ∈ T) :
    res hT (y + z) = y := by

  refine invCLMAt_eq_of_mem hT (a := 1) one_pos ?_
  simpa using hyz
