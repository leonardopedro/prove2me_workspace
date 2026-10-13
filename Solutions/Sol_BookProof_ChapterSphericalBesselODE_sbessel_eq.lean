-- Generated from ChapterSphericalBesselODE.lean — solution of BookProof.ChapterSphericalBesselODE.sbessel_eq
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBesselODE




open BookProof.ChapterSphericalBessel

set_option maxHeartbeats 1000000 in
theorem solution (l : ℕ) (r : ℝ) : sbessel l r = r ^ l * gIter l r := rfl
