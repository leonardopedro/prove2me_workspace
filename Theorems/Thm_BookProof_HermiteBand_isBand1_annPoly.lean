-- Generated from ChapterHermiteBandCalculus.lean — theorem BookProof.HermiteBand.isBand1_annPoly
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand







noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

























open BookProof.NavierStokesFlow.DifferentialL2 BookProof.FullQuadratic

theorem BookProof.HermiteBand.isBand1_annPoly (i : Fin d) : IsBand1 (annPoly i) := by sorry
