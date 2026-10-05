-- Generated from ChapterPvmScalarMeasure.lean — theorem BookProof.ChapterPvmScalarMeasure.scalarMeasure_univ_le
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


theorem BookProof.ChapterPvmScalarMeasure.scalarMeasure_univ_le (P : Pvm X H) {S : Set H} {n : S → ℕ}
    (hn : Function.Injective n) (hunit : ∀ ψ ∈ S, ‖ψ‖ = 1) :
    scalarMeasure P S n Set.univ ≤ 2 := by sorry
