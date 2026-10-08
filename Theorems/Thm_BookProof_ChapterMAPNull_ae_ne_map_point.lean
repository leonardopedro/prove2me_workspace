-- Generated from ChapterMAPNull.lean — theorem BookProof.ChapterMAPNull.ae_ne_map_point
import Mathlib
import Definitions.Def_ChapterMAPNull
open BookProof.ChapterMAPNull


open MeasureTheory


variable {α : Type*} [MeasurableSpace α]


theorem BookProof.ChapterMAPNull.ae_ne_map_point (μ : Measure α) [NullSingletonClass μ] (mapPoint : α) :
    ∀ᵐ x ∂μ, x ≠ mapPoint := by sorry
