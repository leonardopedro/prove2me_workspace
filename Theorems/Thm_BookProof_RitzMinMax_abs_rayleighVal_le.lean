-- Generated from ChapterSirkRitzMinMax.lean — theorem BookProof.RitzMinMax.abs_rayleighVal_le
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterSirkRitzSpectrum
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
open BookProof.RitzMinMax

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology


theorem BookProof.RitzMinMax.abs_rayleighVal_le (T : F →L[ℂ] F) (x : F) : |rayleighVal T x| ≤ ‖T‖ * ‖x‖ ^ 2 := by sorry
