-- Generated from ChapterSirkRitzMinMax.lean — solution of BookProof.RitzMinMax.abs_rayleighVal_le
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
import Theorems.Thm_BookProof_ChapterSirkRitzSpectrum_abs_re_inner_le
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzMinMax










noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (x : F) : |rayleighVal T x| ≤ ‖T‖ * ‖x‖ ^ 2 := abs_re_inner_le T x
