-- Generated from ChapterPvmScalarMeasure.lean — theorem BookProof.ChapterPvmScalarMeasure.scalarMeasure_apply
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


theorem BookProof.ChapterPvmScalarMeasure.scalarMeasure_apply (P : Pvm X H) (S : Set H) (n : S → ℕ) {E : Set X}
    (hE : MeasurableSet E) :
    scalarMeasure P S n E = ∑' ψ : S, (2 : ENNReal)⁻¹ ^ n ψ * pvmMeasure P (ψ : H) E := by sorry
