-- Generated from ChapterSphericalBesselODE.lean — theorem BookProof.ChapterSphericalBesselODE.sbessel_ode
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBessel
open BookProof.ChapterSphericalBesselODE



open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalBesselODE.sbessel_ode (l : ℕ) {r : ℝ} (hr : r ≠ 0) :
    r ^ 2 * deriv (deriv (sbessel l)) r + 2 * r * deriv (sbessel l) r
      + (r ^ 2 - l * (l + 1)) * sbessel l r = 0 := by sorry
