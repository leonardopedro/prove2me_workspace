-- Generated from ChapterSphericalBesselODE.lean — solution of BookProof.ChapterSphericalBesselODE.second_deriv_gIter
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
import Theorems.Thm_BookProof_ChapterSphericalBesselODE_diffAt_gIter
import Theorems.Thm_BookProof_ChapterSphericalBesselODE_deriv_gIter_eq
open BookProof.ChapterSphericalBesselODE




open BookProof.ChapterSphericalBessel

set_option maxHeartbeats 1000000 in
theorem solution (l : ℕ) {r : ℝ} (hr : r ≠ 0) :
    deriv (deriv (gIter l)) r = -gIter (l + 1) r - r * deriv (gIter (l + 1)) r := by

  have hEq : deriv (gIter l) =ᶠ[nhds r] fun x => -x * gIter (l + 1) x := by
    filter_upwards [isOpen_ne.mem_nhds hr] with x hx using deriv_gIter_eq l hx
  have hneg : HasDerivAt (fun x : ℝ => -x) (-1 : ℝ) r := by
    simpa using! (hasDerivAt_id r).neg
  have hD : HasDerivAt (fun x : ℝ => -x * gIter (l + 1) x)
      (-1 * gIter (l + 1) r + -r * deriv (gIter (l + 1)) r) r :=
    hneg.mul ((diffAt_gIter (l + 1) hr).hasDerivAt)
  rw [hEq.deriv_eq, hD.deriv]
  ring
