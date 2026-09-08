-- Generated from ChapterSirkRitzMinMax.lean — theorem BookProof.RitzMinMax.rayleighSup_mono
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
open BookProof.RitzMinMax









noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzMinMax.rayleighSup_mono (T : F →L[ℂ] F) {S S' : Submodule ℂ F} (h : S ≤ S')
    (hS : 0 < Module.finrank ℂ S) : rayleighSup T S ≤ rayleighSup T S' := by sorry
