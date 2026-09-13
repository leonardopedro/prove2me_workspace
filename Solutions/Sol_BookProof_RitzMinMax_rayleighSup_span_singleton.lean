-- Generated from ChapterSirkRitzMinMax.lean — solution of BookProof.RitzMinMax.rayleighSup_span_singleton
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
import Theorems.Thm_BookProof_RitzMinMax_rayleighSetOn_span_singleton
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzMinMax










noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) {x : F} (hx1 : ‖x‖ = 1) :
    rayleighSup T (Submodule.span ℂ {x}) = rayleighVal T x := by

  rw [rayleighSup, rayleighSetOn_span_singleton T hx1, csSup_singleton]
