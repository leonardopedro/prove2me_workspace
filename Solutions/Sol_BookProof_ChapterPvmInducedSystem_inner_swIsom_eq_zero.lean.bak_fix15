-- Generated from ChapterPvmInducedSystem.lean — solution of BookProof.ChapterPvmInducedSystem.inner_swIsom_eq_zero
import Mathlib
import Definitions.Def_ChapterPvmInducedSystem
import Theorems.Thm_BookProof_ChapterPvmInducedSystem_swIsom_mem_cyclicSubspace
import Theorems.Thm_BookProof_ChapterPvmInducedSystem_cyclicSubspace_le_orthogonal
open BookProof.ChapterPvmInducedSystem



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicUnitary
open BookProof.ChapterPvmCyclicDecomposition BookProof.ChapterMackeyQuasiInvariant
open BookProof.ChapterHilbertSumIntertwine

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution {P : Pvm X H} {ψ φ : H} (h : OrthOrbit P ψ φ)
    (u : Lp ℂ 2 (pvmMeasure P ψ)) (v : Lp ℂ 2 (pvmMeasure P φ)) :
    ⟪swIsom P ψ u, swIsom P φ v⟫_ℂ = 0 := by

  have hu : swIsom P ψ u ∈ (cyclicSubspace P φ)ᗮ :=
    cyclicSubspace_le_orthogonal h (swIsom_mem_cyclicSubspace P ψ u)
  exact (Submodule.mem_orthogonal' _ _).mp hu _ (swIsom_mem_cyclicSubspace P φ v)
