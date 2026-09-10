-- Generated from ChapterSirkRitzSpectrum.lean — theorem BookProof.ChapterSirkRitzSpectrum.sInf_spectrum_eq_rayleighInf
import Mathlib
import Definitions.Def_ChapterSirkRitzSpectrum
open BookProof.ChapterSirkRitzSpectrum







noncomputable section


open Filter Topology RCLike ContinuousLinearMap ComplexOrder Pointwise

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.ChapterSirkRitzSpectrum.sInf_spectrum_eq_rayleighInf [Nontrivial F] (T : F →L[ℂ] F) (hT : IsSelfAdjoint T) :
    sInf (spectrum ℝ T) = rayleighInf T := by sorry
