-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.graph_unique
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
theorem solution (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {y z z' : F}
    (h : (y, z) ∈ T) (h' : (y, z') ∈ T) : z = z' := by

  have hsub : ((0 : F), z - z') ∈ T := by
    have := T.sub_mem h h'
    simpa using this
  exact sub_eq_zero.mp (hsv _ hsub)
