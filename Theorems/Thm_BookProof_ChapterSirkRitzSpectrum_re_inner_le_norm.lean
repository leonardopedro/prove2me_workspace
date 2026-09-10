-- Generated from ChapterSirkRitzSpectrum.lean — theorem BookProof.ChapterSirkRitzSpectrum.re_inner_le_norm
import Mathlib
import Definitions.Def_ChapterSirkRitzSpectrum
open BookProof.ChapterSirkRitzSpectrum







noncomputable section


open Filter Topology RCLike ContinuousLinearMap ComplexOrder Pointwise

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.ChapterSirkRitzSpectrum.re_inner_le_norm (T : F →L[ℂ] F) (x : F) :
    (inner ℂ x (T x) : ℂ).re ≤ ‖T‖ * ‖x‖ ^ 2 := by sorry
