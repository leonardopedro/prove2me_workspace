-- Generated from ChapterSirkRitzPerturbation.lean — theorem BookProof.RitzPerturbation.minmaxLevel_shiftOp
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
open BookProof.RitzPerturbation








noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzPerturbation.minmaxLevel_shiftOp (T : F →L[ℂ] F) (c : ℝ) (k : ℕ)
    (hne : (minmaxSet T k).Nonempty) :
    minmaxLevel (shiftOp T c) k = minmaxLevel T k + c := by sorry
