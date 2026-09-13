-- Generated from ChapterHermiteBandCalculus.lean — solution of BookProof.HermiteBand.le_degree
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
open BookProof.HermiteBand








noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (α : Fin d →₀ ℕ) (i : Fin d) : α i ≤ α.degree := Finsupp.le_degree i α
