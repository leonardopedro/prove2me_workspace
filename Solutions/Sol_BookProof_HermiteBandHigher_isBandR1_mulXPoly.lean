-- Generated from ChapterHermiteBandCalculusHigher.lean — solution of BookProof.HermiteBandHigher.isBandR1_mulXPoly
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Theorems.Thm_BookProof_HermiteBandHigher_isBand1_isBandR_one
import Theorems.Thm_BookProof_HermiteBand_isBand1_mulXPoly
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.HermiteBandHigher




noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) : IsBandR 1 1 (mulXPoly i) := isBand1_isBandR_one (isBand1_mulXPoly i)
