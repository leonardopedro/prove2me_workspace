-- Generated from ChapterGaugeParametrization.lean — solution of BookProof.ChapterGaugeParametrization.fiberGauge_ne_bot_iff
import Mathlib
import Definitions.Def_ChapterGaugeParametrization
import Theorems.Thm_BookProof_ChapterGaugeParametrization_fiberGauge_eq_bot_iff
open BookProof.ChapterGaugeParametrization




open BookProof.ChapterGaugeIncompleteFixing

variable {X Y : Type*}

variable {X Y : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (π : X → Y) :
    fiberGauge π ≠ ⊥ ↔ ¬ Function.Injective π := by

  rw [Ne, fiberGauge_eq_bot_iff]
