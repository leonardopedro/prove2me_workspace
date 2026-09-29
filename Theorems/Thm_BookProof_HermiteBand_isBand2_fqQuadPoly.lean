-- Generated from ChapterHermiteBandCalculus.lean — theorem BookProof.HermiteBand.isBand2_fqQuadPoly
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand

variable {d : ℕ}



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

theorem BookProof.HermiteBand.isBand2_fqQuadPoly (P Q S : Fin d → Fin d → ℝ) : IsBand2 (fqQuadPoly P Q S) := by sorry
