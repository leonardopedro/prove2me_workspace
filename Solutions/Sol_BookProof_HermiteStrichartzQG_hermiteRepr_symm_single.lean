-- Generated from ChapterStrichartzHermiteQG.lean — solution of BookProof.HermiteStrichartzQG.hermiteRepr_symm_single
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
import Theorems.Thm_BookProof_HermiteCore_hermiteBasis_apply




open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    hermiteRepr.symm (lp.single 2 n (1 : ℂ)) = hermiteLp n := by

  rw [hermiteRepr, HilbertBasis.repr_symm_single, hermiteBasis_apply]
