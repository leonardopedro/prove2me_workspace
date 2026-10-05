-- Generated from ChapterSolovayCoordinates.lean — solution of BookProof.ChapterSolovayCoordinates.tensor_decide_apply
import Mathlib
import Definitions.Def_ChapterSolovayCoordinates



open MeasureTheory ProbabilityTheory
open scoped ENNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {α β : Type*}
    (L₁ : DecidableLanguage α) (L₂ : DecidableLanguage β) (x : α × β) :
    (L₁.tensor L₂).decide x = (L₁.decide x.1 && L₂.decide x.2) := rfl
