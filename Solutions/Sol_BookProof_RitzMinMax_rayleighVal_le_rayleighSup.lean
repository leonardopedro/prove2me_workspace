-- Generated from ChapterSirkRitzMinMax.lean — solution of BookProof.RitzMinMax.rayleighVal_le_rayleighSup
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
import Theorems.Thm_BookProof_RitzMinMax_rayleighSetOn_bddAbove
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzMinMax










noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) {S : Submodule ℂ F} {x : F}
    (hx : x ∈ S) (hx1 : ‖x‖ = 1) : rayleighVal T x ≤ rayleighSup T S := le_csSup (rayleighSetOn_bddAbove T S) ⟨x, hx, hx1, rfl⟩
