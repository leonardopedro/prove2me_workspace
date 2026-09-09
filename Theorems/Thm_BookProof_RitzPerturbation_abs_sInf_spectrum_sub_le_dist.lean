-- Generated from ChapterSirkRitzPerturbation.lean — theorem BookProof.RitzPerturbation.abs_sInf_spectrum_sub_le_dist
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
open BookProof.RitzPerturbation








noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzPerturbation.abs_sInf_spectrum_sub_le_dist [Nontrivial F] (T T' : F →L[ℂ] F)
    (hT : IsSelfAdjoint T) (hT' : IsSelfAdjoint T')
    (hne : (minmaxSet T 0).Nonempty) :
    |sInf (spectrum ℝ T) - sInf (spectrum ℝ T')| ≤ ‖T - T'‖ := by sorry
