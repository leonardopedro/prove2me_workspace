-- Generated from ChapterHermiteBandCalculus.lean — theorem BookProof.HermiteBand.degree_sub_single
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand

variable {d : ℕ}



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis


theorem BookProof.HermiteBand.degree_sub_single {α : Fin d →₀ ℕ} {i : Fin d} (h : 1 ≤ α i) :
    (α - Finsupp.single i 1).degree + 1 = α.degree := by sorry
