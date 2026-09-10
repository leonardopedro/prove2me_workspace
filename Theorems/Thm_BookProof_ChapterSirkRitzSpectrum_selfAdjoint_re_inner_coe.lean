-- Generated from ChapterSirkRitzSpectrum.lean — theorem BookProof.ChapterSirkRitzSpectrum.selfAdjoint_re_inner_coe
import Mathlib
import Definitions.Def_ChapterSirkRitzSpectrum
open BookProof.ChapterSirkRitzSpectrum







noncomputable section


open Filter Topology RCLike ContinuousLinearMap ComplexOrder Pointwise

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.ChapterSirkRitzSpectrum.selfAdjoint_re_inner_coe (T : F →L[ℂ] F) (hT : IsSelfAdjoint T) (x : F) :
    (((inner ℂ (T x) x : ℂ).re : ℝ) : ℂ) = inner ℂ (T x) x := by sorry
