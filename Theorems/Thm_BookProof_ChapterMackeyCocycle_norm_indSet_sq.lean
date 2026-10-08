-- Generated from ChapterMackeyCocycle.lean — theorem BookProof.ChapterMackeyCocycle.norm_indSet_sq
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterPvmCyclicUnitary
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
open BookProof.ChapterMackeyCocycle


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]


theorem BookProof.ChapterMackeyCocycle.norm_indSet_sq (μ : Measure X) [IsFiniteMeasure μ] {E : Set X} (hE : MeasurableSet E) :
    ‖indSet μ hE‖ ^ 2 = (μ E).toReal := by sorry
