-- Generated from ChapterMackeyCocycle.lean — solution of BookProof.ChapterMackeyCocycle.vmap_indSet
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
import Theorems.Thm_BookProof_ChapterMackeyCocycle_proj_indSet_univ
open BookProof.ChapterMackeyCocycle



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution {μ : Measure X} [IsFiniteMeasure μ]
    {hm : ∀ g : G, Measurable fun x : X => g • x}
    {V : G → (Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)} (hcov : Covariant μ hm V) (g : G)
    {E : Set X} (hE : MeasurableSet E) :
    V g (indSet μ hE)
      = proj μ (measurableSet_smul_image hm hE g)
          (V g (indSet μ (MeasurableSet.univ (α := by

  rw [← proj_indSet_univ μ hE, hcov g E hE]
