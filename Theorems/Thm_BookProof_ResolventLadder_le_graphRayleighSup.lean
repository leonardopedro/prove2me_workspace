-- Generated from ChapterResolventMinMaxLadder.lean — theorem BookProof.ResolventLadder.le_graphRayleighSup
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterStoneResolvent
open BookProof.RitzMinMax
open BookProof.ResolventLadder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology


theorem BookProof.ResolventLadder.le_graphRayleighSup (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {S : Submodule ℂ F} {k : ℕ}
    (hrank : Module.finrank ℂ S = k + 1) (hdom : InDomain T S) :
    1 / maxminLevel (res hT) k - 1 ≤ graphRayleighSup T S := by sorry
