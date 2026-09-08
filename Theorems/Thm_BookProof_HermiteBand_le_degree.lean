-- Generated from ChapterHermiteBandCalculus.lean — theorem BookProof.HermiteBand.le_degree
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand







noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

theorem BookProof.HermiteBand.le_degree (α : Fin d →₀ ℕ) (i : Fin d) : α i ≤ α.degree := by sorry
