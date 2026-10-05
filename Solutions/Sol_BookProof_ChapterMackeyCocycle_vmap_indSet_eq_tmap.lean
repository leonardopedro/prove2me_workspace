-- Generated from ChapterMackeyCocycle.lean — solution of BookProof.ChapterMackeyCocycle.vmap_indSet_eq_tmap
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
import Theorems.Thm_BookProof_ChapterMackeyCocycle_vmap_indSet
import Theorems.Thm_BookProof_ChapterMackeyCocycle_mem_smul_image_iff
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

  have h1 := vmap_indSet hcov g hE
  refine Lp.ext ?_
  filter_upwards [tmap_coeFn hqi g hwmeas hdens (indSet μ hE),
    proj_coeFn μ (measurableSet_smul_image hm hE g)
      (V g (indSet μ (MeasurableSet.univ (α := X)))), hw,
    (quasiMeasurePreserving hqi g⁻¹).ae_eq_comp
      (indicatorConstLp_coeFn (μ := μ) (p := 2) (s := E) (hs := hE)
        (hμs := measure_ne_top μ E) (c := (1 : ℂ)))] with x a1 a2 a3 a4
  rw [h1, a2, a1, tfun]
  simp only [Function.comp_apply] at a4
  have ha4 : ((indSet μ hE : Lp ℂ 2 μ) : X → ℂ) (g⁻¹ • x)
      = E.indicator (fun _ => (1 : ℂ)) (g⁻¹ • x) := a4
  rw [ha4]
  by_cases hx : g⁻¹ • x ∈ E
  · have hmem : x ∈ (fun y : X => g • y) '' E := (mem_smul_image_iff g E x).mpr hx
    rw [Set.indicator_of_mem hmem, Set.indicator_of_mem hx, ← a3, mul_one]
  · have hmem : x ∉ (fun y : X => g • y) '' E := fun h => hx ((mem_smul_image_iff g E x).mp h)
    rw [Set.indicator_of_notMem hmem, Set.indicator_of_notMem hx, mul_zero]
