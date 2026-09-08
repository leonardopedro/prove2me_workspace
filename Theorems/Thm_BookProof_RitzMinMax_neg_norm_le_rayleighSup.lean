-- Generated from ChapterSirkRitzMinMax.lean — theorem BookProof.RitzMinMax.neg_norm_le_rayleighSup
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
open BookProof.RitzMinMax









noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzMinMax.neg_norm_le_rayleighSup (T : F →L[ℂ] F) {S : Submodule ℂ F}
    (hS : 0 < Module.finrank ℂ S) : -‖T‖ ≤ rayleighSup T S := by sorry
