-- Generated from ChapterResolventMinMaxLadder.lean — theorem BookProof.ResolventLadder.graphMinmaxLevel_zero_eq_sSup_spectrum
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterStoneResolvent
open BookProof.ChapterSirkRitzSpectrum
open BookProof.ResolventLadder


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {T : Submodule ℂ (F × F)}

theorem BookProof.ResolventLadder.graphMinmaxLevel_zero_eq_sSup_spectrum [Nontrivial F] (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) :
    graphMinmaxLevel T 0 = 1 / sSup (spectrum ℝ (res hT)) - 1 := by sorry
