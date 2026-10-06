-- Generated from ChapterSphericalBesselODE.lean — theorem BookProof.ChapterSphericalBesselODE.sbessel_radial_eigen
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBessel
open BookProof.ChapterSphericalBesselODE



open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalBesselODE.sbessel_radial_eigen (l : ℕ) {p r : ℝ} (hp : p ≠ 0) (hr : r ≠ 0) :
    -(deriv (deriv (fun s => sbessel l (p * s))) r
        + (2 / r) * deriv (fun s => sbessel l (p * s)) r
        - ((l : ℝ) * (l + 1) / r ^ 2) * sbessel l (p * r))
      = p ^ 2 * sbessel l (p * r) := by sorry
