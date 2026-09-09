-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.abs_rayleighSup_sub_le_dist
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
import Theorems.Thm_BookProof_RitzPerturbation_rayleighSup_le_rayleighSup_add
open BookProof.RitzPerturbation









noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T T' : F →L[ℂ] F) {S : Submodule ℂ F}
    (hS : 0 < Module.finrank ℂ S) :
    |rayleighSup T S - rayleighSup T' S| ≤ ‖T - T'‖ := by

  refine abs_sub_le_iff.mpr ⟨by linarith [rayleighSup_le_rayleighSup_add T T' hS], ?_⟩
  have h := rayleighSup_le_rayleighSup_add T' T hS
  rw [← neg_sub T T', norm_neg] at h
  linarith
