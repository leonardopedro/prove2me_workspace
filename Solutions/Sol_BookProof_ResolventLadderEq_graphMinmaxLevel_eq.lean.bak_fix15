-- Generated from ChapterResolventMinMaxEquality.lean — solution of BookProof.ResolventLadderEq.graphMinmaxLevel_eq
import Mathlib
import Definitions.Def_ChapterResolventMinMaxEquality
import Theorems.Thm_BookProof_ResolventLadderEq_graphMinmaxLevel_le
import Theorems.Thm_BookProof_ResolventLadder_resolvent_ladder_lower
open BookProof.ResolventLadderEq



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.MinMaxSpectrum
open BookProof.ResolventLadder
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (k : ℕ)
    (hne : (graphMinmaxSet T k).Nonempty)
    (hpos : 0 < maxminLevel (res hT) k) :
    graphMinmaxLevel T k = 1 / maxminLevel (res hT) k - 1 := le_antisymm (graphMinmaxLevel_le hT hsv k hne hpos) (resolvent_ladder_lower hT hsv k hne)
