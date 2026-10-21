-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.graphMinmaxLevel_zero_eq_sSup_spectrum
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_res_isSelfAdjoint
import Theorems.Thm_BookProof_ResolventLadder_maxminLevel_zero_eq_sSup_rayleighSet
import Theorems.Thm_BookProof_ResolventLadder_sSup_rayleighSet_eq_sSup_spectrum
import Theorems.Thm_BookProof_ResolventLadder_graphMinmaxLevel_zero_eq
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterStoneResolvent
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology
open BookProof.ChapterSirkRitzSpectrum

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial F] (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) :
    graphMinmaxLevel T 0 = 1 / sSup (spectrum ℝ (res hT)) - 1 := by

  rw [graphMinmaxLevel_zero_eq hT hsv, maxminLevel_zero_eq_sSup_rayleighSet,
    sSup_rayleighSet_eq_sSup_spectrum (res hT) (res_isSelfAdjoint hT)]
