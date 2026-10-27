-- Generated from ChapterMackeyQuasiInvariant.lean — solution of BookProof.ChapterMackeyQuasiInvariant.inducedSystem_covariance
import Mathlib
import Definitions.Def_ChapterMackeyQuasiInvariant
import Theorems.Thm_BookProof_ChapterMackeyQuasiInvariant_vmap_proj
open BookProof.ChapterMackeyQuasiInvariant



open MeasureTheory Measure


variable {G X K : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {G X K : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable (μ : Measure X) (L : G → X → (K ≃ₗᵢ[ℂ] K))
variable {μ L}

set_option maxHeartbeats 1000000 in
theorem solution [SigmaFinite μ] (h : QuasiInvariant μ G)
    (hL : UnitaryCocycle μ L) (g : G) {E : Set X} (hE : MeasurableSet E) (f : Lp K 2 μ) :
    vmap h hL g (proj μ hE (vmap h hL g⁻¹ f))
      = proj μ ((actEquiv h.measurable g).measurableSet_image.mpr hE) f := by

  rw [vmap_proj h hL g hE, vmap_mul h hL g g⁻¹ f]
  simp [vmap_one h hL f]
