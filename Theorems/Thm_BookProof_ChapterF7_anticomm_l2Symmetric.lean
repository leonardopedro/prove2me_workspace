-- Generated from ChapterF7.lean — theorem BookProof.ChapterF7.anticomm_l2Symmetric
import Mathlib
import Definitions.Def_ChapterF7
open BookProof.ChapterF7


open SchwartzMap MeasureTheory Complex
open scoped BigOperators


noncomputable section

theorem BookProof.ChapterF7.anticomm_l2Symmetric {K V : 𝓢(ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ)}
    (hK : IsL2Symmetric K) (hV : IsL2Symmetric V) :
    IsL2Symmetric (K.comp V + V.comp K) := by sorry
