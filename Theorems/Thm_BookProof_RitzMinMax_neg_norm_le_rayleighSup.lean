-- Generated from ChapterSirkRitzMinMax.lean — theorem BookProof.RitzMinMax.neg_norm_le_rayleighSup
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterSirkRitzSpectrum
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
open BookProof.RitzMinMax

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology


theorem BookProof.RitzMinMax.neg_norm_le_rayleighSup (T : F →L[ℂ] F) {S : Submodule ℂ F}
    (hS : 0 < Module.finrank ℂ S) : -‖T‖ ≤ rayleighSup T S := by sorry
