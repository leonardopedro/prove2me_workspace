-- Generated from ChapterF7.lean — theorem BookProof.ChapterF7.smul_l2Symmetric
import Mathlib
import Definitions.Def_ChapterF7
open BookProof.ChapterF7


open SchwartzMap MeasureTheory Complex
open scoped BigOperators


noncomputable section

theorem BookProof.ChapterF7.smul_l2Symmetric {c : ℂ} (hc : (starRingEnd ℂ) c = c)
    {T : 𝓢(ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ)} (hT : IsL2Symmetric T) :
    IsL2Symmetric (c • T) := by sorry
