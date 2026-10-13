-- Generated from ChapterHermiteBandCalculusHigher.lean — solution of BookProof.HermiteBandHigher.isBandDeg1_annPoly
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_isBandDeg
import Theorems.Thm_BookProof_HermiteBandHigher_isBandR1_annPoly
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteProductBasis
open BookProof.HermiteBandHigher




noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) : IsBandDeg 1 (annPoly i) := (isBandR1_annPoly i).isBandDeg
