-- Generated from ChapterBesselHarmonic.lean — theorem BookProof.ChapterBesselHarmonic.helmholtz_sbessel_harmonic
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

theorem BookProof.ChapterBesselHarmonic.helmholtz_sbessel_harmonic [FiniteDimensional ℝ E] (h3 : Module.finrank ℝ E = 3)
    {l : ℕ} {H : E → ℝ} {x : E} {p : ℝ} (hp : p ≠ 0) (hx : x ≠ 0)
    (hH : ContDiffAt ℝ 2 H x) (hharm : (Δ H) x = 0) (heuler : fderiv ℝ H x x = l * H x) :
    -(Δ fun y : E => (sbessel l (p * ‖y‖) / ‖y‖ ^ l) * H y) x
      = p ^ 2 * ((sbessel l (p * ‖x‖) / ‖x‖ ^ l) * H x) := by sorry
