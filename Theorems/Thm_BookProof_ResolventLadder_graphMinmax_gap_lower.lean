-- Generated from ChapterResolventMinMaxLadder.lean — theorem BookProof.ResolventLadder.graphMinmax_gap_lower
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Definitions.Def_ChapterStoneResolvent
open BookProof.ResolventLadder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology


theorem BookProof.ResolventLadder.graphMinmax_gap_lower [Nontrivial F] (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0)
    (hne : (graphMinmaxSet T 1).Nonempty) :
    1 / maxminLevel (res hT) 1 - 1 / maxminLevel (res hT) 0
      ≤ graphMinmaxLevel T 1 - graphMinmaxLevel T 0 := by sorry
