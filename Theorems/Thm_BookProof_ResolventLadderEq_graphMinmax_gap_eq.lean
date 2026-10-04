-- Generated from ChapterResolventMinMaxEquality.lean — theorem BookProof.ResolventLadderEq.graphMinmax_gap_eq
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventMinMaxEquality
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterA4
open BookProof.ResolventLadderEq

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}


noncomputable section


open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology


theorem BookProof.ResolventLadderEq.graphMinmax_gap_eq [Nontrivial F] (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0)
    (hne : (graphMinmaxSet T 1).Nonempty)
    (hpos : 0 < maxminLevel (res hT) 1) :
    graphMinmaxLevel T 1 - graphMinmaxLevel T 0
      = 1 / maxminLevel (res hT) 1 - 1 / maxminLevel (res hT) 0 := by sorry
