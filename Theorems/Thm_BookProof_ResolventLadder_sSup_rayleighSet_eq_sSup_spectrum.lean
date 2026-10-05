-- Generated from ChapterResolventMinMaxLadder.lean — theorem BookProof.ResolventLadder.sSup_rayleighSet_eq_sSup_spectrum
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Definitions.Def_ChapterSirkRitzSpectrum
open BookProof.ChapterSirkRitzSpectrum
open BookProof.ResolventLadder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology


theorem BookProof.ResolventLadder.sSup_rayleighSet_eq_sSup_spectrum [Nontrivial F] (R : F →L[ℂ] F)
    (hR : IsSelfAdjoint R) : sSup (rayleighSet R) = sSup (spectrum ℝ R) := by sorry
