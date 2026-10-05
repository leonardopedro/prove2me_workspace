-- Generated from ChapterPvmScalarMeasure.lean — theorem BookProof.ChapterPvmScalarMeasure.exists_scalarMeasure
import Definitions.Def_ChapterPvmMeasure
import Definitions.Def_ChapterPvmCyclicDecomposition
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterMackeyConverse
import Definitions.Def_ChapterPvmInducedSystem
import Mathlib
import Definitions.Def_ChapterPvmScalarMeasure
open BookProof.ChapterPvmScalarMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicDecomposition
open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterMackeyConverse
open BookProof.ChapterPvmInducedSystem


theorem BookProof.ChapterPvmScalarMeasure.exists_scalarMeasure [CompleteSpace H] [TopologicalSpace.SeparableSpace H]
    (P : Pvm X H) :
    ∃ μ : Measure X, IsFiniteMeasure μ ∧
      ∀ E : Set X, MeasurableSet E → (μ E = 0 ↔ P.p E = 0) := by sorry
