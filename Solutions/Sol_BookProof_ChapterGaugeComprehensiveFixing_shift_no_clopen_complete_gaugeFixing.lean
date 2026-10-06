-- Generated from ChapterGaugeComprehensiveFixing.lean — solution of BookProof.ChapterGaugeComprehensiveFixing.shift_no_clopen_complete_gaugeFixing
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
import Theorems.Thm_BookProof_ChapterGaugeComprehensiveFixing_not_isClopen_of_complete_comprehensive
import Theorems.Thm_BookProof_ChapterGaugeComprehensiveFixing_shift_movesEveryPointOfSpectrum
open BookProof.ChapterGaugeComprehensiveFixing




open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}
variable {X : Type*} [TopologicalSpace X] {G : Type*} [Group G] [MulAction G X]
variable (X : Type*) (G : Type*) [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution {S : Set ℝ}
    (hcomp : IsComprehensiveGaugeFixing (Multiplicative ℤ) S)
    (hcompl : IsCompleteGaugeFixing' (Multiplicative ℤ) S) :
    ¬ IsClopen S := not_isClopen_of_complete_comprehensive hcomp hcompl shift_movesEveryPointOfSpectrum
