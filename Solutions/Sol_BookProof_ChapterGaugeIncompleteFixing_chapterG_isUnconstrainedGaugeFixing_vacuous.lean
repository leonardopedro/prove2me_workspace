-- Generated from ChapterGaugeIncompleteFixing.lean — solution of BookProof.ChapterGaugeIncompleteFixing.chapterG_isUnconstrainedGaugeFixing_vacuous
import Mathlib
import Definitions.Def_ChapterGaugeIncompleteFixing
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
import Definitions.Def_ChapterG
open BookProof.ChapterGaugeIncompleteFixing



open scoped InnerProductSpace
open BookProof.ChapterGaugeUnconstrainedSpectrum

variable {X : Type*}
variable (G : Type*) [Group G] [MulAction G X]
variable {G : Type*} [Group G]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in

theorem solution {X Y : Type*} (π : X → Y) :
    ¬ ChapterG.IsUnconstrainedGaugeFixing π := by
  rintro ⟨g, hg, f, hf⟩
  exact hf (funext fun x => f.property g hg x)
