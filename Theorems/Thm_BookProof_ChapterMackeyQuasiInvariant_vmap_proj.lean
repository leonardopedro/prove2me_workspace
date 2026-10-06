-- Generated from ChapterMackeyQuasiInvariant.lean — theorem BookProof.ChapterMackeyQuasiInvariant.vmap_proj
import Mathlib
import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterMackeyQuasiInvariant

variable {G X K : Type*} [Group G] [MeasurableSpace X] [MulAction G X]
variable [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable (μ : Measure X) (L : G → X → (K ≃ₗᵢ[ℂ] K))
variable {μ L}


open MeasureTheory Measure



theorem BookProof.ChapterMackeyQuasiInvariant.vmap_proj [SigmaFinite μ] (h : QuasiInvariant μ G) (hL : UnitaryCocycle μ L)
    (g : G) {E : Set X} (hE : MeasurableSet E) (f : Lp K 2 μ) :
    vmap h hL g (proj μ hE f)
      = proj μ ((actEquiv h.measurable g).measurableSet_image.mpr hE)
          (vmap h hL g f) := by sorry
