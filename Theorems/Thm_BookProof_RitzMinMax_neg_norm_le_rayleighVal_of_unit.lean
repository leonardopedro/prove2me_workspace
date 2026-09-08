-- Generated from ChapterSirkRitzMinMax.lean — theorem BookProof.RitzMinMax.neg_norm_le_rayleighVal_of_unit
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
open BookProof.RitzMinMax









noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzMinMax.neg_norm_le_rayleighVal_of_unit (T : F →L[ℂ] F) {x : F} (hx1 : ‖x‖ = 1) :
    -‖T‖ ≤ rayleighVal T x := by sorry
