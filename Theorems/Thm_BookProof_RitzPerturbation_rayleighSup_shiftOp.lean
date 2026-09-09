-- Generated from ChapterSirkRitzPerturbation.lean — theorem BookProof.RitzPerturbation.rayleighSup_shiftOp
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
open BookProof.RitzPerturbation








noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzPerturbation.rayleighSup_shiftOp (T : F →L[ℂ] F) (c : ℝ) {S : Submodule ℂ F}
    (hS : 0 < Module.finrank ℂ S) :
    rayleighSup (shiftOp T c) S = rayleighSup T S + c := by sorry
