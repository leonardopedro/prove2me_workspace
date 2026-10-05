-- Generated from ChapterPvmInducedSystem.lean — theorem BookProof.ChapterPvmInducedSystem.inner_swIsom_eq_zero
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


theorem BookProof.ChapterPvmInducedSystem.inner_swIsom_eq_zero {P : Pvm X H} {ψ φ : H} (h : OrthOrbit P ψ φ)
    (u : Lp ℂ 2 (pvmMeasure P ψ)) (v : Lp ℂ 2 (pvmMeasure P φ)) :
    ⟪swIsom P ψ u, swIsom P φ v⟫_ℂ = 0 := by sorry
