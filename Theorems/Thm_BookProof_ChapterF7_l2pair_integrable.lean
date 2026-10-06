-- Generated from ChapterF7.lean — theorem BookProof.ChapterF7.l2pair_integrable
import Mathlib
import Definitions.Def_ChapterF7
open BookProof.ChapterF7


open SchwartzMap MeasureTheory Complex
open scoped BigOperators


noncomputable section

theorem BookProof.ChapterF7.l2pair_integrable (f g : 𝓢(ℝ, ℂ)) :
    Integrable (fun x => (starRingEnd ℂ) (f x) * g x) volume := by sorry
