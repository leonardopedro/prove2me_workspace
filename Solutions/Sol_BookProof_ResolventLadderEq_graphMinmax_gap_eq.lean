-- Generated from ChapterResolventMinMaxEquality.lean — solution of BookProof.ResolventLadderEq.graphMinmax_gap_eq
import Mathlib
import Definitions.Def_ChapterResolventMinMaxEquality
import Theorems.Thm_BookProof_ResolventLadderEq_graphMinmaxLevel_eq
import Theorems.Thm_BookProof_ResolventLadder_graphMinmaxLevel_zero_eq
open BookProof.ResolventLadderEq



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum
open BookProof.ResolventLadder
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
    (hpos : 0 < maxminLevel (res hT) 1) :
    graphMinmaxLevel T 1 - graphMinmaxLevel T 0
      = 1 / maxminLevel (res hT) 1 - 1 / maxminLevel (res hT) 0 := by

  rw [graphMinmaxLevel_eq hT hsv 1 hne hpos, graphMinmaxLevel_zero_eq hT hsv]
  ring
