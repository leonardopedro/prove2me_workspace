-- Generated from ChapterHermiteBandCalculus.lean — solution of BookProof.HermiteBand.degree_add_single
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand








noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (α : Fin d →₀ ℕ) (i : Fin d) :
    (α + Finsupp.single i 1).degree = α.degree + 1 := by

  simp
