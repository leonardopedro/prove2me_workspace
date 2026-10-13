-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.rayleighInfOn_span_singleton
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_RitzMinMax_rayleighSetOn_span_singleton
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterSirkRitzMinMax
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology
open BookProof.RitzMinMax

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (R : F →L[ℂ] F) {x : F} (hx1 : ‖x‖ = 1) :
    rayleighInfOn R (Submodule.span ℂ {x}) = rayleighVal R x := by

  rw [rayleighInfOn, rayleighSetOn_span_singleton R hx1, csInf_singleton]
