-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.one_le_add_mul_rayleigh_of_unit
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_normSq_sq_le_rayleigh_graph
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
theorem solution (hT : IsNonnegSelfAdjoint T) {y z : F}
    (hyz : (y, z) ∈ T) (hy : ‖y‖ = 1) :
    1 ≤ (1 + (inner ℂ y z : ℂ).re) * rayleighVal (res hT) y := by

  have h := normSq_sq_le_rayleigh_graph hT hyz
  rw [hy] at h
  simpa using h
