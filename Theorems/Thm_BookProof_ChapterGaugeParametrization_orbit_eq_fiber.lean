-- Generated from ChapterGaugeParametrization.lean — theorem BookProof.ChapterGaugeParametrization.orbit_eq_fiber
import Definitions.Def_ChapterGaugeIncompleteFixing
import Mathlib
import Definitions.Def_ChapterGaugeParametrization
open BookProof.ChapterGaugeParametrization



open BookProof.ChapterGaugeIncompleteFixing

variable {X Y : Type*}


theorem BookProof.ChapterGaugeParametrization.orbit_eq_fiber (π : X → Y) (x : X) :
    MulAction.orbit (fiberGauge π) x = π ⁻¹' {π x} := by sorry
