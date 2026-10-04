-- Generated from ChapterPvmScalarMeasure.lean — theorem BookProof.ChapterPvmScalarMeasure.quasiInvariant_of_null_iff
import Mathlib
import Definitions.Def_ChapterPvmScalarMeasure
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterA4
open BookProof.ChapterMackeyQuasiInvariant
open BookProof.ChapterPvmScalarMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {G : Type*} [Group G] [MulAction G X]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicDecomposition
open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterMackeyConverse
open BookProof.ChapterPvmInducedSystem


theorem BookProof.ChapterPvmScalarMeasure.quasiInvariant_of_null_iff [CompleteSpace H] (T : ContinuousImprimitivitySystem G X H)
    {μ : Measure X} (hnull : ∀ E : Set X, MeasurableSet E → (μ E = 0 ↔ T.P.p E = 0)) :
    QuasiInvariant μ G := by sorry
