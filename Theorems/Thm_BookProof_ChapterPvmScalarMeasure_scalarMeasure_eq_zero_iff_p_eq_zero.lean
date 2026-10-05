-- Generated from ChapterPvmScalarMeasure.lean — theorem BookProof.ChapterPvmScalarMeasure.scalarMeasure_eq_zero_iff_p_eq_zero
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


theorem BookProof.ChapterPvmScalarMeasure.scalarMeasure_eq_zero_iff_p_eq_zero {P : Pvm X H} {S : Set H} {n : S → ℕ}
    (hdense : Dense ((Submodule.span ℂ (familyOrbit P S) : Submodule ℂ H) : Set H))
    {E : Set X} (hE : MeasurableSet E) :
    scalarMeasure P S n E = 0 ↔ P.p E = 0 := by sorry
