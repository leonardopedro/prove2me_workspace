-- Generated from ChapterGaugeParametrization.lean — solution of BookProof.ChapterGaugeParametrization.apply_eq
import Mathlib
import Definitions.Def_ChapterGaugeParametrization
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeParametrization




open BookProof.ChapterGaugeIncompleteFixing

variable {X Y : Type*}

variable {X Y : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (π : X → Y) (σ : fiberGauge π) (x : X) : π (σ • x) = π x := σ.property x
