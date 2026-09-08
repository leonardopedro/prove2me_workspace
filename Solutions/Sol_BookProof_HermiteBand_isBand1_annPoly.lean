-- Generated from ChapterHermiteBandCalculus.lean — solution of BookProof.HermiteBand.isBand1_annPoly
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
import Theorems.Thm_BookProof_HermiteBand_band_annPoly
open BookProof.HermiteBand








noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

























open BookProof.NavierStokesFlow.DifferentialL2 BookProof.FullQuadratic

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) : IsBand1 (annPoly i) := ⟨1, 1, zero_le_one, band_annPoly i⟩
