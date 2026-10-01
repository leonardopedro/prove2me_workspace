-- Generated from ChapterSirkRitzPerturbation.lean — theorem BookProof.RitzPerturbation.rayleighVal_shiftOp
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterSirkRitzMinMax
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.RitzMinMax
open BookProof.RitzPerturbation

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology


theorem BookProof.RitzPerturbation.rayleighVal_shiftOp (T : F →L[ℂ] F) (c : ℝ) {x : F} (hx1 : ‖x‖ = 1) :
    rayleighVal (shiftOp T c) x = rayleighVal T x + c := by sorry
