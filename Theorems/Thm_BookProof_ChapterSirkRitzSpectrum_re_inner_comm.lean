-- Generated from ChapterSirkRitzSpectrum.lean — theorem BookProof.ChapterSirkRitzSpectrum.re_inner_comm
import Mathlib
import Definitions.Def_ChapterSirkRitzSpectrum
open BookProof.ChapterSirkRitzSpectrum







noncomputable section


open Filter Topology RCLike ContinuousLinearMap ComplexOrder Pointwise

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.ChapterSirkRitzSpectrum.re_inner_comm (T : F →L[ℂ] F) (x : F) :
    (inner ℂ (T x) x : ℂ).re = (inner ℂ x (T x) : ℂ).re := by sorry
