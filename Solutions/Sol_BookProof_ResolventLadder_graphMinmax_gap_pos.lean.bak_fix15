-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.graphMinmax_gap_pos
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_graphMinmax_gap_lower
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
theorem solution [Nontrivial F] (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0)
    (hne : (graphMinmaxSet T 1).Nonempty)
    (hgap : maxminLevel (res hT) 1 < maxminLevel (res hT) 0)
    (hpos : 0 < maxminLevel (res hT) 1) :
    0 < graphMinmaxLevel T 1 - graphMinmaxLevel T 0 := by

  have hlow := graphMinmax_gap_lower hT hsv hne
  have hstrict : 1 / maxminLevel (res hT) 0 < 1 / maxminLevel (res hT) 1 :=
    one_div_lt_one_div_of_lt hpos hgap
  linarith
