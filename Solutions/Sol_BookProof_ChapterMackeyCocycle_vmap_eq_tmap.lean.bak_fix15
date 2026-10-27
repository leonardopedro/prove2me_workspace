-- Generated from ChapterMackeyCocycle.lean — solution of BookProof.ChapterMackeyCocycle.vmap_eq_tmap
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
import Theorems.Thm_BookProof_ChapterMackeyCocycle_vmap_indSet_eq_tmap
import Theorems.Thm_BookProof_ChapterMackeyCocycle_indicatorConstLp_eq_smul
open BookProof.ChapterMackeyCocycle



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable {μ : Measure X} [IsFiniteMeasure μ]

set_option maxHeartbeats 1000000 in
theorem solution {hm : ∀ g : G, Measurable fun x : X => g • x}
    {V : G → (Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)} (hcov : Covariant μ hm V)
    (hqi : QuasiInvariant μ G) (g : G) {w : X → ℂ} (hwmeas : Measurable w)
    (hw : w =ᵐ[μ] ((V g (indSet μ (MeasurableSet.univ (α := by

  refine Lp.induction (p := 2) (by simp)
    (fun f => V g f = tmap hqi g hwmeas hdens f) ?_ ?_ ?_ f
  · intro c F hF hμF
    rw [Lp.simpleFunc.coe_indicatorConst, indicatorConstLp_eq_smul hF hμF.ne c,
      map_smul, tmap_smul, vmap_indSet_eq_tmap hcov hqi g hwmeas hw hdens hF]
  · intro f₁ f₂ _ _ _ h₁ h₂
    rw [map_add, tmap_add, h₁, h₂]
  · exact isClosed_eq (V g).continuous (tmapL hqi g hwmeas hdens).continuous
