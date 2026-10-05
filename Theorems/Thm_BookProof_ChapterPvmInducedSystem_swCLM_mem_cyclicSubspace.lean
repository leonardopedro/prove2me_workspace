-- Generated from ChapterPvmInducedSystem.lean — theorem BookProof.ChapterPvmInducedSystem.swCLM_mem_cyclicSubspace
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


theorem BookProof.ChapterPvmInducedSystem.swCLM_mem_cyclicSubspace (P : Pvm X H) (ψ : H) (f : Lp ℂ 2 (pvmMeasure P ψ)) :
    swCLM P ψ f ∈ cyclicSubspace P ψ := by sorry
