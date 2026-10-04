-- Generated from ChapterPvmInducedSystem.lean — theorem BookProof.ChapterPvmInducedSystem.inner_swIsom_eq_zero
import Definitions.Def_ChapterMackeyQuasiInvariant
import Mathlib
import Definitions.Def_ChapterPvmInducedSystem
import Definitions.Def_ChapterA4
open BookProof.ChapterPvmInducedSystem

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable [CompleteSpace H]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicUnitary
open BookProof.ChapterPvmCyclicDecomposition BookProof.ChapterMackeyQuasiInvariant


theorem BookProof.ChapterPvmInducedSystem.inner_swIsom_eq_zero {P : Pvm X H} {ψ φ : H} (h : OrthOrbit P ψ φ)
    (u : Lp ℂ 2 (pvmMeasure P ψ)) (v : Lp ℂ 2 (pvmMeasure P φ)) :
    ⟪swIsom P ψ u, swIsom P φ v⟫_ℂ = 0 := by sorry
