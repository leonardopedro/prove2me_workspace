-- Generated from ChapterPvmInducedSystem.lean — theorem BookProof.ChapterPvmInducedSystem.orthogonalFamily_swIsom
import Definitions.Def_ChapterPvmMeasure
import Definitions.Def_ChapterPvmCyclicUnitary
import Definitions.Def_ChapterPvmCyclicDecomposition
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterHilbertSumIntertwine
import Mathlib
import Definitions.Def_ChapterPvmInducedSystem
open BookProof.ChapterPvmInducedSystem

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable [CompleteSpace H]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicUnitary
open BookProof.ChapterPvmCyclicDecomposition BookProof.ChapterMackeyQuasiInvariant
open BookProof.ChapterHilbertSumIntertwine


theorem BookProof.ChapterPvmInducedSystem.orthogonalFamily_swIsom {P : Pvm X H} {S : Set H} (hS : OrthCyclicFamily P S) :
    OrthogonalFamily ℂ (fun ψ : S => Lp ℂ 2 (pvmMeasure P (ψ : H)))
      (fun ψ : S => swIsom P (ψ : H)) := by sorry
