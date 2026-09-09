-- Generated from ChapterSirkRitzPerturbation.lean — theorem BookProof.RitzPerturbation.rayleighSup_le_rayleighSup_add
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
open BookProof.RitzPerturbation








noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzPerturbation.rayleighSup_le_rayleighSup_add (T T' : F →L[ℂ] F) {S : Submodule ℂ F}
    (hS : 0 < Module.finrank ℂ S) :
    rayleighSup T S ≤ rayleighSup T' S + ‖T - T'‖ := by sorry
