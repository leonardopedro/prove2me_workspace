-- Generated from ChapterBesselHarmonic.lean — theorem BookProof.ChapterBesselHarmonic.hasDerivAt_quot
import Definitions.Def_ChapterSphericalBessel
import Definitions.Def_ChapterSphericalBesselODE
import Definitions.Def_ChapterRadialLaplacian
import Definitions.Def_ChapterLaplacianProduct
import Mathlib
import Definitions.Def_ChapterBesselHarmonic
open BookProof.ChapterBesselHarmonic



open Filter Laplacian InnerProductSpace
open BookProof.ChapterSphericalBessel BookProof.ChapterSphericalBesselODE
open BookProof.ChapterRadialLaplacian BookProof.ChapterLaplacianProduct
open scoped InnerProductSpace RealInnerProductSpace

theorem BookProof.ChapterBesselHarmonic.hasDerivAt_quot {R : ℝ → ℝ} {l : ℕ} {s : ℝ} (hs : s ≠ 0) (hR : DifferentiableAt ℝ R s) :
    HasDerivAt (fun t => R t / t ^ l)
      (deriv R s / s ^ l - (l : ℝ) * R s / s ^ (l + 1)) s := by sorry
