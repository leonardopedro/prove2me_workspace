-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.graphMinmax_gap_lower
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_resolvent_ladder_lower
import Theorems.Thm_BookProof_ResolventLadder_graphMinmaxLevel_zero_eq
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
    (hne : (graphMinmaxSet T 1).Nonempty) :
    1 / maxminLevel (res hT) 1 - 1 / maxminLevel (res hT) 0
      ≤ graphMinmaxLevel T 1 - graphMinmaxLevel T 0 := by

  have h1 := resolvent_ladder_lower hT hsv 1 hne
  have h0 := graphMinmaxLevel_zero_eq hT hsv
  linarith
