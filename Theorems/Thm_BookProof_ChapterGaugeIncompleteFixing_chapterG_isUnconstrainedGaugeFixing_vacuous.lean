-- Generated from ChapterGaugeIncompleteFixing.lean — theorem BookProof.ChapterGaugeIncompleteFixing.chapterG_isUnconstrainedGaugeFixing_vacuous
import Mathlib
import Definitions.Def_ChapterGaugeIncompleteFixing
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterGaugeIncompleteFixing


open scoped InnerProductSpace

variable {X : Type*}
variable (G : Type*) [Group G] [MulAction G X]
variable {G : Type*} [Group G]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.ChapterGaugeIncompleteFixing.chapterG_isUnconstrainedGaugeFixing_vacuous {X Y : Type*} (π : X → Y) :
    ¬ ChapterG.IsUnconstrainedGaugeFixing π := by sorry
