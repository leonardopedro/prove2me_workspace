-- Generated from ChapterMackeyCocycle.lean — solution of BookProof.ChapterMackeyCocycle.dens_eq_enorm_sq
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
import Theorems.Thm_BookProof_ChapterMackeyCocycle_norm_indSet_sq
import Theorems.Thm_BookProof_ChapterMackeyCocycle_vmap_indSet
import Theorems.Thm_BookProof_ChapterMackeyCocycle_image_preimage_smul
import Theorems.Thm_BookProof_ChapterMackeyCocycle_proj_congr_set
import Theorems.Thm_BookProof_ChapterMackeyCocycle_lintegral_enorm_sq_restrict
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
    {w : X → ℂ} (hwmeas : Measurable w)
    (hw : w =ᵐ[μ] ((V g (indSet μ (MeasurableSet.univ (α := by

  have hmeasw : Measurable fun x => ‖w x‖ₑ ^ 2 := (hwmeas.enorm.pow_const 2)
  have hmap : (μ.map fun x : X => g • x) = μ.withDensity (fun x => ‖w x‖ₑ ^ 2) := by
    refine Measure.ext fun F hF => ?_
    have hEmeas : MeasurableSet ((fun x : X => g • x) ⁻¹' F) := (hm g) hF
    -- the norm identity coming from unitarity and covariance
    have hV0 := vmap_indSet hcov g hEmeas
    have hV : V g (indSet μ hEmeas)
        = proj μ hF (V g (indSet μ (MeasurableSet.univ (α := X)))) := by
      rw [hV0]
      exact proj_congr_set μ _ hF (image_preimage_smul g F) _
    have hnormV : ‖proj μ hF (V g (indSet μ (MeasurableSet.univ (α := X))))‖
        = ‖indSet μ hEmeas‖ := by
      rw [← hV]
      exact (V g).norm_map _
    have hsq : ‖proj μ hF (V g (indSet μ (MeasurableSet.univ (α := X))))‖ ^ 2
        = (μ ((fun x : X => g • x) ⁻¹' F)).toReal := by
      rw [hnormV, norm_indSet_sq μ hEmeas]
    have hlin : ∫⁻ x in F, ‖w x‖ₑ ^ 2 ∂μ
        = ∫⁻ x in F, ‖((V g (indSet μ (MeasurableSet.univ (α := X)))) : X → ℂ) x‖ₑ ^ 2 ∂μ := by
      refine lintegral_congr_ae ?_
      exact ae_restrict_of_ae (hw.mono fun x hx => by simp only [hx])
    rw [withDensity_apply _ hF, hlin,
      lintegral_enorm_sq_restrict μ hF (V g (indSet μ (MeasurableSet.univ (α := X)))), hsq,
      ENNReal.ofReal_toReal (measure_ne_top μ _), Measure.map_apply (hm g) hF]
  rw [dens, hmap]
  exact Measure.rnDeriv_withDensity μ hmeasw
