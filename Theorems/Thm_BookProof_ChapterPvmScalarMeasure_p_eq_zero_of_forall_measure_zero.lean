-- Generated from ChapterPvmScalarMeasure.lean — theorem BookProof.ChapterPvmScalarMeasure.p_eq_zero_of_forall_measure_zero
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


theorem BookProof.ChapterPvmScalarMeasure.p_eq_zero_of_forall_measure_zero {P : Pvm X H} {S : Set H}
    (hdense : Dense ((Submodule.span ℂ (familyOrbit P S) : Submodule ℂ H) : Set H))
    {E : Set X} (hE : MeasurableSet E) (h : ∀ ψ ∈ S, pvmMeasure P ψ E = 0) :
    P.p E = 0 := by sorry
