-- Generated from ChapterBesselHarmonic.lean — theorem BookProof.ChapterBesselHarmonic.reduced_radial_sbessel
import Definitions.Def_ChapterSphericalBesselODE
import Definitions.Def_ChapterRadialLaplacian
import Definitions.Def_ChapterLaplacianProduct
import Mathlib
import Definitions.Def_ChapterBesselHarmonic
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBessel
open BookProof.ChapterBesselHarmonic



open Filter Laplacian InnerProductSpace
open BookProof.ChapterSphericalBessel BookProof.ChapterSphericalBesselODE
open BookProof.ChapterRadialLaplacian BookProof.ChapterLaplacianProduct
open scoped InnerProductSpace RealInnerProductSpace

theorem BookProof.ChapterBesselHarmonic.reduced_radial_sbessel (l : ℕ) {p r : ℝ} (hp : p ≠ 0) (hr : r ≠ 0) :
    deriv (deriv fun s => sbessel l (p * s) / s ^ l) r
        + ((2 + 2 * (l : ℝ)) / r) * deriv (fun s => sbessel l (p * s) / s ^ l) r
      = -(p ^ 2) * (sbessel l (p * r) / r ^ l) := by sorry
