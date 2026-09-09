-- Generated from ChapterSirkRitzPerturbation.lean — theorem BookProof.RitzPerturbation.rayleighVal_shiftOp
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
open BookProof.RitzPerturbation








noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzPerturbation.rayleighVal_shiftOp (T : F →L[ℂ] F) (c : ℝ) {x : F} (hx1 : ‖x‖ = 1) :
    rayleighVal (shiftOp T c) x = rayleighVal T x + c := by sorry
