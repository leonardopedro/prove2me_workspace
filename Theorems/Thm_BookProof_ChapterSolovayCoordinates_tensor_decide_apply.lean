-- Generated from ChapterSolovayCoordinates.lean — theorem BookProof.ChapterSolovayCoordinates.tensor_decide_apply
import Mathlib
import Definitions.Def_ChapterSolovayCoordinates
import Definitions.Def_ChapterA4


open MeasureTheory ProbabilityTheory
open scoped ENNReal

noncomputable section

theorem BookProof.ChapterSolovayCoordinates.tensor_decide_apply {α β : Type*}
    (L₁ : DecidableLanguage α) (L₂ : DecidableLanguage β) (x : α × β) :
    (L₁.tensor L₂).decide x = (L₁.decide x.1 && L₂.decide x.2) := by sorry
