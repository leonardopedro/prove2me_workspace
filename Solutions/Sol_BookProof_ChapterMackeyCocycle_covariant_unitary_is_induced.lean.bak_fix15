-- Generated from ChapterMackeyCocycle.lean — solution of BookProof.ChapterMackeyCocycle.covariant_unitary_is_induced
import Mathlib
import Definitions.Def_ChapterMackeyCocycle
import Theorems.Thm_BookProof_ChapterMackeyCocycle_quasiInvariant_of_covariant
import Theorems.Thm_BookProof_ChapterMackeyCocycle_dens_eq_enorm_sq
import Theorems.Thm_BookProof_ChapterMackeyCocycle_vmap_eq_tmap
import Theorems.Thm_BookProof_ChapterMackeyCocycle_measurable_wrep
import Theorems.Thm_BookProof_ChapterMackeyCocycle_wrep_ae
import Theorems.Thm_BookProof_ChapterMackeyCocycle_norm_ucocycle
import Theorems.Thm_BookProof_ChapterMackeyCocycle_measurable_ucocycle
open BookProof.ChapterMackeyCocycle



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable {μ : Measure X} [IsFiniteMeasure μ]

set_option maxHeartbeats 1000000 in
theorem solution {hm : ∀ g : G, Measurable fun x : X => g • x}
    {V : G → (Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)} (hcov : Covariant μ hm V) :
    QuasiInvariant μ G ∧
      ∃ u : G → X → ℂ, (∀ g x, ‖u g x‖ = 1) ∧ (∀ g, Measurable (u g)) ∧
        ∀ (g : G) (f : Lp ℂ 2 μ), ((V g f : Lp ℂ 2 μ) : X → ℂ) =ᵐ[μ]
          fun x => u g x * (sqrtDens μ g x : ℂ) * (f : X → ℂ) (g⁻¹ • x) := by

  have hqi : QuasiInvariant μ G := quasiInvariant_of_covariant hcov
  refine ⟨hqi, ucocycle V, norm_ucocycle V, measurable_ucocycle V, ?_⟩
  intro g f
  have hdens : dens μ g =ᵐ[μ] fun x => ‖wrep V g x‖ₑ ^ 2 :=
    dens_eq_enorm_sq hcov g (measurable_wrep V g) (wrep_ae V g)
  have hsqrt : ∀ᵐ x ∂μ, sqrtDens μ g x = ‖wrep V g x‖ := by
    filter_upwards [hdens] with x hx
    rw [sqrtDens, hx, ← ofReal_norm_eq_enorm, ← ENNReal.ofReal_pow (norm_nonneg _),
      ENNReal.toReal_ofReal (by positivity), Real.sqrt_sq (norm_nonneg _)]
  have hV := vmap_eq_tmap hcov hqi g (measurable_wrep V g) (wrep_ae V g) hdens f
  rw [hV]
  filter_upwards [tmap_coeFn hqi g (measurable_wrep V g) hdens f, hsqrt] with x a1 a2
  rw [a1, a2, tfun]
  congr 1
  rw [ucocycle]
  split_ifs with h
  · rw [h]
    simp
  · rw [div_mul_cancel₀]
    simpa using h
