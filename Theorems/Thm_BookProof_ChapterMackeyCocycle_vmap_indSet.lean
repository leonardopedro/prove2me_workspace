-- Generated from ChapterMackeyCocycle.lean — theorem BookProof.ChapterMackeyCocycle.vmap_indSet
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterPvmCyclicUnitary
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterMackeyCocycle


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]


theorem BookProof.ChapterMackeyCocycle.vmap_indSet {μ : Measure X} [IsFiniteMeasure μ]
    {hm : ∀ g : G, Measurable fun x : X => g • x}
    {V : G → (Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)} (hcov : Covariant μ hm V) (g : G)
    {E : Set X} (hE : MeasurableSet E) :
    V g (indSet μ hE)
      = proj μ (measurableSet_smul_image hm hE g)
          (V g (indSet μ (MeasurableSet.univ (α := by sorry
