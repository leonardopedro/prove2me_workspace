-- Generated from ChapterHermiteBandCalculus.lean — solution of BookProof.HermiteBand.g1_nonneg
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
open BookProof.HermiteBand








noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : 0 ≤ g1 n := Real.sqrt_nonneg _
