-- Generated from ChapterPvmScalarMeasure.lean — solution of BookProof.ChapterPvmScalarMeasure.pvmMeasure_absolutelyContinuous
import Mathlib
import Definitions.Def_ChapterPvmScalarMeasure
import Definitions.Def_ChapterPvmMeasure
import Definitions.Def_ChapterPvmCyclicDecomposition
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterMackeyConverse
import Definitions.Def_ChapterPvmInducedSystem
open BookProof.ChapterPvmScalarMeasure



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicDecomposition
open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterMackeyConverse
open BookProof.ChapterPvmInducedSystem

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution (P : Pvm X H) {S : Set H} (n : S → ℕ) (ψ : S) :
    pvmMeasure P (ψ : H) ≪ scalarMeasure P S n := by

  refine Measure.AbsolutelyContinuous.mk fun E hE hzero => ?_
  exact (scalarMeasure_eq_zero_iff P S n hE).mp hzero ψ
