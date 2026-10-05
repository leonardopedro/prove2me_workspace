-- Generated from ChapterPvmFibreInducedSystem.lean — theorem BookProof.ChapterPvmFibreInducedSystem.lpCongr_symm_proj
import Definitions.Def_ChapterPvmMeasure
import Definitions.Def_ChapterPvmCyclicUnitary
import Definitions.Def_ChapterPvmCyclicDecomposition
import Definitions.Def_ChapterPvmInducedSystem
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterL2FibreSum
import Definitions.Def_ChapterHilbertSumIntertwine
import Mathlib
import Definitions.Def_ChapterPvmFibreInducedSystem
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterPvmFibreInducedSystem

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicUnitary
open BookProof.ChapterPvmCyclicDecomposition BookProof.ChapterPvmInducedSystem
open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterL2FibreSum
open BookProof.ChapterHilbertSumIntertwine


theorem BookProof.ChapterPvmFibreInducedSystem.lpCongr_symm_proj {μ ν : Measure X} (h : μ = ν) {E : Set X} (hE : MeasurableSet E)
    (f : Lp ℂ 2 ν) :
    (lpCongr h).symm (proj ν hE f) = proj μ hE ((lpCongr h).symm f) := by sorry
