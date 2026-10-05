-- Generated from ChapterBesselHarmonic.lean — theorem BookProof.ChapterBesselHarmonic.helmholtz_sbessel_one_clm
import Definitions.Def_ChapterSphericalBesselODE
import Definitions.Def_ChapterRadialLaplacian
import Definitions.Def_ChapterLaplacianProduct
import Mathlib
import Definitions.Def_ChapterBesselHarmonic
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBessel
open BookProof.ChapterBesselHarmonic

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]



open Filter Laplacian InnerProductSpace
open BookProof.ChapterSphericalBessel BookProof.ChapterSphericalBesselODE
open BookProof.ChapterRadialLaplacian BookProof.ChapterLaplacianProduct
open scoped InnerProductSpace RealInnerProductSpace

theorem BookProof.ChapterBesselHarmonic.helmholtz_sbessel_one_clm [FiniteDimensional ℝ E] (h3 : Module.finrank ℝ E = 3)
    (L : E →L[ℝ] ℝ) {x : E} {p : ℝ} (hp : p ≠ 0) (hx : x ≠ 0) :
    -(Δ fun y : E => (sbessel 1 (p * ‖y‖) / ‖y‖ ^ 1) * L y) x
      = p ^ 2 * ((sbessel 1 (p * ‖x‖) / ‖x‖ ^ 1) * L x) := by sorry
