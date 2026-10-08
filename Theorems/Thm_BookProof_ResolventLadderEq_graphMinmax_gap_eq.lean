-- Generated from ChapterResolventMinMaxEquality.lean — theorem BookProof.ResolventLadderEq.graphMinmax_gap_eq
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterResolventMinMaxLadder
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventMinMaxEquality
import Definitions.Def_ChapterStoneResolvent
open BookProof.ResolventLadderEq


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.MinMaxSpectrum
open BookProof.ResolventLadder
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {T : Submodule ℂ (F × F)}

theorem BookProof.ResolventLadderEq.graphMinmax_gap_eq [Nontrivial F] (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0)
    (hne : (graphMinmaxSet T 1).Nonempty)
    (hpos : 0 < maxminLevel (res hT) 1) :
    graphMinmaxLevel T 1 - graphMinmaxLevel T 0
      = 1 / maxminLevel (res hT) 1 - 1 / maxminLevel (res hT) 0 := by sorry
