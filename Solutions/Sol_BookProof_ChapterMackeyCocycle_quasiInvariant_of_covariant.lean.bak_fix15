-- Generated from ChapterMackeyCocycle.lean — solution of BookProof.ChapterMackeyCocycle.quasiInvariant_of_covariant
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
import Theorems.Thm_BookProof_ChapterMackeyCocycle_norm_indSet_sq
import Theorems.Thm_BookProof_ChapterMackeyCocycle_proj_eq_zero_of_measure_zero
import Theorems.Thm_BookProof_ChapterMackeyCocycle_vmap_indSet
open BookProof.ChapterMackeyCocycle



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution {μ : Measure X} [IsFiniteMeasure μ]
    {hm : ∀ g : G, Measurable fun x : X => g • x}
    {V : G → (Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)} (hcov : Covariant μ hm V) :
    QuasiInvariant μ G := by

  refine ⟨hm, fun g => Measure.AbsolutelyContinuous.mk fun E hE h0 => ?_⟩
  have hFmeas : MeasurableSet ((fun x : X => g • x) ⁻¹' E) := (hm g) hE
  have hsub : (fun x : X => g • x) '' ((fun x : X => g • x) ⁻¹' E) ⊆ E := by
    rintro _ ⟨x, hx, rfl⟩
    exact hx
  have h0' : μ ((fun x : X => g • x) '' ((fun x : X => g • x) ⁻¹' E)) = 0 :=
    measure_mono_null hsub h0
  have hzero : proj μ (measurableSet_smul_image hm hFmeas g)
      (V g (indSet μ (MeasurableSet.univ (α := X)))) = 0 :=
    proj_eq_zero_of_measure_zero μ _ h0' _
  have hnorm : ‖indSet μ hFmeas‖ = 0 := by
    have h1 : ‖V g (indSet μ hFmeas)‖ = ‖indSet μ hFmeas‖ := (V g).norm_map _
    rw [vmap_indSet hcov g hFmeas, hzero, norm_zero] at h1
    exact h1.symm
  have hsq : (μ ((fun x : X => g • x) ⁻¹' E)).toReal = 0 := by
    rw [← norm_indSet_sq μ hFmeas, hnorm]
    norm_num
  have hzero' : μ ((fun x : X => g • x) ⁻¹' E) = 0 :=
    (ENNReal.toReal_eq_zero_iff _).mp hsq |>.resolve_right (measure_ne_top μ _)
  rw [Measure.map_apply (hm g) hE]
  exact hzero'
