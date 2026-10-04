-- Generated from ChapterMackeyCocycle.lean — theorem BookProof.ChapterMackeyCocycle.norm_indSet_sq
import Definitions.Def_ChapterMackeyQuasiInvariant
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
import Definitions.Def_ChapterA4
open BookProof.ChapterMackeyCocycle

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary


theorem BookProof.ChapterMackeyCocycle.norm_indSet_sq (μ : Measure X) [IsFiniteMeasure μ] {E : Set X} (hE : MeasurableSet E) :
    ‖indSet μ hE‖ ^ 2 = (μ E).toReal := by sorry
