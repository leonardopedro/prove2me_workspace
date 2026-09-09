-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.rayleighSup_shiftOp
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
import Theorems.Thm_BookProof_RitzPerturbation_rayleighVal_shiftOp
open BookProof.RitzPerturbation









noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (c : ℝ) {S : Submodule ℂ F}
    (hS : 0 < Module.finrank ℂ S) :
    rayleighSup (shiftOp T c) S = rayleighSup T S + c := by

  refine le_antisymm ?_ ?_
  · refine csSup_le (rayleighSetOn_nonempty _ hS) ?_
    rintro t ⟨x, hx, hx1, rfl⟩
    rw [rayleighVal_shiftOp T c hx1]
    have := rayleighVal_le_rayleighSup T hx hx1
    linarith
  · have : rayleighSup T S ≤ rayleighSup (shiftOp T c) S - c := by
      refine csSup_le (rayleighSetOn_nonempty T hS) ?_
      rintro t ⟨x, hx, hx1, rfl⟩
      have h := rayleighVal_le_rayleighSup (shiftOp T c) hx hx1
      rw [rayleighVal_shiftOp T c hx1] at h
      linarith
    linarith
