-- Generated from ChapterGaugeIncompleteFixing.lean — solution of BookProof.ChapterGaugeIncompleteFixing.chapterG_isUnconstrainedGaugeFixing_vacuous
import Mathlib
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing



open scoped InnerProductSpace

variable {X : Type*}
variable (G : Type*) [Group G] [MulAction G X]
variable {G : Type*} [Group G]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution {X Y : Type*} (π : X → Y) :
    ¬ ChapterG.IsUnconstrainedGaugeFixing π := by

  rintro ⟨g, hg, f, hf⟩
  exact hf (funext fun x => f.property g hg x)
