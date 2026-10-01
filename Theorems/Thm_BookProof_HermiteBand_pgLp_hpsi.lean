-- Generated from ChapterHermiteBandCalculus.lean — theorem BookProof.HermiteBand.pgLp_hpsi
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.HermiteBand

variable {d : ℕ}



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis


theorem BookProof.HermiteBand.pgLp_hpsi (α : Fin d →₀ ℕ) : pgLp (hpsi α) = hermiteMvLp α := by sorry
