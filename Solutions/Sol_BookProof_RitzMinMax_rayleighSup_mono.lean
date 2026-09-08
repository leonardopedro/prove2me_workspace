-- Generated from ChapterSirkRitzMinMax.lean — solution of BookProof.RitzMinMax.rayleighSup_mono
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
import Theorems.Thm_BookProof_RitzMinMax_rayleighSetOn_bddAbove
import Theorems.Thm_BookProof_RitzMinMax_rayleighSetOn_nonempty
open BookProof.RitzMinMax










noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) {S S' : Submodule ℂ F} (h : S ≤ S')
    (hS : 0 < Module.finrank ℂ S) : rayleighSup T S ≤ rayleighSup T S' :=
  csSup_le_csSup (rayleighSetOn_bddAbove T S') (rayleighSetOn_nonempty T hS)
      (by rintro t ⟨x, hx, hx1, rfl⟩; exact ⟨x, h hx, hx1, rfl⟩)
