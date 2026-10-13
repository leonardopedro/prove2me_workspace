-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.maxminLevel_zero_eq_sSup_rayleighSet
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_maxminSet_zero_eq_rayleighSet
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterSirkRitzSpectrum
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology
open BookProof.ChapterSirkRitzSpectrum

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (R : F →L[ℂ] F) :
    maxminLevel R 0 = sSup (rayleighSet R) := by

  rw [maxminLevel, maxminSet_zero_eq_rayleighSet]
