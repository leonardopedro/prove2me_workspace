-- Generated from ChapterResolventMinMaxLadder.lean — theorem BookProof.ResolventLadder.maxminLevel_zero_eq_sSup_rayleighSet
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


theorem BookProof.ResolventLadder.maxminLevel_zero_eq_sSup_rayleighSet (R : F →L[ℂ] F) :
    maxminLevel R 0 = sSup (rayleighSet R) := by sorry
